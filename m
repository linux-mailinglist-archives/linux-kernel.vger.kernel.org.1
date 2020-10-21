Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2B294C81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411808AbgJUMZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJUMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:25:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A82C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:25:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c16so2205804wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N0d0xDJJJQW0QSV6ErmpnDaHVLNafog1H67g3oPgro4=;
        b=HeSR5nl1OLm6pdOfxwlW+srunJfuG8TQPoEgsFRUxvO5HvO2Qf2sB8F1LnTqa91Que
         YkjMBg5sHNjPVOz8ERAnG4VJ1jHBeR+7kDmy7lREYwnVeT1hSC1S3k3NJf8eyk9Wd+ac
         1X8niv888wjCPUkc0sJxwueaW/rEYD5o2lTx2kMnD9BkVNYHG335O3kHHHjUDljq8b2E
         bXCGXA+0Pzh9ePm3aywkaycrnvipoYnS9+mwmIQZAOkCV/obbqsJ/1bZo3E3c8woM/Qe
         8iZdcabeMwtkjLFwjQCroZ+ujVPNQz+A7p0xr9S3RPQzwIHbI8NAWk9Z/GHEeyUcqe8e
         Vsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N0d0xDJJJQW0QSV6ErmpnDaHVLNafog1H67g3oPgro4=;
        b=AYKC8ufLzt3g7LMgfvV0vy1l6SzGlQW/Tu7z+8t5PQzT4F6erOVmBoD5zGBOwOirBi
         Z1EBQ82A79FdMQiUw7uIXCcPwvRTUxZNZOBEkeP4yiYEI7MGoclWKJ1k6VBe/j8UA2ZY
         RtuyeWqgg9RTD5jVF34ZGMzbMLpE1156+9hTPK9IBvTTD9NfnEHDQChe8wRUXimeusi3
         uSptLzI8L9PdZIOoBCXvOC8PEuSzfJZDaMucasNO0PcEMm2EhIUkja40dHARy9Okef9a
         8UdKLMT6u5NqZrTi4KujVeBht77NRrRxbi/RyMDrpsEO3h9KiE1+WCwuTZlUr0gCn3oo
         q6gw==
X-Gm-Message-State: AOAM530Y9EFYuojTe5ROpjKPmrBJpImqkPfSjbf+Qv2FZRq61GyI4K3y
        3xv0w+FsfMewmnhOJrUlwutuKA==
X-Google-Smtp-Source: ABdhPJxD+m3O6OrhK0aPrfbMtmzbuwyZJl8rPeRIg2kgWMmPmGtsSBdIN8NJ6WX1oI+47TA+NJNb6A==
X-Received: by 2002:a1c:3503:: with SMTP id c3mr3243896wma.43.1603283135669;
        Wed, 21 Oct 2020 05:25:35 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:c12c:e34b:8d3a:d26d])
        by smtp.gmail.com with ESMTPSA id v11sm3075632wml.26.2020.10.21.05.25.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Oct 2020 05:25:34 -0700 (PDT)
Date:   Wed, 21 Oct 2020 14:25:32 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles.Muller@inria.fr
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201021122532.GA30733@vingu-book>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201021112038.GC32041@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 21 oct. 2020 à 12:20:38 (+0100), Mel Gorman a écrit :
> On Tue, Oct 20, 2020 at 06:37:59PM +0200, Julia Lawall wrote:
> > On a thread wakeup, the change [1] from runnable load average to load
> > average for comparing candidate cores means that recent short-running
> > daemons on the core where a thread ran previously can be considered to
> > have a higher load than the core performing the wakeup, even when the
> > core where the thread ran previously is currently idle.  This can
> > cause a thread to migrate, taking the place of some other thread that
> > is about to wake up, and so on.  To avoid unnecessary migrations,
> > extend wake_affine_idle to check whether the core where the thread
> > previously ran is currently idle, and if so return that core as the
> > target.
> > 
> > [1] commit 11f10e5420f6ce ("sched/fair: Use load instead of runnable
> > load in wakeup path")
> > 
> > This particularly has an impact when using passive (intel_cpufreq)
> > power management, where kworkers run every 0.004 seconds on all cores,
> > increasing the likelihood that an idle core will be considered to have
> > a load.
> > 
> > The following numbers were obtained with the benchmarking tool
> > hyperfine (https://github.com/sharkdp/hyperfine) on the NAS parallel
> > benchmarks (https://www.nas.nasa.gov/publications/npb.html).  The
> > tests were run on an 80-core Intel(R) Xeon(R) CPU E7-8870 v4 @
> > 2.10GHz.  Active (intel_pstate) and passive (intel_cpufreq) power
> > management were used.  Times are in seconds.  All experiments use all
> > 160 hardware threads.
> > 
> > 	v5.9/active		v5.9+patch/active
> > bt.C.c	24.725724+-0.962340	23.349608+-1.607214
> > lu.C.x	29.105952+-4.804203	25.249052+-5.561617
> > sp.C.x	31.220696+-1.831335	30.227760+-2.429792
> > ua.C.x	26.606118+-1.767384	25.778367+-1.263850
> > 
> > 	v5.9/passive		v5.9+patch/passive
> > bt.C.c	25.330360+-1.028316	23.544036+-1.020189
> > lu.C.x	35.872659+-4.872090	23.719295+-3.883848
> > sp.C.x	32.141310+-2.289541	29.125363+-0.872300
> > ua.C.x	29.024597+-1.667049	25.728888+-1.539772
> > 
> > On the smaller data sets (A and B) and on the other NAS benchmarks
> > there is no impact on performance.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> I suspect that the benefit of this patch is due to avoiding the overhead
> of wake_affine_weight() check because the following check exists in
> select_idle_sibling
> 
>         /*
>          * If the previous CPU is cache affine and idle, don't be stupid:
>          */
>         if (prev != target && cpus_share_cache(prev, target) &&
>             (available_idle_cpu(prev) || sched_idle_cpu(prev)))
>                 return prev;
> 
> Still, the concept makes some sense to avoid wake_affine_weight but look
> at the earlier part of wake_affine_idle()
> 
>         if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>                 return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> 
> This thing is almost completely useless because this_cpu is only going to
> be idle if it's a wakeup from interrupt context when the CPU was otherwise
> idle *but* it takes care to only use the CPU if this and prev share LLC.
> 
> The patch as it stands may leave a task on a remote node when it should
> have been pulled local to the waker because prev happened to be idle. This
> is not guaranteed because a node could have multiple LLCs and prev is
> still appropriate but that's a different problem entirely and requires
> much deeper surgery. Still, not pulling a task from a remote node is
> a change in expected behaviour. While it's possible that NUMA domains
> will not even reach this path, it depends on the NUMA distance as can
> be seen in sd_init() for the setting of SD_WAKE_AFFINE so I think the
> cpus_share_cache check is necessary.
> 
> I think it would be more appropriate to rework that block that checks
> this_cpu to instead check if the CPUs share cache first and then return one
> of them (preference to prev based on the comment above it about avoiding
> a migration) if either one is idle.
> 
> I see Vincent already agreed with the patch so I could be wrong.  Vincent,
> did I miss something stupid?

This patch fixes the problem that we don't favor anymore the prev_cpu when it is idle since
commit 11f10e5420f6ce because load is not null when cpu is idle whereas runnable_load was
And this is important because this will then decide in which LLC we will looks for a cpu

> 
> -- 
> Mel Gorman
> SUSE Labs
