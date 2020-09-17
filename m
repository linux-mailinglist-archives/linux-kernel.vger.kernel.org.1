Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC53A26E320
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgIQSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgIQSBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:01:39 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE24214D8;
        Thu, 17 Sep 2020 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600365697;
        bh=j5h8KkVTAVGXqCV6bTfZwWipP9J+CGaLDG/mC5/naLA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IopTimXQC3kMMjHrpWJm3lglQZvyNAeBeLBHkUm7mc59KB+p2ZzGPm03+cc/EuyTM
         KG1JKdRiQK6/bXxtJP+I0LD7+WE4We/i8O4fMEmNiBsoYc0WRfsuMKCdKIYwgvOAtz
         /TcSsDMWfB1mCkSA8zWHWdZ0kiqJ3hD79DL/0QY8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EBF7B35225FA; Thu, 17 Sep 2020 11:01:36 -0700 (PDT)
Date:   Thu, 17 Sep 2020 11:01:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/next 34/42] kernel/rcu/rcutorture.c:698:20: error:
 'show_rcu_tasks_classic_gp_kthread' undeclared here (not in a function)
Message-ID: <20200917180136.GN29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202009171807.za3QY4hi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009171807.za3QY4hi%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 06:26:14PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   7323bc24b9c5f4d11e9f926eb1d0f3f674f3bd1d
> commit: 675d3ca52626bac52da2c6ddaec94dd1a3724f0f [34/42] rcutorture: Make grace-period kthread report match RCU flavor being tested
> config: nds32-randconfig-r003-20200917 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 675d3ca52626bac52da2c6ddaec94dd1a3724f0f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/rcu/rcutorture.c:698:20: error: 'show_rcu_tasks_classic_gp_kthread' undeclared here (not in a function)
>      698 |  .gp_kthread_dbg = show_rcu_tasks_classic_gp_kthread,
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/rcu/rcutorture.c:768:20: error: 'show_rcu_tasks_rude_gp_kthread' undeclared here (not in a function)
>      768 |  .gp_kthread_dbg = show_rcu_tasks_rude_gp_kthread,
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/rcu/rcutorture.c:807:20: error: 'show_rcu_tasks_trace_gp_kthread' undeclared here (not in a function)
>      807 |  .gp_kthread_dbg = show_rcu_tasks_trace_gp_kthread,
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I have applied an update that fixes the locally, and will push it out
later today.  Thank you for testing this!  So many architectures...  ;-)

							Thanx, Paul

> # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=675d3ca52626bac52da2c6ddaec94dd1a3724f0f
> git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> git fetch --no-tags rcu rcu/next
> git checkout 675d3ca52626bac52da2c6ddaec94dd1a3724f0f
> vim +/show_rcu_tasks_classic_gp_kthread +698 kernel/rcu/rcutorture.c
> 
>    685	
>    686	static struct rcu_torture_ops tasks_ops = {
>    687		.ttype		= RCU_TASKS_FLAVOR,
>    688		.init		= rcu_sync_torture_init,
>    689		.readlock	= tasks_torture_read_lock,
>    690		.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
>    691		.readunlock	= tasks_torture_read_unlock,
>    692		.get_gp_seq	= rcu_no_completed,
>    693		.deferred_free	= rcu_tasks_torture_deferred_free,
>    694		.sync		= synchronize_rcu_tasks,
>    695		.exp_sync	= synchronize_rcu_mult_test,
>    696		.call		= call_rcu_tasks,
>    697		.cb_barrier	= rcu_barrier_tasks,
>  > 698		.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
>    699		.fqs		= NULL,
>    700		.stats		= NULL,
>    701		.irq_capable	= 1,
>    702		.slow_gps	= 1,
>    703		.name		= "tasks"
>    704	};
>    705	
>    706	/*
>    707	 * Definitions for trivial CONFIG_PREEMPT=n-only torture testing.
>    708	 * This implementation does not necessarily work well with CPU hotplug.
>    709	 */
>    710	
>    711	static void synchronize_rcu_trivial(void)
>    712	{
>    713		int cpu;
>    714	
>    715		for_each_online_cpu(cpu) {
>    716			rcutorture_sched_setaffinity(current->pid, cpumask_of(cpu));
>    717			WARN_ON_ONCE(raw_smp_processor_id() != cpu);
>    718		}
>    719	}
>    720	
>    721	static int rcu_torture_read_lock_trivial(void) __acquires(RCU)
>    722	{
>    723		preempt_disable();
>    724		return 0;
>    725	}
>    726	
>    727	static void rcu_torture_read_unlock_trivial(int idx) __releases(RCU)
>    728	{
>    729		preempt_enable();
>    730	}
>    731	
>    732	static struct rcu_torture_ops trivial_ops = {
>    733		.ttype		= RCU_TRIVIAL_FLAVOR,
>    734		.init		= rcu_sync_torture_init,
>    735		.readlock	= rcu_torture_read_lock_trivial,
>    736		.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
>    737		.readunlock	= rcu_torture_read_unlock_trivial,
>    738		.get_gp_seq	= rcu_no_completed,
>    739		.sync		= synchronize_rcu_trivial,
>    740		.exp_sync	= synchronize_rcu_trivial,
>    741		.fqs		= NULL,
>    742		.stats		= NULL,
>    743		.irq_capable	= 1,
>    744		.name		= "trivial"
>    745	};
>    746	
>    747	/*
>    748	 * Definitions for rude RCU-tasks torture testing.
>    749	 */
>    750	
>    751	static void rcu_tasks_rude_torture_deferred_free(struct rcu_torture *p)
>    752	{
>    753		call_rcu_tasks_rude(&p->rtort_rcu, rcu_torture_cb);
>    754	}
>    755	
>    756	static struct rcu_torture_ops tasks_rude_ops = {
>    757		.ttype		= RCU_TASKS_RUDE_FLAVOR,
>    758		.init		= rcu_sync_torture_init,
>    759		.readlock	= rcu_torture_read_lock_trivial,
>    760		.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
>    761		.readunlock	= rcu_torture_read_unlock_trivial,
>    762		.get_gp_seq	= rcu_no_completed,
>    763		.deferred_free	= rcu_tasks_rude_torture_deferred_free,
>    764		.sync		= synchronize_rcu_tasks_rude,
>    765		.exp_sync	= synchronize_rcu_tasks_rude,
>    766		.call		= call_rcu_tasks_rude,
>    767		.cb_barrier	= rcu_barrier_tasks_rude,
>  > 768		.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
>    769		.fqs		= NULL,
>    770		.stats		= NULL,
>    771		.irq_capable	= 1,
>    772		.name		= "tasks-rude"
>    773	};
>    774	
>    775	/*
>    776	 * Definitions for tracing RCU-tasks torture testing.
>    777	 */
>    778	
>    779	static int tasks_tracing_torture_read_lock(void)
>    780	{
>    781		rcu_read_lock_trace();
>    782		return 0;
>    783	}
>    784	
>    785	static void tasks_tracing_torture_read_unlock(int idx)
>    786	{
>    787		rcu_read_unlock_trace();
>    788	}
>    789	
>    790	static void rcu_tasks_tracing_torture_deferred_free(struct rcu_torture *p)
>    791	{
>    792		call_rcu_tasks_trace(&p->rtort_rcu, rcu_torture_cb);
>    793	}
>    794	
>    795	static struct rcu_torture_ops tasks_tracing_ops = {
>    796		.ttype		= RCU_TASKS_TRACING_FLAVOR,
>    797		.init		= rcu_sync_torture_init,
>    798		.readlock	= tasks_tracing_torture_read_lock,
>    799		.read_delay	= srcu_read_delay,  /* just reuse srcu's version. */
>    800		.readunlock	= tasks_tracing_torture_read_unlock,
>    801		.get_gp_seq	= rcu_no_completed,
>    802		.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
>    803		.sync		= synchronize_rcu_tasks_trace,
>    804		.exp_sync	= synchronize_rcu_tasks_trace,
>    805		.call		= call_rcu_tasks_trace,
>    806		.cb_barrier	= rcu_barrier_tasks_trace,
>  > 807		.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
>    808		.fqs		= NULL,
>    809		.stats		= NULL,
>    810		.irq_capable	= 1,
>    811		.slow_gps	= 1,
>    812		.name		= "tasks-tracing"
>    813	};
>    814	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


