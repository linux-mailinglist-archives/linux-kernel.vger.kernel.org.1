Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0870D27A1A6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgI0Pf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 11:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgI0Pf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 11:35:59 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B37E23119;
        Sun, 27 Sep 2020 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601220958;
        bh=MeSSJOs9LS41GK9XDU/Rm12r3+r/5hTQk+fA9pHniDk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X26QebjqmiYdoeX2OYIgXK3EqRA+3mzbMSAN1lPycn9lFuBSr7ipFLYnXELtsVZk9
         RzmETs4n+GGjaUWfJom5ZZYveOq+NNdJuxSLjhzL3h6YA556ofbbc1Zq4xwN1pW6mx
         hX+AqHQUFVoybEmuh8rJf7bRQJbUvKVlzk+m/wxs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 229FB35225F5; Sun, 27 Sep 2020 08:35:58 -0700 (PDT)
Date:   Sun, 27 Sep 2020 08:35:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:urezki-pcount.2020.09.26a 17/17] kernel/rcu/tree.c:3315:52:
 sparse: sparse: incorrect type in argument 2 (different base types)
Message-ID: <20200927153558.GK29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202009270628.gklDosgG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009270628.gklDosgG%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 06:55:31AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urezki-pcount.2020.09.26a
> head:   e9bed2a1239b017d78cec5de66adce0560f6d077
> commit: e9bed2a1239b017d78cec5de66adce0560f6d077 [17/17] kvfree_rcu(): Switch to kmalloc() and kfree() for allocations
> config: i386-randconfig-s002-20200927 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-201-g24bdaac6-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=e9bed2a1239b017d78cec5de66adce0560f6d077
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu urezki-pcount.2020.09.26a
>         git checkout e9bed2a1239b017d78cec5de66adce0560f6d077
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Fixed by 1a8eee1cc5b0 ("squash! kvfree_rcu: Switch to GFP_ATOMIC when
preemption is enabled"), to be squashed into the original.

Thank you for your testing efforts!

							Thanx, Paul

> sparse warnings: (new ones prefixed by >>)
> 
>    kernel/rcu/tree.c:1344:13: sparse: sparse: context imbalance in 'rcu_start_this_gp' - different lock contexts for basic block
>    kernel/rcu/tree.c:1787:9: sparse: sparse: context imbalance in 'rcu_gp_init' - different lock contexts for basic block
>    kernel/rcu/tree.c:2542:9: sparse: sparse: context imbalance in 'force_qs_rnp' - different lock contexts for basic block
>    kernel/rcu/tree.c:2596:25: sparse: sparse: context imbalance in 'rcu_force_quiescent_state' - unexpected unlock
>    kernel/rcu/tree.c:3299:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected int gfp @@     got restricted gfp_t @@
>    kernel/rcu/tree.c:3299:29: sparse:     expected int gfp
>    kernel/rcu/tree.c:3299:29: sparse:     got restricted gfp_t
> >> kernel/rcu/tree.c:3315:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted gfp_t [usertype] flags @@     got int gfp @@
> >> kernel/rcu/tree.c:3315:52: sparse:     expected restricted gfp_t [usertype] flags
>    kernel/rcu/tree.c:3315:52: sparse:     got int gfp
>    kernel/rcu/tree.c: note: in included file:
>    kernel/rcu/tree_stall.h:749:17: sparse: sparse: context imbalance in 'rcu_check_gp_start_stall' - different lock contexts for basic block
>    kernel/rcu/tree.c: note: in included file:
>    kernel/rcu/tree_exp.h:189:9: sparse: sparse: context imbalance in '__rcu_report_exp_rnp' - different lock contexts for basic block
> 
> vim +3315 kernel/rcu/tree.c
> 
>   3292	
>   3293	static inline bool
>   3294	add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>   3295		unsigned long *flags, void *ptr, bool can_sleep)
>   3296	{
>   3297		struct kvfree_rcu_bulk_data *bnode;
>   3298		bool can_alloc_page = preemptible();
>   3299		int gfp = can_sleep ? GFP_NOWAIT | __GFP_NOWARN : GFP_ATOMIC;
>   3300		int idx;
>   3301	
>   3302		*krcp = krc_this_cpu_lock(flags);
>   3303		if (unlikely(!(*krcp)->initialized))
>   3304			return false;
>   3305	
>   3306		idx = !!is_vmalloc_addr(ptr);
>   3307	
>   3308		/* Check if a new block is required. */
>   3309		if (!(*krcp)->bkvhead[idx] ||
>   3310				(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
>   3311			bnode = get_cached_bnode(*krcp);
>   3312			if (!bnode && can_alloc_page) {
>   3313				migrate_disable();
>   3314				krc_this_cpu_unlock(*krcp, *flags);
> > 3315				bnode = kmalloc(PAGE_SIZE, gfp);
>   3316				*krcp = krc_this_cpu_lock(flags);
>   3317				migrate_enable();
>   3318			}
>   3319	
>   3320			/* Switch to emergency path. */
>   3321			if (unlikely(!bnode))
>   3322				return false;
>   3323	
>   3324			/* Initialize the new block. */
>   3325			bnode->nr_records = 0;
>   3326			bnode->next = (*krcp)->bkvhead[idx];
>   3327	
>   3328			/* Attach it to the head. */
>   3329			(*krcp)->bkvhead[idx] = bnode;
>   3330		}
>   3331	
>   3332		/* Finally insert. */
>   3333		(*krcp)->bkvhead[idx]->records
>   3334			[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
>   3335	
>   3336		return true;
>   3337	}
>   3338	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


