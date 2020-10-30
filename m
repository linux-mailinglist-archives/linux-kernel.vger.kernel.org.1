Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0412A03FA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgJ3LTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3LTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:19:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBACC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C89nhQ/URSZktNIS3aB5HrXeyoOTPLxKQZpfjbNyo30=; b=tQPmzsqrLeLNoDjWyGTE0r/fRs
        mpCvmGn3rCDqXrwz7Ka+8iZ7UbQx/Ydk0u/BYxpwYGw9iRsKYj6s0aiPqHx9BXVdu2cAt8OCTwIRv
        nE7IAsOH8Y6pofQiQY7d0hMmD/9ggVgYry42baqBfzuy9q4MNKL1POdo8Tf1onWWrSmTn0YyXJUBN
        YOtQVbLVgpyDfxkDENpbLzu3Dq21ieWgT5knkekBRFmgyxZY0OPIFruI4SgwL0i29HDiSNDq2W7mq
        S5rtDH8VtxDkzXi2GUMUOuuWfbRN2LaLBn04opPIHAgCZIPMoC1WIldfUT7cDI9bBdjuK3Nhd23yr
        CM0zhXVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYSRF-0004SW-2Z; Fri, 30 Oct 2020 11:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CBAD3062EA;
        Fri, 30 Oct 2020 12:19:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7AE22B449DC2; Fri, 30 Oct 2020 12:19:19 +0100 (CET)
Date:   Fri, 30 Oct 2020 12:19:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com
Subject: [PATCH] perf/x86: Make dummy_iregs static
Message-ID: <20201030111919.GM2651@hirez.programming.kicks-ass.net>
References: <20201030002722.766a22df@oasis.local.home>
 <20201030090037.GZ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030090037.GZ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:00:37AM +0100, Peter Zijlstra wrote:
> > static void __intel_pmu_pebs_event(struct perf_event *event,
> > 				   struct pt_regs *iregs,
> > 				   void *base, void *top,
> > 				   int bit, int count,
> > 				   void (*setup_sample)(struct perf_event *,
> > 						struct pt_regs *,
> > 						void *,
> > 						struct perf_sample_data *,
> > 						struct pt_regs *))
> > {
> > 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > 	struct hw_perf_event *hwc = &event->hw;
> > 	struct perf_sample_data data;
> > 	struct x86_perf_regs perf_regs;
> > 	struct pt_regs *regs = &perf_regs.regs;
> > 	void *at = get_next_pebs_record_by_bit(base, top, bit);
> > 	struct pt_regs dummy_iregs;
> 
> The only thing I can come up with in a hurry is that that dummy_iregs
> thing really should be static. That's 168 bytes of stack out the window
> right there.

---
Subject: perf/x86: Make dummy_iregs static
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Oct 30 12:15:06 CET 2020

Having pt_regs on-stack is unfortunate, it's 168 bytes. Since it isn't
actually used, make it a static variable. This both gets if off the
stack and ensures it gets 0 initialized, just in case someone does
look at it.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/ds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1735,7 +1735,7 @@ static void __intel_pmu_pebs_event(struc
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
-	struct pt_regs dummy_iregs;
+	static struct pt_regs dummy_iregs;
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
 		/*
