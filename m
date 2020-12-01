Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16F32CA660
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391677AbgLAO4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389514AbgLAO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:56:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE1C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W1i0rg/foZpVr5SGX99+nlRzuL+ha07mtB+QnwQc4mw=; b=IseEQmaTDadFeYN0ipcC2DFqwP
        aLbriVSUHBQj1VXABEYKY3qv3jy2SPQmrhPwRBGEDWlyZLIsgxJUeaZAkg9Q2LiVJNxvo0C/L1RkL
        xZFfD8siiuivXUk8pQXIUNwQVkZZSyEuEzhijC7YOtcFjg7tgXd/jlGPBUTahewGCTIA7Dgt3Lm+e
        sb1sqvxR258s+zLRhpbuzxlmgYJ9HndxF3eqMujwX0eiGSXMkkSMCgPHmzL3ODPxk13LkMuuzj4fq
        l7+ZdNYxFkPDSuGJLK6hESmbx5dGGUl2M9VxUNYxhzYlpmfUxhYMP0DDJipDN3YiZMOcOVs/0Jbjk
        zVBnb4OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk73o-0005kQ-JU; Tue, 01 Dec 2020 14:55:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51904300DAE;
        Tue,  1 Dec 2020 15:55:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C46E2018E5AF; Tue,  1 Dec 2020 15:55:19 +0100 (CET)
Date:   Tue, 1 Dec 2020 15:55:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201145519.GY2414@hirez.programming.kicks-ass.net>
References: <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201144644.GF1437@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 06:46:44AM -0800, Paul E. McKenney wrote:

> > So after having talked to Sven a bit, the thing that is happening, is
> > that this is the one place where we take interrupts with RCU being
> > disabled. Normally RCU is watching and all is well, except during idle.
> 
> Isn't interrupt entry supposed to invoke rcu_irq_enter() at some point?
> Or did this fall victim to recent optimizations?

It does, but the problem is that s390 is still using
trace_hardirqs_off(), which calls into tracing before RCU is enabled.

The entry order between lockdep, rcu and tracing is critical.

You can't call into tracing without RCU running,
you can't call into RCU without lockdep setup,
you can't call the (old) lockdep setup without landing in tracing.


