Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86ED52B7899
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgKRI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:28:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgKRI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:28:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AI8SAfd109946;
        Wed, 18 Nov 2020 02:28:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605688090;
        bh=wipFy4goU0+9jVvy+SRIoM9QzZ2mMpIZb7D9n8ByuHg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QKFWeFEyDH8QioKBqDwzYVhMuyhh9nc9M+Kez8avBXzae3JwT2O/lNZhRKlexBYEZ
         GXqToKplZMJd/eGxCoJEhOOg8NRBwCZex7iyaeolzMgLA3N/3Wtd8I0+HTuli2GaGv
         YSoEjYRjFGLw9da9cbBzSEain8TrKlGbT3kvwfbE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AI8SAwA076303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 02:28:10 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 02:28:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 02:28:09 -0600
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AI8S8wE064671;
        Wed, 18 Nov 2020 02:28:08 -0600
Subject: Re: [PATCH] ARM: dts: keystone-k2g-evm: add HDMI and analog audio
 data
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <tomi.valkeinen@ti.com>
References: <20201117101749.26187-1-peter.ujfalusi@ti.com>
 <a089db87-ab19-052b-c8d6-77d652ad5581@ti.com>
From:   Jyri Sarha <jsarha@ti.com>
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 xsFNBFbdWt8BEADnCIkQrHIvAmuDcDzp1h2pO9s22nacEffl0ZyzIS//ruiwjMfSnuzhhB33
 fNEWzMjm7eqoUBi1BUAQIReS6won0cXIEXFg9nDYQ3wNTPyh+VRjBvlb/gRJlf4MQnJDTGDP
 S5i63HxYtOfjPMSsUSu8NvhbzayNkN5YKspJDu1cK5toRtyUn1bMzUSKDHfwpdmuCDgXZSj2
 t+z+c6u7yx99/j4m9t0SVlaMt00p1vJJ3HJ2Pkm3IImWvtIfvCmxnOsK8hmwgNQY6PYK1Idk
 puSRjMIGLqjZo071Z6dyDe08zv6DWL1fMoOYbAk/H4elYBaqEsdhUlDCJxZURcheQUnOMYXo
 /kg+7TP6RqjcyXoGgqjfkqlf3hYKmyNMq0FaYmUAfeqCWGOOy3PPxR/IiACezs8mMya1XcIK
 Hk/5JAGuwsqT80bvDFAB2XfnF+fNIie/n5SUHHejJBxngb9lFE90BsSfdcVwzNJ9gVf/TOJc
 qJEHuUx0WPi0taO7hw9+jXV8KTHp6CQPmDSikEIlW7/tJmVDBXQx8n4RMUk4VzjE9Y/m9kHE
 UVJ0bJYzMqECMTAP6KgzgkQCD7n8OzswC18PrK69ByGFpcm664uCAa8YiMuX92MnesKMiYPQ
 z1rvR5riXZdplziIRjFRX+68fvhPverrvjNVmzz0bAFwfVjBsQARAQABzRpKeXJpIFNhcmhh
 IDxqc2FyaGFAdGkuY29tPsLBeAQTAQIAIgUCVt1a3wIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AACgkQkDazUNfWGUEVVhAAmFL/21tUhZECrDrP9FWuAUuDvg+1CgrrqBj7ZxKtMaiz
 qTcZwZdggp8bKlFaNrmsyrBsuPlAk99f7ToxufqbV5l/lAT3DdIkjb4nwN4rJkxqSU3PaUnh
 mDMKIAp6bo1N9L+h82LE6CjI89W4ydQp5i+cOeD/kbdxbHHvxgNwrv5x4gg1JvEQLVnUSHva
 R2kx7u2rlnq7OOyh9vU0MUq7U5enNNqdBjjBTeaOwa5xb3S2Cc9dR10mpFiy+jSSkuFOjPpc
 fLfr/s03NGqbZ4aXvZCGjCw4jclpTJkuWPKO+Gb+a/3oJ4qpGN9pJ+48n2Tx9MdSrR4aaXHi
 EYMrbYQz9ICJ5V80P5+yCY5PzCvqpkizP6vtKvRSi8itzsglauMZGu6GwGraMJNBgu5u+HIZ
 nfRtJO1AAiwuupOHxe1nH05c0zBJaEP4xJHyeyDsMDh+ThwbGwQmAkrLJZtOd3rTmqlJXnuj
 sfgQlFyC68t1YoMHukz9LHzg02xxBCaLb0KjslfwuDUTPrWtcDL1a5hccksrkHx7k9crVFA1
 o6XWsOPGKRHOGvYyo3TU3CRygXysO41UnGG40Q3B5R8RMwRHV925LOQIwEGF/6Os8MLgFXCb
 Lv3iJtan+PBdqO1Bv3u2fXUMbYgQ3v7jHctB8nHphwSwnHuGN7FAmto+SxzotE3OwU0EVt1a
 3wEQAMHwOgNaIidGN8UqhSJJWDEfF/SPSCrsd3WsJklanbDlUCB3WFP2EB4k03JroIRvs7/V
 VMyITLQvPoKgaECbDS5U20r/Po/tmaAOEgC7m1VaWJUUEXhjYQIw7t/tSdWlo5XxZIcO4LwO
 Kf0S4BPrQux6hDLIFL8RkDH/8lKKc44ZnSLoF1gyjc5PUt6iwgGJRRkOD8gGxCv1RcUsu1xU
 U9lHBxdWdPmMwyXiyui1Vx7VJJyD55mqc7+qGrpDHG9yh3pUm2IWp7jVt/qw9+OE9dVwwhP9
 GV2RmBpDmB3oSFpk7lNvLJ11VPixl+9PpmRlozMBO00wA1W017EpDHgOm8XGkq++3wsFNOmx
 6p631T2WuIthdCSlZ2kY32nGITWn4d8L9plgb4HnDX6smrMTy1VHVYX9vsHXzbqffDszQrHS
 wFo5ygKhbGNXO15Ses1r7Cs/XAZk3PkFsL78eDBHbQd+MveApRB7IyfffIz7pW1R1ZmCrmAg
 Bn36AkDXJTgUwWqGyJMd+5GHEOg1UPjR5Koxa4zFhj1jp1Fybn1t4N11cmEmWh0aGgI/zsty
 g/qtGRnFEywBbzyrDEoV4ZJy2Q5pnZohVhpbhsyETeYKQrRnMk/dIPWg6AJx38Cl4P9PK1JX
 8VK661BG8GXsXJ3uZbPSu6K0+FiJy09N4IW7CPJNABEBAAHCwV8EGAECAAkFAlbdWt8CGwwA
 CgkQkDazUNfWGUFOfRAA5K/z9DXVEl2kkuMuIWkgtuuLQ7ZwqgxGP3dMA5z3Iv/N+VNRGbaw
 oxf+ZkTbJHEE/dWclj1TDtpET/t6BJNLaldLtJ1PborQH+0jTmGbsquemKPgaHeSU8vYLCdc
 GV/Rz+3FN0/fRdmoq2+bIHght4T6KZJ6jsrnBhm7y6gzjMOiftH6M5GXPjU0/FsU09qsk/af
 jbwLETaea0mlWMrLd9FC2KfVITA/f/YG2gqtUUF9WlizidyctWJqSTZn08MdzaoPItIkRUTv
 6Bv6rmFn0daWkHt23BLd0ZP7e7pON1rqNVljWjWQ/b/E/SzeETrehgiyDr8pP+CLlC+vSQxi
 XtjhWjt1ItFLXxb4/HLZbb/L4gYX7zbZ3NwkON6Ifn3VU7UwqxGLmKfUwu/mFV+DXif1cKSS
 v6vWkVQ6Go9jPsSMFxMXPA5317sZZk/v18TAkIiwFqda3/SSjwc3e8Y76/DwPvUQd36lEbva
 uBrUXDDhCoiZnjQaNz/J+o9iYjuMTpY1Wp+igjIretYr9+kLvGsoPo/kTPWyiuh/WiFU2d6J
 PMCGFGhodTS5qmQA6IOuazek1qSZIl475u3E2uG98AEX/kRhSzgpsbvADPEUPaz75uvlmOCX
 tv+Sye9QT4Z1QCh3lV/Zh4GlY5lt4MwYnqFCxroK/1LpkLgdyQ4rRVw=
Message-ID: <97da4017-f161-5e16-8133-8541d030fc62@ti.com>
Date:   Wed, 18 Nov 2020 10:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a089db87-ab19-052b-c8d6-77d652ad5581@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2020 09:39, Peter Ujfalusi wrote:
> Hi,
> 
Hi,
I certainly agree with your point, but you missed one place that needs
changing. sii9022-node also refers to the renamed clock node, and that
should be changed too (see bellow).

> On 17/11/2020 12.17, Peter Ujfalusi wrote:
>> The board is using McASP2 for both analog (tlv320aic3106) and
>> HDMI (SiI9022) audio.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm/boot/dts/keystone-k2g-evm.dts | 112 +++++++++++++++++++++++++
>>  1 file changed, 112 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
>> index 8b3d64c913d8..4d7e3514a3a7 100644
>> --- a/arch/arm/boot/dts/keystone-k2g-evm.dts
>> +++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
>> @@ -46,6 +46,14 @@ vcc1v8_ldo1_reg: fixedregulator-vcc1v8-ldo1 {
>>  		regulator-always-on;
>>  	};
>>  
>> +	vcc1v8_ldo2_reg: fixedregulator-vcc1v8-ldo2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "ldo2";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-always-on;
>> +	};
>> +
>>  	hdmi: connector {
>>  		compatible = "hdmi-connector";
>>  		label = "hdmi";
>> @@ -58,6 +66,57 @@ hdmi_connector_in: endpoint {
>>  			};
>>  		};
>>  	};
>> +
>> +	sound0: sound@0 {
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,name = "K2G-EVM";
>> +		simple-audio-card,widgets =
>> +			"Headphone", "Headphone Jack",
>> +			"Line", "Line In";
>> +		simple-audio-card,routing =
>> +			"Headphone Jack",	"HPLOUT",
>> +			"Headphone Jack",	"HPROUT",
>> +			"LINE1L",		"Line In",
>> +			"LINE1R",		"Line In";
>> +
>> +		simple-audio-card,dai-link@0 {
>> +			format = "i2s";
>> +			bitclock-master = <&sound0_0_master>;
>> +			frame-master = <&sound0_0_master>;
>> +			sound0_0_master: cpu {
>> +				sound-dai = <&mcasp2>;
>> +				clocks = <&k2g_clks 0x6 1>;
>> +				system-clock-direction-out;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&tlv320aic3106>;
>> +				system-clock-frequency = <12288000>;
> 
> I think it would be better to use:
> 				clocks = <&aud_mclk>;
> 
> 
>> +			};
>> +		};
>> +
>> +		simple-audio-card,dai-link@1 {
>> +			format = "i2s";
>> +			bitclock-master = <&sound0_1_master>;
>> +			frame-master = <&sound0_1_master>;
>> +			sound0_1_master: cpu {
>> +				sound-dai = <&mcasp2>;
>> +				clocks = <&k2g_clks 0x6 1>;
>> +				system-clock-direction-out;
>> +			};
>> +
>> +			codec {
>> +				sound-dai = <&sii9022>;
>> +				system-clock-frequency = <12288000>;
> 
> and here as well:
> 				clocks = <&aud_mclk>;
> 
> 
>> +			};
>> +		};
>> +	};
>> +
>> +	sii9022_mclk: sii9022_mclk {
> 
> and rename the fixed clock to aud_mclk as the same clock is connected to
> both aic3106 and SiI9022
> 
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <12288000>;
>> +	};
>>  };
>>  
>>  &k2g_pinctrl {
>> @@ -214,6 +273,15 @@ K2G_CORE_IOPAD(0x10e4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssde.dssd
>>  			K2G_CORE_IOPAD(0x10e8) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssfid.dssfid */
>>  		>;
>>  	};
>> +
>> +	mcasp2_pins: pinmux_mcasp2_pins {
>> +		pinctrl-single,pins = <
>> +			K2G_CORE_IOPAD(0x1234) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE4) /* pr0_pru_gpo2.mcasp2_axr2 */
>> +			K2G_CORE_IOPAD(0x1238) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE4) /* pr0_pru_gpo3.mcasp2_axr3 */
>> +			K2G_CORE_IOPAD(0x1254) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE4) /* pr0_pru_gpo10.mcasp2_afsx */
>> +			K2G_CORE_IOPAD(0x125c) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE4) /* pr0_pru_gpo12.mcasp2_aclkx */
>> +		>;
>> +	};
>>  };
>>  
>>  &uart0 {
>> @@ -423,6 +491,10 @@ sii9022: sii9022@3b {
>>  		compatible = "sil,sii9022";
>>  		reg = <0x3b>;
>>  
>> +		sil,i2s-data-lanes = < 0 >;
>> +		clocks = <&sii9022_mclk>;

... and here:
		clocks = <&aud_mclk>;

>> +		clock-names = "mclk";
>> +
>>  		ports {
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
>> @@ -444,6 +516,19 @@ sii9022_out: endpoint {
>>  			};
>>  		};
>>  	};
>> +
>> +	tlv320aic3106: tlv320aic3106@1b {
>> +		#sound-dai-cells = <0>;
>> +		compatible = "ti,tlv320aic3106";
>> +		reg = <0x1b>;
>> +		status = "okay";
>> +
>> +		/* Regulators */
>> +		AVDD-supply = <&vcc3v3_dcin_reg>;
>> +		IOVDD-supply = <&vcc3v3_dcin_reg>;
>> +		DRVDD-supply = <&vcc3v3_dcin_reg>;
>> +		DVDD-supply = <&vcc1v8_ldo2_reg>;
>> +	};
>>  };
>>  
>>  &dss {
>> @@ -458,3 +543,30 @@ dpi_out: endpoint {
>>  		};
>>  	};
>>  };
>> +
>> +&k2g_clks {
>> +	/* on the board 22.5792MHz is connected to AUDOSC_IN */
>> +	assigned-clocks = <&k2g_clks 0x4c 2>;
>> +	assigned-clock-rates = <22579200>;
>> +};
>> +
>> +&mcasp2 {
>> +	#sound-dai-cells = <0>;
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcasp2_pins>;
>> +
>> +	assigned-clocks = <&k2g_clks 0x6 1>;
>> +	assigned-clock-parents = <&k2g_clks 0x6 2>;
>> +
>> +	status = "okay";
>> +
>> +	op-mode = <0>;		/* MCASP_IIS_MODE */
>> +	tdm-slots = <2>;
>> +	/* 6 serializer */
>> +	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
>> +		0 0 1 2 0 0 // AXR2: TX, AXR3: rx
>> +	>;
>> +	tx-num-evt = <32>;
>> +	rx-num-evt = <32>;
>> +};
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

Best regards,
Jyri

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
