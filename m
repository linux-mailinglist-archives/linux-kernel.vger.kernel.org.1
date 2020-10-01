Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DA28020F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbgJAPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbgJAPDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:03:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3F3C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 08:03:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so6203378wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qeO+HST8Alt8TTHfAd+E1LMm1PbcT+IkG0owx3Xzuxk=;
        b=l4+iFFCo1+l+g+ES34C57Um09yEXm62T8GVoyj/mbmgZC4sT3AtzcOdB3TG5VDMcwj
         47ebk2RTFRJ/ELF6NF/Oyoz1m1ar+X0P1zvMEdx6IUqVNP+SzgbNPgw9xzJpIC0NHwXa
         U+Vfv1l3Itd4k5x9aOQatCFzKDID2eXx7K8J1S3H0IWKlO37wz/hvxbdQihPJHuMq5OH
         iqWT6ruU8SENR2NZCqf2MEX80Gq+zMcS7rqCY1vrF1WeYXpjZyCyPB2V25flvHGRrMPF
         o9AKA3zhYSYamY7UmZL2V2O/OIW5IKG3DS+y6mDKbQveaN0HPLC+7C2xeRxlU5uWDoko
         h+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qeO+HST8Alt8TTHfAd+E1LMm1PbcT+IkG0owx3Xzuxk=;
        b=Le8dc8HmL6JR4lpGWE3/iLoaAYJxMw2md3ZLPzqhe5DEeyjeu1MuKGRNSnorzsvWE1
         6TkZJ+Xy94XLcHDuoj5rUft+Vn3dtv3eXXTb10RbE82ihSDmPxr3YKss8SJ6o7jfpa0o
         hUITfrgKNLwfE2JLge8a8rBrIZjLcYw8GfRxQ9N5P2yv9+AdHM4ttoAli8Dq1hDiV67b
         DXw1vFKnDZZQT9C0/iioIuGnX7JyzKjIsIh8HAqmYZZ/Y3cBxA6PzuRPHLUdxocEfhld
         ZD9tgpe2PXF0KQkv1Mq2OH8XDK4O1BzSJc7X74KGEXO8uvAls7hqZr5QPEeIYt/kpMKc
         Yk6w==
X-Gm-Message-State: AOAM533mSaZ2BZ+4zf1qZPxgKxUUky5mEBiN71q2JLp48hZ68TNbmqjQ
        EfFNa1W5Q0Dk8wZUNTCVspSmCk4aoZzsNg==
X-Google-Smtp-Source: ABdhPJzJ7WZpM28O8Xbb6cYw/iSZ7lyPFeKcgOzsuymgVAbOd4Ax6EQJV5JEn4gJ4Z4OIE739jTlkw==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr10141733wrp.390.1601564596429;
        Thu, 01 Oct 2020 08:03:16 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id d19sm379727wmd.0.2020.10.01.08.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 08:03:14 -0700 (PDT)
Subject: Re: [PATCH v2] soc: mediatek: Check if power domains can be powered
 on at boot time
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20200928113107.v2.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <fe2f0eeb-ec21-5cf5-7cae-c17855bf0297@gmail.com>
Date:   Thu, 1 Oct 2020 17:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928113107.v2.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 05:31, Nicolas Boichat wrote:
> In the error case, where a power domain cannot be powered on
> successfully at boot time (in mtk_register_power_domains),
> pm_genpd_init would still be called with is_off=false, and the
> system would later try to disable the power domain again, triggering
> warnings as disabled clocks are disabled again (and other potential
> issues).
> 
> Also print a warning splat in that case, as this should never
> happen.
> 
> Fixes: c84e358718a66f7 ("soc: Mediatek: Add SCPSYS power domain driver")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Applied to v5.10-tmp/soc which will be v5.10-next/soc as soon as v5.10-rc1 gets 
published.

Nicolas can you please make sure that similar logic will be part of the series 
Enric is working on?

Thanks a lot.
Matthias

> ---
> 
> Changes in v2:
>   - Add WARN_ON if the domain can't be powered on, to make it more
>     obvious that this should not happen (there is already an error
>     message).
> 
>   drivers/soc/mediatek/mtk-scpsys.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f669d3754627..ca75b14931ec 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -524,6 +524,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>   	for (i = 0; i < num; i++) {
>   		struct scp_domain *scpd = &scp->domains[i];
>   		struct generic_pm_domain *genpd = &scpd->genpd;
> +		bool on;
>   
>   		/*
>   		 * Initially turn on all domains to make the domains usable
> @@ -531,9 +532,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>   		 * software.  The unused domains will be switched off during
>   		 * late_init time.
>   		 */
> -		genpd->power_on(genpd);
> +		on = !WARN_ON(genpd->power_on(genpd) < 0);
>   
> -		pm_genpd_init(genpd, NULL, false);
> +		pm_genpd_init(genpd, NULL, !on);
>   	}
>   
>   	/*
> 
