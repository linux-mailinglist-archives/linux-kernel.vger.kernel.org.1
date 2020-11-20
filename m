Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C52BBA3D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 00:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgKTXhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKTXhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:37:53 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ACFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:37:53 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c79so8134174pfc.20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FjHjVwdfkJH/O7BzGQZqvWfzHZCa8+FpNDqvo215C2s=;
        b=j5GhYx8NsqDGQ+Q7KsapCIibH84ZbYs1JBURIilY7lYIz31OOlMB68a/jW59hm1D1/
         gwU+gGv6rQ2MiRB2Mn5XLNNJ2dR3RmagRNaUWyRSV65LQw64jXieoNKl4vUVmeujosJJ
         gHQiKiFOe6N18k7SNGyHy+jbPDukTdfZ5NJWOCObPihyLVgTCOdnNampgnnumv1Ilpy0
         jBCzB3A+rc/DM0xkmXoyJj/YFaciwa7q50GHJ2N8LQBZZnlulIeCZN/g0H22HCFxzFw3
         Na5nDf+DHBK5f/nD2qjjoYWH/pYr9PzVIdhLKER2PPKPTJdQc38SpTEIA5nR0xoHTQ8F
         szfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FjHjVwdfkJH/O7BzGQZqvWfzHZCa8+FpNDqvo215C2s=;
        b=P/JzP9XiHVQ7a52bWNLnf1hiYRWUG2cHdt6ZEzowq+P2ThzwrEcMXMZmW3/aiOlPkd
         tm15FfMVU9GDE59BBajhX+ySACqsN6A00p24FYZBePCU3fQ6dhvFDW8hNRqbPxWyDLBc
         H9apXi9FU7j8OD4OQGULFqiGb5F4Nc1IgZ2CFxlQYJdYGcuGxY2L7hdPW+NiByQIHcyq
         fdZsgEjQ/wnB0cRDtVhPqnO3S89zLzbleLoiUsx8GH0o06JS0DLQlIKoiht5Bh0Jdbt4
         BKNou4XilcV2QnS0CNgXeqxmUHuihweb2QzpNTIkrKpyq+cS0h4Adivyx0UdPaV0KTiv
         qZ8g==
X-Gm-Message-State: AOAM532+Mces4TdDLxPpJf8LMCCrti2YDFBMsMJGd1jJXVQl0QQrCFZM
        2yketC5fYkng9R7RTN8byqY+oxtx3Q==
X-Google-Smtp-Source: ABdhPJyMu1/kuiBr/QhpWcj4hLN8w5EQ/jmr8EHUiybYU2+OIUhwYbgsZhcohBihI7+VlvTF+tTo2OIMgg==
Sender: "tkjos via sendgmr" <tkjos@ava-linux2.mtv.corp.google.com>
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:cad3:ffff:feb3:bfed])
 (user=tkjos job=sendgmr) by 2002:a62:6586:0:b029:164:1cb9:8aff with SMTP id
 z128-20020a6265860000b02901641cb98affmr16956332pfb.64.1605915472392; Fri, 20
 Nov 2020 15:37:52 -0800 (PST)
Date:   Fri, 20 Nov 2020 15:37:43 -0800
Message-Id: <20201120233743.3617529-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] binder: add flag to clear buffer on txn complete
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        smoreland@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a per-transaction flag to indicate that the buffer
must be cleared when the transaction is complete to
prevent copies of sensitive data from being preserved
in memory.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c            |  1 +
 drivers/android/binder_alloc.c      | 48 +++++++++++++++++++++++++++++
 drivers/android/binder_alloc.h      |  4 ++-
 include/uapi/linux/android/binder.h |  1 +
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b5117576792b..2a3952925855 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3146,6 +3146,7 @@ static void binder_transaction(struct binder_proc *proc,
 	t->buffer->debug_id = t->debug_id;
 	t->buffer->transaction = t;
 	t->buffer->target_node = target_node;
+	t->buffer->clear_on_free = !!(t->flags & TF_CLEAR_BUF);
 	trace_binder_transaction_alloc_buf(t->buffer);
 
 	if (binder_alloc_copy_user_to_buffer(
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2f846b7ae8b8..7caf74ad2405 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -696,6 +696,8 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 	binder_insert_free_buffer(alloc, buffer);
 }
 
+static void binder_alloc_clear_buf(struct binder_alloc *alloc,
+				   struct binder_buffer *buffer);
 /**
  * binder_alloc_free_buf() - free a binder buffer
  * @alloc:	binder_alloc for this proc
@@ -706,6 +708,18 @@ static void binder_free_buf_locked(struct binder_alloc *alloc,
 void binder_alloc_free_buf(struct binder_alloc *alloc,
 			    struct binder_buffer *buffer)
 {
+	/*
+	 * We could eliminate the call to binder_alloc_clear_buf()
+	 * from binder_alloc_deferred_release() by moving this to
+	 * binder_alloc_free_buf_locked(). However, that could
+	 * increase contention for the alloc mutex if clear_on_free
+	 * is used frequently for large buffers. The mutex is not
+	 * needed for correctness here.
+	 */
+	if (buffer->clear_on_free) {
+		binder_alloc_clear_buf(alloc, buffer);
+		buffer->clear_on_free = false;
+	}
 	mutex_lock(&alloc->mutex);
 	binder_free_buf_locked(alloc, buffer);
 	mutex_unlock(&alloc->mutex);
@@ -802,6 +816,10 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		/* Transaction should already have been freed */
 		BUG_ON(buffer->transaction);
 
+		if (buffer->clear_on_free) {
+			binder_alloc_clear_buf(alloc, buffer);
+			buffer->clear_on_free = false;
+		}
 		binder_free_buf_locked(alloc, buffer);
 		buffers++;
 	}
@@ -1135,6 +1153,36 @@ static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
 	return lru_page->page_ptr;
 }
 
+/**
+ * binder_alloc_clear_buf() - zero out buffer
+ * @alloc: binder_alloc for this proc
+ * @buffer: binder buffer to be cleared
+ *
+ * memset the given buffer to 0
+ */
+static void binder_alloc_clear_buf(struct binder_alloc *alloc,
+				   struct binder_buffer *buffer)
+{
+	size_t bytes = binder_alloc_buffer_size(alloc, buffer);
+	binder_size_t buffer_offset = 0;
+
+	while (bytes) {
+		unsigned long size;
+		struct page *page;
+		pgoff_t pgoff;
+		void *kptr;
+
+		page = binder_alloc_get_page(alloc, buffer,
+					     buffer_offset, &pgoff);
+		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
+		kptr = kmap(page) + pgoff;
+		memset(kptr, 0, size);
+		kunmap(page);
+		bytes -= size;
+		buffer_offset += size;
+	}
+}
+
 /**
  * binder_alloc_copy_user_to_buffer() - copy src user to tgt user
  * @alloc: binder_alloc for this proc
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 55d8b4106766..6e8e001381af 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -23,6 +23,7 @@ struct binder_transaction;
  * @entry:              entry alloc->buffers
  * @rb_node:            node for allocated_buffers/free_buffers rb trees
  * @free:               %true if buffer is free
+ * @clear_on_free:      %true if buffer must be zeroed after use
  * @allow_user_free:    %true if user is allowed to free buffer
  * @async_transaction:  %true if buffer is in use for an async txn
  * @debug_id:           unique ID for debugging
@@ -41,9 +42,10 @@ struct binder_buffer {
 	struct rb_node rb_node; /* free entry by size or allocated entry */
 				/* by address */
 	unsigned free:1;
+	unsigned clear_on_free:1;
 	unsigned allow_user_free:1;
 	unsigned async_transaction:1;
-	unsigned debug_id:29;
+	unsigned debug_id:28;
 
 	struct binder_transaction *transaction;
 
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index f1ce2c4c077e..ec84ad106568 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -248,6 +248,7 @@ enum transaction_flags {
 	TF_ROOT_OBJECT	= 0x04,	/* contents are the component's root object */
 	TF_STATUS_CODE	= 0x08,	/* contents are a 32-bit status code */
 	TF_ACCEPT_FDS	= 0x10,	/* allow replies with file descriptors */
+	TF_CLEAR_BUF	= 0x20,	/* clear buffer on txn complete */
 };
 
 struct binder_transaction_data {
-- 
2.29.2.454.gaff20da3a2-goog

