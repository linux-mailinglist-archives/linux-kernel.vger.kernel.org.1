Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C208D2AAEF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgKICEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:04:47 -0500
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:33376
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbgKICEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:04:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjZRWHCZa6UPXEQ0Psgqu7ae5Ejg8qS2fXhDno2yEXgKiyFzpMwiLFFySXzyJ0XNQiZ3Wf9RAYK9+8HAlIabmIUGa2xSGJRewymnfbYB8n3BGg/QCyYOSp13yOEPzwBPChq2YgfCcrPbk8FUfkG9SkX9h+L5SPGmjJ8yNf4uBy0IaNhmW2EbPiNlxoSqQsx9c76V+is8A0xtSrIv1JAKUG6J5T7L8SSgBBqYg6kjkVh1PC70bGVmmUfHy7e/9sfv2j1lcPxz39EJ/q+SITBEdYE9zRWmF/ktbBxT0DRSsium2r0VhdUTvMB3qgMXn6iCdqOTJJ8cQqfqFMwm1e4k2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVEoGc4pV9zGxubvBWRdGb4X9FkXV5W7HKrRovjb3PU=;
 b=oZYK27fY9ksJ2DN5ggptVc7u9gkhXJjvPXBPv4Iipw3EEhTj9TpInALW5JOmVeX2/fCqSMmzZWr5bYMQ7tfKWB1VXylAhL/jdG6mfomspk5mozZTGCg6bF8J0Ya8zvcxLg9Fom5MHZe0EyW+2srx52lspRN+OQuh/4SeZKFEYGz77Fh0xYGzZYerNpAcDeeoWGfoA3Gcw/XQ0Q9iTB71O72RgoyeQTPnMSan2xtc8PrIfTfL7KBzZIuF1YqHildRuuQ/dsxk6DWHonZZOIjsXpNzJ53pjVTo9gzbic6H/Qa25V8u/npeurRmr97TjqD98DFiLNQy9F709NfYLyqLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVEoGc4pV9zGxubvBWRdGb4X9FkXV5W7HKrRovjb3PU=;
 b=fj6ma5fsQ92rhj3vwdS2lBTVauE6DKbYHuE/DCdIxqLyMZ+JoH6HNh7v+i8j14Plz/LSGHD46g/CIiBq34HgL30Oob6oj/kTBgVL6xe5QEiNRkGU1TH9gPAjc7jCpYQ3szXoZvKo5fB57beJRVgMrt4+cocGkcxJucOfd2UjSIc=
Authentication-Results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SN6PR03MB3981.namprd03.prod.outlook.com (2603:10b6:805:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 02:04:42 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 02:04:42 +0000
Date:   Mon, 9 Nov 2020 10:04:23 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Peter Chen <peter.chen@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Anil Varughese <aniljoy@cadence.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Yue Wang <yue.wang@amlogic.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Remi Pommarel <repk@triplefau.lt>,
        linux-mediatek@lists.infradead.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Roger Quadros <rogerq@ti.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Scott Branden <sbranden@broadcom.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org,
        Sanket Parmar <sparmar@cadence.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Jun <jun.li@nxp.com>
Subject: Re: [PATCH v2 07/17] phy: marvell: convert to
 devm_platform_ioremap_resource
Message-ID: <20201109100423.0d734ec3@xhacker.debian>
In-Reply-To: <1604642930-29019-7-git-send-email-chunfeng.yun@mediatek.com>
References: <1604642930-29019-1-git-send-email-chunfeng.yun@mediatek.com>
        <1604642930-29019-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR03CA0035.namprd03.prod.outlook.com (2603:10b6:a02:a8::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22 via Frontend Transport; Mon, 9 Nov 2020 02:04:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a6834b6-9686-4a1d-3646-08d88453d295
X-MS-TrafficTypeDiagnostic: SN6PR03MB3981:
X-Microsoft-Antispam-PRVS: <SN6PR03MB398132B37C6A0B7EE5C03CD3EDEA0@SN6PR03MB3981.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/9+//NVyJSFxnYEVIe0z3QfJ1izFffoPCEY/OS/kKjgafdAAzoruBOMSBuQf1+MK1zavgacLuMKo8Wemq7mfdMOQRi4N4B0JGbvpH+43h8i5L1DPCtbnlF76zeCTccMpvnIP/t2X7AfVWbdETk+NBapwIWm9wfQS77tiDyzTU3TKbuEiZoXRURPqU9rZbvLt0BDqok6u4UztIj/0wf63GY2z05ku7IjSxsiV6wNK1TSbbK4AtUZG+r9oOjmo18lOVc1C891Pyawf4QF6tXr8b8YGlDgPfdLo0PavxMTrp8iIPyh3nA5xFILlUDu9hmlcNxY9YmeHQ+SWrTtoKFlsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(5660300002)(54906003)(9686003)(7406005)(7416002)(26005)(956004)(478600001)(6506007)(86362001)(52116002)(7696005)(8676002)(6666004)(55016002)(83380400001)(8936002)(186003)(16526019)(1076003)(2906002)(66946007)(6916009)(66476007)(66556008)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YYjAoLMOvfAckFQnPPBYN3l5xKf2pX+wT/EyT8hcxSY8+pUiZe+jBY8SZ1lvV5jCpxVobXwDJcliYpS4WJjed+PNFR84DcuMD120ceEFjqipoqAlQwrWGnKEF+4e6R7TnfqqtxCt0s0FrNy8z62SnhunMKmlYz9qzkFvsWYM8eqHxLcotnBW6W90GSHU/0vN8xjJ6kHUA+cOw+vJldgl3yV09bKSmdcqQA16Ji+m/JLAn8dv8Lv7ZOD45swEId/Daw07l+xiqGDCdjqEHXgk3U3Nqm2fpvMTQ98sRVpwk41uPmYqhavTr2x+I6+S4q569oJiiSKWnSqu6W0GD4OX3t00Lh/xSppm7EQLJGchQjQl/S5L0jbfofqKdYjfdS1Zt50tzccxoCpXp13SL2kZxIhDGaux+KR/xoSobCyKAwOJ8WByX4xzEVNQ7a9xKdhPHw4sQhKL5D7PRCDA8cUHNeBNP+zJnZVOJUDcjKcysQ/lhAjIo1/cwTNYkK+iS05VHwKy4NiqSrmYEEeglkMAV2KRR9k5QkeI+xfVuNcn/oSc4Z/zE2rVAFiBi0ZMK22JFtptZv+UTNO5V2BL48BOzORq9kTFIkT3hIbbHmZIjFiIP6Ks3I6YRlnm7O/UomgGIU+sdg/XZCu9LoAKbHmaGA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6834b6-9686-4a1d-3646-08d88453d295
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 02:04:42.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbR57/27HhbrxRsAkPFuOjzWnJ6mxjXsFVBGvq0wPy3YlaRZK/yv3tfHrfxN5QI2gyddmQVF0pxiLUtic+/Kcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 14:08:40 +0800 Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:


> 
> Use devm_platform_ioremap_resource to simplify code
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  drivers/phy/marvell/phy-armada375-usb2.c | 4 +---
>  drivers/phy/marvell/phy-berlin-usb.c     | 4 +---

For phy-berlin-usb.c, 

Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

>  drivers/phy/marvell/phy-mmp3-usb.c       | 4 +---
>  drivers/phy/marvell/phy-mvebu-sata.c     | 4 +---
>  drivers/phy/marvell/phy-pxa-28nm-hsic.c  | 4 +---
>  drivers/phy/marvell/phy-pxa-28nm-usb2.c  | 4 +---
>  drivers/phy/marvell/phy-pxa-usb.c        | 4 +---
>  7 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-armada375-usb2.c b/drivers/phy/marvell/phy-armada375-usb2.c
> index fa5dc9462d09..b141e3cd8a94 100644
> --- a/drivers/phy/marvell/phy-armada375-usb2.c
> +++ b/drivers/phy/marvell/phy-armada375-usb2.c
> @@ -105,15 +105,13 @@ static int armada375_usb_phy_probe(struct platform_device *pdev)
>         struct phy *phy;
>         struct phy_provider *phy_provider;
>         void __iomem *usb_cluster_base;
> -       struct resource *res;
>         struct armada375_cluster_phy *cluster_phy;
> 
>         cluster_phy = devm_kzalloc(dev, sizeof(*cluster_phy), GFP_KERNEL);
>         if (!cluster_phy)
>                 return  -ENOMEM;
> 
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       usb_cluster_base = devm_ioremap_resource(&pdev->dev, res);
> +       usb_cluster_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(usb_cluster_base))
>                 return PTR_ERR(usb_cluster_base);
> 
> diff --git a/drivers/phy/marvell/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
> index a43df63007c5..78ef6ae72a9a 100644
> --- a/drivers/phy/marvell/phy-berlin-usb.c
> +++ b/drivers/phy/marvell/phy-berlin-usb.c
> @@ -165,7 +165,6 @@ static int phy_berlin_usb_probe(struct platform_device *pdev)
>         const struct of_device_id *match =
>                 of_match_device(phy_berlin_usb_of_match, &pdev->dev);
>         struct phy_berlin_usb_priv *priv;
> -       struct resource *res;
>         struct phy *phy;
>         struct phy_provider *phy_provider;
> 
> @@ -173,8 +172,7 @@ static int phy_berlin_usb_probe(struct platform_device *pdev)
>         if (!priv)
>                 return -ENOMEM;
> 
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       priv->base = devm_ioremap_resource(&pdev->dev, res);
> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(priv->base))
>                 return PTR_ERR(priv->base);
> 
> diff --git a/drivers/phy/marvell/phy-mmp3-usb.c b/drivers/phy/marvell/phy-mmp3-usb.c
> index 499869595a58..04c0bada3519 100644
> --- a/drivers/phy/marvell/phy-mmp3-usb.c
> +++ b/drivers/phy/marvell/phy-mmp3-usb.c
> @@ -246,7 +246,6 @@ MODULE_DEVICE_TABLE(of, mmp3_usb_phy_of_match);
>  static int mmp3_usb_phy_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       struct resource *resource;
>         struct mmp3_usb_phy *mmp3_usb_phy;
>         struct phy_provider *provider;
> 
> @@ -254,8 +253,7 @@ static int mmp3_usb_phy_probe(struct platform_device *pdev)
>         if (!mmp3_usb_phy)
>                 return -ENOMEM;
> 
> -       resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       mmp3_usb_phy->base = devm_ioremap_resource(dev, resource);
> +       mmp3_usb_phy->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(mmp3_usb_phy->base)) {
>                 dev_err(dev, "failed to remap PHY regs\n");
>                 return PTR_ERR(mmp3_usb_phy->base);
> diff --git a/drivers/phy/marvell/phy-mvebu-sata.c b/drivers/phy/marvell/phy-mvebu-sata.c
> index 3c01b5dceaae..51a4646e2933 100644
> --- a/drivers/phy/marvell/phy-mvebu-sata.c
> +++ b/drivers/phy/marvell/phy-mvebu-sata.c
> @@ -80,7 +80,6 @@ static const struct phy_ops phy_mvebu_sata_ops = {
>  static int phy_mvebu_sata_probe(struct platform_device *pdev)
>  {
>         struct phy_provider *phy_provider;
> -       struct resource *res;
>         struct priv *priv;
>         struct phy *phy;
> 
> @@ -88,8 +87,7 @@ static int phy_mvebu_sata_probe(struct platform_device *pdev)
>         if (!priv)
>                 return -ENOMEM;
> 
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       priv->base = devm_ioremap_resource(&pdev->dev, res);
> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(priv->base))
>                 return PTR_ERR(priv->base);
> 
> diff --git a/drivers/phy/marvell/phy-pxa-28nm-hsic.c b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
> index 31b43d2ee39a..c5c100563f55 100644
> --- a/drivers/phy/marvell/phy-pxa-28nm-hsic.c
> +++ b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
> @@ -162,7 +162,6 @@ static int mv_hsic_phy_probe(struct platform_device *pdev)
>  {
>         struct phy_provider *phy_provider;
>         struct mv_hsic_phy *mv_phy;
> -       struct resource *r;
> 
>         mv_phy = devm_kzalloc(&pdev->dev, sizeof(*mv_phy), GFP_KERNEL);
>         if (!mv_phy)
> @@ -176,8 +175,7 @@ static int mv_hsic_phy_probe(struct platform_device *pdev)
>                 return PTR_ERR(mv_phy->clk);
>         }
> 
> -       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       mv_phy->base = devm_ioremap_resource(&pdev->dev, r);
> +       mv_phy->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(mv_phy->base))
>                 return PTR_ERR(mv_phy->base);
> 
> diff --git a/drivers/phy/marvell/phy-pxa-28nm-usb2.c b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
> index a175ae915f02..0b390b9d2ae1 100644
> --- a/drivers/phy/marvell/phy-pxa-28nm-usb2.c
> +++ b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
> @@ -294,7 +294,6 @@ static int mv_usb2_phy_probe(struct platform_device *pdev)
>  {
>         struct phy_provider *phy_provider;
>         struct mv_usb2_phy *mv_phy;
> -       struct resource *r;
> 
>         mv_phy = devm_kzalloc(&pdev->dev, sizeof(*mv_phy), GFP_KERNEL);
>         if (!mv_phy)
> @@ -308,8 +307,7 @@ static int mv_usb2_phy_probe(struct platform_device *pdev)
>                 return PTR_ERR(mv_phy->clk);
>         }
> 
> -       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       mv_phy->base = devm_ioremap_resource(&pdev->dev, r);
> +       mv_phy->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(mv_phy->base))
>                 return PTR_ERR(mv_phy->base);
> 
> diff --git a/drivers/phy/marvell/phy-pxa-usb.c b/drivers/phy/marvell/phy-pxa-usb.c
> index 87ff7550b912..ffe889893ff4 100644
> --- a/drivers/phy/marvell/phy-pxa-usb.c
> +++ b/drivers/phy/marvell/phy-pxa-usb.c
> @@ -286,7 +286,6 @@ MODULE_DEVICE_TABLE(of, pxa_usb_phy_of_match);
>  static int pxa_usb_phy_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       struct resource *resource;
>         struct pxa_usb_phy *pxa_usb_phy;
>         struct phy_provider *provider;
>         const struct of_device_id *of_id;
> @@ -301,8 +300,7 @@ static int pxa_usb_phy_probe(struct platform_device *pdev)
>         else
>                 pxa_usb_phy->version = PXA_USB_PHY_MMP2;
> 
> -       resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       pxa_usb_phy->base = devm_ioremap_resource(dev, resource);
> +       pxa_usb_phy->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(pxa_usb_phy->base)) {
>                 dev_err(dev, "failed to remap PHY regs\n");
>                 return PTR_ERR(pxa_usb_phy->base);
> --
> 2.18.0
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
>
