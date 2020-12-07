Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BFC2D0F94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgLGLkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgLGLkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:40:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1EC0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AKqulzeCHHOEdkU5qNfXgFoB1Mt1dLARPXY1yUXzjF4=; b=ePbiHypo3+tO4M0a33PYmf5eUs
        nVAjNZoVB1Jeop0Pg+tbo+8hK4Vk6/p3PvO60uDlZam5AV5s2+PH20JzbTpy4uXrzQLZPF/RRC3QU
        /ZPwDCGP76p55WvGR0lvTVNjJb2fb5ID4rsCyqvJOsiRZKRdEalhAzT8IOaw1/X8Ybtv7txlH8CHt
        hX2H//ANqfJLXbhtrDhZY9wLjpDDeC8iDPr5zULZzd5f+K4PFZyIjmFo9W52NgkT4lCInc2twLwCc
        5g3wHxz7PH2q62grA7UTrIaU7TSwYaeWTZLTtuOkczQ0jw2RiqIqHtk4IPd1nwFllmKHAAWY59hZ6
        Wf4oR9Vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmEs7-0002ot-60; Mon, 07 Dec 2020 11:40:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0C78305C1C;
        Mon,  7 Dec 2020 12:39:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C57EE20812949; Mon,  7 Dec 2020 12:39:58 +0100 (CET)
Date:   Mon, 7 Dec 2020 12:39:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 7/9] softirq: Replace barrier() with cpu_relax() in
 tasklet_unlock_wait()
Message-ID: <20201207113958.GJ3040@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.430113367@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170805.430113367@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:58PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> A barrier() in a tight loop which waits for something to happen on a remote
> CPU is a pointless exercise. Replace it with cpu_relax() which allows HT
> siblings to make progress.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/interrupt.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -668,7 +668,8 @@ static inline void tasklet_unlock(struct
>  
>  static inline void tasklet_unlock_wait(struct tasklet_struct *t)
>  {
> -	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
> +	while (test_bit(TASKLET_STATE_RUN, &(t)->state))
> +		cpu_relax();
>  }

Wouldn't it be nicer to stick a completion in tasklet_struct ? Or at the
very least use wait_var_event() or something?


diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee8299eb1f52..7818085ac003 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -663,12 +663,14 @@ static inline int tasklet_trylock(struct tasklet_struct *t)
 static inline void tasklet_unlock(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic();
-	clear_bit(TASKLET_STATE_RUN, &(t)->state);
+	clear_bit(TASKLET_STATE_RUN, &t->state);
+	smp_mb__after_atomic();
+	wake_up_var(&t->state);
 }
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+	wait_var_event(&t->state, !test_bit(TASKLET_STATE_RUN, &t->state));
 }
 #else
 #define tasklet_trylock(t) 1
