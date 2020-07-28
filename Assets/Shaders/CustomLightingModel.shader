Shader "Salinger/CustomLightingModel" {
	
	Properties {
	    _Color ("Color", Color) = (1,1,1,1)
	}
	
	SubShader {
		Tags{
			"Queue" = "Geoemtry"
		}

		CGPROGRAM
			#pragma surface surf Salinger

			fixed4 _Color;

			half4 LightingSalinger (SurfaceOutput s, half3 lightDir, half atten) {
				half NdotL = dot (s.Normal, lightDir);
				half4 c;
				//c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
				c.rgb = NdotL < 0.5 ? s.Albedo * 0.5 : s.Albedo;
				c.a = s.Alpha;
				return c;
			}

			struct Input {
				float2 uvMainTex;
				float3 worldNormal;
			};

			
			
			void surf (Input IN, inout SurfaceOutput o){
			    o.Albedo = _Color.rgb;
				//o.Emission = IN.worldNormal;
			}
		
		ENDCG
	}
	
	FallBack "Diffuse"
}