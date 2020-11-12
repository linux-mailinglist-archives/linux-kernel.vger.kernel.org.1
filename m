Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893C52B0CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgKLSlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgKLSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:41:11 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E8AC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:41:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so7058919wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/FQifl2y/j+iEx8t0YMS3kt6V2EmV6dxDAOzQF7gB4U=;
        b=vEOZkbx2w3SP32uR8e7Lzk7IQgr/PYOT3VEpmgSXA6fjRucCT1UModuNyvGUR7TyNp
         6Id+d9D9Wow+23Fhev03aSd1zuLQ7OubdKGUxxb+Qlooa4H+7KdEifb+K/nQiIPRgFWW
         8dugz9HgIM0b5BWbG9VCZLObhygBFDcEeSQDqjsXYatkYn7sPzrz/8HbC+L/+iWpEW+p
         lNH6/FB8yscIzl4M9WGItzRqXNv0+QQ7t14+bYS0mYiDFqWql80zc3Z9snZtlh37YSza
         a/XrIUY24oDAzHF0jnBmWsFu3z2WbvFUS1QXQMU8fk01ww/XyWC6mrb5HuuAE5fCfuKa
         0l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/FQifl2y/j+iEx8t0YMS3kt6V2EmV6dxDAOzQF7gB4U=;
        b=oU0KrWRDrBeBeCnjvCMppKYM6GV8xL6EuwOM2WsKg1ApDnDZN232xurWISyo/0WWvJ
         JU1pvwxTSZrNsVnHt4mzwVX60h0eObrjRyBV/uAOf7xl/arY1foZlel9EBu8KjJt1uYd
         +v+7MkDv644GCZQm64sk83bli13bUb0hEIn6IGHw7cdbDwjHKUGGBIeZOcUv2zo/K5mD
         vIPrwCowv/KE7iPQ/KFZk1AI4dRztfH0FjdD3blrUsIU6g98m3Ep7FQVJIrSM+tHJNoQ
         XZ2RzZapyCye+VOJ8dnu3n8wWmsHQjs1WnbgwX/4xIi12lZqW2o5voOrioEGicHBuW/g
         YDTA==
X-Gm-Message-State: AOAM531E/NxpqHrwSC4sbFQDbBdllbzrbYXh0VQpLPZ/l8W6TVxEnH6h
        Sg79PZczeWlVOWQUBmQDByJwYgQROTrDxw==
X-Google-Smtp-Source: ABdhPJxLHM0lzwc//56xGAcFucAqUl4YPJ5KF54JOwq+cS0oQFQF0p52S3RgUWHt79xj+PKP0ZRRmQ==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr1085379wrm.188.1605206468284;
        Thu, 12 Nov 2020 10:41:08 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j127sm8221850wma.31.2020.11.12.10.41.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 10:41:07 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, sudaraja@codeaurora.org,
        pratikp@codeaurora.org, lmark@codeaurora.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] mm/page_owner: Record timestamp and pid
Date:   Thu, 12 Nov 2020 20:41:06 +0200
Message-Id: <20201112184106.733-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Mark <lmark@codeaurora.org>

Collect the time for each allocation recorded in page owner so that
allocation "surges" can be measured.

Record the pid for each allocation recorded in page owner so that
the source of allocation "surges" can be better identified.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 mm/page_owner.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index b735a8eafcdb..e6dc52db5ba5 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -10,6 +10,7 @@
 #include <linux/migrate.h>
 #include <linux/stackdepot.h>
 #include <linux/seq_file.h>
+#include <linux/sched/clock.h>
 
 #include "internal.h"
 
@@ -25,6 +26,8 @@ struct page_owner {
 	gfp_t gfp_mask;
 	depot_stack_handle_t handle;
 	depot_stack_handle_t free_handle;
+	u64 ts_nsec;
+	int pid;
 };
 
 static bool page_owner_enabled = false;
@@ -172,6 +175,8 @@ static inline void __set_page_owner_handle(struct page *page,
 		page_owner->order = order;
 		page_owner->gfp_mask = gfp_mask;
 		page_owner->last_migrate_reason = -1;
+		page_owner->pid = current->pid;
+		page_owner->ts_nsec = local_clock();
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 
@@ -236,6 +241,8 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	new_page_owner->last_migrate_reason =
 		old_page_owner->last_migrate_reason;
 	new_page_owner->handle = old_page_owner->handle;
+	new_page_owner->pid = old_page_owner->pid;
+	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 
 	/*
 	 * We don't clear the bit on the oldpage as it's going to be freed
@@ -349,9 +356,10 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		return -ENOMEM;
 
 	ret = snprintf(kbuf, count,
-			"Page allocated via order %u, mask %#x(%pGg)\n",
+			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
-			&page_owner->gfp_mask);
+			&page_owner->gfp_mask, page_owner->pid,
+			page_owner->ts_nsec);
 
 	if (ret >= count)
 		goto err;
