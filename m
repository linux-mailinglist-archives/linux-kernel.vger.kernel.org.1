Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AFE2AB228
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgKIIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:06:04 -0500
Received: from mail-eopbgr10095.outbound.protection.outlook.com ([40.107.1.95]:23015
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729764AbgKIIGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:06:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQzniriBdSkBrBOLKsdb0PI1tMjgqXN7EpZG4tehRIiiFYRFUsGNnXd1SLO9QfqF2c+9AaLJJ6Wu1eQIJfiqmvgOKampZfeBPE1r5Sx8aUNJSIlr1E4GX4dy50AHDUwoDEqH6O782892/CDXm+kD1sa9YWZJkd+Uj7iaoCuy+gTakozT9sxWI5e4UoGJJaqprz5IH/sXUtn/lNERtWCEg9hqUDIzmWHPJx4WWCU/Uahyn0xHDIO5OOk5iHiaj9+baOKiCEKmbk21LibSfGCyKsE82gYHIds4al+tgiFPd9LTZg/F0sua7Dl5tEbPDMQJgjxpc5sZ9dTNrfLZzbzSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zOXN7zop2T/HDdQXTjekwZXesIq5YSEUPoN598O2XQ=;
 b=VwOLLTdvUQtuJ0qxZlVnXLIUOTUDqcQgITKq+HTDrZE8qZN0eNcK5tIrjsgd+yEUp/V+rpsYQi1SDdqNQLmyqjQ1p5xBFEcunNtcngZyCIrclEVp/J2VLz2fIkga/ESSu/bdcu5SfoLtVSYEReVvddSyr6r1a3xVB9sx/SuJDTDZdCO2w/yZhyFl/CNvhEELRbg4cMeJz4EwNumY46hdiYu0HJGe2C+kmRyoiT5lLJdhXVyCza8bJYUs0VVMuB6GtjzSZo+S8gPgGDyYKLY8Pp9QDaYgHIOCd6MsRghDB9/fiJRbtp55YFDhi8gIGBnLtN0Z9zEoEcPCmxqS+VjSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zOXN7zop2T/HDdQXTjekwZXesIq5YSEUPoN598O2XQ=;
 b=mOxv9mGZPtQdf4gJ+FWNGqZmLZyyIld/YBhItFS1dtVVLJke1VsjS8OZ5Vy+HvHFFqy3pglb9ap62I1U+WADEdOKsiGL2Sp6zqx+pWFX4KEhUgyeHxkbTh4T809ROuvUpC9cByv0LTFV9DT7JrpZQSwdtWmdRpgZgFkLmOiYZEM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3425.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 9 Nov
 2020 08:05:59 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a0df:b996:7029:318a]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a0df:b996:7029:318a%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 08:05:59 +0000
Subject: Re: [PATCH v2] arm64: dts: imx: Fix imx8mm-kontron-n801x-s.dtb target
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201108022321.2114430-1-natechancellor@gmail.com>
 <20201108191614.4062210-1-natechancellor@gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <ae69c4ab-7df2-c9d3-f245-d5050d18cc14@kontron.de>
Date:   Mon, 9 Nov 2020 09:05:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201108191614.4062210-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.147.118.32]
X-ClientProxiedBy: AM4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::22) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.30.119] (80.147.118.32) by AM4P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 08:05:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb33282c-01fc-4c9d-092e-08d884864af7
X-MS-TrafficTypeDiagnostic: AM0PR10MB3425:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3425B52281C7DFB21147330EE9EA0@AM0PR10MB3425.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DH0j0BsORiASg6kpaAIkJBm1ZPEP4KSnBeP40ezq3gQCTTT9ZfjonKOL/5tO7fyz3wSZkly1HjLzPtXr0C7ZwGzT9eYic0dE1ymZzynIVIIqhpB+vyOGyuYkEyfcWVXVcLsv41YVL23+VLmxGrMb6XKNxc7GLqRDlqUZZn4sui/Thr5RjN780oNMdQW6aiMUtt3XEuNf/cuZ8uJ+WavHR9PbrD5na0ky4piqck82lBA318AyNPLb7tTmkD5t9KUDfwXFh6VwQ4YctNzaHQeU34bMpGRcLOOS7+a3Aiok76BUPtJfvxNIENHysfePtCXqgAxyk4eJ7vsQqdkavhZ5zrJUr+4dat1nXjkP1PY8MCCBr1vxBmdKZkBPKs9PfZZkwRLhPasxpFd3slpKT5Dhjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(376002)(136003)(396003)(31686004)(26005)(52116002)(316002)(16526019)(956004)(44832011)(66556008)(8676002)(54906003)(8936002)(36756003)(2616005)(16576012)(186003)(66946007)(53546011)(4326008)(5660300002)(6486002)(478600001)(31696002)(66476007)(86362001)(2906002)(83380400001)(110136005)(32563001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Zwa3PRQea1JtUMacn8ZWEDUpXOqCLQwcFTN2N4DUX9e6ExXV3LmT8TZsEjdLgpmz4lruzmQpF2+aV6MShUIRh5f2be9/A3aspnUwFQ9QlD7Wm6MV5310TUnbSvGic/N2/UflX+xsgOYUddJkaakKPZ/sAlVc9IA6qrnp9/gaSL2uyMkuoSm1F6lm3Z12qCg/vlPtwtefeYgqoTa3QG+UfbIsqnl9foWgzWYRV7YRb/8mmPTOwtxFg+lfVQvY8D0cxaHZj5gXC3PJFidOiMyLA4fG4ndVHon/nFU7BYIj0B3jkK0X0yNlrP0trTFgCmTKglb2LKElzY8hgD6d7Knza2xidsx/gr2MrM2WKQUJk9TTjWW/ABnYjCqD0voLBUhVFAMCiGbm0JZGpBPxy2aQxK8ZsgXB77GcmF1qVjfE8WWw3bYayLGtOhOYNWoo8kfj9ijjzTeRyu9hJBa64IILymXTK6EqcLc5/bkq8fRV86JJh/C5oDMrvnUYl5HVfR0aOpEWiFoYSJznhnjLfLPNqIMu9gu0npOkITXLrIZBvz16s2z7pZ6RJwVN9VGgvBYqk2OC16pRwaGgZV8aXYmAqe9wd93XFiOSbbOIRl5SkXky9HtI1Bm7ql1YtHL7KYvAz8Qej7fATog17P5pR/9z5Q==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb33282c-01fc-4c9d-092e-08d884864af7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:05:59.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPZk2BwyETh0MRJtuYKFSCrZlmvVjLs0CDYMYe65cYf2roxJ/cT36pKmcp6BeKct1VXpyOTzGDuIlb4R5DYO44Uu26JJfsImuIlkFjOvIG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3425
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.20 20:16, Nathan Chancellor wrote:
> While running 'make dtbs_install', the following error occurs:
> 
> make[3]: *** No rule to make target 'rootfs/freescale/imx8mm-kontron-n801x-s.dts', needed by '__dtbs_install'.
> 
> It should be .dtb, not .dts.
> 
> Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for fixing my error!
I often use Yocto to build the kernel and it doesn't use "make dtbs", 
but reference single dtbs directly by its name. I probably should have 
tested this more properly.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
> 
> v1 -> v2:
> 
> * Simplify commit message and error (Krzysztof).
> * Pick up Krzysztof's tag.
> 
>   arch/arm64/boot/dts/freescale/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 876bf484bbe6..6f0777ee6cd6 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -32,7 +32,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> -dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dts
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> 
> base-commit: 39fabe22e0f8c00334882ceac1dc70ffbd7f4871
> 
