Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51953233CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgGaBgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 21:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgGaBgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:36:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6136620663;
        Fri, 31 Jul 2020 01:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596159367;
        bh=g1quuKAY02DWMAdeKKN9Yi71IxJiJ9RAEH+eVpo4FxA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kEyq63J0eBsHXUOGldm3VfPkGfglpd3hp+3+xq/gvbXoG+f4cqozrFP5o79K6NtV2
         DR8BtTr158viU8thoqFDv7VhU7bTLAX36ZS97A6Bwcz0rYo2dKugWSkv7GDHuGFMG0
         rkt/u4jT91oaTrvux4PhAOJRkGChiSV7zFiAanJA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3EBC63521361; Thu, 30 Jul 2020 18:36:07 -0700 (PDT)
Date:   Thu, 30 Jul 2020 18:36:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 3/3] rcu/tree: Make FQS complaining about offline CPU
 more aggressive
Message-ID: <20200731013607.GH9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200731004012.2324147-1-joel@joelfernandes.org>
 <20200731004012.2324147-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731004012.2324147-3-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:40:12PM -0400, Joel Fernandes (Google) wrote:
> Make FQS loop consider it an immediate failure if the case of an offline CPU
> reporting QS is detected, instead of a full second.
> 
> This is because rcu_report_dead() already reports quiescent states and
> updates ->qsmaskinitnext under node lock.
> 
> Light testing with TREE03 and hotplug shows no warnings.
> 
> Convert the warning as well to WARN_ON_ONCE() to reduce log spam.

I will give you a chance to upgrade the above on your V3.
And the comment below.

I do very much like the change to WARN_ON_ONCE(), by the way!

							Thanx, Paul

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a621932cc385..39bdd744ba97 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1208,13 +1208,15 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  		return 1;
>  	}
>  
> -	/* If waiting too long on an offline CPU, complain. */
> -	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
> -	    time_after(jiffies, rcu_state.gp_start + HZ)) {
> +	/*
> +	 * Complain if an offline CPU by RCU's books has not reported QS. Node
> +	 * lock is held ensuring offlining does not race here.
> +	 */
> +	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp))) {
>  		bool onl;
>  		struct rcu_node *rnp1;
>  
> -		WARN_ON(1);  /* Offline CPUs are supposed to report QS! */
> +		WARN_ON_ONCE(1);  /* Offline CPUs are supposed to report QS! */
>  		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
>  			__func__, rnp->grplo, rnp->grphi, rnp->level,
>  			(long)rnp->gp_seq, (long)rnp->completedqs);
> -- 
> 2.28.0.163.g6104cc2f0b6-goog
> 
