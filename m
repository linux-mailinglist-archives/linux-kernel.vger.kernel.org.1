Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3894D2A099B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgJ3PVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJ3PVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:21:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0920C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xdM7vb429C5FCi3whvgwpbUVPSYQAxnaEWeIaiMceQs=; b=QGhwoacRi7s8yTLhe6Q6GWvZ2f
        T5mCw5+Sg3y0mn745HhYY4oZV1CSDXI7tuOqtHJRcmvplQ58pya2gHqKpF0YkQJhfmrjGhrX6z6Eu
        kkkackdz1QaLPAMLVR0NHjfpsPrEnOpIP+pvIPbpH7fowuvVAu7ZyC+6iivemglylCONV4cXWNAhz
        oXnQVR6Q74Fca6hyf/KstS0BbEiph0ivSQSDI/kssjP+vjDFmllFB1cNNvGjccp7he6tWqB6oySS4
        mprs3gGRVbUHWIkBz+084ZOvPCaEkqib8zJqaJfocmPMWlYeUNcBTLiMPITM4UB+4HGTm0NH2UT4e
        4UTx7w5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYWDK-0002kd-My; Fri, 30 Oct 2020 15:21:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 830B5307967;
        Fri, 30 Oct 2020 16:21:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 079722B708599; Fri, 30 Oct 2020 16:21:12 +0100 (CET)
Message-ID: <20201030151955.324273677@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 16:13:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com,
        peterz@infradead.org
Subject: [PATCH 6/6] perf/x86: Make dummy_iregs static
References: <20201030151345.540479897@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


