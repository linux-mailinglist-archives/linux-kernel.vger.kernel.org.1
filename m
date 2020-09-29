Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918CF27C524
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgI2Lbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:31:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:20901 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbgI2L3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:29:23 -0400
IronPort-SDR: yExZVxvdvMre+pMeMnt7tUMCy4jqtuiE3HcTtk/nhqK4SwCtsXGAfN1j98hUEp/92S6H1psrEe
 U04OOsaFNA5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159544246"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="159544246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 04:29:00 -0700
IronPort-SDR: 9ixOqNBRYI/s0y8NrHSuQWdCraasuc0LiaRbewRpTclH+lY/dlnZeWGCwWMvolcvpV4jUbU5t0
 UnE6YDP8ydDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="340812412"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 29 Sep 2020 04:28:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D93B320; Tue, 29 Sep 2020 14:28:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] list: Add a macro to test if entry is pointing to the head
Date:   Tue, 29 Sep 2020 14:28:56 +0300
Message-Id: <20200929112856.41771-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a macro to test if entry is pointing to the head of the list
which is useful in cases like:

  list_for_each_entry(pos, &head, member) {
    if (cond)
      break;
  }
  if (list_entry_is_head(pos, &head, member))
    return -ERRNO;

that allows to avoid additional variable to be added to track if loop
has not been stopped in the middle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/list.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 796975c3c35c..49efaa8c3403 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -770,6 +770,17 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_safe_reset_next(pos, n, member)				\
 	n = list_next_entry(pos, member)
 
+/**
+ * list_entry_is_head - test if the entry points to the head of the list
+ * @pos:	the type * to cursor
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * This macro can be used to check if the loop over the list wasn't stopped.
+ */
+#define list_entry_is_head(pos, head, member)				\
+	(&pos->member == (head))
+
 /*
  * Double linked lists with a single pointer list head.
  * Mostly useful for hash tables where the two pointer list head is
-- 
2.28.0

