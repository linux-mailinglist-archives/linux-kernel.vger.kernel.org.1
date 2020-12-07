Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1565D2D13AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgLGO2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgLGO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:28:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9537C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lc+ijTkBTFJeV4kyAdNcu+rWKSkRs67Ui4faQ+DhIkg=; b=qIRc6Ac0jAizxtddA+Zu5PeRna
        MNBTXEG+Up8AV2YbU4RQBAPhf1q6l6tAytExYlPlHoBDxctpcMpFlJaY1IX6gw1Er0S5vLxtyug7Z
        Lh6tjzB9blewYj14ig1yX2Plg/tce0zfFhIwECWd5YqJR0awH8T1P4UJwQSQH5/AXpLAbTG8X3w3f
        42EzBWPgT3nmqtw6MsDccFXssdA+f7iSffHXZQTntznWEQdve0/HB1vvbAWymYQcoKKyrOSETNF/r
        YLVh4nRra/oVb9fLuRtDpS2GVDa9X03oRjYrmABMyLKTQWw7NsgT3441LfoAkzpXeH8osjLx/DyQg
        Mmu6MqWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmHU9-0007eJ-84; Mon, 07 Dec 2020 14:27:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B81CF303DA0;
        Mon,  7 Dec 2020 15:27:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A26BC20812955; Mon,  7 Dec 2020 15:27:27 +0100 (CET)
Date:   Mon, 7 Dec 2020 15:27:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [patch V2 9/9] tasklets: Prevent kill/unlock_wait deadlock on RT
Message-ID: <20201207142727.GU3021@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.627618080@linutronix.de>
 <20201207114743.GK3040@hirez.programming.kicks-ass.net>
 <20201207140040.yrxsu4v4xz43szkk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207140040.yrxsu4v4xz43szkk@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:00:40PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-07 12:47:43 [+0100], Peter Zijlstra wrote:
> > On Fri, Dec 04, 2020 at 06:02:00PM +0100, Thomas Gleixner wrote:
> > > @@ -825,7 +848,20 @@ void tasklet_kill(struct tasklet_struct
> > >  
> > >  	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
> > >  		do {
> > > -			yield();
> > >  		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
> > >  	}
> > >  	tasklet_unlock_wait(t);
> > 
> > 
> > Egads... should we not start by doing something like this?
> 
> So we keep the RT part as-is and replace the non-RT bits with this?

For RT you probably want to wrap the wait_var_event() in that
local_bh_disable()/enable() pear. I just figured those unbounded
spin/yield loops suck and we should get rid of em.
