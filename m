Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E121B2C354F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgKYATW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 19:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgKYATW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:19:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 16:19:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E7A941F4539F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [tip:core/entry 1/1] include/linux/seccomp.h:45:15: error: use
 of undeclared identifier 'TIF_WORK_SECCOMP'
Organization: Collabora
References: <202011250806.w8maTx2J-lkp@intel.com>
Date:   Tue, 24 Nov 2020 19:19:13 -0500
In-Reply-To: <202011250806.w8maTx2J-lkp@intel.com> (kernel test robot's
        message of "Wed, 25 Nov 2020 08:09:27 +0800")
Message-ID: <87pn42nv9a.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
> head:   0395124a2fbff5132afee5767071ebe7e05885ac
> commit: 0395124a2fbff5132afee5767071ebe7e05885ac [1/1] entry: Fix boot for !CONFIG_GENERIC_ENTRY
> config: riscv-randconfig-r024-20201124 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project df9ae5992889560a8f3c6760b54d5051b47c7bf5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=0395124a2fbff5132afee5767071ebe7e05885ac
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip core/entry
>         git checkout 0395124a2fbff5132afee5767071ebe7e05885ac
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/sched.h:22:
>>> include/linux/seccomp.h:45:15: error: use of undeclared identifier 'TIF_WORK_SECCOMP'
>            if (unlikely(test_syscall_work(SECCOMP)))
>                         ^
>    include/linux/thread_info.h:136:45: note: expanded from macro 'test_syscall_work'
>            test_ti_thread_flag(current_thread_info(), TIF_WORK_##fl)
>                                                       ^
>    <scratch space>:71:1: note: expanded from here
>    TIF_WORK_SECCOMP

Was this a merge error when applying the commit?

The patch I submitted is different from what is in the TIP tree.

https://www.spinics.net/lists/arm-kernel/msg857461.html

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=core/entry

-- 
Gabriel Krisman Bertazi
