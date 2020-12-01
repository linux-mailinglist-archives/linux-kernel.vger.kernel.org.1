Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5712CA679
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbgLAPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389514AbgLAPCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:02:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jnht86pD3yq7U+rFN+c+PZKSrM6gKzPyOSAK99iCZwQ=; b=dgSYvfILuoEV3q8g19JLd64Hlg
        A5nve0zQ+bttY1SBLgg81B4wWGS0Ur8aLNv6AptVT2HWC9qkAQITGaBEjpwbRWOIsKngV0ggDvVhw
        6+GmOrxg4pKonhOcSdcZE+mx9+ywo/ZOrUVA9vehhAnOih30EMkENKotnq2AXjoZXvUxtHRrCd62f
        n8UPe3uW+HMeh3J8tgBZNX4EuIFMdhGvv7Sc7ZlgVxHfOGL0sOisiFxLan1m3a1NvoHtnP4WTpLsu
        C+PEA/Uux/W4fYWOXfODSbnfCEAkPOx3BNKyuTttM7+/asI/zvaMeSIt7zuh+JOuSRcxd1aoa18Ws
        /L5L/p6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk79Z-0006nC-0s; Tue, 01 Dec 2020 15:01:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18EE63003E1;
        Tue,  1 Dec 2020 16:01:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03C332BAB3CBF; Tue,  1 Dec 2020 16:01:14 +0100 (CET)
Date:   Tue, 1 Dec 2020 16:01:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/5] irqtime: Move irqtime entry accounting after irq
 offset incrementation
Message-ID: <20201201150114.GZ2414@hirez.programming.kicks-ass.net>
References: <20201201001226.65107-1-frederic@kernel.org>
 <20201201001226.65107-5-frederic@kernel.org>
 <20201201092011.GS2414@hirez.programming.kicks-ass.net>
 <87im9lhibd.fsf@nanos.tec.linutronix.de>
 <20201201114026.GB72897@lothringen>
 <87blfdhcp2.fsf@nanos.tec.linutronix.de>
 <20201201143545.GC72897@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201143545.GC72897@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 03:35:45PM +0100, Frederic Weisbecker wrote:
> And that one too makes things simple. But note that
> 
>     account_hardirq_enter_time()
> 
> will still need some preempt count checks to see if
> this is a nested hardirq, a hardirq interrupting a softirq
> or a hardirq interrupting a task.

So the current tests get that all correct in a single function.
Splitting it out will just result in more lines to get wrong.

That is, I don't think you can do it saner than:

  account_softirq_enter() := irqtime_account_irq(curr, SOFTIRQ_OFFSET);
  account_softirq_exit()  := irqtime_account_irq(curr, 0);
  account_hardirq_enter() := irqtime_account_irq(curr, HARDIRQ_OFFSET);
  account_hardirq_exit()  := irqtime_account_irq(curr, 0);

Fundamentally you have to determine the previous context to determine
where to account the delta to. Note that when the previous context is
task context we throw away the delta.
