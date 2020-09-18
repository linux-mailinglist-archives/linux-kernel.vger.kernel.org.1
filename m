Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581D626F8B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgIRIx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:53:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E88C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:53:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so4770564wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WPIlA/z7whFroU2oB/fNcXF3tXCleKMwzRZeoWQH8x8=;
        b=L3gc80Ta+vfPF7YkrdswvSUXh4ddZcvaKN6p0reFhA+rB0eXQuo8p15Q8XPspIfCRc
         FjXiNHU1EKZrZESQhFOpZ492y5LH9/6nCSxM7VHDQOTDoPx0dTDzwSQef/XiQ7MiT//0
         u//yas9tTjiFuG2DvNtlihYmc7FHgRXKbUg44vdOqKm8MhhL53FctbnZKbGGnE8D7wIZ
         iP1lpk/ZEfyvSFJ/fSWXLSFVLSmAQrv5sesW9mDiiLfIwiMpYAs22q0Qo8973M/sKDyH
         McwxdUiD45kyJJWfrC8FESFB8+xEn5fK8O72+Fyfwgan9PWnZuCH+BeZipFXuNmCvUIG
         bZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WPIlA/z7whFroU2oB/fNcXF3tXCleKMwzRZeoWQH8x8=;
        b=DRDwKPL56B6FcihsqCaYI7yWhU0C5yAODsinbckEvAv3z7JcI18Q+xJi83vZx6251Q
         7C6Hsfc+jRYoX+URvG/241Hawde8viMycrxYPkrfxc/Rupur72m5PtY4xVQtLcEXrKui
         cZ7X54VgZmEVyHC4Nb/drpVLC2rFOxI1z+lwmDFzca/xpxUf7sdcDtK5xkoShdPiZB2z
         pvR/Qi7K5tzUKZjYfWNLKOmuivUCj+2NTozqllwI0NFWw8+P/fczwGNkVVV0FzoxXtfL
         EgW6KoaDGk0GiiI3+doezI7zU/m+fGXL2Q2om/6WMTG4ZNys738Ol4CIrrJYrVz+/Nc9
         0acw==
X-Gm-Message-State: AOAM5339LRqLsL9SdG84yHNgxYN1GoX8sjmiRLbL36ltW3lasFyozUeh
        p5MN0FH6wUO2fZ7Grb0BJnDQjmPAr+/S4w==
X-Google-Smtp-Source: ABdhPJyYpRddTX9CzffFP6jW1DZuqV5HA+JPvWv940du9bCleYrJamhg0q7KCryC4jOIDR5Oaaw9dg==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr36051523wrm.120.1600419207287;
        Fri, 18 Sep 2020 01:53:27 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8c8d:2ddc:70d0:767c? ([2a01:e34:ed2f:f020:8c8d:2ddc:70d0:767c])
        by smtp.googlemail.com with ESMTPSA id d124sm3764584wmd.47.2020.09.18.01.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 01:53:26 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] clocksource: sp804: add support for Hisilicon
 sp804 timer
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
References: <20200912114536.2910-1-thunder.leizhen@huawei.com>
 <20200912114536.2910-8-thunder.leizhen@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5efc0de3-754b-2b48-7769-d9ac7f5e21b0@linaro.org>
Date:   Fri, 18 Sep 2020 10:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200912114536.2910-8-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2020 13:45, Zhen Lei wrote:
> The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
> it to 64-bit. That means, the registers: TimerXload, TimerXValue and
> TimerXBGLoad are 64bits, all other registers are the same as those in the
> SP804. The driver code can be completely reused except that the register
> offset is different.
> 
> Use compatible = "hisilicon,sp804" mark as Hisilicon sp804 timer.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/clocksource/timer-sp.h    | 12 ++++++++++++
>  drivers/clocksource/timer-sp804.c | 15 +++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
> index 1ab75cbed0e0..6ca8d82e8544 100644
> --- a/drivers/clocksource/timer-sp.h
> +++ b/drivers/clocksource/timer-sp.h
> @@ -31,6 +31,18 @@
>  #define TIMER_MIS	0x14			/*  CVR ro */
>  #define TIMER_BGLOAD	0x18			/*  CVR rw */
>  
> +
> +#define HISI_TIMER_1_BASE	0x00
> +#define HISI_TIMER_2_BASE	0x40
> +#define HISI_TIMER_LOAD		0x00
> +#define HISI_TIMER_VALUE	0x08
> +#define HISI_TIMER_CTRL		0x10
> +#define HISI_TIMER_INTCLR	0x14
> +#define HISI_TIMER_RIS		0x18
> +#define HISI_TIMER_MIS		0x1c
> +#define HISI_TIMER_BGLOAD	0x20

Why not put them in timer-sp804.c directly ?

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
