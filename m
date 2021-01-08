Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8E2EF0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbhAHKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbhAHKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:35:02 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA971C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 02:34:21 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m12so21807912lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZWVWmavS5vu3wrnPQC6HYziJesZ5SIUr4PRWObvSaE=;
        b=ICZ75o4UlaXpLcSreKbU3FhhgoS5hGHK7ZPwqT8FjjIuN9r95dgpHKqQNp+t2sgHfg
         4KR3k6JRhDrNRYn7epeVo5vDh0fNsFCcGCPKjiuvaaH0RQ3MxaQmysjCftI8hNXJ8GMy
         LF1ny3RN5jddLBQduCs94Ys7zNRErA6+o7ZBcF/ZMcW2EZeinwvTNM6TUJ9JY8nlolAI
         9z3KHAMyy5DdraYmmCgmk4eQHcFSOrgPmU9GjEmKoToFNx1lXV72Q7XQb7m/fd0d8M8u
         +DjY/jJkd8EeQfZz64lr6Lj/3SKuD3YMCRG49NXfMuNGh3FCG/fycTNmT3JiqZgLA3Wq
         Kniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZWVWmavS5vu3wrnPQC6HYziJesZ5SIUr4PRWObvSaE=;
        b=mjL2NWc8rd98FQTi/4WGxhTUdNCE7KsdxgHDlYb+kkdHekIdW3upWsyzvyNcYp2sMB
         SlbWPgA/zNR0/GrqCKVFyH95FmAiVJDQdNjRKXDhbpIbWXL0xbA0RBLwvj8dZa1YaSw5
         EaHjtUp8s2weI7T8Ht6dYceoXyO79zM6NAj9cXYVh7WY0ljeI+trDakvOGY1loo4OqaW
         ddDXrVb0mgM9xobmVhslu+mS3/6xVuJU9+s58shhahPALahC9dV5LR+Hql+/b1QIQiZu
         UwZg9OEsgn3aMOli0IvxN+c0hFYghWKqAeaDGjO16AAmFPEM5Psofw1DO1HlylbRHi7d
         uWAg==
X-Gm-Message-State: AOAM532apMnLunhpgZpW1r3Zcbq6KC1HNaZVoj8n4taab/UD7Y7M/BUg
        uAN1v8r7q0UteIjYq4lZs67oWDSSxbz9ufciKnCvhg==
X-Google-Smtp-Source: ABdhPJy5njqJ4BguHmU6umicpmDwsk9IsKGaQuXvlpuYhSCXL2l5IU5elog+nZaWUkhnP8Omqd53r3Uqph9rOvlgPHM=
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr1199939ljo.152.1610102060299;
 Fri, 08 Jan 2021 02:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20201221162249.3119-1-lecopzer.chen@mediatek.com>
In-Reply-To: <20201221162249.3119-1-lecopzer.chen@mediatek.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 8 Jan 2021 16:04:09 +0530
Message-ID: <CAFA6WYNepUP=SeHWnDDbxx=ggwPq2jDd5JmrcXD5GoMC5dYH2g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: perf: Fix access percpu variables in
 preemptible context
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        oliver.sang@intel.com, Will Deacon <will@kernel.org>,
        yj.chiang@mediatek.com, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, acme@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 at 21:53, Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
>
> commit 367c820ef08082 ("arm64: Enable perf events based hard lockup detector")
> reinitilizes lockup detector after arm64 PMU is initialized and open
> a window for accessing smp_processor_id() in preemptible context.
> Since hardlockup_detector_perf_init() always called in init stage
> with a single cpu, but we initialize lockup detector after the init task
> is migratable.
>
> Fix this by utilizing lockup detector reconfiguration which calls
> softlockup_start_all() on each cpu and calls watatchdog_nmi_enable() later.
> Because softlockup_start_all() use IPI call function to make sure
> watatchdog_nmi_enable() will bind on each cpu and fix this issue.

IMO, this just creates unnecessary dependency for hardlockup detector
init via softlockup detector (see the alternative definition of
lockup_detector_reconfigure()).

>
>     BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1

How about just the below fix in order to make CONFIG_DEBUG_PREEMPT happy?

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..db06ee28f48e 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -165,7 +165,7 @@ static void watchdog_overflow_callback(struct
perf_event *event,

 static int hardlockup_detector_event_create(void)
 {
-       unsigned int cpu = smp_processor_id();
+       unsigned int cpu = raw_smp_processor_id();
        struct perf_event_attr *wd_attr;
        struct perf_event *evt;

-Sumit

>     caller is debug_smp_processor_id+0x20/0x2c
>     CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.0+ #276
>     Hardware name: linux,dummy-virt (DT)
>     Call trace:
>       dump_backtrace+0x0/0x3c0
>       show_stack+0x20/0x6c
>       dump_stack+0x2f0/0x42c
>       check_preemption_disabled+0x1cc/0x1dc
>       debug_smp_processor_id+0x20/0x2c
>       hardlockup_detector_event_create+0x34/0x18c
>       hardlockup_detector_perf_init+0x2c/0x134
>       watchdog_nmi_probe+0x18/0x24
>       lockup_detector_init+0x44/0xa8
>       armv8_pmu_driver_init+0x54/0x78
>       do_one_initcall+0x184/0x43c
>       kernel_init_freeable+0x368/0x380
>       kernel_init+0x1c/0x1cc
>       ret_from_fork+0x10/0x30
>
>
> Fixes: 367c820ef08082 ("arm64: Enable perf events based hard lockup detector")
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changelog v1 -> v2:
> * https://lore.kernel.org/lkml/20201217130617.32202-1-lecopzer.chen@mediatek.com/
> * Move solution from kernel/watchdog_hld.c to arm64 perf_event
>     * avoid preemptive kmalloc in preempt_disable().
>
>
>
>  arch/arm64/kernel/perf_event.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 38bb07eff872..c03e21210bbb 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1345,4 +1345,20 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
>
>         return (u64)max_cpu_freq * watchdog_thresh;
>  }
> +
> +/*
> + * hardlockup_detector_perf_init() always call in init stage with a single
> + * cpu. In arm64 case, we re-initialize lockup detector after pmu driver
> + * initialized. Lockup detector initial function use lots of percpu variables
> + * and this makes CONFIG_DEBUG_PREEMPT unhappy because we are now in
> + * preemptive context.
> + * Return 0 if the nmi is ready and register nmi hardlockup detector by
> + * lockup detector reconfiguration.
> + */
> +int __init watchdog_nmi_probe(void)
> +{
> +       if (arm_pmu_irq_is_nmi())
> +               return 0;
> +       return -ENODEV;
> +}
>  #endif
> --
> 2.25.1
>
