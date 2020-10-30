Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E622E2A09A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgJ3PVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgJ3PVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:21:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08277C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gTP2/dk1dZhFSAXwVKI6M38nVuRpixTJ3mr8CkUeBTM=; b=BvgM9seUQ5sQNTTSoos9sGkioJ
        A3VQddcRf7H22PVSiRfe5gZ3l77H65oAHflnhaW8a1OVVbwAQFCR83VXEEfrlWBzvGxbNUTbucjcd
        dRyboFcXg6jUFR50XEWCmCCmLB+j5TFw9fyIw+BhBvbyRX3yCcF+SCeo/54rf6RHSTKTU6OFEzWfv
        gCpfgHentsaKNShiKU+C6kfvs89G3rB0RyGn4lnZkUOYGDjleBZ1OAbipYrFxXn9z5vycaqY2GkJ0
        PtawquNauMT48Y90qvhbRHF18b1WY4wKD2r0zopZbqKSh9P24934dKzrS2xH0sWA0SeD1apV6+ixS
        TdkN6e1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYWDM-0003MB-9K; Fri, 30 Oct 2020 15:21:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11DA0307890;
        Fri, 30 Oct 2020 16:21:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EBF072B708595; Fri, 30 Oct 2020 16:21:11 +0100 (CET)
Message-ID: <20201030151955.120572175@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 16:13:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com,
        peterz@infradead.org
Subject: [PATCH 3/6] perf: Fix get_recursion_context()
References: <20201030151345.540479897@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One should use in_server_softirq() to detector SoftIRQ context.

Fixes: 96f6d4444302 ("perf_counter: avoid recursion")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/internal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -211,7 +211,7 @@ static inline int get_recursion_context(
 		rctx = 3;
 	else if (in_irq())
 		rctx = 2;
-	else if (in_softirq())
+	else if (in_serving_softirq())
 		rctx = 1;
 	else
 		rctx = 0;


