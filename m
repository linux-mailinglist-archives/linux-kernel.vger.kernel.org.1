Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B202DCA62
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbgLQBMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388972AbgLQBMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:12:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124C923AC8;
        Thu, 17 Dec 2020 01:05:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kphj5-000xtU-2O; Wed, 16 Dec 2020 20:05:03 -0500
Message-ID: <20201217010502.939040369@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 16 Dec 2020 20:04:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-linus][PATCH 6/9] ring-buffer: Fix two typos in comments
References: <20201217010408.742794078@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

s/inerrupting/interrupting/
s/beween/between/

Link: https://lkml.kernel.org/r/20201014152749.29986-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8b57251ebf9d..e97ecf72c727 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3399,7 +3399,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			/* This did not interrupt any time update */
 			info->delta = info->ts - info->after;
 		else
-			/* Just use full timestamp for inerrupting event */
+			/* Just use full timestamp for interrupting event */
 			info->delta = info->ts;
 		barrier();
 		check_buffer(cpu_buffer, info, tail);
@@ -3436,7 +3436,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			info->ts = ts;
 		} else {
 			/*
-			 * Interrupted beween C and E:
+			 * Interrupted between C and E:
 			 * Lost the previous events time stamp. Just set the
 			 * delta to zero, and this will be the same time as
 			 * the event this event interrupted. And the events that
-- 
2.29.2


