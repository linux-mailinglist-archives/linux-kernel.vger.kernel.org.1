Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A52E2C44
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgLYUVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgLYUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:39 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A7C06179A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:24 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q5so4588683ilc.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfNgHX3+qK+u0VOsAx/K275yCLCkfDIhGcN/UVgID1U=;
        b=ZAHv7TFcIx1Mf5mGX+/8xLBwSPzs1ubKMP+G38fFzQQZOShqDkHcHLThvhLJBorgh3
         DbzuEXt9OCCXphofuGDl4AstqrTWN8qeehb+BVpflrzKBr/180UAXKczKoijZJHluK2C
         AFHQhPQWpNqMNKORKduYgQz3qZ4fEKhyK34Dp/wo54v/KNV5etVtI/iLLMv7x22Gw9dM
         dC4efj1Ou+HvbprRrG9PpU9jE6Bkb2jSt8shNs0WtzkZ1wFCtg37c1emdPyI0t4fgHD0
         rn9nzlbR+yE7w2kDjySkGvRjB7A8Q+i6uG9vqJOXj7eh/M8rjGkHykd+PYs2E3l3DfLd
         UZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfNgHX3+qK+u0VOsAx/K275yCLCkfDIhGcN/UVgID1U=;
        b=fZJL1U27ZEOzRvHomsuwlDAJiRU4pjJl6SgcRFqEMEajD/MOTYWSLDBSk0MTZ4gr+v
         BfNQg7NaLOIFkCcTc2m3QgdaNTtM9uDt/SPCGtJwVNegWej0G23nP5jIUvDn/ZfxXJpd
         iuUNPD3eabpiM3LUx32hfdz9qstfh1TwZdSBYl4FskaMRkMAbMQkZssaJUxTlX3J5YIE
         WeBTsbKcodrXVlLzEzsXFeh3J2nIPn4E/0kOVxjWZn0XdKXxac3fcu8VlZNzlqQbvYD/
         JylAQXWGmE1p9nuh62WUjJYllYrCYp01p3XS6YYbDUbmmeGPiOMJoNRUnuUNYpCqsnTx
         +fYQ==
X-Gm-Message-State: AOAM532faw1w4OhERiuaiffPT3y7o4u++wgsPQxTu2nWcZmtLeXpApmb
        DMh8oUehZFSu/+89Fg6FW7o=
X-Google-Smtp-Source: ABdhPJzOm7VNLs80O1ZjcJyUiH5EygM2C+qO7sBtY91dLqHSXfXV+ZPqfmxiJahUtgAFywbSotiOBw==
X-Received: by 2002:a05:6e02:10c2:: with SMTP id s2mr33628689ilj.290.1608927624353;
        Fri, 25 Dec 2020 12:20:24 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:23 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 10/19] dyndbg: avoid calling dyndbg_emit_prefix when it has no work
Date:   Fri, 25 Dec 2020 13:19:35 -0700
Message-Id: <20201225201944.3701590-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap function in a static-inline one, which checks flags to avoid
calling the function unnecessarily.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8e81ce58c1bd..daded73c8575 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -612,7 +612,7 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
+static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
@@ -652,6 +652,13 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	return buf;
 }
 
+static inline char *dynamic_emit_prefix(struct _ddebug *dp, char *buf)
+{
+	if (unlikely(dp->flags & _DPRINTK_FLAGS_INCL_ANY))
+		return __dynamic_emit_prefix(dp, buf);
+	return buf;
+}
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
-- 
2.29.2

