Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956851F4112
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgFIQie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 12:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:38:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4889C05BD1E;
        Tue,  9 Jun 2020 09:38:33 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jihGi-0004qD-9P; Tue, 09 Jun 2020 18:38:32 +0200
Date:   Tue, 9 Jun 2020 18:38:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [4.19 stable-rt PATCH] tasklet: Fix UP case for tasklet CHAINED
 state
Message-ID: <20200609163832.vicpmza6qgxalhmg@linutronix.de>
References: <7642da1ef2578601d8c2b7bb739b0f8451e69bed.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7642da1ef2578601d8c2b7bb739b0f8451e69bed.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-09 11:21:44 [-0500], Tom Zanussi wrote:
> index 73dae64bfc9c..4f37a6173ab9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -947,10 +947,12 @@ static void __tasklet_schedule_common(struct tasklet_struct *t,
>  	 * is locked before adding it to the list.
>  	 */
>  	if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
> +#if defined(CONFIG_SMP)
>  		if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state)) {
>  			tasklet_unlock(t);
>  			return;
>  		}
> +#endif
>  		t->next = NULL;
>  		*head->tail = t;
>  		head->tail = &(t->next);
> @@ -1044,7 +1046,11 @@ static void tasklet_action_common(struct softirq_action *a,
>  again:
>  		t->func(t->data);
>  
> +#if !defined(CONFIG_SMP)
> +		while (!tasklet_tryunlock(t)) {
> +#else
>  		while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) != TASKLET_STATEF_RC) {
> +#endif

This is still needed for RT && !SMP

>  			/*
>  			 * If it got disabled meanwhile, bail out:
>  			 */

Sebastian
