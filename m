Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0D29AA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421658AbgJ0Kxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:53:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37146 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421573AbgJ0Kxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:53:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so1357273wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WpqypFnY9U7+uLzrR/1nVmk8p5K95P6Yb5r5N8zFRV8=;
        b=SMviA3v7hqhKjl0nNuRoXzMKyrWCHttiZtdn3Ryxceo34RlaxwsSVGfZE9aBh66ic7
         XVBDmwzvUy0hcFtsIQZyYFDp8jFoacC7pL7oR99+YkkOElWEQy55jjCj6E6mzKoZYKDo
         YbytgNuPCMp65uYnq/4e9bHZGLYUZqXIokImv9u8vQlmbFUJLpvra7p19DNgeAlTc72C
         oVfNY8QXGJFkE4uDLTLIuq+Ldxj0LPn5gLph80+JBsxssfkMXyvUsH5gih4WlSoyURJZ
         TaghWavZJz71030V5bV5huvIyU0e8aKaibwPO4dwbXfQ0IUr3UhBMYAX7ZSA3VPLx8VV
         03+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WpqypFnY9U7+uLzrR/1nVmk8p5K95P6Yb5r5N8zFRV8=;
        b=TmMF0Ksf4Gq5mCoxCRUjGIrrxV3vYMA841u5Sos+xqymu1umlFgoGsQ3XlnWeHCy8Q
         PxBDC8RegwkOIKWNjuXYfplQD2MeroPyFiJXfs+tDkipzrrgsqTdw1wfZczDu4mkx8Ml
         pFIrRn7KqQpX2lIER3FEk1NTEdzWEBV1eLfDOQ63H1oDv03sr8xe20jPNl9fufI2iPWi
         PJjRRikWVIG2bJwFuwfmXKJT5ObNPBjMLpqrkqRVuMvFXTt8jNAKsHjvGF9Jz0iegYQZ
         I16Rk3TIR+0yFbG5cZcwNROojDXPbNG0uv9u7Z4My6mZiinsgTmDjFAff+ht7rY7oQTq
         V58A==
X-Gm-Message-State: AOAM531qX7SAfodq2txvHqc5AkvxrKoI7Tcn8uHIXUN+UXaMDzfpCE8Y
        YcX0h5YjA55FGmBCM8ySXWg=
X-Google-Smtp-Source: ABdhPJwyIZPcF6b+fQtE1zkd+SAnxeK5QDQlxoK7O1bXCgNEwx76qskbS2hNznMNMX01TBXkvCJjnw==
X-Received: by 2002:adf:8541:: with SMTP id 59mr2138495wrh.61.1603796016049;
        Tue, 27 Oct 2020 03:53:36 -0700 (PDT)
Received: from ziggy.stardust ([213.195.117.206])
        by smtp.gmail.com with ESMTPSA id m12sm1489623wrs.92.2020.10.27.03.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 03:53:35 -0700 (PDT)
Subject: Re: [PATCH v3 15/16] soc: mediatek: pm-domains: Add default power off
 flag
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
 <20201026175526.2915399-16-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <05be2a94-d6e6-36e5-2c14-6d971e4a7677@gmail.com>
Date:   Tue, 27 Oct 2020 11:53:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026175526.2915399-16-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/10/2020 18:55, Enric Balletbo i Serra wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> For some power domain, like conn on MT8192, it should be default OFF.
> Because the power on/off control relies the function of connectivity chip
> and its firmware. And if project choose other chip vendor solution,
> those necessary connectivity functions will not provided.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 23 +++++++++++++++++------
>   drivers/soc/mediatek/mtk-pm-domains.h |  1 +
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 63993076a544..fe0e955076a0 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -378,10 +378,16 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   	 * software.  The unused domains will be switched off during
>   	 * late_init time.
>   	 */
> -	ret = scpsys_power_on(&pd->genpd);
> -	if (ret < 0) {
> -		dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
> -		goto err_unprepare_clocks;
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF)) {
> +		if (scpsys_domain_is_on(pd))
> +			dev_warn(scpsys->dev,
> +				 "%pOF: A default off power domain has been ON\n", node);
> +	} else {
> +		ret = scpsys_power_on(&pd->genpd);
> +		if (ret < 0) {
> +			dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
> +			goto err_unprepare_clocks;
> +		}
>   	}
>   
>   	if (scpsys->domains[id]) {
> @@ -395,7 +401,11 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>   	pd->genpd.power_off = scpsys_power_off;
>   	pd->genpd.power_on = scpsys_power_on;
>   
> -	pm_genpd_init(&pd->genpd, NULL, false);
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
> +		pm_genpd_init(&pd->genpd, NULL, true);
> +	else
> +		pm_genpd_init(&pd->genpd, NULL, false);
> +
>   	scpsys->domains[id] = &pd->genpd;
>   
>   	return scpsys->pd_data.domains[id];
> @@ -478,7 +488,8 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
>   			"failed to remove domain '%s' : %d - state may be inconsistent\n",
>   			pd->genpd.name, ret);
>   
> -	scpsys_power_off(&pd->genpd);
> +	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
> +		scpsys_power_off(&pd->genpd);

OK, so you merged Weiyi's patches in this series :)

So same comment here: Does it really hurt if we turn-off a already turned-off 
power domain? Or can we get rid of this check?

Regards,
Matthias

>   
>   	clk_bulk_unprepare(pd->num_clks, pd->clks);
>   	clk_bulk_put(pd->num_clks, pd->clks);
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 2ad213be84a5..0fa6a938b40c 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -6,6 +6,7 @@
>   #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
>   #define MTK_SCPD_FWAIT_SRAM		BIT(1)
>   #define MTK_SCPD_SRAM_ISO		BIT(2)
> +#define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>   
>   #define SPM_VDE_PWR_CON			0x0210
> 
