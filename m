Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD42829920D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774711AbgJZQOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:14:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40221 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774104AbgJZQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:14:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id k18so13052934wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+2/GD6WghzXv5Orh4Uuj5Q88ZWaFAri1XysCs8NKws=;
        b=TxDk0j/4PqbrBFujraZWkctVWILZmy8Yspl9JnbGo12z1Eh273OQEzRgIyO+/wZkaj
         ZxvgZYB8e70d14aSSixKz5L7byEXWAKiNtxxLTUxsfmTZLklmFrkgd3RDHaOodlxU7GO
         icoJTc/DswgahHd1BlvjgRtdlelL3RRmXg1IJx3xx4yWPoKr8W86Yu92/aBPqtDoJl8o
         BNigY6FHF9Ymoz4K4mAvNf+oeB4WNA6nEUDfttqVGMYrQeJR8iDteahppceQdAX3W0Fy
         ZgoA7U12tzgtTElhsZGWw+do84O4XHG5yqdIG09sT9h9kECGCxZKow60Q0T9q+oGFLf5
         AEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+2/GD6WghzXv5Orh4Uuj5Q88ZWaFAri1XysCs8NKws=;
        b=OVOuTN9SF91nGus/Rr8ZEPKajCCBe7kf+mtoioXqLT1TfhRLJRnuP7+QpGYBGWk+PT
         20l+dm2jut99tB4virBswaO3CwKL2ooeT0Ka/2UGamRiGjKGEfPFPQGtQebTVslx/HGB
         YVU+zopM9XAtvQGuQX/kIn1+0RntKvh5bYSQGbgz8w1LBhoaDfHtE5sWbNobUdDJaAU2
         fQKM6yaCOKLfu+21OFutc3y9efhpxQLjcjMMahg1VXfnIhvb9/BudWLJmKZHvXjbMgBi
         L6KHF9kVVNxFBhoO3H+lqrTHKp/LLU+W6NRU2eURsidrNsVpqXBLOMX/m9yToiBSfWA1
         juVA==
X-Gm-Message-State: AOAM532EsQ9vd7Gx5yjTOq5vxUX7of99ER4/UH9b6DYdB44QmsTsQzrd
        MvAuILd8/+EjNKMWYDxmPpHbaCNODtjFwLrRIvUb+vcbpbg=
X-Google-Smtp-Source: ABdhPJyhjcn9Rqa7MioEIQeOu6jyq6v5JpaW9CS1SQ7tlIzGWHWs6mDnc9C76eyTXu+Ro8RYqMLQFRFSdgLcFq0jmi4=
X-Received: by 2002:a7b:c04a:: with SMTP id u10mr17802219wmc.83.1603728856397;
 Mon, 26 Oct 2020 09:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160810.2503534-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20201026160810.2503534-1-willemdebruijn.kernel@gmail.com>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Mon, 26 Oct 2020 12:13:39 -0400
Message-ID: <CACSApvYv1OWLExUcFu0j9VuWS6uMMb2r0B3FqPEsapy9EK9kfg@mail.gmail.com>
Subject: Re: [PATCH] epoll: add nsec timeout support
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:08 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> The underlying hrtimer is programmed with nanosecond resolution.
>
> Use cases such as datacenter networking operate on timescales well
> below milliseconds. Setting shorter timeouts bounds tail latency.
>
> Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
> interpretation of argument timeout in epoll_wait from msec to nsec.
>
> The new eventpoll state fits in existing 4B of padding when busy poll
> is compiled in (the default), and reads the same cacheline.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Thanks for adding the feature!

> ---
>
> Selftest for now at github. Can follow-up for kselftests.
> https://github.com/wdebruij/kerneltools/blob/master/tests/epoll_nstimeo.c
> ---
>  fs/eventpoll.c                 | 26 +++++++++++++++++++-------
>  include/uapi/linux/eventpoll.h |  1 +
>  2 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 4df61129566d..1216b909d155 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -225,6 +225,9 @@ struct eventpoll {
>         unsigned int napi_id;
>  #endif
>
> +       /* Accept timeout in ns resolution (EPOLL_NSTIMEO) */
> +       unsigned int nstimeout:1;
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         /* tracks wakeup nests for lockdep validation */
>         u8 nests;
> @@ -1787,17 +1790,20 @@ static int ep_send_events(struct eventpoll *ep,
>         return esed.res;
>  }
>
> -static inline struct timespec64 ep_set_mstimeout(long ms)
> +static inline struct timespec64 ep_set_nstimeout(long ns)
>  {
> -       struct timespec64 now, ts = {
> -               .tv_sec = ms / MSEC_PER_SEC,
> -               .tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
> -       };
> +       struct timespec64 now, ts;
>
> +       ts = ns_to_timespec64(ns);
>         ktime_get_ts64(&now);
>         return timespec64_add_safe(now, ts);
>  }
>
> +static inline struct timespec64 ep_set_mstimeout(long ms)
> +{
> +       return ep_set_nstimeout(NSEC_PER_MSEC * ms);
> +}
> +
>  /**
>   * ep_poll - Retrieves ready events, and delivers them to the caller supplied
>   *           event buffer.
> @@ -1826,7 +1832,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>         lockdep_assert_irqs_enabled();
>
>         if (timeout > 0) {
> -               struct timespec64 end_time = ep_set_mstimeout(timeout);
> +               struct timespec64 end_time;
> +
> +               end_time = ep->nstimeout ? ep_set_nstimeout(timeout) :
> +                                          ep_set_mstimeout(timeout);
>
>                 slack = select_estimate_accuracy(&end_time);
>                 to = &expires;
> @@ -2046,7 +2055,7 @@ static int do_epoll_create(int flags)
>         /* Check the EPOLL_* constant for consistency.  */
>         BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
>
> -       if (flags & ~EPOLL_CLOEXEC)
> +       if (flags & ~(EPOLL_CLOEXEC | EPOLL_NSTIMEO))
>                 return -EINVAL;
>         /*
>          * Create the internal data structure ("struct eventpoll").
> @@ -2054,6 +2063,9 @@ static int do_epoll_create(int flags)
>         error = ep_alloc(&ep);
>         if (error < 0)
>                 return error;
> +
> +       ep->nstimeout = !!(flags & EPOLL_NSTIMEO);
> +
>         /*
>          * Creates all the items needed to setup an eventpoll file. That is,
>          * a file structure and a free file descriptor.
> diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> index 8a3432d0f0dc..f6ef9c9f8ac2 100644
> --- a/include/uapi/linux/eventpoll.h
> +++ b/include/uapi/linux/eventpoll.h
> @@ -21,6 +21,7 @@
>
>  /* Flags for epoll_create1.  */
>  #define EPOLL_CLOEXEC O_CLOEXEC
> +#define EPOLL_NSTIMEO 0x1
>
>  /* Valid opcodes to issue to sys_epoll_ctl() */
>  #define EPOLL_CTL_ADD 1
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
