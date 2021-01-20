Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC032FDDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbhAUARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390966AbhATXQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:16:56 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9CC06138E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:00:05 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n10so16250404pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=naJWyog5LuuHKOMNzFVVtDJI18pgyc1wxhwt3mNZ+rI=;
        b=IuSoTAnmOidf/UHVQi23kgOR6TCyAZfmjBHtkHX11Kn3S6d+LXWZc4T/F9RK592+I4
         3an8LNRl21pzxG+A+TH5QNeIokhx8G2nBzmbLnZ4Dx1HlizGpPV5aygrcDy8LW2Q4oKw
         qZ+B8FAlmjL5mAtqc9iaqlClE+vt8EsjkDD7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=naJWyog5LuuHKOMNzFVVtDJI18pgyc1wxhwt3mNZ+rI=;
        b=d7QTDP4H4AKEYGtdm769S/JymvaGjebYtQDoXtzRgiMom05s9r6BXsHjCozwSji2Nx
         nb624a/q4YMKuEoMc0Rm8pjPtFfutGrGhZvJTUIE57jR5gCsDR4c5aU/kobPE+KEHBDN
         3ETQdMxPrtmVdf0o0SVWNxRMec5qGO13mCqcGvUT2juudYXsBXliBo8r52IFC67LCMzS
         sYxCh/vdXFnd9yiRGExMFbdz4w/zcJ6yjJwrREK7IdStcm42Rs35VhZR8//eLma9TCM4
         8M77PTT8dHX6boOh8TDCwxitpeEacaV7sDrExIs5j/4eeNzlXQ5P/Cavf82BT7Ty4kxi
         4Mtg==
X-Gm-Message-State: AOAM530WPyDMyBw5rsdj+t0TQS7i1mOmXRcMEOE+DFQCCCwrt4tHFLxk
        My4lD4alpUPb1BFeObPNLKQYbPAGWomEtqp0peBkHdYYVq+kd+F5nHzPwAQw2kMXh+OJcX5Wcvm
        AEozbJ4J1ffAW4WhuJiTdVQr8c+tZE56ep1+qTRCvNYWIGJyg0Aic77kefCKWr83esDPg3n16pT
        jfry4=
X-Google-Smtp-Source: ABdhPJwCeOlg1uLOlbyEDKjqJZkC8xQcPfS2vZiiK+LADScA5vqNS5DK0J8P6D6mnz/ML3UhHywRlA==
X-Received: by 2002:aa7:8245:0:b029:1b8:da74:40ec with SMTP id e5-20020aa782450000b02901b8da7440ecmr11275219pfn.15.1611183603857;
        Wed, 20 Jan 2021 15:00:03 -0800 (PST)
Received: from [10.230.182.181] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id t206sm3199782pgb.84.2021.01.20.15.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 15:00:02 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: stingray: remove sata
To:     Scott Branden <scott.branden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210120185140.16929-1-scott.branden@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <640bd260-3253-d36d-57c1-ab1ca2e08ddc@broadcom.com>
Date:   Wed, 20 Jan 2021 15:00:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120185140.16929-1-scott.branden@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006c6f8705b95ceab0"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006c6f8705b95ceab0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 1/20/2021 10:51 AM, Scott Branden wrote:
> Remove sata from stingray as it is unsupported.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../dts/broadcom/stingray/bcm958742-base.dtsi |  64 ----
>  .../dts/broadcom/stingray/stingray-sata.dtsi  | 278 ------------------
>  .../boot/dts/broadcom/stingray/stingray.dtsi  |   7 -
>  3 files changed, 349 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
> 
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> index 43aa5e9c0020..8fe7325cfbb2 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
> @@ -56,70 +56,6 @@
>  	};
>  };
>  
> -&sata0 {
> -	status = "okay";
> -};
> -
> -&sata_phy0{
> -	status = "okay";
> -};
> -
> -&sata1 {
> -	status = "okay";
> -};
> -
> -&sata_phy1{
> -	status = "okay";
> -};
> -
> -&sata2 {
> -	status = "okay";
> -};
> -
> -&sata_phy2{
> -	status = "okay";
> -};
> -
> -&sata3 {
> -	status = "okay";
> -};
> -
> -&sata_phy3{
> -	status = "okay";
> -};
> -
> -&sata4 {
> -	status = "okay";
> -};
> -
> -&sata_phy4{
> -	status = "okay";
> -};
> -
> -&sata5 {
> -	status = "okay";
> -};
> -
> -&sata_phy5{
> -	status = "okay";
> -};
> -
> -&sata6 {
> -	status = "okay";
> -};
> -
> -&sata_phy6{
> -	status = "okay";
> -};
> -
> -&sata7 {
> -	status = "okay";
> -};
> -
> -&sata_phy7{
> -	status = "okay";
> -};
> -
>  &pwm {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
> deleted file mode 100644
> index 8c68e0c26f1b..000000000000
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
> +++ /dev/null
> @@ -1,278 +0,0 @@
> -/*
> - *  BSD LICENSE
> - *
> - *  Copyright(c) 2016-2017 Broadcom.  All rights reserved.
> - *
> - *  Redistribution and use in source and binary forms, with or without
> - *  modification, are permitted provided that the following conditions
> - *  are met:
> - *
> - *    * Redistributions of source code must retain the above copyright
> - *      notice, this list of conditions and the following disclaimer.
> - *    * Redistributions in binary form must reproduce the above copyright
> - *      notice, this list of conditions and the following disclaimer in
> - *      the documentation and/or other materials provided with the
> - *      distribution.
> - *    * Neither the name of Broadcom nor the names of its
> - *      contributors may be used to endorse or promote products derived
> - *      from this software without specific prior written permission.
> - *
> - *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> - *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> - *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> - *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> - *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> - *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> - *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> - *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> - *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> - *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - */
> -
> -	sata {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges = <0x0 0x0 0x67d00000 0x00800000>;
> -
> -		sata0: ahci@0 {
> -			compatible = "brcm,iproc-ahci", "generic-ahci";
> -			reg = <0x00000000 0x1000>;
> -			reg-names = "ahci";
> -			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata0_port0: sata-port@0 {
> -				reg = <0>;
> -				phys = <&sata0_phy0>;
> -				phy-names = "sata-phy";
> -			};
> -		};
> -
> -		sata_phy0: sata_phy@2100 {
> -			compatible = "brcm,iproc-sr-sata-phy";
> -			reg = <0x00002100 0x1000>;
> -			reg-names = "phy";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata0_phy0: sata-phy@0 {
> -				reg = <0>;
> -				#phy-cells = <0>;
> -			};
> -		};
> -
> -		sata1: ahci@10000 {
> -			compatible = "brcm,iproc-ahci", "generic-ahci";
> -			reg = <0x00010000 0x1000>;
> -			reg-names = "ahci";
> -			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata1_port0: sata-port@0 {
> -				reg = <0>;
> -				phys = <&sata1_phy0>;
> -				phy-names = "sata-phy";
> -			};
> -		};
> -
> -		sata_phy1: sata_phy@12100 {
> -			compatible = "brcm,iproc-sr-sata-phy";
> -			reg = <0x00012100 0x1000>;
> -			reg-names = "phy";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata1_phy0: sata-phy@0 {
> -				reg = <0>;
> -				#phy-cells = <0>;
> -			};
> -		};
> -
> -		sata2: ahci@20000 {
> -			compatible = "brcm,iproc-ahci", "generic-ahci";
> -			reg = <0x00020000 0x1000>;
> -			reg-names = "ahci";
> -			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata2_port0: sata-port@0 {
> -				reg = <0>;
> -				phys = <&sata2_phy0>;
> -				phy-names = "sata-phy";
> -			};
> -		};
> -
> -		sata_phy2: sata_phy@22100 {
> -			compatible = "brcm,iproc-sr-sata-phy";
> -			reg = <0x00022100 0x1000>;
> -			reg-names = "phy";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata2_phy0: sata-phy@0 {
> -				reg = <0>;
> -				#phy-cells = <0>;
> -			};
> -		};
> -
> -		sata3: ahci@30000 {
> -			compatible = "brcm,iproc-ahci", "generic-ahci";
> -			reg = <0x00030000 0x1000>;
> -			reg-names = "ahci";
> -			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata3_port0: sata-port@0 {
> -				reg = <0>;
> -				phys = <&sata3_phy0>;
> -				phy-names = "sata-phy";
> -			};
> -		};
> -
> -		sata_phy3: sata_phy@32100 {
> -			compatible = "brcm,iproc-sr-sata-phy";
> -			reg = <0x00032100 0x1000>;
> -			reg-names = "phy";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata3_phy0: sata-phy@0 {
> -				reg = <0>;
> -				#phy-cells = <0>;
> -			};
> -		};
> -
> -		sata4: ahci@100000 {
> -			compatible = "brcm,iproc-ahci", "generic-ahci";
> -			reg = <0x00100000 0x1000>;
> -			reg-names = "ahci";
> -			interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata4_port0: sata-port@0 {
> -				reg = <0>;
> -				phys = <&sata4_phy0>;
> -				phy-names = "sata-phy";
> -			};
> -		};
> -
> -		sata_phy4: sata_phy@102100 {
> -			compatible = "brcm,iproc-sr-sata-phy";
> -			reg = <0x00102100 0x1000>;
> -			reg-names = "phy";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata4_phy0: sata-phy@0 {
> -				reg = <0>;
> -				#phy-cells = <0>;
> -			};
> -		};
> -
> -		sata5: ahci@110000 {
> -			compatible = "brcm,iproc-ahci", "generic-ahci";
> -			reg = <0x00110000 0x1000>;
> -			reg-names = "ahci";
> -			interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata5_port0: sata-port@0 {
> -				reg = <0>;
> -				phys = <&sata5_phy0>;
> -				phy-names = "sata-phy";
> -			};
> -		};
> -
> -		sata_phy5: sata_phy@112100 {
> -			compatible = "brcm,iproc-sr-sata-phy";
> -			reg = <0x00112100 0x1000>;
> -			reg-names = "phy";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata5_phy0: sata-phy@0 {
> -				reg = <0>;
> -				#phy-cells = <0>;
> -			};
> -		};
> -
> -		sata6: ahci@120000 {
> -			compatible = "brcm,iproc-ahci", "generic-ahci";
> -			reg = <0x00120000 0x1000>;
> -			reg-names = "ahci";
> -			interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata6_port0: sata-port@0 {
> -				reg = <0>;
> -				phys = <&sata6_phy0>;
> -				phy-names = "sata-phy";
> -			};
> -		};
> -
> -		sata_phy6: sata_phy@122100 {
> -			compatible = "brcm,iproc-sr-sata-phy";
> -			reg = <0x00122100 0x1000>;
> -			reg-names = "phy";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata6_phy0: sata-phy@0 {
> -				reg = <0>;
> -				#phy-cells = <0>;
> -			};
> -		};
> -
> -		sata7: ahci@130000 {
> -			compatible = "brcm,iproc-ahci", "generic-ahci";
> -			reg = <0x00130000 0x1000>;
> -			reg-names = "ahci";
> -			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata7_port0: sata-port@0 {
> -				reg = <0>;
> -				phys = <&sata7_phy0>;
> -				phy-names = "sata-phy";
> -			};
> -		};
> -
> -		sata_phy7: sata_phy@132100 {
> -			compatible = "brcm,iproc-sr-sata-phy";
> -			reg = <0x00132100 0x1000>;
> -			reg-names = "phy";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -
> -			sata7_phy0: sata-phy@0 {
> -				reg = <0>;
> -				#phy-cells = <0>;
> -			};
> -		};
> -	};
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> index b425b12c3ed2..2ffb2c92182a 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> @@ -285,7 +285,6 @@
>  	};
>  
>  	#include "stingray-fs4.dtsi"
> -	#include "stingray-sata.dtsi"
>  	#include "stingray-pcie.dtsi"
>  	#include "stingray-usb.dtsi"
>  
> @@ -309,12 +308,6 @@
>  				#size-cells = <0>;
>  			};
>  
> -			mdio@2 { /* SATA */
> -				reg = <0x2>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -			};
> -
>  			mdio@3 { /* USB */
>  				reg = <0x3>;
>  				#address-cells = <1>;
> 

The entire change looks good to me!

Acked-by: Ray Jui <ray.jui@broadcom.com>

--0000000000006c6f8705b95ceab0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Gp3tsmw0Vz7IMJs6DQIm7T8CfIzeId1IIHcH02MbpO7m1Btzyz625FoBWF8CAwEAAaOCAcswggHH
MA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUHMAKGQWh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNoYTJnM29jc3AuY3J0
MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24y
c2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1UdHwQ9MDswOaA3oDWG
M2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hhMmczLmNybDAfBgNV
HREEGDAWgRRyYXkuanVpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUvUTLkCwFvnpejW/KGvdaDA31b+sw
DQYJKoZIhvcNAQELBQADggEBACMny/9Y1OPK7qwiBKBMt478eBgXnTlJ0J0HNebYcxN/l7fKIKMb
/eX/AQKIDsHeshmV2ekPU4yY/04veXx3QTgmE1bb4ksKEFEbU0LXlVPrnlgNn8M75cPymegn/2yU
r1+htd2eve3obmKc5Lrl0GP+4m72XxAOL687Aw5vRa4Lf294s+x4d+VRwUjoFTj9zyLhexWQuJv/
yX1HjSkrlIsRwi6DN0/ieL04O9aD1UNPlCC6akGnv4tgwlESh51M564qhonlfSW6La+L/aTIuQc0
88lq8s/VMBBGdc7176/v5TbNwEC/c5QYbp2n76rAmKKjhjwWmBk64yLT7CoIxk0xggJvMIICawIB
ATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypH
bG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDCUMagLNLily51ao1jAN
BglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgYKLdTxPoSZqKKhP5KOWvcmn9DTBn0jPX
4qDeT/68aH0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwMTIw
MjMwMDA0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIB
MA0GCSqGSIb3DQEBAQUABIIBADDnpa6Bf/KMzYH+MDa39lMurG0iIsf1guTUWN7QH7Xh19ZqpyzO
dc1iPtglk+fmKW7c+BJ1bo0k1U0KUij6kzvnUoX0EHGLXuk58xjZ8UeGi4CQrOUeqe3f+zqala7n
kzqYv9qlqP57wK1ByqKMQtYB7FZkwAbhDZXHhf7oOmhe55tKeuSvfJoJFsvuQ5JQdQS1XY67INrw
N7oJGodgCDyZmCy4sQS5qnnqIY1KBViiGqhmSbKggOXE2BE4aPYzFMmB5sfAC1SSkeGj5ymb5rJA
LBCr59pGsNxCHnn/brKGZinXT2m2zT+js60pUjxU4h7toiWOsHXtWsru2r//jeI=
--0000000000006c6f8705b95ceab0--
