Shader "Salinger/CustomLightingModel_Lambert" {
	
	Properties {
	    _Color1 ("Color 1", Color) = (1,1,1,1)
		_Color2 ("Color 2", Color) = (1,1,1,1)
		_SplitRange ("Split Range", Range(0,1)) = 0.5
		_BlendRange("Blend Range", Range(0,0.5)) = 0.1
	}
	
	SubShader {
		Tags{
			"Queue" = "Geometry"
		}


		CGPROGRAM
			#pragma surface surf Salinger

			fixed4 _Color1;
			fixed4 _Color2;
			half _SplitRange;
			half _BlendRange;

			struct Input {
				float2 uv_MainTex;
			};


			//float3 viewDir - contains view direction, for computing Parallax effects, rim lighting etc.
			//float4 with COLOR semantic - contains interpolated per - vertex color.
			//float4 screenPos - contains screen space position for reflection or screenspace effects.Note that this is not suitable for GrabPass; you need to compute custom UV yourself using ComputeGrabScreenPos function.
			//float3 worldPos - contains world space position.
			//float3 worldRefl - contains world reflection vector if surface shader does not write to o.Normal.See Reflect - Diffuse shader for example.
			//float3 worldNormal - contains world normal vector if surface shader does not write to o.Normal.
			//float3 worldRefl; INTERNAL_DATA - contains world reflection vector if surface shader writes to o.Normal.To get the reflection vector based on per - pixel normal map
			//, use WorldReflectionVector(IN, o.Normal).See Reflect - Bumped shader for example.
			//float3 worldNormal; INTERNAL_DATA - contains world normal vector if surface shader writes to o.Normal.To get the normal vector based on per - pixel normal map, use WorldNormalVector(IN, o.Normal).
			void surf (Input IN, inout SurfaceOutput o){
			    //o.Albedo = o.Normal > 0.5 ? _Color1.rgb : _Color2.rgb;
				//half3 c = (0,0,1);
				//o.Albedo = c;
			}

			half4 LightingSalinger(SurfaceOutput s, half3 lightDir, half atten) {
				half NdotL = dot(s.Normal, lightDir);
				half4 c;
				//c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
				half blend = (NdotL - (_SplitRange - _BlendRange / 2)) / _BlendRange;
				half3 b = blend;
				c.rgb = NdotL < _SplitRange - _BlendRange / 2 ?
						_Color2.rgb : 
						NdotL > _SplitRange + _BlendRange / 2 ?
						_Color1.rgb :
						lerp(_Color2.rgb, _Color1.rgb, b);
				//c.rgb = s.Albedo;
				c.a = s.Alpha;
				return c;
			}
		
		ENDCG
	}
	
	FallBack "Diffuse"
}