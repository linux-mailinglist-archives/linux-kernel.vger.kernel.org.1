Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4D26F89E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIRIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgIRIsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:48:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:48:38 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:48:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600418917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xrwqb8emfg0+zuovHZmra52ub5Ax38TjifDBCV568B0=;
        b=ida0nrdDFonfiLuCxJmFLP4bivtBsw0uoBoGMfVH7wu0CIVPXpqAm/OIQJyKNkeWieBMZO
        2DjmNRMieSpCE76FwXZDV5QaoT6LejXN141CgS11ku7+durukade4JrGFYPajhkz3k9Cwa
        6avFtTxaqzgnX9hmeTNgvG2teMrCs7UVjF4NsG+vPLCvKQz316EHOSo4PQv+5qKMwyPd7l
        WpSO2HDvppfTpK5k2QdkjaYbyJo1aqUCcJF6cV7RYetmsW4kKwQvTsOFvsEY8ebHBCTT4a
        7Bd0fG08v73xs43mSjZXcDbnU3ugPwXn9OSGET3ne2690bxeioj8FyjTkREPMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600418917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xrwqb8emfg0+zuovHZmra52ub5Ax38TjifDBCV568B0=;
        b=RPM+nJIN4jAivhtmkd8e0Vts2mcE8pUhauujQVwEoqXb7bTBDCHeA23ObBkRGaNhybpLxT
        UYpmeWkne0xmilBw==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [patch 09/10] sched/core: Add migrate_disable/enable()
Message-ID: <20200918084835.onjipzofxac5epe2@linutronix.de>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
 <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
 <20200917143850.25akkvr32ojtwohy@linutronix.de>
 <20200917144937.GI1362448@hirez.programming.kicks-ass.net>
 <20200917151341.2ilqamtnc6hperix@linutronix.de>
 <20200917155410.GK1362448@hirez.programming.kicks-ass.net>
 <20200917163001.5ksl5vjwi35ozzsv@linutronix.de>
 <20200918082232.GL1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200918082232.GL1362448@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-18 10:22:32 [+0200], peterz@infradead.org wrote:
> > > One reason for not allowing migrate_disable() to sleep was: FPU code.
> > >=20
> > > Could it be it does something like:
> > >=20
> > > 	preempt_disable();
> > > 	spin_lock();
> > >=20
> > > 	spin_unlock();
> > > 	preempt_enable();
> > >=20
> > > Where we'll never get preempted while migrate_disable()'d and thus ne=
ver
> > > trigger any of the sleep paths?
> >=20
> > I try to get rid of something like that. This doesn't work either way
> > because the spin_lock() may block which it can't with disabled
> > preemption.
>=20
> Yeah, that obviously should have been migrate_disable/enable instead of
> spin_lock/unlock :/

Ah. Me stupid. fpregs_lock() does

	preempt_disable();
	local_bh_disable();

which is more or less the "official" pattern. As of today
local_bh_disable() does migrate_disable() / spin_lock(). Not sure what
we end up with for local_bh_disable() in the end.
We used not have a BLK here on RT but ended up in all kind of locking
problems because vanilla treats local_bh_disable() as a BLK and uses it
for locking.
Today we have a per-CPU spinlock_t in local_bh_disable() to emulate the
BKL. But this pattern above isn't working due to the atomic part=E2=80=A6

Sebastian
