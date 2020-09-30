Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A47327F4BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgI3WBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgI3WBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:01:14 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8DFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:01:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so3543015edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4YL+lNdGMsghFiiyVXUFYKr+d1Y4X0K0yYZxdRVN+Q=;
        b=nsRbXiOR1d5uOkP2Hn3WDkdiWl4FaafECWJk0Z0LoZJOdD4x9ju+bYpc03KEpkHcOP
         rNxeoWyFWXQKqM3JfgZE3Lgs8ZCa507m90YbFDJ1wlkj3LjbHj2Ar1OdxFJR8jxVEYhU
         lMqszQp89VwZ7BwQM+cnG427o+9/H4/nlbdxFPw2AwRRdc8xrPoNRv5Q/Prwpdg5PwR2
         7oWU4S9IDHEw5p40xcMbz47y8E5xLgug1W8vr8kTd1oIRGwRTHCHugrN4M9Zmn139XVk
         d0DU2DdpnThlnlZscBJgqBcghKwckBJQ21qz8AnqGSRjKsbsFL3FoaEiybGKfrqMpXzW
         FxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4YL+lNdGMsghFiiyVXUFYKr+d1Y4X0K0yYZxdRVN+Q=;
        b=QAEgEO9zzdCgSJBDnd28kWgCRw76CwoPyxIOM4WvGGUWy8Kqj+MhsctqYDQxyQfZXW
         4i/tWY7kHCecZywosV/8iiw4Nv2tjZAGd3r7IhjF6P04f16OE9cWp+G0Cf6PHSAr4D/Q
         KxXbPhhrJXUlM5PvaACfYdEM82hZLsg0ik2Iz2qqjP89vVExaUoPKJRjqi1cAXWNF/EW
         F9EQwHqNO3QHJZc66Y4TQjq/KSnzQPAHUSNWVfZ/Rw1vvwlGTKXTxMHYFpyQFlqz1NlX
         y6KWA95UKYXukaIAw07BnXimW3ObXqY9OJHZMgVHYdefPzXVNODpRClEPpKoYU+mPaFG
         1Psw==
X-Gm-Message-State: AOAM533Ih8MHp8S7Ac5w+CENRVKIUl03QWkuZYGQz8o1MArjwglghAGv
        At9TOhMeLBzzmgCYOZix8lJTljHDJ1H2R0OwlPzhTA==
X-Google-Smtp-Source: ABdhPJx+r3ymqn4NTjaCSnTfnu9MJPet1q8fE2eAOfbo/VZn36pDDUmIF7542A/F5sgR+LytFnb9dd+ClgVFQzScsmw=
X-Received: by 2002:a50:fe98:: with SMTP id d24mr4937741edt.223.1601503272085;
 Wed, 30 Sep 2020 15:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
In-Reply-To: <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 00:00:46 +0200
Message-ID: <CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNiEg0qbD3w@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 5:20 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> Currently the kernel does not provide an infrastructure to translate
> architecture numbers to a human-readable name. Translating syscall
> numbers to syscall names is possible through FTRACE_SYSCALL
> infrastructure but it does not provide support for compat syscalls.
>
> This will create a file for each PID as /proc/pid/seccomp_cache.
> The file will be empty when no seccomp filters are loaded, or be
> in the format of:
> <arch name> <decimal syscall number> <ALLOW | FILTER>
> where ALLOW means the cache is guaranteed to allow the syscall,
> and filter means the cache will pass the syscall to the BPF filter.
>
> For the docker default profile on x86_64 it looks like:
> x86_64 0 ALLOW
> x86_64 1 ALLOW
> x86_64 2 ALLOW
> x86_64 3 ALLOW
> [...]
> x86_64 132 ALLOW
> x86_64 133 ALLOW
> x86_64 134 FILTER
> x86_64 135 FILTER
> x86_64 136 FILTER
> x86_64 137 ALLOW
> x86_64 138 ALLOW
> x86_64 139 FILTER
> x86_64 140 ALLOW
> x86_64 141 ALLOW
> [...]

Oooh, neat! :) Thanks!

> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/Kconfig                   | 15 +++++++++++
>  arch/x86/include/asm/seccomp.h |  3 +++
>  fs/proc/base.c                 |  3 +++
>  include/linux/seccomp.h        |  5 ++++
>  kernel/seccomp.c               | 46 ++++++++++++++++++++++++++++++++++
>  5 files changed, 72 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ca867b2a5d71..b840cadcc882 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -478,6 +478,7 @@ config HAVE_ARCH_SECCOMP_CACHE_NR_ONLY
>           - all the requirements for HAVE_ARCH_SECCOMP_FILTER
>           - SECCOMP_ARCH_DEFAULT
>           - SECCOMP_ARCH_DEFAULT_NR
> +         - SECCOMP_ARCH_DEFAULT_NAME
>
>  config SECCOMP
>         prompt "Enable seccomp to safely execute untrusted bytecode"
> @@ -532,6 +533,20 @@ config SECCOMP_CACHE_NR_ONLY
>
>  endchoice
>
> +config DEBUG_SECCOMP_CACHE
> +       bool "Show seccomp filter cache status in /proc/pid/seccomp_cache"
> +       depends on SECCOMP_CACHE_NR_ONLY
> +       depends on PROC_FS
> +       help
> +         This is enables /proc/pid/seccomp_cache interface to monitor

nit: s/is enables/enables/

> +         seccomp cache data. The file format is subject to change. Reading
> +         the file requires CAP_SYS_ADMIN.
> +
> +         This option is for debugging only. Enabling present the risk that
> +         an adversary may be able to infer the seccomp filter logic.
> +
> +         If unsure, say N.
> +
[...]
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
[...]
> +int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
> +                          struct pid *pid, struct task_struct *task)
> +{
> +       struct seccomp_filter *f;
> +
> +       /*
> +        * We don't want some sandboxed process know what their seccomp
> +        * filters consist of.
> +        */
> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
> +               return -EACCES;
> +
> +       f = READ_ONCE(task->seccomp.filter);
> +       if (!f)
> +               return 0;

Hmm, this won't work, because the task could be exiting, and seccomp
filters are detached in release_task() (using
seccomp_filter_release()). And at the moment, seccomp_filter_release()
just locklessly NULLs out the tsk->seccomp.filter pointer and drops
the reference.

The locking here is kind of gross, but basically I think you can
change this code to use lock_task_sighand() / unlock_task_sighand()
(see the other examples in fs/proc/base.c), and bail out if
lock_task_sighand() returns NULL. And in seccomp_filter_release(), add
something like this:

/* We are effectively holding the siglock by not having any sighand. */
WARN_ON(tsk->sighand != NULL);

> +#ifdef SECCOMP_ARCH_DEFAULT
> +       proc_pid_seccomp_cache_arch(m, SECCOMP_ARCH_DEFAULT_NAME,
> +                                   f->cache.syscall_allow_default,
> +                                   SECCOMP_ARCH_DEFAULT_NR);
> +#endif /* SECCOMP_ARCH_DEFAULT */
> +
> +#ifdef SECCOMP_ARCH_COMPAT
> +       proc_pid_seccomp_cache_arch(m, SECCOMP_ARCH_COMPAT_NAME,
> +                                   f->cache.syscall_allow_compat,
> +                                   SECCOMP_ARCH_COMPAT_NR);
> +#endif /* SECCOMP_ARCH_COMPAT */
> +       return 0;
> +}
> +#endif /* CONFIG_DEBUG_SECCOMP_CACHE */
> --
> 2.28.0
>
