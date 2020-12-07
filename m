Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949FD2D08D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgLGB0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgLGB0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607304289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=J1oN9sljlo2pwicIsZRRyVmn98jc3XH9a9o30D1qed4=;
        b=FWqMZa8IhxLVzSRwTsSJwfoEeZvP9pVS9v6+zLL9ZWAuU7L8qK7UK6txqHuxGwIXEVsE1p
        J4pL+h4qrGD3zniuLxrjzal3zE8UZBkwJ6DHdytLCLNfC7UKZ2o2UPG/rW6tAGrpo47eIG
        QoCYk2bL6ElZgYUXkS3dAvjtrr2pHzs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-HiHmB0fYMOCvIOmapatulQ-1; Sun, 06 Dec 2020 20:24:47 -0500
X-MC-Unique: HiHmB0fYMOCvIOmapatulQ-1
Received: by mail-pj1-f71.google.com with SMTP id kb15so6100714pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 17:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J1oN9sljlo2pwicIsZRRyVmn98jc3XH9a9o30D1qed4=;
        b=IRxgmBZAT2vFMTsXjRsReql1oYW6zkvRqg9tHqQ71YkFG+zs71Rg/cPCEezFPq/OVU
         RVMccKaQexi0OpGwKkrsZrznlKaJFX0+BIlLxiubrOLp/YAB8q8Y0oIIrX9QtXBfkBtB
         Gfo6N39YxG/o4aOt7x9J6Cr+9hbxpELkGchPzXyKnOfgdweqwZK0NorgxyfcuhO/vzYq
         HGANXJhIjRhE08zaT5/LMakNkjk1el+UpLQe+dFaPSuch0cUIHTPL2Vx9mvfWd9KnUQ7
         hoiWXVBOXp9FnVRXBbKJUtbAbZ23+6Fyy1YNQlGxeDbCIpC5LQ82o0muwN5m0zCmzzC4
         ytQA==
X-Gm-Message-State: AOAM533ZSZmRQYyfu0N90OhHyCBZu8sxB2T9mVTiFDs++1f4vJqU6Zm9
        Vw5yK/9h/ey4HyoaDASkvc/nQq05M/jgKEVQztcy7gLfTlaQS+inlt1eY0XXd6VgzUhxIj4l6c1
        GW453VBv7HnKLZho7Ujo8cNHM
X-Received: by 2002:a17:902:988c:b029:da:60e0:10ec with SMTP id s12-20020a170902988cb02900da60e010ecmr13661214plp.83.1607304286330;
        Sun, 06 Dec 2020 17:24:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYCeL5bFeJwgvAd8bgm/URwkfycr/f6iQI0ks84hppoFfPEEnwKQQX9XEEQ7rJRDKUvFLgKg==
X-Received: by 2002:a17:902:988c:b029:da:60e0:10ec with SMTP id s12-20020a170902988cb02900da60e010ecmr13661200plp.83.1607304286141;
        Sun, 06 Dec 2020 17:24:46 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z13sm8600202pjt.45.2020.12.06.17.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 17:24:45 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 2/3] erofs: insert to managed cache after adding to pcl
Date:   Mon,  7 Dec 2020 09:23:45 +0800
Message-Id: <20201207012346.2713857-2-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201207012346.2713857-1-hsiangkao@redhat.com>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, it could be some concern to call add_to_page_cache_lru()
with page->mapping == Z_EROFS_MAPPING_STAGING (!= NULL).

In contrast, page->private is used instead now, so partially revert
commit 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
with some adaption for simplicity.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index afeadf413c2c..edd7325570e1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1071,28 +1071,19 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
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
-		set_page_private(page, (unsigned long)pcl);
-		SetPagePrivate(page);
+	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+		/* turn into temporary page if fails */
+		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
+		goto out;
 	}
+	set_page_private(page, (unsigned long)pcl);
+	SetPagePrivate(page);
 out:	/* the only exit (for tracing and debugging) */
 	return page;
 }
-- 
2.18.4

