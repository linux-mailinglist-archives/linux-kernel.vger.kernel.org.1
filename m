Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53692948E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501886AbgJUH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:27:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38928 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440901AbgJUH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:27:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603265242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9JhoxiSkl//TRpg6H0wTEK9OO42PSxN3Z9C2PUIcrs=;
        b=FWZ3j6icl+AUwgJ4utKAmAy8jgbWhXNgF0vYdTVSNQVRPzTRB06XNlrmFvD4MJpfmtMdQ4
        R06PRzo/YeuEG+P/nnBhs9wwS2qkVl1DqUThb36UpNDSjAiJY8yM9ywypSiyXd/amQCE9G
        3Oqc+7RIVvj1SO49CeSucWmu/opjadZBag7+Z0roAExCz28c1lcHQrapFDMPXamIm/qcN1
        +I6m3Es7rf8Z7eyC8EWOSiq3+bLml43s8jV3nZnBP0rjo4cnSyvZG35Ujw3b6VWrs/4Z8D
        0s0xNRLxpP5/vAxQ+aPd/GbgnYTbPd3Nbb2oko2RkeKHywmk3Qp0+VUmIjq6ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603265242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9JhoxiSkl//TRpg6H0wTEK9OO42PSxN3Z9C2PUIcrs=;
        b=gjsHXiflWNLQr2vc4+ld1RCRfwAGDI2iigskzNe5o0LtNk25Xqof4qbFU5W4CHkD/Ve32L
        19mkCJa5IIHMt4CQ==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: sched: Reenable interrupts in do sched_yield()
In-Reply-To: <20201020160732.5f8fc24e@oasis.local.home>
References: <87r1pt7y5c.fsf@nanos.tec.linutronix.de> <20201020113830.378b4a4c@gandalf.local.home> <87o8kw93n4.fsf@nanos.tec.linutronix.de> <20201020160732.5f8fc24e@oasis.local.home>
Date:   Wed, 21 Oct 2020 09:27:22 +0200
Message-ID: <87h7qo6ntx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20 2020 at 16:07, Steven Rostedt wrote:
> On Tue, 20 Oct 2020 20:02:55 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> What I wrote wasn't exactly what I meant. What I meant to have:
>
> 	/*
> 	 * Since we are going to call schedule() anyways, there's
> 	 * no need to do the preemption check when the rq_lock is released.
> 	 */
>
> That is, to document why we have the preempt_disable() before the unlock:

which is pretty obvious, but I let Peter decide on that.
