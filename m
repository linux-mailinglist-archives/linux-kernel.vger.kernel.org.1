Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E702C12CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390672AbgKWSAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:00:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:8569 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbgKWSAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:00:45 -0500
IronPort-SDR: kYOZs1+kqnRoF41PQPB4B1GaclnsVigiYDs7gd1CWzXTcv5GfqhEVCJ1PfMi+A5fzcC0os8Xzk
 Lh9W+aV2AUrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151072817"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="151072817"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 10:00:37 -0800
IronPort-SDR: uIJ4xAF3qw/Rcf2+KRTJQ9eAiso9qCyOcgRGhS6DXYqHRVSdfyYteyYsRbbBLbRpVGCXhW3EjL
 3CoEmmfbw+EA==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="332267090"
Received: from suygunge-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 10:00:34 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 9/9] blktrace: make relay callbacks const
Date:   Mon, 23 Nov 2020 19:59:29 +0200
Message-Id: <7ff5ce0b735901eb4f10e13da2704f1d8c4a2507.1606153547.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1606153547.git.jani.nikula@intel.com>
References: <cover.1606153547.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that relay_open() accepts const callbacks, make relay callbacks
const.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f1022945e346..b5c4b9ade960 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -449,7 +449,7 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
 					&relay_file_operations);
 }
 
-static struct rchan_callbacks blk_relay_callbacks = {
+static const struct rchan_callbacks blk_relay_callbacks = {
 	.subbuf_start		= blk_subbuf_start_callback,
 	.create_buf_file	= blk_create_buf_file_callback,
 	.remove_buf_file	= blk_remove_buf_file_callback,
-- 
2.20.1

