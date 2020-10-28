Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEEA29D6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbgJ1WS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbgJ1WRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from localhost (i15-lef02-th2-89-83-213-3.ft.lns.abo.bbox.fr [89.83.213.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5CE24671;
        Wed, 28 Oct 2020 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603892449;
        bh=X+30g5YKs+8oMJAS08Jtf2Iv1iwIT2fJ6zl6TGlh4c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GiE/4m+2qKi44EdTLOJq9woqLAqa9zK6WQhFMIR7IT3pSPyDtsPF5L0WbvRHzL/Qz
         R9ajM/JSCzCNsHy6sFJwpvvIVi+xmdQoOjhs6tb+mucoTfkn4LiYmtrKlto0ASQCg7
         fylS9KmjCR69M8eBTLc/I5mv/4Q8jGpb2qjhxq1o=
Date:   Wed, 28 Oct 2020 14:40:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 5/6] irq_work: Provide irq_work_queue_remote()
Message-ID: <20201028134046.GE229044@lothringen>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.526249871@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028111221.526249871@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:07:12PM +0100, Peter Zijlstra wrote:
> While the traditional irq_work relies on the ability to self-IPI, it
> makes sense to provide an unconditional irq_work_queue_remote()
> interface.

We may need a reason as well here.

> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1308,13 +1308,14 @@ static int rcu_implicit_dynticks_qs(stru
>  			resched_cpu(rdp->cpu);
>  			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
>  		}
> -		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
> -		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> +#ifdef CONFIG_IRQ_WORK
> +		if (!rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&

If it's unconditional on SMP, I expect it to be unconditional on rcutree.

Also this chunk seems unrelated to this patch.

>  		    (rnp->ffmask & rdp->grpmask)) {
>  			rdp->rcu_iw_pending = true;
>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
>  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
>  		}
> +#endif
>  	}
>  
>  	return 0;
> 
> 
