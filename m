Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0B1F4197
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbgFIQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 12:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731252AbgFIQ7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:59:13 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69E3B2074B;
        Tue,  9 Jun 2020 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591721952;
        bh=rGg4RVPuDPsCrypGxDIVSPgpmCXO9dRZpbAlRuILa0M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fVmPylwSiI4UmjAsgCSTUu70Vkg+jsuNPWZrPmOJ7qbqannDQUr9GlGXa0+HGj3/2
         fsfOvHb/p7cD6hS1n8OwjHzbcmNoOVsERkmHXi3NeADh3AB4gLDYFEd+2r5kqYZ1h4
         rk+vdYbQ9+JkX9rtoq1M3H4JXcY5hwOYX4ohXgKA=
Message-ID: <5ed2c074f367c2939d0cce494b85f9f5d74d4234.camel@kernel.org>
Subject: Re: [4.19 stable-rt PATCH] tasklet: Fix UP case for tasklet CHAINED
 state
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jun 2020 11:59:11 -0500
In-Reply-To: <20200609163832.vicpmza6qgxalhmg@linutronix.de>
References: <7642da1ef2578601d8c2b7bb739b0f8451e69bed.camel@kernel.org>
         <20200609163832.vicpmza6qgxalhmg@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, 2020-06-09 at 18:38 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-09 11:21:44 [-0500], Tom Zanussi wrote:
> > index 73dae64bfc9c..4f37a6173ab9 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -947,10 +947,12 @@ static void __tasklet_schedule_common(struct
> > tasklet_struct *t,
> >  	 * is locked before adding it to the list.
> >  	 */
> >  	if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
> > +#if defined(CONFIG_SMP)
> >  		if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state)) 
> > {
> >  			tasklet_unlock(t);
> >  			return;
> >  		}
> > +#endif
> >  		t->next = NULL;
> >  		*head->tail = t;
> >  		head->tail = &(t->next);
> > @@ -1044,7 +1046,11 @@ static void tasklet_action_common(struct
> > softirq_action *a,
> >  again:
> >  		t->func(t->data);
> >  
> > +#if !defined(CONFIG_SMP)
> > +		while (!tasklet_tryunlock(t)) {
> > +#else
> >  		while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) !=
> > TASKLET_STATEF_RC) {
> > +#endif
> 
> This is still needed for RT && !SMP
> 

Yes, you're right - I'll change this and repost after testing all
cases.

Thanks,

Tom

> >  			/*
> >  			 * If it got disabled meanwhile, bail out:
> >  			 */
> 
> Sebastian

