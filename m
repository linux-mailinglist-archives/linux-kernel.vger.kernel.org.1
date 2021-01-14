Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42EF2F6628
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbhANQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbhANQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:41:56 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:41:15 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id y21so1961385uag.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucUo43DPZJ2d/n97vrCXUQQGDHB8YrUFAnwcmPbryUY=;
        b=ERabjKgCKiAEayL4eSIjd9wBN/ebsC8H+sUE9SzueseBO8jkXEnH+EfKzukwzW56kc
         5qIBJ2xDz0jWJsZYA/VC2DiSXl49ANc3Po833oRsV6bPxlSK1Ytc0veTPgNnDMCoP6YO
         se5AdmxJkrjnanVWz+vR7H6wXNWM4CIw1NS1Z1UClinZwEhTDa9JFmIhrAe1Y5ER+Zd5
         idcU7lq7oNViMEVbozkrRZzV9rIsvqHdUloOY7NEAiEA22eafYPmBu0o0umUQxuLP6Cs
         2OOKPynqgcSAoRUUKCKCoImjH807XrHUKC1AaAZ0AH+aBIbpWiGVtbfjiFcVaN5U01ug
         iILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucUo43DPZJ2d/n97vrCXUQQGDHB8YrUFAnwcmPbryUY=;
        b=nqMvQGEnlTgUDvxbKWHjP8OB7v/0CB0AtFERmmfjG2iG2YFgOTUDjJqqAiAFidy2oe
         NrKOPYf6KkCZrGr8oXi3F+G09CdTLyWX+H+d05k+lV/vh8iO29YrMoWrh6RzEOaB0d8q
         sh+Etd2z/fLVmH9XPMTelg06ffh3aoytJnTXUPTteioKL7q1NS+Qf7JhMkzwFlNrR2Dl
         F0JuEwJPAqugSg6of1hVakUusTSKDyZe0r00bo2IaQ16sZC9f31VDYIc/u+Jxpu3UFvO
         AxFAvGB9Y3jTMhH9Lye4Znzw1XSvYtY2EI/9iwWsY+9v63M5FWY16dpM48sOcEHGZBeB
         tCPg==
X-Gm-Message-State: AOAM532Y/LGPDYwUNgOdPJK6kSBORH1r9phwUb7y1AwuOYxrGzDK2xo6
        bSL+diVM9bdUkSSc81Y0jm1+tfuti7ODb87O+EL69BX4u8s=
X-Google-Smtp-Source: ABdhPJwFDchpGB88vI5DyVGFffjg5ckbUGKes/qyRWr/cUYXxMsQxmJFs+ANaX9v8rUKGlrcaQSpkfcMLV9w8tTP1ZQ=
X-Received: by 2002:ab0:2:: with SMTP id 2mr6517767uai.108.1610642474303; Thu,
 14 Jan 2021 08:41:14 -0800 (PST)
MIME-Version: 1.0
References: <202101141602.oEXcPc7c-lkp@intel.com>
In-Reply-To: <202101141602.oEXcPc7c-lkp@intel.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Thu, 14 Jan 2021 11:40:38 -0500
Message-ID: <CA+FuTSd+omnNXq7MafjoF4j74g9P4eNkrd+q_mswuX_=5QE6MQ@mail.gmail.com>
Subject: Re: arch/arm64/include/asm/syscall_wrapper.h:41:25: warning: no
 previous prototype for '__arm64_compat_sys_epoll_pwait2'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 3:05 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   65f0d2414b7079556fbbcc070b3d1c9f9587606d
> commit: b0a0c2615f6f199a656ed8549d7dce625d77aa77 epoll: wire up syscall epoll_pwait2
> date:   4 weeks ago
> config: arm64-randconfig-r005-20210113 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0a0c2615f6f199a656ed8549d7dce625d77aa77
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b0a0c2615f6f199a656ed8549d7dce625d77aa77
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:45:1: note: in expansion of macro 'COND_SYSCALL'
>       45 | COND_SYSCALL(io_getevents_time32);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_io_getevents' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:46:1: note: in expansion of macro 'COND_SYSCALL'
>       46 | COND_SYSCALL(io_getevents);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_io_pgetevents_time32' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:47:1: note: in expansion of macro 'COND_SYSCALL'
>       47 | COND_SYSCALL(io_pgetevents_time32);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_io_pgetevents' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:48:1: note: in expansion of macro 'COND_SYSCALL'
>       48 | COND_SYSCALL(io_pgetevents);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:41:25: warning: no previous prototype for '__arm64_compat_sys_io_pgetevents_time32' [-Wmissing-prototypes]
>       41 |  asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~~~~~~~~
>    kernel/sys_ni.c:49:1: note: in expansion of macro 'COND_SYSCALL_COMPAT'
>       49 | COND_SYSCALL_COMPAT(io_pgetevents_time32);
>          | ^~~~~~~~~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:41:25: warning: no previous prototype for '__arm64_compat_sys_io_pgetevents' [-Wmissing-prototypes]
>       41 |  asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~~~~~~~~
>    kernel/sys_ni.c:50:1: note: in expansion of macro 'COND_SYSCALL_COMPAT'
>       50 | COND_SYSCALL_COMPAT(io_pgetevents);
>          | ^~~~~~~~~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_io_uring_setup' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:51:1: note: in expansion of macro 'COND_SYSCALL'
>       51 | COND_SYSCALL(io_uring_setup);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_io_uring_enter' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:52:1: note: in expansion of macro 'COND_SYSCALL'
>       52 | COND_SYSCALL(io_uring_enter);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_io_uring_register' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:53:1: note: in expansion of macro 'COND_SYSCALL'
>       53 | COND_SYSCALL(io_uring_register);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_lookup_dcookie' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:60:1: note: in expansion of macro 'COND_SYSCALL'
>       60 | COND_SYSCALL(lookup_dcookie);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:41:25: warning: no previous prototype for '__arm64_compat_sys_lookup_dcookie' [-Wmissing-prototypes]
>       41 |  asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~~~~~~~~
>    kernel/sys_ni.c:61:1: note: in expansion of macro 'COND_SYSCALL_COMPAT'
>       61 | COND_SYSCALL_COMPAT(lookup_dcookie);
>          | ^~~~~~~~~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_eventfd2' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:64:1: note: in expansion of macro 'COND_SYSCALL'
>       64 | COND_SYSCALL(eventfd2);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_epoll_create1' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:67:1: note: in expansion of macro 'COND_SYSCALL'
>       67 | COND_SYSCALL(epoll_create1);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_epoll_ctl' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:68:1: note: in expansion of macro 'COND_SYSCALL'
>       68 | COND_SYSCALL(epoll_ctl);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_epoll_pwait' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:69:1: note: in expansion of macro 'COND_SYSCALL'
>       69 | COND_SYSCALL(epoll_pwait);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:41:25: warning: no previous prototype for '__arm64_compat_sys_epoll_pwait' [-Wmissing-prototypes]
>       41 |  asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~~~~~~~~
>    kernel/sys_ni.c:70:1: note: in expansion of macro 'COND_SYSCALL_COMPAT'
>       70 | COND_SYSCALL_COMPAT(epoll_pwait);
>          | ^~~~~~~~~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_epoll_pwait2' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:71:1: note: in expansion of macro 'COND_SYSCALL'
>       71 | COND_SYSCALL(epoll_pwait2);
>          | ^~~~~~~~~~~~
> >> arch/arm64/include/asm/syscall_wrapper.h:41:25: warning: no previous prototype for '__arm64_compat_sys_epoll_pwait2' [-Wmissing-prototypes]
>       41 |  asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~~~~~~~~
>    kernel/sys_ni.c:72:1: note: in expansion of macro 'COND_SYSCALL_COMPAT'
>       72 | COND_SYSCALL_COMPAT(epoll_pwait2);
>          | ^~~~~~~~~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_inotify_init1' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:77:1: note: in expansion of macro 'COND_SYSCALL'
>       77 | COND_SYSCALL(inotify_init1);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_inotify_add_watch' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:78:1: note: in expansion of macro 'COND_SYSCALL'
>       78 | COND_SYSCALL(inotify_add_watch);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_inotify_rm_watch' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:79:1: note: in expansion of macro 'COND_SYSCALL'
>       79 | COND_SYSCALL(inotify_rm_watch);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_ioprio_set' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:84:1: note: in expansion of macro 'COND_SYSCALL'
>       84 | COND_SYSCALL(ioprio_set);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_ioprio_get' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:85:1: note: in expansion of macro 'COND_SYSCALL'
>       85 | COND_SYSCALL(ioprio_get);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_flock' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:88:1: note: in expansion of macro 'COND_SYSCALL'
>       88 | COND_SYSCALL(flock);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_quotactl' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:101:1: note: in expansion of macro 'COND_SYSCALL'
>      101 | COND_SYSCALL(quotactl);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_signalfd4' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:112:1: note: in expansion of macro 'COND_SYSCALL'
>      112 | COND_SYSCALL(signalfd4);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:41:25: warning: no previous prototype for '__arm64_compat_sys_signalfd4' [-Wmissing-prototypes]
>       41 |  asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~~~~~~~~
>    kernel/sys_ni.c:113:1: note: in expansion of macro 'COND_SYSCALL_COMPAT'
>      113 | COND_SYSCALL_COMPAT(signalfd4);
>          | ^~~~~~~~~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_timerfd_create' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:122:1: note: in expansion of macro 'COND_SYSCALL'
>      122 | COND_SYSCALL(timerfd_create);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_timerfd_settime' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:123:1: note: in expansion of macro 'COND_SYSCALL'
>      123 | COND_SYSCALL(timerfd_settime);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_timerfd_settime32' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:124:1: note: in expansion of macro 'COND_SYSCALL'
>      124 | COND_SYSCALL(timerfd_settime32);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_timerfd_gettime' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:125:1: note: in expansion of macro 'COND_SYSCALL'
>      125 | COND_SYSCALL(timerfd_gettime);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_timerfd_gettime32' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:126:1: note: in expansion of macro 'COND_SYSCALL'
>      126 | COND_SYSCALL(timerfd_gettime32);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_acct' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:131:1: note: in expansion of macro 'COND_SYSCALL'
>      131 | COND_SYSCALL(acct);
>          | ^~~~~~~~~~~~
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: warning: no previous prototype for '__arm64_sys_capget' [-Wmissing-prototypes]
>       76 |  asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs) \
>          |                         ^~~~~~~~~~~~
>    kernel/sys_ni.c:134:1: note: in expansion of macro 'COND_SYSCALL'
>      134 | COND_SYSCALL(capget);
>
>
> vim +/__arm64_compat_sys_epoll_pwait2 +41 arch/arm64/include/asm/syscall_wrapper.h
>
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  19
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  20  #define COMPAT_SYSCALL_DEFINEx(x, name, ...)                                             \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  21   asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs);           \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  22   ALLOW_ERROR_INJECTION(__arm64_compat_sys##name, ERRNO);                         \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  23   static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));              \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  24   static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));       \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  25   asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs)            \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  26   {                                                                               \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  27           return __se_compat_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));     \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  28   }                                                                               \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  29   static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))               \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  30   {                                                                               \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  31           return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));        \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  32   }                                                                               \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  33   static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  34
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  35  #define COMPAT_SYSCALL_DEFINE0(sname)                                                    \
> 0e358bd7b7ebd27e Sami Tolvanen 2019-05-24  36   asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused);     \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  37   ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);                       \
> 0e358bd7b7ebd27e Sami Tolvanen 2019-05-24  38   asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused)
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  39
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  40  #define COND_SYSCALL_COMPAT(name)                                                        \
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10 @41   asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs)    \
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10  42   {                                                                               \
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10  43           return sys_ni_syscall();                                                \
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10  44   }
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  45
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  46  #define COMPAT_SYS_NI(name) \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  47   SYSCALL_ALIAS(__arm64_compat_sys_##name, sys_ni_posix_timers);
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  48
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  49  #endif /* CONFIG_COMPAT */
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  50
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  51  #define __SYSCALL_DEFINEx(x, name, ...)                                          \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  52   asmlinkage long __arm64_sys##name(const struct pt_regs *regs);          \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  53   ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);                        \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  54   static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));             \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  55   static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));      \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  56   asmlinkage long __arm64_sys##name(const struct pt_regs *regs)           \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  57   {                                                                       \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  58           return __se_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));    \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  59   }                                                                       \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  60   static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))              \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  61   {                                                                       \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  62           long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));      \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  63           __MAP(x,__SC_TEST,__VA_ARGS__);                                 \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  64           __PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));               \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  65           return ret;                                                     \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  66   }                                                                       \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  67   static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  68
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  69  #define SYSCALL_DEFINE0(sname)                                                   \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  70   SYSCALL_METADATA(_##sname, 0);                                          \
> 0e358bd7b7ebd27e Sami Tolvanen 2019-05-24  71   asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);    \
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  72   ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);                      \
> 0e358bd7b7ebd27e Sami Tolvanen 2019-05-24  73   asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused)
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  74
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10  75  #define COND_SYSCALL(name)                                                       \
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10 @76   asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10  77   {                                                                       \
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10  78           return sys_ni_syscall();                                        \
> c27eccfe4d6c7481 Sami Tolvanen 2019-09-10  79   }
> 4378a7d4be30ec69 Mark Rutland  2018-07-11  80
>
> :::::: The code at line 41 was first introduced by commit
> :::::: c27eccfe4d6c7481ce99f1c433ca043ab464080a arm64: fix function types in COND_SYSCALL
>
> :::::: TO: Sami Tolvanen <samitolvanen@google.com>
> :::::: CC: Will Deacon <will@kernel.org>

As the report notes, the warnings in general are not new with this
commit. This commit only adds one more instance, for epoll_pwait2.
