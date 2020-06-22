Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B1202ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 05:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgFVDN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 23:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgFVDNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:13:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46A71253BB;
        Mon, 22 Jun 2020 03:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592795605;
        bh=XGykBpJ30XX3b6TPGbSr+m6G6XNDRVZ1v1eR+xyxTOM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xYOL530IGS33v9M4oB3FT1yonPx5WyBzjfUtIv7eBlUTCTsNhxDyAUyiBadmtD1mO
         l10QvfJncjYwzSpe1UMMfoqjDfPVp9Z0VbUk9H2gQ9X1HHQp2WvWnVQnimTtPeDXvq
         dQ7qYL2W2Lq7k6YBgPyqnaJLF5XC6/ZVgR16zoTQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 286563522B3D; Sun, 21 Jun 2020 20:13:25 -0700 (PDT)
Date:   Sun, 21 Jun 2020 20:13:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Force quiescent state on callback overload
Message-ID: <20200622031325.GG9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
 <20200621195052.GF9247@paulmck-ThinkPad-P72>
 <94686c2e-b589-2598-e658-42f13cec1216@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94686c2e-b589-2598-e658-42f13cec1216@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:30:31AM +0530, Neeraj Upadhyay wrote:
> Hi Paul,
> 
> On 6/22/2020 1:20 AM, Paul E. McKenney wrote:
> > On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
> > > On callback overload, we want to force quiescent state immediately,
> > > for the first and second fqs. Enforce the same, by including
> > > RCU_GP_FLAG_OVLD flag, in fqsstart check.
> > > 
> > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > 
> > Good catch!
> > 
> > But what did you do to verify that this change does the right thing?
> > 
> > 						Thanx, Paul
> > 
> 
> I haven't done a runtime verification of this code path; I posted this,
> based on review of this code.

My concern is that under overload, the FQS scans would happen continuously
rather than accelerating only the first such scan in a given grace period.
This would of course result in a CPU-bound grace-period kthread, which
users might not be all that happy with.

Or am I missing something subtle that prevents this?

But yes, it does look like the current mainline code fails to do the
first scan immediately, so again, good catch!

							Thanx, Paul

> Thanks
> Neeraj
> 
> > > ---
> > >   kernel/rcu/tree.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index d0988a1..6226bfb 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
> > >   			break;
> > >   		/* If time for quiescent-state forcing, do it. */
> > >   		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> > > -		    (gf & RCU_GP_FLAG_FQS)) {
> > > +		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
> > >   			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > >   					       TPS("fqsstart"));
> > >   			rcu_gp_fqs(first_gp_fqs);
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > > a Linux Foundation Collaborative Project
> > > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
> the Code Aurora Forum, hosted by The Linux Foundation
