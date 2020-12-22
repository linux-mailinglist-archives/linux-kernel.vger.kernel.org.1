Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45A2E058A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 06:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgLVFDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 00:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgLVFDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 00:03:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3867F22518;
        Tue, 22 Dec 2020 05:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608613386;
        bh=cPk2W6GKhabXQskzP6DCuQDT6bv8ApGi/8s7Y9Q3mCQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f/wcKe6xX5h46+qKgfAq+Jk4n0gYLuObsCn4foiApT8W/4I4zVswkXtQobkdb1Cmu
         VZgrhPOS6j3H5ry9WyyEWKYGh/KU5DM5f9HdosUVJlezIONOVhbsA3C1GBvWQR2W6A
         TNOzf/mpYO4CqAZrfC2qlrDMYQ8k/hM2IWRGNGERrqeEmGUDDpPZHKAMPUQPZvcCEV
         nchALWqKA6JttCinavfzP7Isv8PMGaxGYmhr5wKda/55EiMIa7Gs5HnITAIfPMqMHm
         hGKszYL+RZtXBVTFgR62MFWu/qVtQMutAstyA5dgBYKIq2qz/wQ3rWC6RPxYNvoyKj
         2mQ2WcJ/OLXNg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E7671352275F; Mon, 21 Dec 2020 21:03:05 -0800 (PST)
Date:   Mon, 21 Dec 2020 21:03:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: update.c:undefined reference to `irq_work_queue'
Message-ID: <20201222050305.GA2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012221118.j0EcAlVl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012221118.j0EcAlVl-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 11:24:22AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8653b778e454a7708847aeafe689bce07aeeb94e
> commit: b38f57c1fe64276773b124dffb0a139cc32ab3cb rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
> date:   8 months ago
> config: h8300-randconfig-s032-20201220 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-184-g1b896707-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b38f57c1fe64276773b124dffb0a139cc32ab3cb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b38f57c1fe64276773b124dffb0a139cc32ab3cb
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=h8300 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    h8300-linux-ld: section .init.text LMA [000000000043a160,0000000000452569] overlaps section .rodata LMA [00000000003ff420,000000000047df2f]
>    h8300-linux-ld: section .data VMA [0000000000400000,000000000043a15f] overlaps section .rodata VMA [00000000003ff420,000000000047df2f]
>    h8300-linux-ld: section __ksymtab VMA [000000000047df30,000000000048611f] overlaps section .bss VMA [000000000045ebd0,000000000056a053]
>    h8300-linux-ld: kernel/rcu/update.o: in function `rcu_read_unlock_trace_special':
> >> update.c:(.text+0x8f9): undefined reference to `irq_work_queue'

Does the patch below help?

							Thanx, Paul

------------------------------------------------------------------------

commit cb7220ed05190c9a92df95b52a21525a7e08a449
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Dec 21 21:00:18 2020 -0800

    rcu: Make TASKS_TRACE_RCU select IRQ_WORK
    
    Tasks Trace RCU uses irq_work_queue() to safely awaken its grace-period
    kthread, so this commit therefore causes the TASKS_TRACE_RCU Kconfig
    option select the IRQ_WORK Kconfig option.
    
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index aa8cc8c9..3128b7c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -95,6 +95,7 @@ config TASKS_RUDE_RCU
 
 config TASKS_TRACE_RCU
 	def_bool 0
+	select IRQ_WORK
 	help
 	  This option enables a task-based RCU implementation that uses
 	  explicit rcu_read_lock_trace() read-side markers, and allows
