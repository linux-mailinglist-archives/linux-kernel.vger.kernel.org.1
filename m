Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253C02D2858
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLHKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:01:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbgLHKBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607421596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=OnbVOCo3bXOU9/kWOo4VVhQfQzo7GWaQzsbv1nJLpY0=;
        b=Bx27fKQ3cQPBbVez8/yZTlGImFp6deW8zHYDuGxzPw3+7pdsgPdg7ATEu2Qr71cb3Ufv+A
        nvTgdp3VZUxYK4S/QEky0QwHVlX3W1P4lLtoyptXMdBi2YQvI5IhMw0aC2nbUarbrOGgO9
        7xksxqts1L/VPe02kSQ0aXVcAx/aPkY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-nQKv4MegOvSd6rI3mZDWZg-1; Tue, 08 Dec 2020 04:59:54 -0500
X-MC-Unique: nQKv4MegOvSd6rI3mZDWZg-1
Received: by mail-pl1-f200.google.com with SMTP id x12so1003543plr.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OnbVOCo3bXOU9/kWOo4VVhQfQzo7GWaQzsbv1nJLpY0=;
        b=L8lUHkJaqtSHjy96vPsBqDAmj1RPjXbeN9PsoVIAGA4V/Kc4Cv01Q474VBfVtUaUWY
         KzOaYKnwSbCFNk1bvMPX6UPed6Yl9v9xLLsOH/86JYhRv6dpv8PwEWnR+jJqlwmBIA++
         E7cGU2I+54FHcip4kYchrKDMapj/naEit82bipslIF4incQLzZHdg5e5q/zRv9gVSwca
         DZasfaAX3LIi8nuT1DZnvfMngHgGSXR6MpVrWyk/Bv/gpjyjZCxXiuYXthoCE2jLh5dJ
         asIH8uGOIao75K5X7ODFgXqFSRHwyMmCu+oZSU+oYYuUVqjWHIMo2Xu1jfEjH/519ZPA
         pAow==
X-Gm-Message-State: AOAM5311hkSd3xn4McY3o5AyGWHTYSuIcTULuZ4Xz4KfvNcG69+FpHha
        177XMtOzaIuF4DHbxiR+nhIS6bSNyFqOM6VOsebP7fcZI9C5tpC/VWJCmL/bfWrLi/E9gkL4IOr
        TTar+xgq44C9+NvnGmNii5MCV
X-Received: by 2002:a62:2b4e:0:b029:197:96c2:bfef with SMTP id r75-20020a622b4e0000b029019796c2bfefmr19807445pfr.46.1607421593388;
        Tue, 08 Dec 2020 01:59:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyOM02KFHrCbMiE5pqTFonEcc7mLe5Ma4LE3EHzuAQSxiV3ib9dsPfNmT9CWKZRK/3VHhbOg==
X-Received: by 2002:a62:2b4e:0:b029:197:96c2:bfef with SMTP id r75-20020a622b4e0000b029019796c2bfefmr19807435pfr.46.1607421593111;
        Tue, 08 Dec 2020 01:59:53 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z7sm11529018pfq.193.2020.12.08.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:59:52 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v3 2/3] erofs: insert to managed cache after adding to pcl
Date:   Tue,  8 Dec 2020 17:58:33 +0800
Message-Id: <20201208095834.3133565-2-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201208095834.3133565-1-hsiangkao@redhat.com>
References: <20201208095834.3133565-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, it could be some concern to call add_to_page_cache_lru()
with page->mapping == Z_EROFS_MAPPING_STAGING (!= NULL).

In contrast, page->private is used instead now, so partially revert
commit 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
with some adaption for simplicity.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cfb0d11f893b..37fee144f0e7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1065,29 +1065,21 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	put_page(page);
 out_allocpage:
 	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
-	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
-		/* turn into temporary page if fails */
-		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
-		tocache = false;
-	}
-
 	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
-		if (tocache) {
-			/* since it added to managed cache successfully */
-			unlock_page(page);
-			put_page(page);
-		} else {
-			list_add(&page->lru, pagepool);
-		}
+		list_add(&page->lru, pagepool);
 		cond_resched();
 		goto repeat;
 	}
 
-	if (tocache) {
-		attach_page_private(page, pcl);
-		/* drop a ref added by allocpage (then we have 2 refs here) */
-		put_page(page);
+	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+		/* turn into temporary page if fails (1 ref) */
+		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
+		goto out;
 	}
+	attach_page_private(page, pcl);
+	/* drop a refcount added by allocpage (then we have 2 refs here) */
+	put_page(page);
+
 out:	/* the only exit (for tracing and debugging) */
 	return page;
 }
-- 
2.18.4

