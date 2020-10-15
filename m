Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21928F350
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgJONfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbgJONfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:35:14 -0400
Received: from localhost (unknown [176.167.119.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976232222B;
        Thu, 15 Oct 2020 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602768914;
        bh=iHp6TRkSwgAcFdZicoonLvGHsT3alscYX4RQ7OCWarE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NeXLDmVqypHWmZtiOY4TK0MNY1lFwPABDAX0HuwIudPjBPCffF7y1XviIXM9wipIW
         1XHTwqGYMwmB01nO7WKbLBHYeRJhK3Nv5KfDFbljav27dajlseQCiGjvC2AN39PiLy
         amVoKXTH10l5lCcdYevOmvt4j7GZo/Qf/cNUgMHE=
Date:   Thu, 15 Oct 2020 15:35:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201015133511.GB127222@lothringen>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015002301.101830-7-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 08:23:01PM -0400, Joel Fernandes (Google) wrote:
> Memory barriers are needed when updating the full length of the
> segcblist, however it is not fully clearly why one is needed before and
> after. This patch therefore adds additional comments to the function
> header to explain it.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 271d5d9d7f60..25ffd07f9951 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -147,17 +147,47 @@ static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
>   * field to disagree with the actual number of callbacks on the structure.
>   * This increase is fully ordered with respect to the callers accesses
>   * both before and after.
> + *
> + * About memory barriers:
> + * There is a situation where rcu_barrier() locklessly samples the full
> + * length of the segmented cblist before deciding what to do. That can
> + * race with another path that calls this function. rcu_barrier() should
> + * not wrongly assume there are no callbacks, so any transitions from 1->0
> + * and 0->1 have to be carefully ordered with respect to list modifications.
> + *
> + * Memory barrier is needed before adding to length, for the case where
> + * v is negative which does not happen in current code, but used
> + * to happen. Keep the memory barrier for robustness reasons.

Heh, I seem to recongnize someone's decision's style ;-)

>     When/If the
> + * length transitions from 1 -> 0, the write to 0 has to be ordered *after*
> + * the memory accesses of the CBs that were dequeued and the segcblist
> + * modifications:
> + * P0 (what P1 sees)	P1
> + * set len = 0
> + *                      rcu_barrier sees len as 0
> + * dequeue from list
> + *                      rcu_barrier does nothing.

It's a bit difficult to read that way. So that would be:


      rcu_do_batch()                rcu_barrier()
      --                            --
      dequeue                       l = READ(len)
      smp_mb()                      if (!l)
      WRITE(len, 0)                     check next CPU...

But I'm a bit confused against what it pairs in rcu_barrier().

> + *
> + * Memory barrier is needed after adding to length for the case
> + * where length transitions from 0 -> 1. This is because rcu_barrier()
> + * should never miss an update to the length. So the update to length
> + * has to be seen *before* any modifications to the segmented list. Otherwise a
> + * race can happen.
> + * P0 (what P1 sees)	P1
> + * queue to list
> + *                      rcu_barrier sees len as 0
> + * set len = 1.
> + *                      rcu_barrier does nothing.

So that would be:

      call_rcu()                    rcu_barrier()
      --                            --
      WRITE(len, len + 1)           l = READ(len)
      smp_mb()                      if (!l)
      queue                            check next CPU...


But I still don't see against what it pairs in rcu_barrier.

Thanks.
