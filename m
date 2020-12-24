Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B21C2E2435
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 05:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgLXEr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 23:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbgLXEr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 23:47:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 185BA22AAA;
        Thu, 24 Dec 2020 04:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608785206;
        bh=YCM/X6E5BB915TYSMuedoa1msD++ClYAdx1/p+9UNM0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NTL9dDL7QtGq9XzpF/N+WIYELWpYqI6XJjAsTKN2Mg+Q/WG85XeTNlEmwInurqgxJ
         A8wrZeLXAepZ2ERttWNbEq4hB26VtSKNQL8k5B1bVOB5j4pGCaNJ6j5nMDTQD43q+W
         DmgrJE7rA5yaTCMSd6mNOm+drAgO7eJLssOqoP2V7ufJRwNRvMSoaqVYEABnWuNh2/
         QlFX5Xej2KMaXuzB0QOG4eoD24qTYUOycWkwDSEvlabPF/p7fzbiDuHQIyMOl5ruo3
         p0srWosvHaPT9iwuUykqhVgUv6RQZjSrgJ0LVdXIhDoPNQRLR1vv5SrarPAGaM3kLm
         /ta7QI1y5lgjQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D93FF35225D6; Wed, 23 Dec 2020 20:46:45 -0800 (PST)
Date:   Wed, 23 Dec 2020 20:46:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: update.c:undefined reference to `irq_work_queue'
Message-ID: <20201224044645.GH2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012221118.j0EcAlVl-lkp@intel.com>
 <20201222050305.GA2657@paulmck-ThinkPad-P72>
 <02b0dfb2-b3bd-be13-515c-515b49a32fe8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b0dfb2-b3bd-be13-515c-515b49a32fe8@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 12:06:07PM -0800, Randy Dunlap wrote:
> On 12/21/20 9:03 PM, Paul E. McKenney wrote:
> > On Tue, Dec 22, 2020 at 11:24:22AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   8653b778e454a7708847aeafe689bce07aeeb94e
> > > commit: b38f57c1fe64276773b124dffb0a139cc32ab3cb rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
> > > date:   8 months ago
> > > config: h8300-randconfig-s032-20201220 (attached as .config)
> > > compiler: h8300-linux-gcc (GCC) 9.3.0
> > > reproduce:
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # apt-get install sparse
> > >          # sparse version: v0.6.3-184-g1b896707-dirty
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b38f57c1fe64276773b124dffb0a139cc32ab3cb
> > >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >          git fetch --no-tags linus master
> > >          git checkout b38f57c1fe64276773b124dffb0a139cc32ab3cb
> > >          # save the attached .config to linux build tree
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=h8300
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >     h8300-linux-ld: section .init.text LMA [000000000043a160,0000000000452569] overlaps section .rodata LMA [00000000003ff420,000000000047df2f]
> > >     h8300-linux-ld: section .data VMA [0000000000400000,000000000043a15f] overlaps section .rodata VMA [00000000003ff420,000000000047df2f]
> > >     h8300-linux-ld: section __ksymtab VMA [000000000047df30,000000000048611f] overlaps section .bss VMA [000000000045ebd0,000000000056a053]
> > >     h8300-linux-ld: kernel/rcu/update.o: in function `rcu_read_unlock_trace_special':
> > > > > update.c:(.text+0x8f9): undefined reference to `irq_work_queue'
> > 
> > Does the patch below help?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit cb7220ed05190c9a92df95b52a21525a7e08a449
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Mon Dec 21 21:00:18 2020 -0800
> > 
> >      rcu: Make TASKS_TRACE_RCU select IRQ_WORK
> >      Tasks Trace RCU uses irq_work_queue() to safely awaken its grace-period
> >      kthread, so this commit therefore causes the TASKS_TRACE_RCU Kconfig
> >      option select the IRQ_WORK Kconfig option.
> >      Reported-by: kernel test robot <lkp@intel.com>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index aa8cc8c9..3128b7c 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -95,6 +95,7 @@ config TASKS_RUDE_RCU
> >   config TASKS_TRACE_RCU
> >   	def_bool 0
> > +	select IRQ_WORK
> >   	help
> >   	  This option enables a task-based RCU implementation that uses
> >   	  explicit rcu_read_lock_trace() read-side markers, and allows
> > 
> 
> WorksForMe. Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thank you, I will apply on my next rebase.

							Thanx, Paul
