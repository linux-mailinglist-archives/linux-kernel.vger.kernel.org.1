Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E320B273331
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgIUTz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:55:27 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:54506 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgIUTz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:55:26 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 15:55:25 EDT
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A6BA613C2B0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:50:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A6BA613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600717821;
        bh=pzVh9PGk6J97AGhYlX2+bmQYSaGEvPuI9GpRPmjIDYc=;
        h=To:From:Subject:Date:From;
        b=KwxK6m4hvkoz89bHWaA4fAMLZ9dnC7+DBNbn/CGWXDy6K8Xv2HnHI1Liw1GAWkJCF
         bcxjw+NqLvb62xgUmN74cMj5/zTUaJF7a9lreK7pHmRhKkxi0SHcQ7cB6DhtDJpcqj
         S7RqPMXuxpGc78kM4FNA+bLujl+4qrRcMYZDG3zA=
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Build failure for today's tree, Fedora-32
Organization: Candela Technologies
Message-ID: <10ab525d-cd22-18ec-3c82-c651a6749c0e@candelatech.com>
Date:   Mon, 21 Sep 2020 12:50:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm seeing this build failure, any idea what is the issue?  I've cleared my ccache (ccache --clear)
but that did not help.  A pull from this morning builds on Fedora-29 with same .config file.  I tried
that same commit on my F32 system to no success, so it seems like it might be something with
my F32 compiler/system.

[greearb@bendt7 linux-linus-x64-dbg]$ make bzImage
   GEN     Makefile
   CC      arch/x86/kernel/asm-offsets.s
In file included from /home/greearb/git/linux-linus/arch/x86/include/uapi/asm/siginfo.h:13,
                  from /home/greearb/git/linux-linus/include/uapi/linux/signal.h:6,
                  from /home/greearb/git/linux-linus/include/linux/signal_types.h:10,
                  from /home/greearb/git/linux-linus/include/linux/sched.h:30,
                  from /home/greearb/git/linux-linus/include/linux/uaccess.h:6,
                  from /home/greearb/git/linux-linus/arch/x86/include/asm/fpu/xstate.h:5,
                  from /home/greearb/git/linux-linus/arch/x86/include/asm/pgtable.h:26,
                  from /home/greearb/git/linux-linus/include/linux/pgtable.h:6,
                  from /home/greearb/git/linux-linus/include/linux/kasan.h:14,
                  from /home/greearb/git/linux-linus/include/linux/slab.h:136,
                  from /home/greearb/git/linux-linus/include/linux/crypto.h:20,
                  from /home/greearb/git/linux-linus/arch/x86/kernel/asm-offsets.c:9:
/home/greearb/git/linux-linus/include/asm-generic/siginfo.h: In function ‘copy_siginfo’:
/home/greearb/git/linux-linus/include/asm-generic/siginfo.h:30:20: error: ‘__ARCH_SI_PREAMBLE_SIZE’ undeclared (first use in this function)
    30 |   memcpy(to, from, __ARCH_SI_PREAMBLE_SIZE + sizeof(from->_sifields._sigchld));
       |                    ^~~~~~~~~~~~~~~~~~~~~~~
/home/greearb/git/linux-linus/include/asm-generic/siginfo.h:30:20: note: each undeclared identifier is reported only once for each function it appears in
In file included from /home/greearb/git/linux-linus/include/linux/sched/signal.h:6,
                  from /home/greearb/git/linux-linus/include/linux/rcuwait.h:6,
                  from /home/greearb/git/linux-linus/include/linux/percpu-rwsem.h:7,
                  from /home/greearb/git/linux-linus/include/linux/fs.h:33,
                  from /home/greearb/git/linux-linus/include/linux/cgroup.h:17,
                  from /home/greearb/git/linux-linus/include/linux/memcontrol.h:13,
                  from /home/greearb/git/linux-linus/include/linux/swap.h:9,
                  from /home/greearb/git/linux-linus/include/linux/suspend.h:5,
                  from /home/greearb/git/linux-linus/arch/x86/kernel/asm-offsets.c:13:
/home/greearb/git/linux-linus/include/linux/signal.h: At top level:
/home/greearb/git/linux-linus/include/linux/signal.h:14:20: error: conflicting types for ‘copy_siginfo’
    14 | static inline void copy_siginfo(kernel_siginfo_t *to,
       |                    ^~~~~~~~~~~~
In file included from /home/greearb/git/linux-linus/arch/x86/include/uapi/asm/siginfo.h:13,
                  from /home/greearb/git/linux-linus/include/uapi/linux/signal.h:6,
                  from /home/greearb/git/linux-linus/include/linux/signal_types.h:10,
                  from /home/greearb/git/linux-linus/include/linux/sched.h:30,
                  from /home/greearb/git/linux-linus/include/linux/uaccess.h:6,
                  from /home/greearb/git/linux-linus/arch/x86/include/asm/fpu/xstate.h:5,
                  from /home/greearb/git/linux-linus/arch/x86/include/asm/pgtable.h:26,
                  from /home/greearb/git/linux-linus/include/linux/pgtable.h:6,
                  from /home/greearb/git/linux-linus/include/linux/kasan.h:14,
                  from /home/greearb/git/linux-linus/include/linux/slab.h:136,
                  from /home/greearb/git/linux-linus/include/linux/crypto.h:20,
                  from /home/greearb/git/linux-linus/arch/x86/kernel/asm-offsets.c:9:
/home/greearb/git/linux-linus/include/asm-generic/siginfo.h:24:20: note: previous definition of ‘copy_siginfo’ was here
    24 | static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
       |                    ^~~~~~~~~~~~
In file included from /home/greearb/git/linux-linus/include/linux/sched/signal.h:6,
                  from /home/greearb/git/linux-linus/include/linux/rcuwait.h:6,
                  from /home/greearb/git/linux-linus/include/linux/percpu-rwsem.h:7,
                  from /home/greearb/git/linux-linus/include/linux/fs.h:33,
                  from /home/greearb/git/linux-linus/include/linux/cgroup.h:17,
                  from /home/greearb/git/linux-linus/include/linux/memcontrol.h:13,
                  from /home/greearb/git/linux-linus/include/linux/swap.h:9,
                  from /home/greearb/git/linux-linus/include/linux/suspend.h:5,
                  from /home/greearb/git/linux-linus/arch/x86/kernel/asm-offsets.c:13:
/home/greearb/git/linux-linus/include/linux/signal.h:35:5: error: conflicting types for ‘copy_siginfo_to_user’
    35 | int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from);
       |     ^~~~~~~~~~~~~~~~~~~~
In file included from /home/greearb/git/linux-linus/arch/x86/include/uapi/asm/siginfo.h:13,
                  from /home/greearb/git/linux-linus/include/uapi/linux/signal.h:6,
                  from /home/greearb/git/linux-linus/include/linux/signal_types.h:10,
                  from /home/greearb/git/linux-linus/include/linux/sched.h:30,
                  from /home/greearb/git/linux-linus/include/linux/uaccess.h:6,
                  from /home/greearb/git/linux-linus/arch/x86/include/asm/fpu/xstate.h:5,
                  from /home/greearb/git/linux-linus/arch/x86/include/asm/pgtable.h:26,
                  from /home/greearb/git/linux-linus/include/linux/pgtable.h:6,
                  from /home/greearb/git/linux-linus/include/linux/kasan.h:14,
                  from /home/greearb/git/linux-linus/include/linux/slab.h:136,
                  from /home/greearb/git/linux-linus/include/linux/crypto.h:20,
                  from /home/greearb/git/linux-linus/arch/x86/kernel/asm-offsets.c:9:
/home/greearb/git/linux-linus/include/asm-generic/siginfo.h:35:12: note: previous declaration of ‘copy_siginfo_to_user’ was here
    35 | extern int copy_siginfo_to_user(struct siginfo __user *to, const struct siginfo *from);
       |            ^~~~~~~~~~~~~~~~~~~~
make[2]: *** [/home/greearb/git/linux-linus/scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
make[1]: *** [/home/greearb/git/linux-linus/Makefile:1198: prepare0] Error 2
make: *** [/home/greearb/git/linux-linus/Makefile:185: __sub-make] Error 2


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
