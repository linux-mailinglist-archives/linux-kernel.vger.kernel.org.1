Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47521EFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 14:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgGNMCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 08:02:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52571 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728047AbgGNMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:02:13 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with SMTP; 14 Jul 2020 15:02:06 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06EC25de004353;
        Tue, 14 Jul 2020 15:02:06 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 01/11] lib/string_helpers: Introduce string_upper() and string_lower() helpers
Date:   Tue, 14 Jul 2020 15:01:53 +0300
Message-Id: <20200714120203.10352-2-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200714120203.10352-1-vadimp@mellanox.com>
References: <20200714120203.10352-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the helpers for string conversions to upper alnd lower cases.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 include/linux/string_helpers.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index c28955132234..86f150c2a6b6 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_STRING_HELPERS_H_
 #define _LINUX_STRING_HELPERS_H_
 
+#include <linux/ctype.h>
 #include <linux/types.h>
 
 struct file;
@@ -75,6 +76,20 @@ static inline int string_escape_str_any_np(const char *src, char *dst,
 	return string_escape_str(src, dst, sz, ESCAPE_ANY_NP, only);
 }
 
+static inline void string_upper(char *dst, const char *src)
+{
+	do {
+		*dst++ = toupper(*src);
+	} while (*src++);
+}
+
+static inline void string_lower(char *dst, const char *src)
+{
+	do {
+		*dst++ = tolower(*src);
+	} while (*src++);
+}
+
 char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
-- 
2.11.0

