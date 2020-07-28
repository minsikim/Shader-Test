﻿Shader "Salinger/BasicLambert" {
	
	Properties {
	    _Color ("Color", Color) = (1,1,1,1)
		_SpecColor("Specular Color", Color) = (1,1,1,1)
		_Spec("Specular", Range(0,1)) = 0.5
		_Gloss("Gloss", Range(0,1)) = 0.5
	}
	
	SubShader {
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
			#pragma surface surf Lambert

			struct Input {
				float2 uvMainTex;
			};

			fixed4 _Color;
			half _Spec;
			fixed _Gloss;
			
			void surf (Input IN, inout SurfaceOutput o){
			    o.Albedo = _Color.rgb;
				o.Specular = _Spec;
				o.Gloss = _Gloss;
			}
		
		ENDCG
	}
	
	FallBack "Diffuse"
}