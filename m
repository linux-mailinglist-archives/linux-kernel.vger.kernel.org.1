Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93EA2E2077
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 19:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgLWSd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 13:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgLWSd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:33:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F192422202;
        Wed, 23 Dec 2020 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608748395;
        bh=S5iXmgD7c/eHqeOr783zJ0y/+5ryHc+hdT/v5SPBZJA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RQXlxEG0cdSj/ARFCFyLG9vP7kXgHLqlbL4npEezInQQvQmFgvh63k2SFwjVzCM6G
         LLBANuaxu7wBw40xUqY5Hg7wqraQWYd5ktyl19v2S6Oci9XLH+jdLu7Qv0OCEZmVu+
         hQG7cZa1jnz4i5sWhoGiMeeP/1yJ7NMmuXwWy2QCW4jTLSXRboztEg3O5leUcRkrlL
         pNyRMqlAo+FnXZaUgZWaxiJ5ZZw5Yf4YocUZcOZcmiL8QbJ/MmZNtgG1a4LB9E69wS
         Q+qp9iikE6Pb9u6fyZ3zq3oNTygaxzxRJoFqDH9lV8tF452dkMiyVMNWFO+whdz1Vz
         xP8bjQRQ1f2+A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B673C3522E72; Wed, 23 Dec 2020 10:33:14 -0800 (PST)
Date:   Wed, 23 Dec 2020 10:33:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/test 136/143] kernel/rcu/tree_plugin.h:2696:25: error:
 'struct task_struct' has no member named 'on_cpu'
Message-ID: <20201223183314.GF2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202012232351.OhLvWNy8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012232351.OhLvWNy8-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 11:28:58PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/test
> head:   4c4c8e04a7f8522de634aa062f4cd6b8b80c151b
> commit: 72351a864d02b480a5c237144033e21be816f29f [136/143] fixup! rcu/nocb: Add grace period and task state to show_rcu_nocb_state() output
> config: nds32-randconfig-r014-20201221 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=72351a864d02b480a5c237144033e21be816f29f
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu rcu/test
>         git checkout 72351a864d02b480a5c237144033e21be816f29f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:16,
>                     from kernel/rcu/tree.c:21:
>    kernel/rcu/tree_plugin.h: In function 'show_rcu_nocb_gp_state':
> >> kernel/rcu/tree_plugin.h:2696:25: error: 'struct task_struct' has no member named 'on_cpu'
>     2696 |    !rdp->nocb_cb_kthread->on_cpu ? "!" : "");
>          |                         ^~
>    include/linux/printk.h:373:34: note: in definition of macro 'pr_info'
>      373 |  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>          |                                  ^~~~~~~~~~~
>    kernel/rcu/tree_plugin.h: In function 'show_rcu_nocb_state':
>    kernel/rcu/tree_plugin.h:2737:25: error: 'struct task_struct' has no member named 'on_cpu'
>     2737 |    !rdp->nocb_cb_kthread->on_cpu ? "!" : "");
>          |                         ^~
>    include/linux/printk.h:373:34: note: in definition of macro 'pr_info'
>      373 |  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>          |                                  ^~~~~~~~~~~

Good catch, I missed the case of !SMP and rcu_nocbs CPUs, thank you!

Does the following fix this for you?  (To be folded into the original
with attribution.)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2c16fa8..f97c991 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2668,6 +2668,19 @@ void rcu_bind_current_to_nocb(void)
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 
+// The ->on_cpu field is available only in CONFIG_SMP=y, so...
+#ifdef CONFIG_SMP
+static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
+{
+	return tsp && tsp->state == TASK_RUNNING && !tsp->on_cpu ? "!" : "";
+}
+#else // #ifdef CONFIG_SMP
+static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
+{
+	return "";
+}
+#endif // #else #ifdef CONFIG_SMP
+
 /*
  * Dump out nocb grace-period kthread state for the specified rcu_data
  * structure.
@@ -2693,8 +2706,7 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
 		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
 		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
-		rdp->nocb_cb_kthread && rdp->nocb_cb_kthread->state == TASK_RUNNING &&
-			!rdp->nocb_cb_kthread->on_cpu ? "!" : "");
+		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 }
 
 /* Dump out nocb kthread state for the specified rcu_data structure. */
@@ -2734,8 +2746,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		rcu_segcblist_n_cbs(&rdp->cblist),
 		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
 		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
-		rdp->nocb_cb_kthread && rdp->nocb_cb_kthread->state == TASK_RUNNING &&
-			!rdp->nocb_cb_kthread->on_cpu ? "!" : "");
+		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 
 	/* It is OK for GP kthreads to have GP state. */
 	if (rdp->nocb_gp_rdp == rdp)
