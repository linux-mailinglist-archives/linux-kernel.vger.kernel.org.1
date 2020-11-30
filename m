Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B972C8607
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgK3N4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:56:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727365AbgK3N4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606744525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQtv8KiZgdd7jr6hk8MSwc0XZd64w6sYVEBFxR5bqsY=;
        b=W8WoBjetURzKxGrvFTZlpYC982m2aU9w6hMYtZPxwMwOQ72j8nMRenHXBQNC0KA4qea++9
        DpQAimg8CrBFto9XMdihYHJpl+wNNwAJSWWe+oer3VOlKj10jxX0HOZqyxUj4bAbnKGUY4
        hbNN/i/v0zUvTbNu4se7jBFXp/bBFQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-gmbzhrzJPrWh_1RI5YLhow-1; Mon, 30 Nov 2020 08:55:22 -0500
X-MC-Unique: gmbzhrzJPrWh_1RI5YLhow-1
Received: by mail-wr1-f71.google.com with SMTP id e6so8361399wrx.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQtv8KiZgdd7jr6hk8MSwc0XZd64w6sYVEBFxR5bqsY=;
        b=h4JYHSzeIgR7NIh050rIvjphqzpyTOIJ0LTX/A/Goc0FDNx4N9air2G+GZglTduE4w
         Kr+WHdBBZMKi4mVSXxH4UpKVSuwrAZTCBdAd7gwYFqfMKwBhYlN57hdKZrUrGTg9UMV8
         MVC3PhWIjUiCY0hdEDxjhzWfqPbUZL1QI2Vl4zISPjr/CZbgKUTa8KWeab6XqV06mCrx
         O3NTWQohtKwZMJ5XuNmncEZLSqOhDWus5eXfz4V5AZYZn7nVT/aHWblAgsRCQYX1zy+3
         +cQ/+JBON5gWFeosxeokV25P1i5x4DxJKH98pFO3Whhmi7Jdr3abd9kOft0UR6OOn2GN
         S95Q==
X-Gm-Message-State: AOAM531azcIxZuREcX+3bUtBsH0gQv3gDBqjlosRLQP8ItlxrmnppWBf
        BBHvLXHLW1BCfNgWFqeTcdzr5OEFcCJXO99XXbCv4cninpiBDVNYm413yDy0Iy7pzV9+b6aBahL
        9YVKTVtQ61GBJFh2v9r7f0WyU
X-Received: by 2002:a5d:4586:: with SMTP id p6mr29263651wrq.308.1606744521497;
        Mon, 30 Nov 2020 05:55:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBer9HKeX2ucq4GjREuzEArXJK0Vn94oNpI85I2Tf/keh1OK2G5VWNVYQQCnoVlF+zYH+UJA==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr29263634wrq.308.1606744521329;
        Mon, 30 Nov 2020 05:55:21 -0800 (PST)
Received: from x1.bristot.me (host-95-246-207-183.retail.telecomitalia.it. [95.246.207.183])
        by smtp.gmail.com with ESMTPSA id m4sm7952273wmi.41.2020.11.30.05.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 05:55:20 -0800 (PST)
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alex Shi <alex.shi@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
References: <20201122201904.30940-1-valentin.schneider@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <ff48cee8-6634-c04c-3a33-509ce1f92e21@redhat.com>
Date:   Mon, 30 Nov 2020 14:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201122201904.30940-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/20 9:19 PM, Valentin Schneider wrote:
> Booting a recent PREEMPT_RT kernel (v5.10-rc3-rt7-rebase) on my arm64 Juno
> leads to the idle task blocking on an RT sleeping spinlock down some
> notifier path:
> 
>   [    1.809101] BUG: scheduling while atomic: swapper/5/0/0x00000002
>   [    1.809116] Modules linked in:
>   [    1.809123] Preemption disabled at:
>   [    1.809125] secondary_start_kernel (arch/arm64/kernel/smp.c:227)
>   [    1.809146] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W         5.10.0-rc3-rt7 #168
>   [    1.809153] Hardware name: ARM Juno development board (r0) (DT)
>   [    1.809158] Call trace:
>   [    1.809160] dump_backtrace (arch/arm64/kernel/stacktrace.c:100 (discriminator 1))
>   [    1.809170] show_stack (arch/arm64/kernel/stacktrace.c:198)
>   [    1.809178] dump_stack (lib/dump_stack.c:122)
>   [    1.809188] __schedule_bug (kernel/sched/core.c:4886)
>   [    1.809197] __schedule (./arch/arm64/include/asm/preempt.h:18 kernel/sched/core.c:4913 kernel/sched/core.c:5040)
>   [    1.809204] preempt_schedule_lock (kernel/sched/core.c:5365 (discriminator 1))
>   [    1.809210] rt_spin_lock_slowlock_locked (kernel/locking/rtmutex.c:1072)
>   [    1.809217] rt_spin_lock_slowlock (kernel/locking/rtmutex.c:1110)
>   [    1.809224] rt_spin_lock (./include/linux/rcupdate.h:647 kernel/locking/rtmutex.c:1139)
>   [    1.809231] atomic_notifier_call_chain_robust (kernel/notifier.c:71 kernel/notifier.c:118 kernel/notifier.c:186)
>   [    1.809240] cpu_pm_enter (kernel/cpu_pm.c:39 kernel/cpu_pm.c:93)
>   [    1.809249] psci_enter_idle_state (drivers/cpuidle/cpuidle-psci.c:52 drivers/cpuidle/cpuidle-psci.c:129)
>   [    1.809258] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:238)
>   [    1.809267] cpuidle_enter (drivers/cpuidle/cpuidle.c:353)
>   [    1.809275] do_idle (kernel/sched/idle.c:132 kernel/sched/idle.c:213 kernel/sched/idle.c:273)
>   [    1.809282] cpu_startup_entry (kernel/sched/idle.c:368 (discriminator 1))
>   [    1.809288] secondary_start_kernel (arch/arm64/kernel/smp.c:273)
> 
> Two points worth noting:
> 
> 1) That this is conceptually the same issue as pointed out in:
>    313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
> 2) Only the _robust() variant of atomic_notifier callchains suffer from
>    this
> 
> AFAICT only the cpu_pm_notifier_chain really needs to be changed, but
> singling it out would mean introducing a new (truly) non-blocking API. At
> the same time, callers that are fine with any blocking within the call
> chain should use blocking notifiers, so patching up all atomic_notifier's
> doesn't seem *too* crazy to me.
> 
> Fixes: 70d932985757 ("notifier: Fix broken error handling pattern")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

