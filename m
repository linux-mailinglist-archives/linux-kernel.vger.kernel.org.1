Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4AA2AF4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKKPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:22:35 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C6C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:22:33 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g19so2423138otp.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qXuq3ha015RB7+Wp6T10l2uYM1lO9pj4+Ev82Ko6MA=;
        b=doby/aOl1OVARP7VU52k8cICTKkAEh+GZTZEEfoDiz+qQaMdo/cGEjhRE6hojVh2N+
         XBb7iT210sawrd871afqUi6C9DtBA9KAOx+XxHmZlmBdySxnS55EBVW9I5By1s+6pL3g
         KVN7X199uRaXBO+xeIpypMtACIAGFBjwhbP0Po/K+dr8JFEP6xgIKtjZwT7lhIfk0KyF
         kzFb8rMEbYPW4QG4YqD3Dv4rNyW+0FkMjgdQjcZNwqxUUsWZ2JVeK35WV3J2+K+J6U1U
         NACvPQYjuyS6rfT5n4TIgFZTfzw4abqKmbD+MV9tWWtbl+DWWiucxVn8mDGuo8u1vqc+
         AqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qXuq3ha015RB7+Wp6T10l2uYM1lO9pj4+Ev82Ko6MA=;
        b=dhIkgV6RuKdnIhqe9HG6ONEpA19Q/s3jIfXx89njFpRCjgAoQPj/X4qB9oxZLKEPUS
         tmXgZvzDT5YsWADwBQlBc1cHuogI5Equ1ZxovR23cr54LSxjYx7/VXUeZqPIpQVFDbUQ
         urly96WX1SMqTMRMU2xLCmYZjtOLiz44vTE1lWxdYD0qR+LmjdcD16d1MX6ZPK+QBzby
         hL2tq68v2McaWf7QL6hg9NBZldYHW0SAZ5tCAX6clZEGAJAtQ+RmYFsOqchqvu5yCIBM
         FcjVdJ+Oo1pAQT2lEVEulRhCUqiQ20dmcVVfxi0oReop0FO62u3dPH+6+meGPJa1zg59
         U0Pg==
X-Gm-Message-State: AOAM533bGfYObXHD1ZyrHoHzRZa85xDULDeZhVNb2URC58ETf+PjwrN5
        VEmEUI+xvm2kSZBX3qTvujzPgIleN9wqM7OrPXk+dQ==
X-Google-Smtp-Source: ABdhPJyDVj8jY7v5bU35bgEFcJJ3qyH4qWzPgn4DfZKaOxb0cDIcRbbbycTRyijSRolnkLnVo6mit5GCdF2sfqfhgqQ=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr16777802oth.251.1605108152557;
 Wed, 11 Nov 2020 07:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20201110135320.3309507-1-elver@google.com> <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
 <CANpmjNM8MZphvkTSo=KgCBXQ6fNY4qo6NZD5SBHjNse_L9i5FQ@mail.gmail.com> <CADYN=9LtdW3Bs29VSq2ygnNcb3ub_UBLj8tZg5ff5Zvojr5FWg@mail.gmail.com>
In-Reply-To: <CADYN=9LtdW3Bs29VSq2ygnNcb3ub_UBLj8tZg5ff5Zvojr5FWg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 11 Nov 2020 16:22:20 +0100
Message-ID: <CANpmjNMBUR-gxDbq5ip4J38PwRHbwOk=zoG5ScVuF6aW326mxQ@mail.gmail.com>
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

On Wed, 11 Nov 2020 at 16:01, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Wed, 11 Nov 2020 at 09:29, Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 11 Nov 2020 at 00:23, Anders Roxell <anders.roxell@linaro.org> wrote:
> > [...]
> > >
> > > I gave them a spin on next-20201105 [1] and on next-20201110 [2].
> > >
> > > I eventually got to a prompt on next-20201105.
> > > However, I got to this kernel panic on the next-20201110:
> > >
> > > [...]
> > > [ 1514.089966][    T1] Testing event system initcall: OK
> > > [ 1514.806232][    T1] Running tests on all trace events:
> > > [ 1514.857835][    T1] Testing all events:
> > > [ 1525.503262][    C0] hrtimer: interrupt took 10902600 ns
> > > [ 1623.861452][    C0] BUG: workqueue lockup - pool cpus=0 node=0
> > > flags=0x0 nice=0 stuck for 65s!
> > > [...]
> > > [ 7823.104349][   T28]       Tainted: G        W
> > > 5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> > > [ 7833.206491][   T28] "echo 0 >
> > > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [ 7840.750700][   T28] task:kworker/0:1     state:D stack:26640 pid:
> > > 1872 ppid:     2 flags:0x00000428
> > > [ 7875.642531][   T28] Workqueue: events toggle_allocation_gate
> > > [ 7889.178334][   T28] Call trace:
> > > [ 7897.066649][   T28]  __switch_to+0x1cc/0x1e0
> > > [ 7905.326856][   T28]  0xffff00000f7077b0
> > > [ 7928.354644][   T28] INFO: lockdep is turned off.
> > > [ 7934.022572][   T28] Kernel panic - not syncing: hung_task: blocked tasks
> > > [ 7934.032039][   T28] CPU: 0 PID: 28 Comm: khungtaskd Tainted: G
> > >   W         5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> > > [ 7934.045586][   T28] Hardware name: linux,dummy-virt (DT)
> > > [ 7934.053677][   T28] Call trace:
> > > [ 7934.060276][   T28]  dump_backtrace+0x0/0x420
> > > [ 7934.067635][   T28]  show_stack+0x38/0xa0
> > > [ 7934.091277][   T28]  dump_stack+0x1d4/0x278
> > > [ 7934.098878][   T28]  panic+0x304/0x5d8
> > > [ 7934.114923][   T28]  check_hung_uninterruptible_tasks+0x5e4/0x640
> > > [ 7934.123823][   T28]  watchdog+0x138/0x160
> > > [ 7934.131561][   T28]  kthread+0x23c/0x260
> > > [ 7934.138590][   T28]  ret_from_fork+0x10/0x18
> > > [ 7934.146631][   T28] Kernel Offset: disabled
> > > [ 7934.153749][   T28] CPU features: 0x0240002,20002004
> > > [ 7934.161476][   T28] Memory Limit: none
> > > [ 7934.171272][   T28] ---[ end Kernel panic - not syncing: hung_task:
> > > blocked tasks ]---
> > >
> > > Cheers,
> > > Anders
> > > [1] https://people.linaro.org/~anders.roxell/output-next-20201105-test.log
> > > [2] https://people.linaro.org/~anders.roxell/output-next-20201110-test.log
> >
> > Thanks for testing. The fact that it passes on next-20201105 but not
> > on 20201110 is strange. If you boot with KFENCE disabled (boot param
> > kfence.sample_interval=0), does it boot?
>
> This is my qemu cmdline with kfence.sample_interval=0
> $ qemu-system-aarch64 --enable-kvm -cpu cortex-a53 -kernel
> Image-20201110-test -serial stdio -monitor none -nographic -m 2G -M
> virt -fsdev local,id=root,path=/srv/kvm/tmp/stretch/arm64-test,security_model=none,writeout=immediate
> -device virtio-rng-pci -device
> virtio-9p-pci,fsdev=root,mount_tag=/dev/root -append "root=/dev/root
> rootfstype=9p rootflags=trans=virtio console=ttyAMA0,38400n8
> earlycon=pl011,0x9000000 initcall_debug softlockup_panic=0
> security=none kpti=no kfence.sample_interval=0"
>
> This is the result, I managed to get to the prompt. see
> https://people.linaro.org/~anders.roxell/output-next-20201110-test-2.log

Hmm, you still have a ton of

   BUG: workqueue lockup - pool ...

and other warnings in that log though that weren't there in
next-20201105, so I do not trust the results until those are fixed. To
me it looks like KFENCE's timer helps uncover a new problem, but
trying to work around this new problem in KFENCE seems wrong for now.
We need to understand why these "BUG: workqueue lockup" warnings are
there. I Cc'd a bunch of folks in that other email that might be able
to help.

Thanks,
-- Marco
