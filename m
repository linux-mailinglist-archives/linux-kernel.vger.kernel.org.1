Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC2A2E2BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 15:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLYOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 09:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLYOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:05:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CE2C061573
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:04:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so2584845pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YZfKieCX5rV1B+nrxp3LHVOn4c4ho6IJxTmdo80zdOo=;
        b=Ex7oPNGc9G/tLqpFJrxZsATvd4yACnE+Oi4uZt4IKkv4J3Ref+A3xpzy9StuKR0hog
         YpOivzn77ta6v9idBnSk/YtJlsjAp8e4tcw/VL9Ca8oizvfXG4qxvvzggE3kXPdD3uc5
         k1GSlcC0I7nZK6vw2wEUsfV/iSK2yFdkpIFdR3ZNQSjfvV0oGk7kp/6TnWYkgMpFZZb6
         sKRa0qarGBQ6UTKvBk89Z/phAleypaw66q4VZGrc84jnRgzuFNlfflObm6+YNTS31Gkg
         wCzYYc2MLckOC8KeCuZ7EaxzNv4DIboRR6o+fPAwir+Eh7yfK9fa4KuIOkm0ijdYiOpV
         eAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YZfKieCX5rV1B+nrxp3LHVOn4c4ho6IJxTmdo80zdOo=;
        b=KjwJtb079tHBZiZw+kqQ7tDeQwvLM1vewfbiOBmQDINUJ+WYFtJhLdEWvtL5agnjD2
         EPL5Xr7rQJPb+Tf0unOWAnwKPhrihKkpMyswFkKO7fFj3b5rCBRvFZ3HeQuPCNn26va9
         FQKJ/0HjNMbJr17smMY3heWOgUMQDPSv0eOZTeswtvM3GylUhSxLjAYpqrO8CYmE5Q0g
         kv8fewq5YZbtoHKA/nVwcAm6jm3IwmzCsrSAnUhPlbI4QC+1KkhZvo1hBTufRDJBW8le
         h7mcCIyp8X8YLXDm3EDfR/8qm+1dqJdMLcPiRFGQ3La2ms29QHS0SVdfORZ9izvrYFFe
         4+ag==
X-Gm-Message-State: AOAM531lpQ+78H5m0+jsCfwYCyKLAvPGl5ti4ejXudl7qYOGXW7T3siP
        ULQ5T1kVqRfRKUGizJ61B2g=
X-Google-Smtp-Source: ABdhPJxvHHno7NUz8Fn9iEnrl+mH1xBkCOObv9nvgYdCsmMH6wB8/nMYoTwrX2wYE1mmJzAVB6ebZQ==
X-Received: by 2002:aa7:8550:0:b029:19e:46e7:913b with SMTP id y16-20020aa785500000b029019e46e7913bmr30937121pfn.58.1608905060763;
        Fri, 25 Dec 2020 06:04:20 -0800 (PST)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id u6sm30300743pgj.37.2020.12.25.06.04.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Dec 2020 06:04:20 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ring-buffer: Remove cpu_buffer argument from the rb_inc_page()
Date:   Fri, 25 Dec 2020 22:03:56 +0800
Message-Id: <20201225140356.23008-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_buffer argument is not used inside the rb_inc_page() after
commit 3adc54fa82a6 ("ring-buffer: make the buffer a true circular link
list").
And cpu_buffer argument is not used inside the two functions too,
rb_is_head_page/rb_set_list_to_head.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/ring_buffer.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ec08f948dd80..8fccee76a5f3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1112,8 +1112,7 @@ static struct list_head *rb_list_head(struct list_head *list)
  * its flags will be non zero.
  */
 static inline int
-rb_is_head_page(struct ring_buffer_per_cpu *cpu_buffer,
-		struct buffer_page *page, struct list_head *list)
+rb_is_head_page(struct buffer_page *page, struct list_head *list)
 {
 	unsigned long val;
 
@@ -1142,8 +1141,7 @@ static bool rb_is_reader_page(struct buffer_page *page)
 /*
  * rb_set_list_to_head - set a list_head to be pointing to head.
  */
-static void rb_set_list_to_head(struct ring_buffer_per_cpu *cpu_buffer,
-				struct list_head *list)
+static void rb_set_list_to_head(struct list_head *list)
 {
 	unsigned long *ptr;
 
@@ -1166,7 +1164,7 @@ static void rb_head_page_activate(struct ring_buffer_per_cpu *cpu_buffer)
 	/*
 	 * Set the previous list pointer to have the HEAD flag.
 	 */
-	rb_set_list_to_head(cpu_buffer, head->list.prev);
+	rb_set_list_to_head(head->list.prev);
 }
 
 static void rb_list_head_clear(struct list_head *list)
@@ -1241,8 +1239,7 @@ static int rb_head_page_set_normal(struct ring_buffer_per_cpu *cpu_buffer,
 				old_flag, RB_PAGE_NORMAL);
 }
 
-static inline void rb_inc_page(struct ring_buffer_per_cpu *cpu_buffer,
-			       struct buffer_page **bpage)
+static inline void rb_inc_page(struct buffer_page **bpage)
 {
 	struct list_head *p = rb_list_head((*bpage)->list.next);
 
@@ -1274,11 +1271,11 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	for (i = 0; i < 3; i++) {
 		do {
-			if (rb_is_head_page(cpu_buffer, page, page->list.prev)) {
+			if (rb_is_head_page(page, page->list.prev)) {
 				cpu_buffer->head_page = page;
 				return page;
 			}
-			rb_inc_page(cpu_buffer, &page);
+			rb_inc_page(&page);
 		} while (page != head);
 	}
 
@@ -1824,7 +1821,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cond_resched();
 
 		to_remove_page = tmp_iter_page;
-		rb_inc_page(cpu_buffer, &tmp_iter_page);
+		rb_inc_page(&tmp_iter_page);
 
 		/* update the counters */
 		page_entries = rb_page_entries(to_remove_page);
@@ -2271,7 +2268,7 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 	if (iter->head_page == cpu_buffer->reader_page)
 		iter->head_page = rb_set_head_page(cpu_buffer);
 	else
-		rb_inc_page(cpu_buffer, &iter->head_page);
+		rb_inc_page(&iter->head_page);
 
 	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
 	iter->head = 0;
@@ -2374,7 +2371,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	 * want the outer most commit to reset it.
 	 */
 	new_head = next_page;
-	rb_inc_page(cpu_buffer, &new_head);
+	rb_inc_page(&new_head);
 
 	ret = rb_head_page_set_head(cpu_buffer, new_head, next_page,
 				    RB_PAGE_NORMAL);
@@ -2526,7 +2523,7 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 	next_page = tail_page;
 
-	rb_inc_page(cpu_buffer, &next_page);
+	rb_inc_page(&next_page);
 
 	/*
 	 * If for some reason, we had an interrupt storm that made
@@ -2552,7 +2549,7 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * the buffer, unless the commit page is still on the
 	 * reader page.
 	 */
-	if (rb_is_head_page(cpu_buffer, next_page, &tail_page->list)) {
+	if (rb_is_head_page(next_page, &tail_page->list)) {
 
 		/*
 		 * If the commit is not on the reader page, then
@@ -2879,7 +2876,7 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 			return;
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
-		rb_inc_page(cpu_buffer, &cpu_buffer->commit_page);
+		rb_inc_page(&cpu_buffer->commit_page);
 		/* add barrier to keep gcc from optimizing too much */
 		barrier();
 	}
@@ -3638,14 +3635,14 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
 	 * Because the commit page may be on the reader page we
 	 * start with the next page and check the end loop there.
 	 */
-	rb_inc_page(cpu_buffer, &bpage);
+	rb_inc_page(&bpage);
 	start = bpage;
 	do {
 		if (bpage->page == (void *)addr) {
 			local_dec(&bpage->entries);
 			return;
 		}
-		rb_inc_page(cpu_buffer, &bpage);
+		rb_inc_page(&bpage);
 	} while (bpage != start);
 
 	/* commit not part of this buffer?? */
@@ -4367,7 +4364,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->pages = reader->list.prev;
 
 	/* The reader page will be pointing to the new head */
-	rb_set_list_to_head(cpu_buffer, &cpu_buffer->reader_page->list);
+	rb_set_list_to_head(&cpu_buffer->reader_page->list);
 
 	/*
 	 * We want to make sure we read the overruns after we set up our
@@ -4406,7 +4403,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 * Now make the new head point back to the reader page.
 	 */
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
-	rb_inc_page(cpu_buffer, &cpu_buffer->head_page);
+	rb_inc_page(&cpu_buffer->head_page);
 
 	local_inc(&cpu_buffer->pages_read);
 
-- 
2.17.1

