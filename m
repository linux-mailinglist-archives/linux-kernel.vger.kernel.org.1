Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436F329F172
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgJ2Q3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2Q3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:29:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE05C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hBo9k+x0HnRwHVO8DGsS2oLlZWb0Tb1CXsDltKFHhNs=; b=Hb5nG6DJ/szLk0RP7g+1k0e8f8
        ycQRCXNcfdpQudil7s3qM7du8g+tX7ktE7710bHpdl9MKVrK2tvZNGt3yuxXCIZzHyQsbWkBUepFr
        eCNTdB8b2qA0dJC6YSejrMBrzrUr1XrFUItak1SH8/ipkNEzidhofq+mARCkUyCw8vX6oO4zNtfGh
        rIwYP+qKHlumWOO7FXAAeecmpN8hjk/dCxaUpHpolBgaFi3eG6FytUQ9HTVY6aAQgIjnPHFdmhr9K
        1WDQeRDPXhiY6V5UrlHYyLLTz2jQZr6gVU7WejUy1KP/RHChIUn7eJ6qL+UdPuc/1ZPu1bCTeZ0zq
        RyyzG+Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYAo7-00040l-Do; Thu, 29 Oct 2020 16:29:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A0CD3062EA;
        Thu, 29 Oct 2020 17:29:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ECD472107F30B; Thu, 29 Oct 2020 17:29:46 +0100 (CET)
Message-ID: <20201029162902.105962225@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Oct 2020 17:27:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, peterz@infradead.org
Subject: [PATCH v2 4/4] perf: Tweak perf_event_attr::exclusive semantics
References: <20201029162719.519685265@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf_event_attr::exclusive can be used to ensure an
event(group) is the sole group scheduled on the PMU. One consequence
is that when you have a pinned event (say the watchdog) you can no
longer have regular exclusive event(group)s.

Inspired by the fact that !pinned events are considered less strict,
allow !pinned,exclusive events to share the PMU with pinned,!exclusive
events.

Pinned,exclusive is still fully exclusive.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2637,7 +2637,7 @@ static int group_can_go_on(struct perf_e
 	 * If this group is exclusive and there are already
 	 * events on the CPU, it can't go on.
 	 */
-	if (event->attr.exclusive && cpuctx->active_oncpu)
+	if (event->attr.exclusive && !list_empty(get_event_list(event)))
 		return 0;
 	/*
 	 * Otherwise, try to add it if all previous groups were able


