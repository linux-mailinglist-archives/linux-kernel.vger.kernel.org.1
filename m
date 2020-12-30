Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC32E7B04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 17:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgL3QUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 11:20:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgL3QUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:20:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E78520780;
        Wed, 30 Dec 2020 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609345181;
        bh=2vjw4RXrbCn3wiC+56smANDAn4JwYaeUxrWOmYLCqHA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mZx2bwe81KzjKjoCyzhwedHoV/DWN2b9UAp1IP5rOxoqlgF1e16P5m/J+Q83LHHvJ
         1fDQtD4BascWH/UVExmuyYvbSJceB4vMhwnhl181tLpO488nN0L6tPZEch2f/u/TOl
         XaIQBVV56+sEu7Pg+WKIKc0NmiKVI+6ypkx0wOtq3f9EkwyA/HwgaFD/xatVUfvoB2
         nmBpF/ZXmozfKfQ92DXyYSyK7tCNypL4h5Tm2BhNqYcuXxyvLGmoFNr8biwuzhF4Ui
         l8RYR8GSwTrbRu9Y5QzC6KTtkB0/MtaECDKwrXPpCiJDWfwaXTihco12/kl1dRQvKI
         JkUf4hOEybA4g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 09AC335227F7; Wed, 30 Dec 2020 08:19:41 -0800 (PST)
Date:   Wed, 30 Dec 2020 08:19:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     akpm@linux-foundation.org, manfred@colorfullife.com,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/sem.c: Convert kfree_rcu() to call_rcu() in freeary
 function
Message-ID: <20201230161941.GN2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201230120038.19489-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230120038.19489-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 08:00:38PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> Due to freeary function is called with spinlock be held,
> the synchronize_rcu function may be called in kfree_rcu
> function, the schedule may be happen in spinlock critical
> region, need to replace kfree_rcu() with call_rcu().

Except that the call to kfree_rcu() below has two arguments, and thus
provides a link for queuing the callback.  It will never directly invoke
synchronize_rcu().  It is only the single-argument variant of kfree_rcu()
that might invoke synchronize_rcu().

Or are you seeing lockdep or might-sleep failures with the current code?
If so, please post the relevant portions of the console output.

							Thanx, Paul

> Fixes: 693a8b6eecce ("ipc,rcu: Convert call_rcu(free_un) to kfree_rcu()")
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  ipc/sem.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index f6c30a85dadf..12c3184347d9 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -1132,6 +1132,13 @@ static int count_semcnt(struct sem_array *sma, ushort semnum,
>  	return semcnt;
>  }
>  
> +static void free_un(struct rcu_head *head)
> +{
> +	struct sem_undo *un = container_of(head, struct sem_undo, rcu);
> +
> +	kfree(un);
> +}
> +
>  /* Free a semaphore set. freeary() is called with sem_ids.rwsem locked
>   * as a writer and the spinlock for this semaphore set hold. sem_ids.rwsem
>   * remains locked on exit.
> @@ -1152,7 +1159,7 @@ static void freeary(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
>  		un->semid = -1;
>  		list_del_rcu(&un->list_proc);
>  		spin_unlock(&un->ulp->lock);
> -		kfree_rcu(un, rcu);
> +		call_rcu(&un->rcu, free_un);
>  	}
>  
>  	/* Wake up all pending processes and let them fail with EIDRM. */
> -- 
> 2.17.1
> 
