Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09AD2DCA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbgLQBNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389016AbgLQBMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:12:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FCBF23AFA;
        Thu, 17 Dec 2020 01:05:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kphj5-000xu0-8u; Wed, 16 Dec 2020 20:05:03 -0500
Message-ID: <20201217010503.108121702@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 16 Dec 2020 20:04:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-linus][PATCH 7/9] ring-buffer: Add rb_check_bpage in __rb_allocate_pages
References: <20201217010408.742794078@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

It may be better to check each page is aligned by 4 bytes. The 2
least significant bits of the address will be used as flags.

Link: https://lkml.kernel.org/r/20201015113842.2921-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e97ecf72c727..e03bc4e5d482 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1423,7 +1423,8 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	return 0;
 }
 
-static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
+static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
+		long nr_pages, struct list_head *pages)
 {
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
@@ -1463,13 +1464,15 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 		struct page *page;
 
 		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-				    mflags, cpu_to_node(cpu));
+				    mflags, cpu_to_node(cpu_buffer->cpu));
 		if (!bpage)
 			goto free_pages;
 
+		rb_check_bpage(cpu_buffer, bpage);
+
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu), mflags, 0);
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags, 0);
 		if (!page)
 			goto free_pages;
 		bpage->page = page_address(page);
@@ -1501,7 +1504,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(!nr_pages);
 
-	if (__rb_allocate_pages(nr_pages, &pages, cpu_buffer->cpu))
+	if (__rb_allocate_pages(cpu_buffer, nr_pages, &pages))
 		return -ENOMEM;
 
 	/*
@@ -2008,8 +2011,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			 * allocated without receiving ENOMEM
 			 */
 			INIT_LIST_HEAD(&cpu_buffer->new_pages);
-			if (__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
-						&cpu_buffer->new_pages, cpu)) {
+			if (__rb_allocate_pages(cpu_buffer, cpu_buffer->nr_pages_to_update,
+						&cpu_buffer->new_pages)) {
 				/* not enough memory for new pages */
 				err = -ENOMEM;
 				goto out_err;
@@ -2074,8 +2077,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);
 		if (cpu_buffer->nr_pages_to_update > 0 &&
-			__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
-					    &cpu_buffer->new_pages, cpu_id)) {
+			__rb_allocate_pages(cpu_buffer, cpu_buffer->nr_pages_to_update,
+					    &cpu_buffer->new_pages)) {
 			err = -ENOMEM;
 			goto out_err;
 		}
-- 
2.29.2


