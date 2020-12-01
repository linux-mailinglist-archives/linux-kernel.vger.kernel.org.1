Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8312CA7E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404060AbgLAQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbgLAQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:13:12 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:12:26 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id b144so1732987qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pv6Mzxor2+R5OnRVrZEMoeinj6r+eUiZ62bCMKojMyI=;
        b=dYwCu16kBnubHryi3fTziiQM5QEe7RTg51IUCeYj/YQRiKYeBdFBQsxofehvYiU64V
         M9OAxZTvCKL+UOzp/TqY5MThox2muiT8b0GUL8d6pnWRxm4X944WMMbS6Smm4eYcKQ85
         y/Kh0133C3FxOhhhi5qbuiBorNqIOPxo+7B6fgNw9G7Z7tj6zu95Nfy3K9SWMNkO5T7r
         DHjY7lnOy2ZxsUF1VXoI3K1O06jAx8SsypyJ2N7rp/MSHr2x+zMJuN/sFrgO5LQ+SINY
         e5ACiUtDHp0pbCjVHkOW81OK2C61cW3xUq0KGnvzbMCCrqTrQiFgXny7l47lyNLd1us4
         01hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pv6Mzxor2+R5OnRVrZEMoeinj6r+eUiZ62bCMKojMyI=;
        b=VRMHZsepPRGgK0OWdTHTRIPqmCyHObCLxARsJDZazKHqAWrUa4ELrRtFB48gBCQ89N
         KRqGplW7L4aASANzwSPrkZOrI55cZq7L4XD3uDiZVDbA4DC7d0CUHe77lZqseZdeNuno
         Aa62x9SpFOIjcvm+Pqdlal9bUGBjO5sGzk0v4Qwk5uFzWGzvcFr7yqT1ipphvnyKB7Qr
         LIZzDJqWtgu8Oz5AOrQ4fpEye5rC+94nPMeg/+DbNEMheVJXylrguNgUfU5k5HRyh6UP
         PiVdWxW9/9hMXr3qZw1ggWm0xmWzTGVAuXuVKtzjTHIt6hrAjakogwQaXdjgNKk6IQKN
         GnYA==
X-Gm-Message-State: AOAM5316nPEBuN8HET42ijeEWex9pj4GSVK7nFZzDwTyTytQTPqUfjeg
        lwh3L4qgNux9Li76pBu8NrRYCA==
X-Google-Smtp-Source: ABdhPJw+PFkd+7IUGHacT0zmkmF9rtPeqw7QY24kQQRg3oufF3wY5SJE/LyHh9dO9agXuOVIfUxW0Q==
X-Received: by 2002:a05:620a:132d:: with SMTP id p13mr3622067qkj.233.1606839146116;
        Tue, 01 Dec 2020 08:12:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b64sm34463qkg.19.2020.12.01.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:12:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kk8GO-004Td8-Jn; Tue, 01 Dec 2020 12:12:24 -0400
Date:   Tue, 1 Dec 2020 12:12:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201201161224.GF5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201143835.2054508-1-mlichvar@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 03:38:35PM +0100, Miroslav Lichvar wrote:
> When the system clock is marked as synchronized via adjtimex(), the
> kernel is expected to copy the system time to the RTC every 11 minutes.
> 
> There are reports that it doesn't always work reliably. It seems the
> current requirement for the RTC update to happen within 5 ticks of the
> target time in some cases can consistently fail for hours or even days.
> 
> It is better to set the RTC with a larger error than let it drift for
> too long.
> 
> Add a static variable to rtc_tv_nsec_ok() to count the checks. With each
> failed check, relax the requirement by one jiffie, and reset the counter
> when it finally succeeds. This should allow the RTC update to happen in
> a minute at most.
> 
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>  include/linux/rtc.h | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 22d1575e4991..8d105f10ef6a 100644
> +++ b/include/linux/rtc.h
> @@ -218,21 +218,30 @@ static inline bool rtc_tv_nsec_ok(s64 set_offset_nsec,
>  				  struct timespec64 *to_set,
>  				  const struct timespec64 *now)
>  {
> -	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
> -	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
>  	struct timespec64 delay = {.tv_sec = 0,
>  				   .tv_nsec = set_offset_nsec};
> +	unsigned long time_set_nsec_fuzz;
> +	static unsigned int attempt;

Adding a static value instide a static inline should not be done

I'm not sure using a static like this is the best idea anyhow, if you
want something like this it should be per-rtc, not global

Did you look at why time has become so in-accurate in your system? 5
jiffies is usually a pretty long time?

Jason
