Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB21227CFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgI2NoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:44:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:33791 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgI2NoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:44:08 -0400
IronPort-SDR: 8i6q3Rx9Nn+y9wO0y2NlGzNdATKyqHU7r81AjQFjWO7DibKuVbQF7f9cK0jMcfPRpZQ0bLSNeV
 nAdOAXGxdXTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159568250"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="159568250"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 06:43:45 -0700
IronPort-SDR: mkrRdUkcaw4CBVY3WmZ8Q3fjAXelOgqhzRckxdGpkkwshFJp7ZAVnzYvC8+Ia9w+n3zf6e28+0
 wGMJLDEaVoPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="294254987"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2020 06:43:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D6A13327; Tue, 29 Sep 2020 16:43:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] list: Add a macro to test if entry is pointing to the head
Date:   Tue, 29 Sep 2020 16:43:42 +0300
Message-Id: <20200929134342.51489-1-andriy.shevchenko@linux.intel.com>
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

While here, convert list_for_each_entry*() family of macros to use a new one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: converted users inside list.h, dropped ambiguous description
 include/linux/list.h | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 796975c3c35c..89bdc92e75c3 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -609,6 +609,15 @@ static inline void list_splice_tail_init(struct list_head *list,
 	     pos != (head); \
 	     pos = n, n = pos->prev)
 
+/**
+ * list_entry_is_head - test if the entry points to the head of the list
+ * @pos:	the type * to cursor
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_entry_is_head(pos, head, member)				\
+	(&pos->member == (head))
+
 /**
  * list_for_each_entry	-	iterate over list of given type
  * @pos:	the type * to use as a loop cursor.
@@ -617,7 +626,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_entry(pos, head, member)				\
 	for (pos = list_first_entry(head, typeof(*pos), member);	\
-	     &pos->member != (head);					\
+	     !list_entry_is_head(pos, head, member);			\
 	     pos = list_next_entry(pos, member))
 
 /**
@@ -628,7 +637,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_entry_reverse(pos, head, member)			\
 	for (pos = list_last_entry(head, typeof(*pos), member);		\
-	     &pos->member != (head); 					\
+	     !list_entry_is_head(pos, head, member); 			\
 	     pos = list_prev_entry(pos, member))
 
 /**
@@ -653,7 +662,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_entry_continue(pos, head, member) 		\
 	for (pos = list_next_entry(pos, member);			\
-	     &pos->member != (head);					\
+	     !list_entry_is_head(pos, head, member);			\
 	     pos = list_next_entry(pos, member))
 
 /**
@@ -667,7 +676,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_entry_continue_reverse(pos, head, member)		\
 	for (pos = list_prev_entry(pos, member);			\
-	     &pos->member != (head);					\
+	     !list_entry_is_head(pos, head, member);			\
 	     pos = list_prev_entry(pos, member))
 
 /**
@@ -679,7 +688,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * Iterate over list of given type, continuing from current position.
  */
 #define list_for_each_entry_from(pos, head, member) 			\
-	for (; &pos->member != (head);					\
+	for (; !list_entry_is_head(pos, head, member);			\
 	     pos = list_next_entry(pos, member))
 
 /**
@@ -692,7 +701,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * Iterate backwards over list of given type, continuing from current position.
  */
 #define list_for_each_entry_from_reverse(pos, head, member)		\
-	for (; &pos->member != (head);					\
+	for (; !list_entry_is_head(pos, head, member);			\
 	     pos = list_prev_entry(pos, member))
 
 /**
@@ -705,7 +714,7 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_for_each_entry_safe(pos, n, head, member)			\
 	for (pos = list_first_entry(head, typeof(*pos), member),	\
 		n = list_next_entry(pos, member);			\
-	     &pos->member != (head); 					\
+	     !list_entry_is_head(pos, head, member); 			\
 	     pos = n, n = list_next_entry(n, member))
 
 /**
@@ -721,7 +730,7 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_for_each_entry_safe_continue(pos, n, head, member) 		\
 	for (pos = list_next_entry(pos, member), 				\
 		n = list_next_entry(pos, member);				\
-	     &pos->member != (head);						\
+	     !list_entry_is_head(pos, head, member);				\
 	     pos = n, n = list_next_entry(n, member))
 
 /**
@@ -736,7 +745,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_entry_safe_from(pos, n, head, member) 			\
 	for (n = list_next_entry(pos, member);					\
-	     &pos->member != (head);						\
+	     !list_entry_is_head(pos, head, member);				\
 	     pos = n, n = list_next_entry(n, member))
 
 /**
@@ -752,7 +761,7 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_for_each_entry_safe_reverse(pos, n, head, member)		\
 	for (pos = list_last_entry(head, typeof(*pos), member),		\
 		n = list_prev_entry(pos, member);			\
-	     &pos->member != (head); 					\
+	     !list_entry_is_head(pos, head, member); 			\
 	     pos = n, n = list_prev_entry(n, member))
 
 /**
-- 
2.28.0

