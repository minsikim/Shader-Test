Shader "Salinger/BasicTransparent" {
	
	Properties {
	    _Color ("Color", Color) = (1,1,1,1)
		_RimBrightness ("Rim Brightness", Range(0, 10)) = 1
		_RimPower ("Rim Power", Range(0, 10)) = 1
	}
	
	SubShader {
		Tags{
			"Queue" = "Transparent"
		}

		Pass{
			ZWrite On
			ColorMask 0
		}

		CGPROGRAM
			#pragma surface surf Lambert alpha:fade

			struct Input {
				float2 uv_MainTex;
				float3 viewDir;
			};

			fixed4 _Color;
			half _RimPower;
			half _RimBrightness;
			
			void surf (Input IN, inout SurfaceOutput o){
				float NdotV = saturate(dot(normalize(IN.viewDir), o.Normal));
			    //o.Albedo = _Color.rgb;
				o.Emission = _Color.rgb * pow(1 - NdotV, _RimPower) * _RimBrightness;
				o.Alpha = pow(1 - NdotV, _RimPower);
			}
		
		ENDCG
	}
	
	FallBack "Diffuse"
}