Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719DC1C6DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgEFJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729233AbgEFJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:57:35 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A5C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:57:34 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 1so608189vsl.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSGKGmCDCFtLQZd+imNsGpFQmJNoAPGMlCir0YS3PDY=;
        b=q0nAVBG0KzkAp6uJhAiUbSWsGe5tMXf2uUo5NNXlAIuwzx2+A1thFbz2Rfn0qNoYEp
         H07670OGlTuPsN/nmB1OKg6lWGNxN60QpMsPi3+CGNYnsf1YRqrrzmsD6mD0RmwuWo1A
         KZK/XJzBnX0SYwt5FuqHlNbnmKyqhDEunwl5ypK4JmYRzhdgimKgNIvslAKYl5ytrx28
         4K5XxVg52/VvfWxO9s9B/mXcSR8HFJgIDx/aST9fvdKJQmvEsEnnS7rVMuRHDVZmUrnZ
         4ZhNOwOn+vYzuw62FvPElylWdDTIpHn1e/VZxDwHmK2TjoWQxsE94vO9ufcdRizvnHv8
         3S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSGKGmCDCFtLQZd+imNsGpFQmJNoAPGMlCir0YS3PDY=;
        b=K+XJVRZwSoQHal+4YIrM3ElYw+NPso1AUmFDEs8FeKWB5EE13SDAEUvRkBDS0CEJhV
         JVxh7g9EoZh1r4PUsc5hOZ4Eu1EBedW9jQ+X2eKpMhs29+QCkIhXLaQ2YSCaheW3ttsX
         mcwd2AKxUZzcUXO1J9E1f68njHhsJGzFv1ALIIyLjRckrlImndHpgUiCkFEAKt7OH4Io
         Dup3x40lPxxXyYCGgEBbXhn6fnic/QN2nd534AitIjVtmepK8Gbp75YRRpPCumdfibD5
         UDPHgrXAQFdoD/xJMF7tTySuS6ETbh+ISdM1plw4RQvibbwXxrl6APkIJwGNnaYC5TSh
         O0zQ==
X-Gm-Message-State: AGi0Pua6xGFUIHVYwxVP6vMnqUmqjHKyA3c+zlZ7OgXB6rIUFa78OD9x
        XrV2QPeber4o9QL/An+/3krExqWQe7cnVFqcsFQcFg==
X-Google-Smtp-Source: APiQypKJ7citzlPeGK3mXoZ3uB97JzPAPIFvYQtO9o9p7WOzI60x+N0CC175YJvQ30Vjihvt0vsJCWQqq3RR6Q80084=
X-Received: by 2002:a67:42c6:: with SMTP id p189mr6947906vsa.9.1588759053119;
 Wed, 06 May 2020 02:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200429103644.5492-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 6 May 2020 15:26:58 +0530
Message-ID: <CAHLCerPZ-VMWmEDXqYRka8sWnVnnmJRSLhwG-zm_0Th3ZwzBqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] powercap/drivers/idle_inject: Specify idle state
 max latency
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 4:07 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Currently the idle injection framework uses the play_idle() function
> which puts the current CPU in an idle state. The idle state is the
> deepest one, as specified by the latency constraint when calling the
> subsequent play_idle_precise() function with the INT_MAX.
>
> The idle_injection is used by the cpuidle_cooling device which
> computes the idle / run duration to mitigate the temperature by
> injecting idle cycles. The cooling device has no control on the depth
> of the idle state.
>
> Allow finer control of the idle injection mechanism by allowing to
> specify the latency for the idle state. Thus the cooling device has
> the ability to have a guarantee on the exit latency of the idle states
> it is injecting.
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>   - V4:
>     - Respin against v5.7-rc1
> ---
>  drivers/powercap/idle_inject.c | 16 +++++++++++++++-
>  include/linux/idle_inject.h    |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index e9bbd3c42eef..c90f0990968b 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -61,12 +61,14 @@ struct idle_inject_thread {
>   * @timer: idle injection period timer
>   * @idle_duration_us: duration of CPU idle time to inject
>   * @run_duration_us: duration of CPU run time to allow
> + * @latency_us: max allowed latency
>   * @cpumask: mask of CPUs affected by idle injection
>   */
>  struct idle_inject_device {
>         struct hrtimer timer;
>         unsigned int idle_duration_us;
>         unsigned int run_duration_us;
> +       unsigned int latency_us;
>         unsigned long cpumask[];
>  };
>
> @@ -138,7 +140,8 @@ static void idle_inject_fn(unsigned int cpu)
>          */
>         iit->should_run = 0;
>
> -       play_idle(READ_ONCE(ii_dev->idle_duration_us));
> +       play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
> +                         READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
>  }
>
>  /**
> @@ -169,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>         *idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>  }
>
> +/**
> + * idle_inject_set_latency - set the maximum latency allowed
> + * @latency_us: set the latency requirement for the idle state
> + */
> +void idle_inject_set_latency(struct idle_inject_device *ii_dev,
> +                            unsigned int latency_us)
> +{
> +       WRITE_ONCE(ii_dev->latency_us, latency_us);
> +}
> +
>  /**
>   * idle_inject_start - start idle injections
>   * @ii_dev: idle injection control device structure
> @@ -297,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>         cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>         hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         ii_dev->timer.function = idle_inject_timer_fn;
> +       ii_dev->latency_us = UINT_MAX;
>
>         for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index a445cd1a36c5..91a8612b8bf9 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -26,4 +26,8 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>  void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>                                  unsigned int *run_duration_us,
>                                  unsigned int *idle_duration_us);
> +
> +void idle_inject_set_latency(struct idle_inject_device *ii_dev,
> +                            unsigned int latency_ns);
> +
>  #endif /* __IDLE_INJECT_H__ */
> --
> 2.17.1
>
