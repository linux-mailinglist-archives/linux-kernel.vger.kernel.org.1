Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7529F174
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgJ2Q36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgJ2Q3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:29:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705CBC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AAI1oHsCV3/xmCkpQpM7mpXAiKg13r86KJUuoaxUSyk=; b=dEhtzvlWYiyiL7zmnIsLZ3GSko
        Sd/ST9/rUjpPzhFYNa6oItvPz25QovValD9/CSRPIezv/3mE8i6vK37d8TauZEQJAfH/mMdiVRpQ1
        7YCvTAduKjAZ5HNNWlSypcV70ZCUK5HMswLj7N3G/3qFwgfv8tPeKMT/iBKCXN/uchy6DiK+kWGAr
        AtaiKVevOxSFeiEF3x/dEG5MIjC6AUGGxE0M7V4tADmxRQ271bt8t5kxtsQesYeuw7foowLfdRnEw
        lN2tbBNfOI8uVBBAeZaF5Rvi5QRB+YnCQ1Vp8YSsapqXwWqhE+hyXMsLG035UR+XdrDzVnlbPvQe7
        0aExJfVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYAo7-00040m-IY; Thu, 29 Oct 2020 16:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D4203070F9;
        Thu, 29 Oct 2020 17:29:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E8E182107F30A; Thu, 29 Oct 2020 17:29:46 +0100 (CET)
Message-ID: <20201029162902.038667689@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Oct 2020 17:27:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, peterz@infradead.org
Subject: [PATCH v2 3/4] perf: Fix event multiplexing for exclusive groups
References: <20201029162719.519685265@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9e6302056f80 ("perf: Use hrtimers for event multiplexing")
placed the hrtimer (re)start call in the wrong place.  Instead of
capturing all scheduling failures, it only considered the PMU failure.

The result is that groups using perf_event_attr::exclusive are no
longer rotated.

Fixes: 9e6302056f80 ("perf: Use hrtimers for event multiplexing")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2612,7 +2612,6 @@ group_sched_in(struct perf_event *group_
 
 error:
 	pmu->cancel_txn(pmu);
-	perf_mux_hrtimer_restart(cpuctx);
 	return -EAGAIN;
 }
 
@@ -3672,6 +3671,7 @@ static int merge_sched_in(struct perf_ev
 
 		*can_add_hw = 0;
 		ctx->rotate_necessary = 1;
+		perf_mux_hrtimer_restart(cpuctx);
 	}
 
 	return 0;


