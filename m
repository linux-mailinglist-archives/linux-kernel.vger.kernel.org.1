Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5A2C12BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390617AbgKWR7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:59:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:8398 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390610AbgKWR7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:59:52 -0500
IronPort-SDR: wqUkqw/qeh8V0/ba/9r5bNWTVgO9kjtO9w8qks4YzRFObduHCN+PI19eeYGK9ITSmbSzuWAKCc
 /QGYzIuhaq/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151072625"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="151072625"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:59:52 -0800
IronPort-SDR: duHfIIVTNvV65/0AdPRzgIGLvxPFyjofGjd781D1oylk5RL1U45olbrp/VQmqqVbI+z1S2o8ne
 96cZz0rF9vaQ==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="478196756"
Received: from suygunge-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.108])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:59:49 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com
Subject: [PATCH 2/9] relay: require non-NULL callbacks in relay_open()
Date:   Mon, 23 Nov 2020 19:59:22 +0200
Message-Id: <e40642f3b027d2bb6bc851ddb60e0a61ea51f5f8.1606153547.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1606153547.git.jani.nikula@intel.com>
References: <cover.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no clients passing NULL callbacks, which makes sense as it
wouldn't even create a file. Require non-NULL callbacks, and throw away
the handling for NULL callbacks.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/relay.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index b51343642bf4..d9b8185161a8 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -291,13 +291,6 @@ static int remove_buf_file_default_callback(struct dentry *dentry)
 	return -EINVAL;
 }
 
-/* relay channel default callbacks */
-static struct rchan_callbacks default_channel_callbacks = {
-	.subbuf_start = subbuf_start_default_callback,
-	.create_buf_file = create_buf_file_default_callback,
-	.remove_buf_file = remove_buf_file_default_callback,
-};
-
 /**
  *	wakeup_readers - wake up readers waiting on a channel
  *	@work: contains the channel buffer
@@ -472,11 +465,6 @@ static void relay_close_buf(struct rchan_buf *buf)
 static void setup_callbacks(struct rchan *chan,
 				   struct rchan_callbacks *cb)
 {
-	if (!cb) {
-		chan->cb = &default_channel_callbacks;
-		return;
-	}
-
 	if (!cb->subbuf_start)
 		cb->subbuf_start = subbuf_start_default_callback;
 	if (!cb->create_buf_file)
@@ -542,6 +530,8 @@ struct rchan *relay_open(const char *base_filename,
 		return NULL;
 	if (subbuf_size > UINT_MAX / n_subbufs)
 		return NULL;
+	if (!cb)
+		return NULL;
 
 	chan = kzalloc(sizeof(struct rchan), GFP_KERNEL);
 	if (!chan)
-- 
2.20.1

