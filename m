Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822EC2824D4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgJCOjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgJCOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:39:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB6C0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ovpqGIldjsodgVCbtVP+i9x5Z/lL56OSfrqaI5z7PG0=; b=Xh0rBWuqQscGufPUfZrq5LeR8h
        P/TGcF6V+VbLV2mPw7ME+k2HVCfd9FaSV5/8Qxuo8hj8bnIHhQijz4cnpz/rWe5ne96VROLl2fohS
        d9XxAgUl8qM2rYTcAHzwHuXHRA8bX5AM1Pva5XeJVGS9IEN+j1tj9PAKw04JOnJ3DfauA2K6Qd9lo
        oUi1bUv1XUfvEeh58mwwYocaiyRAp0nWcViG4VK/RiKpsqeF7QYBdIlQWPz/ic6XWNmXTmti9fP7x
        EzP3LZSnL9DHB6gMIfeX9RziDvLdGIvkBjPlY+dbJITCtWyTAXtN8Z1srxkwxfjSWRrSwNMuSC5pW
        ugjDHRFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOih5-0000RR-1r; Sat, 03 Oct 2020 14:39:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B105302526;
        Sat,  3 Oct 2020 16:39:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73C522B7C0E0A; Sat,  3 Oct 2020 16:39:23 +0200 (CEST)
Date:   Sat, 3 Oct 2020 16:39:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH 0/3] x86: Add initial support to discover Intel hybrid
 CPUs
Message-ID: <20201003143923.GC2628@hirez.programming.kicks-ass.net>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <87r1qgccku.fsf@nanos.tec.linutronix.de>
 <20201003021730.GA19361@agluck-desk2.amr.corp.intel.com>
 <87lfgnd1tm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfgnd1tm.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 12:46:29PM +0200, Thomas Gleixner wrote:
> > There might be some model specific performance counter events that only
> > apply to some cores. Or a machine check error code that is logged in the
> > model specific MSCOD field of IA32_MCi_STATUS. But any and all code can run
> > on any core.
> 
> Ok. The perf side should be doable, IIRC we already have something like
> that, but Peter should know better.

Yes, ARM big.LITTLE has horrible hacks. Please look at them for
inspiration.

Also, I once started (and never found time to finish)..

  https://lkml.kernel.org/r/20181010104559.GO5728@hirez.programming.kicks-ass.net

Kan should be aware of all this.
