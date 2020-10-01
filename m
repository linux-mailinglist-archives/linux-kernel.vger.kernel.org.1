Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98DF280118
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbgJAOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732339AbgJAOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:15:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53EBC0613D0;
        Thu,  1 Oct 2020 07:15:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so5982277wrn.0;
        Thu, 01 Oct 2020 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BEVeioAblvOjShBbM1jBg6agZyVGfRoTs/GtPxjBCbI=;
        b=oMhrCQWAOHqG6HxVMBmqVZPYxMru6FIXm3mJvAbc8rbL7tactK29OZk+GvNiM5PZk8
         rF6p5qi0AyXKRjNx+f23OJ8VJ+FleD7gQP9lLRLq2Y4dXvx012uxiiO1b7fpiRntPsoI
         PI0IvzVtjor7xv0a/TguOEJumonWGlfE65S4PwSOaNJs2XyLk4l1P2ZKGnjoloQnXwyz
         6CDkgfu187Eq4Lf2dvoi1cHfzHjCKVZhmf5NrBoC9ZlJVUhX8aK9BA+/KWZFgHuk8Wxl
         7frfWbzrA5r6wEJBfZ+pXNAGHzjb8U3WB0CfY06Dbqb+2MmXIltXnqleTmlcDnjvc9Mi
         EFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BEVeioAblvOjShBbM1jBg6agZyVGfRoTs/GtPxjBCbI=;
        b=HbEo7gVGRlw2ugI3ZSZ3AWHARrqmWTTmInCljAwWrPb4rEdmRzMDF5udluFCZnoZ+U
         mQNkfG3gdCx616tVTzvlUGT2/GQ/ttRe/rXtxQ/VuZPpjNYBWRsKNhIDanlIcWonJMWa
         g1IVnq1DmYrnLFZ1ZQjonvwehEY3FnxSnR9fFCJSYaf/ERo8vrXkryWsjAAYDbHnuaCl
         AI3Xe/urnrBk9TWFs9J6YEUafb3dkDtrK0gnPJNBLc7VCR4XOeGQmxJy8CbbR7Zq+LRz
         arD8eqymjDgDxRAqb/4+AoGKfK3YUGzDSGrg/sfIMLAs1oTcawtZTOu+Bl5FqPD7OVu4
         iH5A==
X-Gm-Message-State: AOAM533dlyHIlXQz1c46N7XkXL4oVuk6GzYb0gju21XFub9y5Fle4dTD
        DHBMGeQ1Fc5iMgNRX6rQntc=
X-Google-Smtp-Source: ABdhPJwUjBFOW1XPUuWU4ekSqDncW2iPM/Z45iswZFbsIeOrE+yuHZU3Vu24DSJPTVO2+ih9PwthHw==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr9174610wrm.174.1601561747382;
        Thu, 01 Oct 2020 07:15:47 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id v4sm96564wml.46.2020.10.01.07.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 07:15:45 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] clk: mediatek: Fix asymmetrical PLL enable and
 disable control
To:     Weiyi Lu <weiyi.lu@mediatek.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Wendell Lin <wendell.lin@mediatek.com>
References: <1599103380-4155-1-git-send-email-weiyi.lu@mediatek.com>
 <1599103380-4155-8-git-send-email-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <516a5f5b-f5af-0362-a73e-97b3db7300aa@gmail.com>
Date:   Thu, 1 Oct 2020 16:15:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599103380-4155-8-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2020 05:22, Weiyi Lu wrote:
> The en_mask actually is a combination of divider enable mask
> and pll enable bit(bit0).
> Before this patch, we enabled both divider mask and bit0 in prepare(),
> but only cleared the bit0 in unprepare().
> Now, setting the enable register(CON0) in 2 steps: first divider mask,
> then bit0 during prepare(), vice versa.
> Hence, en_mask will only be used as divider enable mask.
> Meanwhile, all the SoC PLL data are updated.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mt2701.c | 26 +++++++++++++-------------
>   drivers/clk/mediatek/clk-mt2712.c | 30 +++++++++++++++---------------
>   drivers/clk/mediatek/clk-mt6765.c | 20 ++++++++++----------
>   drivers/clk/mediatek/clk-mt6779.c | 24 ++++++++++++------------
>   drivers/clk/mediatek/clk-mt6797.c | 20 ++++++++++----------
>   drivers/clk/mediatek/clk-mt7622.c | 18 +++++++++---------
>   drivers/clk/mediatek/clk-mt7629.c | 12 ++++++------
>   drivers/clk/mediatek/clk-mt8173.c | 28 ++++++++++++++--------------
>   drivers/clk/mediatek/clk-mt8183.c | 22 +++++++++++-----------
>   drivers/clk/mediatek/clk-pll.c    | 16 ++++++++++++----
>   10 files changed, 112 insertions(+), 104 deletions(-)
> 
[...]
>   
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f440f2cd..e0b00bc 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -247,10 +247,14 @@ static int mtk_pll_prepare(struct clk_hw *hw)
>   	writel(r, pll->pwr_addr);
>   	udelay(1);
>   
> -	r = readl(pll->base_addr + REG_CON0);
> -	r |= pll->data->en_mask;
> +	r = readl(pll->base_addr + REG_CON0) | CON0_BASE_EN;
>   	writel(r, pll->base_addr + REG_CON0);
>   
> +	if (pll->data->en_mask) {
> +		r = readl(pll->base_addr + REG_CON0) | pll->data->en_mask;
> +		writel(r, pll->base_addr + REG_CON0);
> +	}
> +

I think a better approach here would be to add a flag to mtk_pll_data instead of 
changing all drivers in one big patch. This will allow you to add the driver 
that needs to write the en_mask after writing CON0_BASE_EN more easily. And it 
will later allow you to change the remaining driver one by one until all are 
using the new flag.

Regards,
Matthias
