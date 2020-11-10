Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE972ACA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbgKJBUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJBUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:20:35 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11CCB206ED;
        Tue, 10 Nov 2020 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604971233;
        bh=nDAdKFCt1bWycgxovIvv4DTw/Tf27/IvExHmb22q48w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KM7y/uBG9ShTjAaswr/2NJbcwyHvh+4JuejwKNDNsJ2LLVIHNUJ9jjnk4SCad2XS7
         Zi/pXZPQ+fjr+xgmURVl8QlyfnAWqzSaQmNO45uTDvJGohIjUZqMNBLnt/7bXAUrmC
         GL0Bi+rUG8gTj8CXu5nDSmrRboHC7yoZq7unGiPg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C509435225E9; Mon,  9 Nov 2020 17:20:32 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:20:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Hui Su <sh_def@163.com>
Subject: Re: [PATCH tip/core/rcu 4/4] docs/rcu: Update the call_rcu() API
Message-ID: <20201110012032.GN3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-4-paulmck@kernel.org>
 <20201109122424.GN2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109122424.GN2594@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 01:24:24PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 05, 2020 at 03:05:10PM -0800, paulmck@kernel.org wrote:
> > From: Hui Su <sh_def@163.com>
> > 
> > This commit updates the documented API of call_rcu() to use the
> > rcu_callback_t typedef instead of the open-coded function definition.
> > 
> > Signed-off-by: Hui Su <sh_def@163.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  Documentation/RCU/whatisRCU.rst | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index fb3ff76..1a4723f 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -497,8 +497,7 @@ long -- there might be other high-priority work to be done.
> >  In such cases, one uses call_rcu() rather than synchronize_rcu().
> >  The call_rcu() API is as follows::
> >  
> > -	void call_rcu(struct rcu_head * head,
> > -		      void (*func)(struct rcu_head *head));
> > +	void call_rcu(struct rcu_head *head, rcu_callback_t func);
> 
> Personally I much prefer the old form, because now I have to go look up
> rcu_callback_t to figure out wtf kind of signature is actually required.

How about if this part of the documentation read as follows:

	typedef void (*rcu_callback_t)(struct rcu_head *head);
	void call_rcu(struct rcu_head *head, rcu_callback_t func);

Wold that help?

							Thanx, Paul
