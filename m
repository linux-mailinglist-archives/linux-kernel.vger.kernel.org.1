Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DCC27FF52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbgJAMip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:38:45 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com ([40.107.6.111]:50499
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731993AbgJAMi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:38:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLdVFhPC4GW/KMrFlbhU84LJgrlK035Yc1UDtKVWyu9m8wj8yxHSemwKC2fJHzNAgW22ur6cUUl+cdD1JGmpOH8j5fcs/OCdFoBOV411GJm2cu5ptTkvmbIzTTXCPDG1lqm8qYyGa/KLcK/Qm4YhTT2W8lLsKh+xdk7YXCWsOnWtaJ6AKKJfNLcsZ4borT5b8SyulkvUTNflU9Or7iXrqjpLRuVLgQVETUKmUAgA+AKG+0PK8H6zFAzOw7+I5Lw3k4K4YjnqTNYKl97WBMY066EcNCdg11wpJYahWoWrpSQXSZabctCnNG17rmpAW2mpdPurak8aMazXT8y1BHGIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZZHFQf0LQ65mVjAftyCQyEEBVnxkamPSZfzvOtlZnA=;
 b=QFEZcPKH8RF2DKgbKbbE0ov7UXxy50JWwVc1Hb6G9PxcBs4wOLetqX9hBUKHmWLubyDx1AOyQVlL+K4bMvCRUttdcM2LVLROs6398U6iwv4bpcERwX3h/Vm+9uVidw6WcZY4ulR0RJYoc3hvo5t4+FDgnnd9SrBsTyzkNA2efTuTMUZvHc5qi4zjSJsVeVAOlGi+gOE/0SfyXY+XDnL7/YrnqcJ5EU5Q+2yximsXGJ8fUZAgeptRjI1FgadhktYdBJwzGEs8dRBr7K7opBtnpt7iVEhbfdeLc2pApHEUSzusctvrXWvi5Kkrtqbygg90h6rc4yd16v0tEgUTnl7LbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZZHFQf0LQ65mVjAftyCQyEEBVnxkamPSZfzvOtlZnA=;
 b=mkxgt8V7yNceh6qz8HjZMwudKG5d9qnkY/lwx5YvAc6yoNwUoRR/o87vMQRgvtl2VJm0P1VQDTHafFhUgaR4Uqw1Vloj9UNVwsq9Kxg9z1qdbGqo6klFbEkD5PqKDJN1yFgOJG9yp0KjY+aT6lZhk4GuqhrM6jJRRpseq8/Gt6Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2354.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:da::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Thu, 1 Oct
 2020 12:38:25 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 12:38:25 +0000
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm-kontron: Add support for ultra
 high speed modes on SD card
To:     Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201001123447.1610-1-frieder.schrempf@kontron.de>
 <20201001123447.1610-2-frieder.schrempf@kontron.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <ebf8035f-8d9e-d2e3-d1f4-c398bca92790@kontron.de>
Date:   Thu, 1 Oct 2020 14:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201001123447.1610-2-frieder.schrempf@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM5P194CA0014.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::24) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (89.247.42.197) by AM5P194CA0014.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Thu, 1 Oct 2020 12:38:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10f2071d-3059-4a1b-ab64-08d86606e42c
X-MS-TrafficTypeDiagnostic: AM0PR10MB2354:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2354CAEFFC5D70537BE3B8B9E9300@AM0PR10MB2354.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWZmx/p0eTQwkvXtLXmdFmM2HySs/cdpWaIU7zoXl8dUNyYizbm1giVEiCPKMm85tNNdjhlMetENUPZEMhJNhJdJuQWhiGZdahRN2waATY2QrTN65hG1AgZ7WMsycm1rpzudqqVr/mod/4nB5w9DCi4n1qRSk8Kahdt2E8z2/Ma+Srl7MrmnLfI69TW09FaX91bPpkkfW21RPWxdgizKGzdoZKegHBkGlsRjKyCoSgnhRiM3+1pM9KGDGd8URr/lBrnYOWn6VmT3iHI9T0emIfUtiZ/1dS3blKVGUJU4hUUPsusSf/KIWMv/+R/MIYttD/np9LmmSPNkXUJsUZGBGq8ingBIFT+Czl7FW4f5H8hGydVQ6hbD0FLWk04dT3EP/HCzGQEWSStdkKgNL0itmexmoMRlFf0o8Q81Zv6zAM92AAZFnem9L+hgGKdzIYWLlGcSa7hfQMjX1eTTu68ZXKUbtC1+7Uf/vK340+6rLxZLhbDouIjQgpW6yxaOuqZQ+2Sy0hWynizVyKIUejI3vx2HqwsnQAF7r+pyQMxgn40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(6486002)(26005)(7416002)(86362001)(31696002)(83380400001)(186003)(16526019)(31686004)(53546011)(52116002)(478600001)(2906002)(966005)(110136005)(66476007)(36756003)(2616005)(316002)(8676002)(44832011)(66946007)(956004)(66556008)(16576012)(8936002)(4326008)(5660300002)(32563001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: K0wTJHjgj5wuuVF0V5NAREnS52HS1nnypmv5oqkt3PZduMiRnRBz+EgSCp5zEXkTV/Ld1FYUOHxH71eqIebaqgsaPTu6KR03qq6VJZx3B0/gm6wodTxB/LV28NieTrnZl0aH52TAiQ96i5++eKKq/tHe+cljl4DlMv3mAJyAIVWy+v69LGwb43KO3JU/tnVCHoPHaZjGHFr8U/XGIWDK64PoicxyskRd1ySFKkCOA8Fyj8UqvyLrEYidjDu7364qmspunc3Eo3dMoXm264UB20/t1cgcqi4ESOhTbSdST0JuUSj3gP+t6hbBPkMTFC/ZBFiahuYbRUJvgqWQfVhR9zqGvxzj/YnUvBzHyzNmds0bZe+WOOt2iNEUvZFEIx/BaAI0BeL3qGSYS9WS9B4sfwzhIx3TEIITqNi4eIqOFPnRu7hzTKMm+HkUm1ziZkKk3r9NMycidwQJTblPTF5zmoNPjOEffW+fna/Gjt/4vO67gbJe8UlrUclITEw6h/cbFFpiO5vqJZRlrVtibPjIeorRXJR/5xJHhLrt8ty3BCG0L8E3hpPSLPkCmj4caWOaviP1O9gsfScGxs3y8iCLiYUetidLNs4UvysBxlN8OrSNXhP5oOKVRBktDcHMYkc9Mp8sqmS/I45pqrg+u0Tkqg==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f2071d-3059-4a1b-ab64-08d86606e42c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 12:38:25.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhRZFxwY8bP7adjK1jlUWeIZUcrLr3jQlQXZtqhBh03qvY4AOb0GOC1K6BH9x+ZWN4MFX/JONHFicsb3AC+enwjZefO7ioxrsSO8is5olVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2354
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.20 14:34, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> In order to use ultra high speed modes (UHS) on the SD card slot, we
> add matching pinctrls and fix the voltage switching for LDO5 of the
> PMIC, by providing the SD_VSEL pin as GPIO to the PMIC driver.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Sorry, forgot to mention that this depends on the board support patch:
https://patchwork.kernel.org/patch/11811347/

> ---
>   .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 27 +++++++++++++++++++
>   .../freescale/imx8mm-kontron-n801x-som.dtsi   |  2 ++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> index 389e735b2880..6913aefa56aa 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> @@ -190,8 +190,11 @@
>   };
>   
>   &usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
>   	vmmc-supply = <&reg_vdd_3v3>;
>   	vqmmc-supply = <&reg_nvcc_sd>;
>   	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> @@ -320,4 +323,28 @@
>   			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>   		>;
>   	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> +		>;
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> index 5c6a660f4395..282a56fb3949 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> @@ -85,6 +85,7 @@
>   		pinctrl-0 = <&pinctrl_pmic>;
>   		interrupt-parent = <&gpio1>;
>   		interrupts = <0 GPIO_ACTIVE_LOW>;
> +		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>   
>   		regulators {
>   			reg_vdd_soc: BUCK1 {
> @@ -224,6 +225,7 @@
>   	pinctrl_pmic: pmicgrp {
>   		fsl,pins = <
>   			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x41
> +			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x41
>   		>;
>   	};
>   
> 
