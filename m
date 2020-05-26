Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C23A1AFBAA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDSPP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 11:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgDSPP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:15:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E69212CC;
        Sun, 19 Apr 2020 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587309327;
        bh=DGVk2yx9ykTGpw0cwM6d0yMZFSOGvcb2VwTbquDBchg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BTI5DS2kWxbQIlMFOFxgGwtISthWkdOrS9qyy01/LZtxivZcVxtN1RmLWZ/zD18Jr
         Pw1w+1aJ3BeWFpu+46LNyc3XDB105If9zPGIgPDKNiBkAfeyPHfo/EaW9zdaO4L2SR
         mSnxlxD3/974XBec7mCYoRsM/nKRj2bjdbJEiSUk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 46F0D35226A1; Sun, 19 Apr 2020 08:15:27 -0700 (PDT)
Date:   Sun, 19 Apr 2020 08:15:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ethon Paul <ethp@qq.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Fix a typo in comment "amoritized"->"amortized"
Message-ID: <20200419151527.GT17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200418114648.7651-1-ethp@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418114648.7651-1-ethp@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 07:46:47PM +0800, Ethon Paul wrote:
> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Good eyes!!!  Queued, thank you!

I did edit the commit log as shown below.  Please let me know if I messed
anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 496c9c0dc7b259ee93ea91789a20e09421e840c1
Author: Ethon Paul <ethp@qq.com>
Date:   Sat Apr 18 19:46:47 2020 +0800

    srcu: Fix a typo in comment "amoritized"->"amortized"
    
    This commit fixes a typo in a comment.
    
    Signed-off-by: Ethon Paul <ethp@qq.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6d3ef70..8ff71e5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -766,7 +766,7 @@ static void srcu_flip(struct srcu_struct *ssp)
  * it, if this function was preempted for enough time for the counters
  * to wrap, it really doesn't matter whether or not we expedite the grace
  * period.  The extra overhead of a needlessly expedited grace period is
- * negligible when amoritized over that time period, and the extra latency
+ * negligible when amortized over that time period, and the extra latency
  * of a needlessly non-expedited grace period is similarly negligible.
  */
 static bool srcu_might_be_idle(struct srcu_struct *ssp)
