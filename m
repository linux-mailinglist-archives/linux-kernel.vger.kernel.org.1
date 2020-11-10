Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC582AE3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgKJXXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJXXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:23:36 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D17C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:23:35 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w142so554885lff.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snmzgSJawG90tTENS8PRBQJwFI4U/+eiuWYIm1kFYpU=;
        b=uSONrwvLS562QD778AZnBzkL2b13eJTCpIkg8DZEkUeeam0tmYKKSBV/kx+uOLHdVf
         ZNnXB/UORVGeRUKcXKSZxusE4kthAsy5euuYRLWjoj6YJFAio7Yo7jI4DyUkdtlzFXpB
         2B3bs5jUETOsb5quhJyXAI89PX+HdfqMtfHJxcJYsq++Xd0giVPV4gNfMSJi7AzFzGLW
         8LcMaLXUnkhVOhjAMteowWEowIW7Za5GTFrVilW4l+Hs4/z22dy7TOBeRVIin+9KVhcm
         2GTzcNXnwZba1hzZ9rvBz+De1lTWmjjWAX0flo1w1A8OAZDOKElAu0nuVU0AUhE9teHy
         bi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snmzgSJawG90tTENS8PRBQJwFI4U/+eiuWYIm1kFYpU=;
        b=iB2lOsvTKf/juuYEXf2U9B5Bp74iDmLPOZ5nFeC+PAFOLu7vBvKEReBtluj91G5nB0
         6MhS5KRIDapi971NXtEcacFE48WBARK1QvpAOChbSAguOtEO+NmNl2yABNp9jxsh8LUJ
         PeKMeIhtR857nMnYJo0CQuc6H6yX5NNFF2indrcVvWtvB3vVMbicMQySyi5jFR2MupFs
         TZ20uSyAOg9npK7Ie+H1JhpeVCc+HKI40KptyMgC6AAIg49u1YXHEpVY3F4kfTkhf1yx
         qHIVeoDPWrGuq9E+XxHHw7TEJ1jY+fTztnODf2yhIT2TA9j29r4/80kpgTkU0QpEXKLF
         LFZg==
X-Gm-Message-State: AOAM530+zh9oV8WTcPfkJW2jB3B5vmg5w6J7zrJuH4/TfDK6mxvnh1R8
        ixwAM3OzxLn17Mx7Ew7q8Cf91aQyUBZQi4VYbN4ypw==
X-Google-Smtp-Source: ABdhPJyS2NN9tRpqxcU5Fpkjh4lEZ2YMoIh1E9ka9q+9o1Kwp0lXj/r2Bw0pDxM3hW0UCgzMs/mXFiJZPs+iIgibWVM=
X-Received: by 2002:a19:40c7:: with SMTP id n190mr2214361lfa.185.1605050605523;
 Tue, 10 Nov 2020 15:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20201110135320.3309507-1-elver@google.com>
In-Reply-To: <20201110135320.3309507-1-elver@google.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 11 Nov 2020 00:23:14 +0100
Message-ID: <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without allocations
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 14:53, Marco Elver <elver@google.com> wrote:
>
> To toggle the allocation gates, we set up a delayed work that calls
> toggle_allocation_gate(). Here we use wait_event() to await an
> allocation and subsequently disable the static branch again. However, if
> the kernel has stopped doing allocations entirely, we'd wait
> indefinitely, and stall the worker task. This may also result in the
> appropriate warnings if CONFIG_DETECT_HUNG_TASK=y.
>
> Therefore, introduce a 1 second timeout and use wait_event_timeout(). If
> the timeout is reached, the static branch is disabled and a new delayed
> work is scheduled to try setting up an allocation at a later time.
>
> Note that, this scenario is very unlikely during normal workloads once
> the kernel has booted and user space tasks are running. It can, however,
> happen during early boot after KFENCE has been enabled, when e.g.
> running tests that do not result in any allocations.
>
> Link: https://lkml.kernel.org/r/CADYN=9J0DQhizAGB0-jz4HOBBh+05kMBXb4c0cXMS7Qi5NAJiw@mail.gmail.com
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/kfence/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 9358f42a9a9e..933b197b8634 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -592,7 +592,11 @@ static void toggle_allocation_gate(struct work_struct *work)
>         /* Enable static key, and await allocation to happen. */
>         atomic_set(&allocation_gate, 0);
>         static_branch_enable(&kfence_allocation_key);
> -       wait_event(allocation_wait, atomic_read(&allocation_gate) != 0);
> +       /*
> +        * Await an allocation. Timeout after 1 second, in case the kernel stops
> +        * doing allocations, to avoid stalling this worker task for too long.
> +        */
> +       wait_event_timeout(allocation_wait, atomic_read(&allocation_gate) != 0, HZ);
>
>         /* Disable static key and reset timer. */
>         static_branch_disable(&kfence_allocation_key);
> --
> 2.29.2.222.g5d2a92d10f8-goog
>

I gave them a spin on next-20201105 [1] and on next-20201110 [2].

I eventually got to a prompt on next-20201105.
However, I got to this kernel panic on the next-20201110:

[...]
[ 1514.089966][    T1] Testing event system initcall: OK
[ 1514.806232][    T1] Running tests on all trace events:
[ 1514.857835][    T1] Testing all events:
[ 1525.503262][    C0] hrtimer: interrupt took 10902600 ns
[ 1623.861452][    C0] BUG: workqueue lockup - pool cpus=0 node=0
flags=0x0 nice=0 stuck for 65s!
[...]
[ 7823.104349][   T28]       Tainted: G        W
5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
[ 7833.206491][   T28] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 7840.750700][   T28] task:kworker/0:1     state:D stack:26640 pid:
1872 ppid:     2 flags:0x00000428
[ 7875.642531][   T28] Workqueue: events toggle_allocation_gate
[ 7889.178334][   T28] Call trace:
[ 7897.066649][   T28]  __switch_to+0x1cc/0x1e0
[ 7905.326856][   T28]  0xffff00000f7077b0
[ 7928.354644][   T28] INFO: lockdep is turned off.
[ 7934.022572][   T28] Kernel panic - not syncing: hung_task: blocked tasks
[ 7934.032039][   T28] CPU: 0 PID: 28 Comm: khungtaskd Tainted: G
  W         5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
[ 7934.045586][   T28] Hardware name: linux,dummy-virt (DT)
[ 7934.053677][   T28] Call trace:
[ 7934.060276][   T28]  dump_backtrace+0x0/0x420
[ 7934.067635][   T28]  show_stack+0x38/0xa0
[ 7934.091277][   T28]  dump_stack+0x1d4/0x278
[ 7934.098878][   T28]  panic+0x304/0x5d8
[ 7934.114923][   T28]  check_hung_uninterruptible_tasks+0x5e4/0x640
[ 7934.123823][   T28]  watchdog+0x138/0x160
[ 7934.131561][   T28]  kthread+0x23c/0x260
[ 7934.138590][   T28]  ret_from_fork+0x10/0x18
[ 7934.146631][   T28] Kernel Offset: disabled
[ 7934.153749][   T28] CPU features: 0x0240002,20002004
[ 7934.161476][   T28] Memory Limit: none
[ 7934.171272][   T28] ---[ end Kernel panic - not syncing: hung_task:
blocked tasks ]---


Cheers,
Anders
[1] https://people.linaro.org/~anders.roxell/output-next-20201105-test.log
[2] https://people.linaro.org/~anders.roxell/output-next-20201110-test.log
