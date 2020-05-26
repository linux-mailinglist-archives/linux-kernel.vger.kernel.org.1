Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262641AFF95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 03:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDTBli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 21:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgDTBli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:41:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0592087E;
        Mon, 20 Apr 2020 01:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587346898;
        bh=az85tus44NMG4SMjB0IngO85+hPz52zrrMtkhEa/4RA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VSYqKY2OT5HtsftDAocIYLAXRfFoDwWR0WgW6DWWmZmmaVMZ3rQ8BXHrNdRYDsyLw
         y+bGFOKGZH5e0QJavheQ2doNarmdccz7piZwe74/4gaMCfEE7ti1KShLFmpAxyfZZh
         2PHj9fnl+Ot8EG/SDE+BRagfBO7o+OTAvLypE1IY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CE5713522C68; Sun, 19 Apr 2020 18:41:37 -0700 (PDT)
Date:   Sun, 19 Apr 2020 18:41:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] rcu: simplify the calculation of rcu_state.ncpus
Message-ID: <20200420014137.GW17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200419215715.21071-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419215715.21071-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 09:57:15PM +0000, Wei Yang wrote:
> There is only 1 bit set in mask, which means the difference between
> oldmask and the new one would be at the position where the bit is set in
> mask.
> 
> Based on this knowledge, rcu_state.ncpus could be calculated by checking
> whether mask is already set in rnp->expmaskinitnext.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Queued, thank you!

I updated the commit log as shown below, so please let me know if I
messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit 2ff1b8268456b1a476f8b79672c87d32d4f59024
Author: Wei Yang <richard.weiyang@gmail.com>
Date:   Sun Apr 19 21:57:15 2020 +0000

    rcu: Simplify the calculation of rcu_state.ncpus
    
    There is only 1 bit set in mask, which means that the only difference
    between oldmask and the new one will be at the position where the bit is
    set in mask.  This commit therefore updates rcu_state.ncpus by checking
    whether the bit in mask is already set in rnp->expmaskinitnext.
    
    Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f288477..6d39485 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3732,10 +3732,9 @@ void rcu_cpu_starting(unsigned int cpu)
 {
 	unsigned long flags;
 	unsigned long mask;
-	int nbits;
-	unsigned long oldmask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	bool newcpu;
 
 	if (per_cpu(rcu_cpu_started, cpu))
 		return;
@@ -3747,12 +3746,10 @@ void rcu_cpu_starting(unsigned int cpu)
 	mask = rdp->grpmask;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-	oldmask = rnp->expmaskinitnext;
+	newcpu = !(rnp->expmaskinitnext & mask);
 	rnp->expmaskinitnext |= mask;
-	oldmask ^= rnp->expmaskinitnext;
-	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
-	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
+	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
