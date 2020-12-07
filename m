Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2373D2D12F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLGOBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgLGOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:01:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57492C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:00:43 -0800 (PST)
Date:   Mon, 7 Dec 2020 15:00:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607349641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EpLte4OfQdYM2bvhiOAl1LeQjrSrqFUqkKhrRrW07gY=;
        b=JtS7Ylt++U4yYFnk/5jb5Zwst/Tn7BnkjqIbKBhQf/8q4gpuCpfZnKuMQjZV0EdrdjY2Vi
        EnKb7SMjWY0JElsw0QIwLk68m08z6FsAKPpeSjIpeGGZJ58irRTFdfpy1IwaWAx/WimnaT
        mWLyGedG+uMfA9pLMnQpwUPRN8SQzeE6hM+VpfuJsLHpoz+lqZUJkKNgMbeKZ0PbpYUOJy
        RIbvWGF/YaAAmWOMvOMddr5Ga7W239QLnVRCtj2GzQrdda171rRg2xO/cFRZsYec3Gtz/W
        lyoH0dj4LG0FOOGLcsAl3rw5zXW4ARyEqEPcxvVWbbAirDMMSPcDwPfA1suNAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607349641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EpLte4OfQdYM2bvhiOAl1LeQjrSrqFUqkKhrRrW07gY=;
        b=PfjhlqPhY/T17mp1rwFrfV4BheK9NiZ2O9F9c+hUx8WgVnzKysf22PxEpS6v+rI9qTwzY5
        eV7gHx57gLf7blBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [patch V2 9/9] tasklets: Prevent kill/unlock_wait deadlock on RT
Message-ID: <20201207140040.yrxsu4v4xz43szkk@linutronix.de>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.627618080@linutronix.de>
 <20201207114743.GK3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207114743.GK3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07 12:47:43 [+0100], Peter Zijlstra wrote:
> On Fri, Dec 04, 2020 at 06:02:00PM +0100, Thomas Gleixner wrote:
> > @@ -825,7 +848,20 @@ void tasklet_kill(struct tasklet_struct
> >  
> >  	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> >  		do {
> > -			yield();
> >  		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
> >  	}
> >  	tasklet_unlock_wait(t);
> 
> 
> Egads... should we not start by doing something like this?

So we keep the RT part as-is and replace the non-RT bits with this?

Sebastian
