Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EED2E7250
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgL2Qan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:30:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgL2Qan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:30:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C74F207BC;
        Tue, 29 Dec 2020 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609259402;
        bh=m67px+2pRMeljHeb6eW6pNDGGZ3YI69PjC0TCzw071A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pzXGUsP+lpfxKhmpYA1py0aKiRuzA7WFHj1UkZ1+Qrlv/9ckT/emnYXRuVxOL0QJV
         3RKKwbZgzzAffg9KeuIUZSOZ+HQPg/0DRbIkea6M5qEXNE6cseaBSyYaZX13GSA4It
         bM9D2LyoX92WyIC/UJuFC4eIhLUoueW4aeqzSYyn4m+TPDcqqbG4YhBN+Z0lMuzRje
         1jei/gn1J0M4RsFDSDTXgcPmRY0Y8awMnQerpKv6sYN19sVtVMdK0jTzGGhIASsGSJ
         Y2oKc30+2wC6GhMN/Do8755NgNctXJsafIuXLy7iX8B5ZNFLnu0eRKoCEBR9rS1IMf
         KIU/If5rR6HOw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BAD3A352265D; Tue, 29 Dec 2020 08:30:01 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:30:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.12.15b 130/134] include/linux/stddef.h:8:14:
 error: called object is not a function or function pointer
Message-ID: <20201229163001.GL2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012291105.rCCNspgz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012291105.rCCNspgz-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:28:26AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.12.15b
> head:   f895a17eec290b0038a6294d884a9cc92d7d6e80
> commit: 7655dc620982c6505386efdaf975e6bde3c27afb [130/134] rcu-tasks: Use NULL pointer instead of empty show_rcu_tasks_*() functions
> config: ia64-randconfig-r012-20201217 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=7655dc620982c6505386efdaf975e6bde3c27afb
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2020.12.15b
>         git checkout 7655dc620982c6505386efdaf975e6bde3c27afb
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

This is fixed in -rcu by reverting 4cad23d7f4de ("rcu-tasks: Use NULL
pointer instead of empty show_rcu_tasks_*() functions").  Thank you for
your testing!

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    In file included from arch/ia64/include/asm/pgtable.h:154,
>                     from include/linux/pgtable.h:6,
>                     from arch/ia64/include/asm/uaccess.h:40,
>                     from include/linux/uaccess.h:11,
>                     from arch/ia64/include/asm/sections.h:11,
>                     from include/linux/interrupt.h:20,
>                     from kernel/rcu/update.c:25:
>    arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
>    arch/ia64/include/asm/mmu_context.h:137:41: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
>      137 |  unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
>          |                                         ^~~~~~~
>    In file included from include/uapi/linux/posix_types.h:5,
>                     from include/uapi/linux/types.h:14,
>                     from include/linux/types.h:6,
>                     from kernel/rcu/update.c:20:
>    kernel/rcu/tasks.h: In function 'show_rcu_tasks_gp_kthreads':
> >> include/linux/stddef.h:8:14: error: called object is not a function or function pointer
>        8 | #define NULL ((void *)0)
>          |              ^
>    kernel/rcu/rcu.h:554:40: note: in expansion of macro 'NULL'
>      554 | #define show_rcu_tasks_rude_gp_kthread NULL
>          |                                        ^~~~
>    kernel/rcu/tasks.h:1222:2: note: in expansion of macro 'show_rcu_tasks_rude_gp_kthread'
>     1222 |  show_rcu_tasks_rude_gp_kthread();
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/stddef.h:8:14: error: called object is not a function or function pointer
>        8 | #define NULL ((void *)0)
>          |              ^
>    kernel/rcu/rcu.h:559:41: note: in expansion of macro 'NULL'
>      559 | #define show_rcu_tasks_trace_gp_kthread NULL
>          |                                         ^~~~
>    kernel/rcu/tasks.h:1223:2: note: in expansion of macro 'show_rcu_tasks_trace_gp_kthread'
>     1223 |  show_rcu_tasks_trace_gp_kthread();
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +8 include/linux/stddef.h
> 
> ^1da177e4c3f415 Linus Torvalds   2005-04-16  6  
> ^1da177e4c3f415 Linus Torvalds   2005-04-16  7  #undef NULL
> ^1da177e4c3f415 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
> 6e2182874324727 Richard Knutsson 2006-09-30  9  
> 
> :::::: The code at line 8 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


