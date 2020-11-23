Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7C2C12C0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390625AbgKWR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:59:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:8419 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390610AbgKWR76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:59:58 -0500
IronPort-SDR: brXQtO02mmoWVzujk2ibdrP2Q0oG7l6iA4vdJto4ylCaJn0vhI3DlSt3CxQfXPli1hi7qQFV5v
 V49181bBUzcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151072636"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="151072636"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:59:58 -0800
IronPort-SDR: f8T1J64kku1oms2cBb/glw0QI/tIYtsZ3XN5tvBdfvuRCX3mURFNzaUmC7IuN6z02uS+fTEs4r
 c1fKByUb9WaA==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="478196775"
Received: from suygunge-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.108])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:59:56 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com
Subject: [PATCH 3/9] relay: make create_buf_file and remove_buf_file callbacks mandatory
Date:   Mon, 23 Nov 2020 19:59:23 +0200
Message-Id: <88003c1527386b93036e286e7917f1e33aec84ac.1606153547.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1606153547.git.jani.nikula@intel.com>
References: <cover.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All clients provide create_buf_file and remove_buf_file callbacks, and
they're required for relay to make sense. There is no point in them
being optional.

Also document whether each callback is mandatory/optional.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/relay.h |  6 ++++++
 kernel/relay.c        | 26 +-------------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index b3c4f49f6951..99d024475ba5 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -89,6 +89,8 @@ struct rchan_callbacks
 	 * The client should return 1 to continue logging, 0 to stop
 	 * logging.
 	 *
+	 * This callback is optional.
+	 *
 	 * NOTE: subbuf_start will also be invoked when the buffer is
 	 *       created, so that the first sub-buffer can be initialized
 	 *       if necessary.  In this case, prev_subbuf will be NULL.
@@ -122,6 +124,8 @@ struct rchan_callbacks
 	 * cause relay_open() to create a single global buffer rather
 	 * than the default set of per-cpu buffers.
 	 *
+	 * This callback is mandatory.
+	 *
 	 * See Documentation/filesystems/relay.rst for more info.
 	 */
 	struct dentry *(*create_buf_file)(const char *filename,
@@ -139,6 +143,8 @@ struct rchan_callbacks
 	 * channel buffer.
 	 *
 	 * The callback should return 0 if successful, negative if not.
+	 *
+	 * This callback is mandatory.
 	 */
 	int (*remove_buf_file)(struct dentry *dentry);
 };
diff --git a/kernel/relay.c b/kernel/relay.c
index d9b8185161a8..dd4ec4ec07f3 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -271,26 +271,6 @@ static int subbuf_start_default_callback (struct rchan_buf *buf,
 	return 1;
 }
 
-/*
- * create_buf_file_create() default callback.  Does nothing.
- */
-static struct dentry *create_buf_file_default_callback(const char *filename,
-						       struct dentry *parent,
-						       umode_t mode,
-						       struct rchan_buf *buf,
-						       int *is_global)
-{
-	return NULL;
-}
-
-/*
- * remove_buf_file() default callback.  Does nothing.
- */
-static int remove_buf_file_default_callback(struct dentry *dentry)
-{
-	return -EINVAL;
-}
-
 /**
  *	wakeup_readers - wake up readers waiting on a channel
  *	@work: contains the channel buffer
@@ -467,10 +447,6 @@ static void setup_callbacks(struct rchan *chan,
 {
 	if (!cb->subbuf_start)
 		cb->subbuf_start = subbuf_start_default_callback;
-	if (!cb->create_buf_file)
-		cb->create_buf_file = create_buf_file_default_callback;
-	if (!cb->remove_buf_file)
-		cb->remove_buf_file = remove_buf_file_default_callback;
 	chan->cb = cb;
 }
 
@@ -530,7 +506,7 @@ struct rchan *relay_open(const char *base_filename,
 		return NULL;
 	if (subbuf_size > UINT_MAX / n_subbufs)
 		return NULL;
-	if (!cb)
+	if (!cb || !cb->create_buf_file || !cb->remove_buf_file)
 		return NULL;
 
 	chan = kzalloc(sizeof(struct rchan), GFP_KERNEL);
-- 
2.20.1

