Shader "Salinger/StandardSpecPBR" {
	
	Properties {
	    _Color ("Color", Color) = (1,1,1,1)
		_MetallicTex ("Metallic (R)", 2D) = "white" {}
		_SpecColor ("Spec Color", Color) = (1,1,1,1)
		_EmissionRange ("Emission Range", Range(0,1)) = 0
	}
	
	SubShader {
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
			#pragma surface surf StandardSpecular

			struct Input {
				float2 uv_MetallicTex;
			};

			fixed4 _Color;
			sampler2D _MetallicTex;
			float _EmissionRange;
			
			void surf (Input IN, inout SurfaceOutputStandardSpecular o){
				o.Albedo = _Color.rgb;
				o.Smoothness = 1 - tex2D (_MetallicTex, IN.uv_MetallicTex).r;
				o.Specular = _SpecColor.rgb;
				o.Emission =  tex2D (_MetallicTex, IN.uv_MetallicTex).rgb * _EmissionRange * _SpecColor;
			}
		
		ENDCG
	}
	
	FallBack "Diffuse"
}