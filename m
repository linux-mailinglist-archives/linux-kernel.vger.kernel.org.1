Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467602DCA59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbgLQBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:12:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388941AbgLQBMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:12:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3672A23A60;
        Thu, 17 Dec 2020 01:05:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kphj4-000xr2-3d; Wed, 16 Dec 2020 20:05:02 -0500
Message-ID: <20201217010501.965734417@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 16 Dec 2020 20:04:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [for-linus][PATCH 1/9] ring-buffer: Remove obsolete rb_event_is_commit()
References: <20201217010408.742794078@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Commit a389d86f7fd0 ("ring-buffer: Have nested events still record running
time stamp") removed the only uses of rb_event_is_commit() in
rb_update_event() and rb_update_write_stamp().

Hence, since then, make CC=clang W=1 warns:

  kernel/trace/ring_buffer.c:2763:1:
    warning: unused function 'rb_event_is_commit' [-Wunused-function]

Remove this obsolete function.

Link: https://lkml.kernel.org/r/20201117053703.11275-1-lukas.bulwahn@gmail.com

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7cd888ee9ac7..1b9da155ff00 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2629,9 +2629,6 @@ rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 	return skip_time_extend(event);
 }
 
-static inline bool rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
-				     struct ring_buffer_event *event);
-
 #ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 static inline bool sched_clock_stable(void)
 {
@@ -2759,20 +2756,6 @@ static unsigned rb_calculate_event_length(unsigned length)
 	return length;
 }
 
-static __always_inline bool
-rb_event_is_commit(struct ring_buffer_per_cpu *cpu_buffer,
-		   struct ring_buffer_event *event)
-{
-	unsigned long addr = (unsigned long)event;
-	unsigned long index;
-
-	index = rb_event_index(event);
-	addr &= PAGE_MASK;
-
-	return cpu_buffer->commit_page->page == (void *)addr &&
-		rb_commit_index(cpu_buffer) == index;
-}
-
 static u64 rb_time_delta(struct ring_buffer_event *event)
 {
 	switch (event->type_len) {
-- 
2.29.2


