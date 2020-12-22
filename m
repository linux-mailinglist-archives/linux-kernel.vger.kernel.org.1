Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B862DCA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbgLQBMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388969AbgLQBMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:12:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BEF23ABA;
        Thu, 17 Dec 2020 01:05:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kphj4-000xs2-HN; Wed, 16 Dec 2020 20:05:02 -0500
Message-ID: <20201217010502.374037887@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 16 Dec 2020 20:04:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [for-linus][PATCH 3/9] seq_buf: Avoid type mismatch for seq_buf_init
References: <20201217010408.742794078@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with W=2 prints a number of warnings for one function that
has a pointer type mismatch:

linux/seq_buf.h: In function 'seq_buf_init':
linux/seq_buf.h:35:12: warning: pointer targets in assignment from 'unsigned char *' to 'char *' differ in signedness [-Wpointer-sign]

Change the type in the function prototype according to the type in
the structure.

Link: https://lkml.kernel.org/r/20201026161108.3707783-1-arnd@kernel.org

Fixes: 9a7777935c34 ("tracing: Convert seq_buf fields to be like seq_file fields")
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h   | 2 +-
 include/linux/trace_seq.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index fb0205d87d3c..9d6c28cc4d8f 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -30,7 +30,7 @@ static inline void seq_buf_clear(struct seq_buf *s)
 }
 
 static inline void
-seq_buf_init(struct seq_buf *s, unsigned char *buf, unsigned int size)
+seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
 {
 	s->buffer = buf;
 	s->size = size;
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 6c30508fca19..5a2c650d9e1c 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -12,7 +12,7 @@
  */
 
 struct trace_seq {
-	unsigned char		buffer[PAGE_SIZE];
+	char			buffer[PAGE_SIZE];
 	struct seq_buf		seq;
 	int			full;
 };
@@ -51,7 +51,7 @@ static inline int trace_seq_used(struct trace_seq *s)
  * that is about to be written to and then return the result
  * of that write.
  */
-static inline unsigned char *
+static inline char *
 trace_seq_buffer_ptr(struct trace_seq *s)
 {
 	return s->buffer + seq_buf_used(&s->seq);
-- 
2.29.2


