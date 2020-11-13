Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856FB2B181F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgKMJVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:21:45 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6985 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:21:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fae50300001>; Fri, 13 Nov 2020 01:21:52 -0800
Received: from [10.19.100.45] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 09:21:41 +0000
Subject: Re: [PATCH] phy: tegra: Don't warn on probe deferral
To:     Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20201111103708.152566-1-jonathanh@nvidia.com>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <cfcfb222-2b4d-31e9-a868-b9e7a7e0cc6e@nvidia.com>
Date:   Fri, 13 Nov 2020 17:21:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111103708.152566-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605259312; bh=jW9wXiL0GJuLyPme7G5JtmrdGa0/tP4O40Ns1vfyadY=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=MYoF28Q2jWCQvWTwpuoETJG1A4up1mDCHJ0Re11U6EO43y2cCHlZpZ+Kp6du4DB7m
         88E5mh8E4sh61F4iFsmQXl79jmBCuOJOp4JYta5q8RRCfEnQd6NTnYz/lBDfU2bT46
         XCwqS4tvQK/Tns4o3cKbOBUiuSKFZvB2RDN7Ek3Dnnhyg6EkJjJ12FulevqCTd87jj
         GF9mFUhIhSE+T4RiBHwXt/Zws8psTPTwmhnhXFTaAgH7CB5m7KN3+gUB2CIllF1LkQ
         pXlhN63UWKrMTnweTZkT/N7JvE2SRx4c4U24egYuIzi4APUYYafqQ8SI429YljUThu
         HSAX5NqFvx6Xg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 6:37 PM, Jon Hunter wrote:
> Deferred probe is an expected return value for devm_regulator_bulk_get().
> Given that the driver deals with it properly, there's no need to output a
> warning that may potentially confuse users.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/phy/tegra/xusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index ad88d74c1884..2eafb813825b 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -1200,7 +1200,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
>  	err = devm_regulator_bulk_get(&pdev->dev, padctl->soc->num_supplies,
>  				      padctl->supplies);
>  	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to get regulators: %d\n", err);
> +		dev_err_probe(&pdev->dev, err, "failed to get regulators\n");
>  		goto remove;
>  	}
>  
> 
Acked-by: JC Kuo <jckuo@nvidia.com>
