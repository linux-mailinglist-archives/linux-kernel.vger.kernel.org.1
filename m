Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE93327FFD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbgJANPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:15:20 -0400
Received: from mail-eopbgr150128.outbound.protection.outlook.com ([40.107.15.128]:37025
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731936AbgJANPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:15:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFo1aDCDSx8L5RIZOOvrcV19P/ryaoFyesMXdT9RxBeo6TM0DzZIKWv2nGyiHHczMzb2ePgP5DgvVN5/rNAusJqj++qpp8QKdQOEOgxNeOnEWCxlSpyCd0OHmVTNys2KZkVe2B3ttFFCay45fSU3Lfe0MqfgGk3cPPGfMQHh0A6tKwl4T4pkT1a59Ncdp5n9SV9MEMCiOQomS4G3lmx8d/e9lq260Q/kZD2Lxdrz0KfBN6Jh4vApb0wMJdPFvN8IhH7UL7KeJ8JD0hFdSh+amznyjcDAPCxsDeZ60AllskIqThepTEyt5AEjEgKD3NLbOYPmvYT/XLsb0C+wYYRRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gKPeFIjRR6YEUHxWYaj0QSznVA29+rhIQrA4qRUsWc=;
 b=NFPd9/Ps+1+QIg4KNtk82UJk8ulJGA171b3cGLCuyE9EmxGB4P0fz4nkgYQPd5KoIzjuVAaSm7NF97KehQW4O2R/5qGAIOptWnOHFmJoe+BF4NGINF+gSOD45YPNWZmSwpU/hhfSyh3UA3J5Tow5VJ18HltVp3uusRjEmc1sXx+d/1ZbdJYNGXXcOW4mRHhMJrgKGw4fZWoveFygLui+HZgNhS1DxrC5k4fsyGcwPx2zhqDSlTKqCvphmGbx9VbJ0Dn/db+2XF36qfq8m57Q0kDxg+UfQlsmV/UClGn0upw6Duuji0TBK5UA7n8IHC1NN40T9Cf46DxDzoYTtKthAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gKPeFIjRR6YEUHxWYaj0QSznVA29+rhIQrA4qRUsWc=;
 b=SELqUtGMJdEtR8RJi3S2aOz0K7szWHlnkny0N5sYi+Kz/3fQf1ObiEfaGmfgZgso/PjUI2lkd1OGxfOB7/bwBtpreD+99cJhxqY3JY9iwpHMzZbwPAUjRvVy+r8WAdVsRyEr/z0GOtiGin1jxEYli2fnwvxjOrEz+oWi56PtbSQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 13:15:15 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 13:15:15 +0000
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
Message-ID: <d40f71e8-52d9-e4c3-0fba-f122e03a5fd7@kontron.de>
Date:   Thu, 1 Oct 2020 15:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201001123447.1610-2-frieder.schrempf@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM7PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::32) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (89.247.42.197) by AM7PR02CA0022.eurprd02.prod.outlook.com (2603:10a6:20b:100::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend Transport; Thu, 1 Oct 2020 13:15:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddb65438-e070-4838-22b6-08d8660c095d
X-MS-TrafficTypeDiagnostic: AM8PR10MB3988:
X-Microsoft-Antispam-PRVS: <AM8PR10MB398818BA43E930E61BA7AF8CE9300@AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1l0dCkRaqRXcY89EAvNwyAMjM9cBC6w7zRbNAm+kko2dc4QdsAayAMXmxy+9uRYQU3dSvc0szpzZleeADID2/73TNzC2sypRORJOBocaKD7GsM91fv8jtrj7OA/rdVtACyFQhMy/MPIedDd/DNZApB8lKRiRsiQcipz1Lh03WAYAnhZGq6uPmXqXiq3cXtQs4VTkZNHN1r5Y0WRHRMDrays1JMYvp70GFMVDyERLcsaf9PaopFUQXybmeODHBTBg4unqVHFKKrvXruEfV436YWDeGXrDB01MM2lwp8pHIL77oYfC9MgMlnJSG01vOleXqDWB/Yfg6efC1Vrk8w/b8BeoYTwYQZw+7UvHrlzFui2hg0xLyMoqliqdP3ZiF1ZtFO2H/rdBdaS/NcjEdpkWDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39850400004)(396003)(44832011)(83380400001)(52116002)(6486002)(66476007)(2616005)(8936002)(31696002)(956004)(2906002)(7416002)(86362001)(4326008)(16526019)(26005)(31686004)(8676002)(53546011)(16576012)(66946007)(110136005)(316002)(36756003)(186003)(5660300002)(478600001)(66556008)(32563001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UflgXH/CMEkyvqkj1kG9qhd1iIReJ5sa169KpEOD1g3cZNg4TDOhMiaa0CV1VT3PxFyWuNpVwxQdVAeIiDy0I/acRS/0A3z56466joa3niESMfZ3ycYLTqeKMdpJuKQ9xHPq0J9dXCd/QmyUcAwPsc7da3Fdz4aTCsMXhNgNgKg2AGsMqUC/JDYfimPVn+/5ox0wzMUJ80fe9hyLZ1tBel1gqG7sdeCRwZ/jtulR/BOt2FM/Elkr2+/GWjBN6A20wD/CbEB8Bkc6Qsp2jV2FltNHGY+0BsGxFihnb7iX5yMc0MSNVRQdMzq9ERwiKTivRj2xbfgqn2vFfB6XWpcbK+QuptKTy769NOAbc3eNPXuxK7jh7ZcIKk05oFJtjcLGc1+Ecueizul/0GY9FMbgTfek1omQvKKWj/7YXDlXqcy35qNFT+GkDqNSMSZr2IwnRyioEObJwTBqouN5Da972cmQNwHrcf5ickUCpi7MRsMukg7rWoxSY4AKB4KT6JbIzTYvTUJ+hQJyXIttOjJkCPZA9X0909J7bhFTsPoW+mr3+krmDqmYSb80fWWr5vMOc72piHqWW8Bn1XlcxBW+bthINjWJz0ybodnqAeepoM5QP359mNBf1epMWv8wareFilKaOLSSFd3Da3AmC/tCAA==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb65438-e070-4838-22b6-08d8660c095d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 13:15:15.7373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJjDAxoINRqjUOi2SPGikkE+eHOt/VxCyCrN5eBzy94qQqdUgnm/tVHhpFuilNagNl1IPOAe58cMJowrhIvwV0mflHmT+2DgvpVp1AQtq/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3988
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

And before anyone complains: The above line needs to be dropped of course.

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
