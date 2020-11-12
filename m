Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375DF2AFC82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgKLBh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgKLAfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:35:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E506221F9;
        Thu, 12 Nov 2020 00:33:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YR-0002Ck-56; Wed, 11 Nov 2020 19:33:35 -0500
Message-ID: <20201112003335.043100338@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:32:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 13/17] ftrace: Clean up the recursion code a bit
References: <20201112003244.764326960@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In trace_test_and_set_recursion(), current->trace_recursion is placed into a
variable, and that variable should be used for the processing, as there's no
reason to dereference current multiple times.

On trace_clear_recursion(), current->trace_recursion is modified and there's
no reason to copy it over to a variable.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 228cc56ed66e..a9f9c5714e65 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -162,7 +162,7 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
 							int start, int max)
 {
-	unsigned int val = current->trace_recursion;
+	unsigned int val = READ_ONCE(current->trace_recursion);
 	int bit;
 
 	/* A previous recursion check was made */
@@ -176,18 +176,15 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 		 * a switch between contexts. Allow for a single recursion.
 		 */
 		bit = TRACE_TRANSITION_BIT;
-		if (trace_recursion_test(bit)) {
+		if (val & (1 << bit)) {
 			do_ftrace_record_recursion(ip, pip);
 			return -1;
 		}
-		trace_recursion_set(bit);
-		barrier();
-		return bit + 1;
+	} else {
+		/* Normal check passed, clear the transition to allow it again */
+		val &= ~(1 << TRACE_TRANSITION_BIT);
 	}
 
-	/* Normal check passed, clear the transition to allow it again */
-	trace_recursion_clear(TRACE_TRANSITION_BIT);
-
 	val |= 1 << bit;
 	current->trace_recursion = val;
 	barrier();
@@ -197,17 +194,12 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 
 static __always_inline void trace_clear_recursion(int bit)
 {
-	unsigned int val = current->trace_recursion;
-
 	if (!bit)
 		return;
 
-	bit--;
-	bit = 1 << bit;
-	val &= ~bit;
-
 	barrier();
-	current->trace_recursion = val;
+	bit--;
+	trace_recursion_clear(bit);
 }
 
 /**
-- 
2.28.0


