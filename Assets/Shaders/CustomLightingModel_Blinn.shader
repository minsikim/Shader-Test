Shader "Salinger/CustomLightingModel_Blinn" {
	
	Properties {
	    _Color ("Color", Color) = (1,1,1,1)
		_Color2("Color 2", Color) = (1,1,1,1)
	}
	
	SubShader {
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
			#pragma surface surf SalingerBlinn

			fixed4 _Color;
			fixed4 _Color2;

			half4 LightingSalingerBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
				//블린퐁의 개념을 통해 라이팅 모델 구현
				//halfway normal 생성
				half3 h = normalize(lightDir + viewDir);
				
				half diff = max(0, dot(s.Normal, lightDir));

				float nh = max(0, dot(s.Normal, h));
				float spec = pow(nh, 48.0);

				half4 c;
				c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten + _Color2.rgb * pow((1 - diff), 3) * 0.5;
				c.a = s.Alpha;
				return c;
			}

			struct Input {
				float2 uv_MainTex;
			};

			
			void surf (Input IN, inout SurfaceOutput o){
			    o.Albedo = _Color.rgb;
			}
		
		ENDCG
	}
	
	FallBack "Diffuse"
}