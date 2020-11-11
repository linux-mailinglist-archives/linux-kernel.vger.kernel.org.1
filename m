Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAA2AEBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgKKI36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:29:56 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C526C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:29:56 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id o25so1328106oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfSE5/lXKDKWvupd66vFeefPVzfzS3PVTtaZxopqHn0=;
        b=fY5gjnlcVshqGSRA6q6KUAXv/ADS/nDaZZEyYRq0zzOlqIBhd8YeaznY6x2LonMMEp
         +kkAI7SHlgNaXz8mMj5c4GYchnXQH1qFHxKneGweu9V6EHXVaNk7NYehPvYga6Dveujn
         q/bc+0hMvDzb80sshZeUn0EZr7bir5H7LXoXI5VwKMQ8M/mz5lGOmue1AuHbSj+NLbFB
         co9evogF7/JXWpyLdV+31dm4BJHr52+12hPBXtoUHOF3a5Q4p6Fu+0QYAFodijk3BUmg
         pkywXX9HE60D3PCTBgBIUqJrKCMJRgiO98visg0AVt6QArGrRCua17+swFdxRoyOGZvD
         vu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfSE5/lXKDKWvupd66vFeefPVzfzS3PVTtaZxopqHn0=;
        b=OL5LuYhbuKvWJYeSmO0Qs6hAIsYRCIgjS1rIpez1KDMkwNQuk6v3fxtmuOJxoNq/jp
         JIOytX12TA4FPlHGMDMxw0qH/GEq3wsLkwVwlv4Lskz15T6+D+7xNLBI6qC5SIs6YpMF
         kahKP8A0BqORX1KILgzHUTXThxLcrDYCKL7OPT4SwXyNjQto7+ZHfcr1QwIbg3TV98Ia
         MrFgIHT1xZKMAQ5qHVd1nXwfuMa/J++BvpGQhwHSEjf4tR4bPWzaBZSoN0HBQQwHLnFe
         MH+7tu7mXmqzuVL2ojR6MHJYUk01SQy3JyuA9MVsQsM5zYCU8Ms/WwQt3S1ESM99Iu1O
         KvSA==
X-Gm-Message-State: AOAM532NVT5aKStO8A4yt5z8JI7d6Oa2GY/OzbP5hSuljVTnDN4nyt6n
        7iKzhfy6nomt39iayDu21oQiBix/f2vmdxh59wjGZw==
X-Google-Smtp-Source: ABdhPJzSacpvGvWxh02TIAEIeTJX7iTjjyCW2uU9tYSTviNQgaMkp7c83J1N3CAcupo238JycrG45gFh4n4SmI6HuL8=
X-Received: by 2002:a05:6808:5ca:: with SMTP id d10mr1524759oij.70.1605083395264;
 Wed, 11 Nov 2020 00:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20201110135320.3309507-1-elver@google.com> <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
In-Reply-To: <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 11 Nov 2020 09:29:43 +0100
Message-ID: <CANpmjNM8MZphvkTSo=KgCBXQ6fNY4qo6NZD5SBHjNse_L9i5FQ@mail.gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without allocations
To:     Anders Roxell <anders.roxell@linaro.org>
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

On Wed, 11 Nov 2020 at 00:23, Anders Roxell <anders.roxell@linaro.org> wrote:
[...]
>
> I gave them a spin on next-20201105 [1] and on next-20201110 [2].
>
> I eventually got to a prompt on next-20201105.
> However, I got to this kernel panic on the next-20201110:
>
> [...]
> [ 1514.089966][    T1] Testing event system initcall: OK
> [ 1514.806232][    T1] Running tests on all trace events:
> [ 1514.857835][    T1] Testing all events:
> [ 1525.503262][    C0] hrtimer: interrupt took 10902600 ns
> [ 1623.861452][    C0] BUG: workqueue lockup - pool cpus=0 node=0
> flags=0x0 nice=0 stuck for 65s!
> [...]
> [ 7823.104349][   T28]       Tainted: G        W
> 5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> [ 7833.206491][   T28] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 7840.750700][   T28] task:kworker/0:1     state:D stack:26640 pid:
> 1872 ppid:     2 flags:0x00000428
> [ 7875.642531][   T28] Workqueue: events toggle_allocation_gate
> [ 7889.178334][   T28] Call trace:
> [ 7897.066649][   T28]  __switch_to+0x1cc/0x1e0
> [ 7905.326856][   T28]  0xffff00000f7077b0
> [ 7928.354644][   T28] INFO: lockdep is turned off.
> [ 7934.022572][   T28] Kernel panic - not syncing: hung_task: blocked tasks
> [ 7934.032039][   T28] CPU: 0 PID: 28 Comm: khungtaskd Tainted: G
>   W         5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> [ 7934.045586][   T28] Hardware name: linux,dummy-virt (DT)
> [ 7934.053677][   T28] Call trace:
> [ 7934.060276][   T28]  dump_backtrace+0x0/0x420
> [ 7934.067635][   T28]  show_stack+0x38/0xa0
> [ 7934.091277][   T28]  dump_stack+0x1d4/0x278
> [ 7934.098878][   T28]  panic+0x304/0x5d8
> [ 7934.114923][   T28]  check_hung_uninterruptible_tasks+0x5e4/0x640
> [ 7934.123823][   T28]  watchdog+0x138/0x160
> [ 7934.131561][   T28]  kthread+0x23c/0x260
> [ 7934.138590][   T28]  ret_from_fork+0x10/0x18
> [ 7934.146631][   T28] Kernel Offset: disabled
> [ 7934.153749][   T28] CPU features: 0x0240002,20002004
> [ 7934.161476][   T28] Memory Limit: none
> [ 7934.171272][   T28] ---[ end Kernel panic - not syncing: hung_task:
> blocked tasks ]---
>
> Cheers,
> Anders
> [1] https://people.linaro.org/~anders.roxell/output-next-20201105-test.log
> [2] https://people.linaro.org/~anders.roxell/output-next-20201110-test.log

Thanks for testing. The fact that it passes on next-20201105 but not
on 20201110 is strange. If you boot with KFENCE disabled (boot param
kfence.sample_interval=0), does it boot?

In your log [2] I see a number of "BUG: workqueue lockup ..." but that
doesn't make sense, at least I don't think the KFENCE work item is
causing this. It'd be interesting to bisect what changed between
20201105 and 20201110, but I have a suspicion that might take too
long. Short of that, let me see if there are any changes between the 2
that look like it might be causing this.

Thanks,
-- Marco
