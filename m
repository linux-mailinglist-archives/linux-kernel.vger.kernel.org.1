Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3535F29E8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgJ2KVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:21:51 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:4836 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgJ2KVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:21:50 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TAHDMM004599;
        Thu, 29 Oct 2020 11:20:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=qld9yon9YboDN8H9lMAvI0/c1iFxnx7SJQj59lzAMVg=;
 b=zGCfAuRFsjl3iJlYvPrc8g5lv2YzZMxgRpTawt1867zj1AC+pTE0UYtvxKwrpTvzPDD3
 nswiy8lFodnYptO6s9UrSWALmQrKnvtWwXSFN7OfP0koXAqLsAHOA8KGUwV3hB7WnJ0l
 a9A+3p3azduvwH0rZnyPSlu7uWOhwKuXPzXZTMhtWeow2HwrY8TT+ZNhGd1kweUEX4Ag
 yXgEwKQJpC9fY9N0g2o19Efuh3QO3RyBJhpw5GqEArAJz+LoAY9mP/uG5LhBwSkynr4M
 ZWTX0xDcuPDaazenQgSYyA+5biK3Y6y/+80wukGo3PmKvB5Q+ohSxu9iEjnncAsVjHAc qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccf3yg7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 11:20:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 477E5100034;
        Thu, 29 Oct 2020 11:20:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F200025D241;
        Thu, 29 Oct 2020 11:20:36 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 11:20:33 +0100
Subject: Re: [PATCH 15/17] phy: phy-stm32-usbphyc: convert to
 devm_platform_ioremap_resource
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Ondrej Jirman <megous@megous.com>, Peter Chen <peter.chen@nxp.com>,
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
        <bcm-kernel-feedback-list@broadcom.com>,
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
        <linux-mediatek@lists.infradead.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Scott Branden <sbranden@broadcom.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jyri Sarha <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        Sanket Parmar <sparmar@cadence.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Jun <jun.li@nxp.com>
References: <1603940079-8131-1-git-send-email-chunfeng.yun@mediatek.com>
 <1603940079-8131-15-git-send-email-chunfeng.yun@mediatek.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <64bc5ff6-5495-30de-108f-80a4a8c54e91@st.com>
Date:   Thu, 29 Oct 2020 11:20:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603940079-8131-15-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_03:2020-10-29,2020-10-29 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/20 3:54 AM, Chunfeng Yun wrote:
> Use devm_platform_ioremap_resource to simplify code
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>

> ---
>   drivers/phy/st/phy-stm32-usbphyc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
> index 2b3639cba51a..0ab18f2078db 100644
> --- a/drivers/phy/st/phy-stm32-usbphyc.c
> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
> @@ -311,7 +311,6 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   	struct stm32_usbphyc *usbphyc;
>   	struct device *dev = &pdev->dev;
>   	struct device_node *child, *np = dev->of_node;
> -	struct resource *res;
>   	struct phy_provider *phy_provider;
>   	u32 version;
>   	int ret, port = 0;
> @@ -322,8 +321,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   	usbphyc->dev = dev;
>   	dev_set_drvdata(dev, usbphyc);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	usbphyc->base = devm_ioremap_resource(dev, res);
> +	usbphyc->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(usbphyc->base))
>   		return PTR_ERR(usbphyc->base);
>   
> 
