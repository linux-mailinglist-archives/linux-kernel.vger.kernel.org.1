Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED22AC265
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbgKIRdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbgKIRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:33:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6185C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MN5fEbCCOfm0UTwfvqURWX6PZeFYFh1peP1HdaagJQc=; b=J5T/QsOrbjEpqRqU4LTehIKiKn
        xVjicTP78uPa7BiXIhdoEluuOEUzoQpHJvzzeCLdzGr5Bz2z1/uBPzb5/A7VKh+qqhOnD5S0gLx3D
        0/Dk5b0/qPL5CvCJmOpFDhveqF37fpHelTVBPYHl1G5j2C3toO/lzt3ic8SDVs3MWFsFbsfn/ThYv
        VTzYL+3pDqctj0/5wSv0ny27OdD0wPufEcdAiY9bl85N6zr/Xaq11D2P6XwGI+bOwMft6wAMLPZJ/
        0Pr9+jk3RaTjDTBxZ3J2nL2cnpoYbTzDCbsgP8L9Aqs05rWgcKbAIcL33H3MvBE9mD9wWeeHQutvJ
        o3rRUrHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcB2M-0005FU-ST; Mon, 09 Nov 2020 17:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9338B300455;
        Mon,  9 Nov 2020 18:33:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77C4C2C17FC37; Mon,  9 Nov 2020 18:33:00 +0100 (CET)
Date:   Mon, 9 Nov 2020 18:33:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf/core: Flush PMU internal buffers for per-CPU
 events
Message-ID: <20201109173300.GM2611@hirez.programming.kicks-ass.net>
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
 <20201109095235.GC2594@hirez.programming.kicks-ass.net>
 <20201109110405.GN2651@hirez.programming.kicks-ass.net>
 <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1db246-c34a-22a3-160c-3e0c0a38119d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 09:49:31AM -0500, Liang, Kan wrote:
> > Maybe we can frob x86_pmu_enable()...
> 
> Could you please elaborate?

Something horrible like this. It will detect the first time we enable
the PMU on a new task (IOW we did a context switch) and wipe the
counters when user RDPMC is on...

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 77b963e5e70a..d862927baaef 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1289,6 +1289,15 @@ static void x86_pmu_enable(struct pmu *pmu)
 		perf_events_lapic_init();
 	}
 
+	if (cpuc->current != current) {
+		struct mm_struct *mm = current->mm;
+
+		cpuc->current = current;
+
+		if (mm && atomic_read(&mm->context.perf_rdpmc_allowed))
+			wipe_dirty_counters();
+	}
+
 	cpuc->enabled = 1;
 	barrier();
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7895cf4c59a7..d16118cb3bd0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -248,6 +248,8 @@ struct cpu_hw_events {
 	unsigned int		txn_flags;
 	int			is_fake;
 
+	void			*current;
+
 	/*
 	 * Intel DebugStore bits
 	 */
