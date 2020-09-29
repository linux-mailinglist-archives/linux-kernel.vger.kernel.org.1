Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDFA27BD16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgI2GY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:24:27 -0400
Received: from mail-eopbgr60102.outbound.protection.outlook.com ([40.107.6.102]:22241
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgI2GY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfrpxkFreaJw4FIuqAoJjAMc+CP/MF3epAX2yt6LYLmSmqjIYs0KL8uSDsLnVnvOWbgcf+Fjv88+Cz2cd0k0aNj60E1Usj12ZSKAHZZg2qy0GjY2skIQnYclOwqry92bk1fGrSbMLCMwzyHffV8ktMVfOu8TkDaDnEB3tBLCJC5PgdjFmy8kHUpoXwvIASO/4JenV4itleiFNpNagpjP7RhwxKHbos15HK2upKu5tt+pIwK1Pazcf7rpgJkxp9IKQr6kobGHUmVG88uWEmqyOrYsyodWZp15MnWlje3Gnemv6uG96SA//RgKuAGJX98Ci8Rz5CGP2tDqhEe8a4uxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHzFKzn1MJoymPr9SpUDNbAvVYMkG6N2Fna0z0JtjxU=;
 b=MPX2pfiyTb6TijXP6dcIc0NFZaHUldywEk61nriJRcfNhXudzylsapDZKJhVs6PEdOCHIApH2pb13L70GItftOuLY6c9bEenD0wuVGekCVtBdrsXcSb+36rRO+mNvWf9caZfTaFeeCMmFW73mzCeGhTXdLLUAD0JmeenRLbVDujsMxVglE9K2kf5GQeB7jBcBJ0mQgj+HerWogSFvy9Q78U1andq4LAvyFS5XOBJSYPsgfOkO0nimsDgsi28FSjp/+J5bll7P8LvOAIRcRCuW4fhWMD/QBz+AV1/xc9NAKXsSYNcxzqhgtnj3MQS82Go2z4AvYYZyFjBcE0O+9S3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHzFKzn1MJoymPr9SpUDNbAvVYMkG6N2Fna0z0JtjxU=;
 b=QuCMWmVhb6oddSQixPLSGamGG83VYNpLvoiIPUARkQbzOFFdD3/ng9Xws4p8t/qD2AJMKjDlXFbuJ1awUlH4kClaDkAwyWUxv5x1umSY9PKb0hHCw+QEruxIODlXExPU31VTnhIiP5Idp46iTBbuCi6kH3uotaJ5XDN7u17fzoc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3673.eurprd02.prod.outlook.com (2603:10a6:5:8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.28; Tue, 29 Sep 2020 06:24:22 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f505:527c:91ae:6990]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::f505:527c:91ae:6990%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 06:24:22 +0000
Subject: Re: [PATCH v4 1/6] dt-bindings: ti-serdes-mux: Add defines for J7200
 SoC
To:     Roger Quadros <rogerq@ti.com>, nm@ti.com
Cc:     t-kristo@ti.com, nsekhar@ti.com, kishon@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200921143941.13905-1-rogerq@ti.com>
 <20200921143941.13905-2-rogerq@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <1289d193-7c69-e93d-f6dd-287cba0f476a@axentia.se>
Date:   Tue, 29 Sep 2020 08:24:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200921143941.13905-2-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0069.eurprd04.prod.outlook.com
 (2603:10a6:3:19::37) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR0401CA0069.eurprd04.prod.outlook.com (2603:10a6:3:19::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 06:24:21 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50a4d2a1-6828-451d-10fb-08d864404db4
X-MS-TrafficTypeDiagnostic: DB7PR02MB3673:
X-Microsoft-Antispam-PRVS: <DB7PR02MB3673A5C4E85424E31FA9D5C4BC320@DB7PR02MB3673.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKRL1SwTeyBhZyHFpImXddzRVKqY2ss/Xel6R4G/In/1K3ZkNamfHMz8/OpI3CbFLNvRy9yr4ggl2Mek6dHNumO9oBYxwwomHl+hKahXWzzaOcqZ8Jnq/Vt2APRblHSh36JGk60ioIMzsIrdoieEZYyGpOpxUmVpzfCjWBaFBstkrphb6iAN0bHD7U2/GxevmL2AHUdsPNWA2AZ5P+jHNPGqEtMNMx0MFzvigv++fuCp9rqHbT8BVD0cZfKWGnAxAZo4cxmSr1pOqyX43pNhXYWWYFu2bavxbN1V5981d2Ep+6yBZJvSRzTXDnbAilaGsM1ep0EP7VRL5MXyzpJxIskH6NQALmsmKpb113fx30vWYaC+M9OStVe8SIwGx2ustz4fw5yDfUZ75bsNi4PNcx6uBDwUicLPhL8DJKZFonCp2nNYlfnhkAr5ID8vHccC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(396003)(136003)(366004)(31696002)(5660300002)(53546011)(36756003)(6666004)(956004)(36916002)(66556008)(66476007)(478600001)(86362001)(52116002)(2616005)(8676002)(8936002)(16576012)(26005)(2906002)(31686004)(16526019)(4326008)(186003)(66946007)(6486002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FdJ/D3mf0lBrwt+0XF3wHWfIHfMaJBG3/0nnU5sP/FNj7uZmGccwYRp2O6vpOYM4lxMOJqmbeI06+oqfuB7UcA2MvPaEyVc19SIsbmvSfLTeZPI/BkbVqmIvAHiSGWok7g5IWIVKXIPoRrIEpUFicMlCWAc4fPUfrMmtZIgVXclk5AJ1vT5x3OjI1w1e6+6nbuSa8HMj/upRSB78ZEQLClITtJWeZLVXt12Z217nkpWc3ARsOSj2U20nqgKtyaMfwWebwla7/+U+DtEXi6gD1zd9JuQ43tXDUPzm7T0Q1kLbfWGAEFtHb4ow4jhkqoetk9qi2j0gf7zxCGNVq6x361VdqgYBXiAqCrWmseyJrin3v0qXkAxH47lrOpjKWw4vdo1QiZj76cU3y61U3IMI/YF0G8u76za15wgpEr+khg1XT1J0RtN4rthqGqub2b5VxBmLGvUlm4LRKMHXPxyIe5bXqncs9fqJzQoVEAxEer32lRs51W/NQajSSIyz1dpxIIy9eupg6xjIUxgsSww8igDym1aur76R/iG4DM1G3v5VqzyNORXIIl3iekOhOZfiuCsYHDS/4gQIjZT2hAiXcMlNU7gxL31EJsZIbP9cchrDi95tFcgpa2aaNGu6y2SunMB7wXFpt7eVN4Pa8hunHA==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a4d2a1-6828-451d-10fb-08d864404db4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 06:24:21.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXzFI5q40i5fBtSDHT/cOEQX8SvAlH3wFDsISYSyH8VGgwhEnCDePwo5zC2SYt8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3673
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2020-09-21 16:39, Roger Quadros wrote:
> There are 4 lanes in each J7200 SERDES. Each SERDES lane mux can
> select upto 4 different IPs. Define all the possible functions.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Peter Rosin <peda@axentia.se>

Thanks for taking care of this!

Cheers,
Peter

> ---
>  include/dt-bindings/mux/ti-serdes.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
> index 146d0685a925..9047ec6bd3cf 100644
> --- a/include/dt-bindings/mux/ti-serdes.h
> +++ b/include/dt-bindings/mux/ti-serdes.h
> @@ -68,4 +68,26 @@
>  #define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
>  #define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
>  
> +/* J7200 */
> +
> +#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
> +#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
> +#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
> +#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
> +#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
> +#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
> +#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
> +#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
> +
> +#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
> +#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
> +#define J7200_SERDES0_LANE3_USB			0x2
> +#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
> +
>  #endif /* _DT_BINDINGS_MUX_TI_SERDES */
> 
