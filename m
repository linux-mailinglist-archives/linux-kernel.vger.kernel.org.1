Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C326FF37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIRNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgIRNzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600437319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=x/V6psnjWa7bZ2+Jw/8jPkXMC70/LQzTlIIUciZVaDg=;
        b=CgwUIGMWrOJWsGEbYlzmcjlJO5N5+/2QXyMwL0Uy2lhVFJXdZJNAuw/Y/3U+vXRhGGp08s
        XUhniO+bFeMHOggl8VV5y2yy0bObc4Q+ea/i25iKshkFz8nCNwkUtt9nXNbiBrLOH3ljo3
        pO0oQJmluhiBlJQjr5eXs82CD+l3z34=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-1DFQETq5PY2NcLAsCYNRJQ-1; Fri, 18 Sep 2020 09:55:15 -0400
X-MC-Unique: 1DFQETq5PY2NcLAsCYNRJQ-1
Received: by mail-pf1-f200.google.com with SMTP id 82so3713070pfz.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x/V6psnjWa7bZ2+Jw/8jPkXMC70/LQzTlIIUciZVaDg=;
        b=RElHkXvWzEIudZrAlljTuwB8uZ/lGMwNRrmkBX4Yh2yRVU2wkVTT9AcLuAnFOUxeEy
         GETmtmvK8ebgChtdflek0vPXiwngAxjzQ3eWirpx8LsBl5WJF/TbgZouDN7b6cG7jPVy
         5bHMjYAG4mU4Fcx/yw96JbQy9U8yujW5timREjFnqilxm9RmAxAIJvE+8cM9uJYL29hx
         q7EntWZFhGXizFGd/bfeT8LnMD0j+x2sOtU9aiPA+x1H/DxWUwH7WJ5ZHRc14iyNX0Eq
         n+BBtO8Ih6hIQr9lHgY63ITEauXWC4FTVJ2UHGuh6bjPZr56EkQXWRZ41cYhwt4b6ssQ
         YTOQ==
X-Gm-Message-State: AOAM530KVa1SVgnTfnF5l8foXIRvPBGQRbWMR9v8bn62n9Wy+Ilvv1GS
        K5eEkmMfmkE0CvhFUo6SacXQ8P7hq4s1NQi1+AvmihgQYb7Gn06r7CHU1TerQcE+ObYsMtmqHzx
        bG6/K8beLtGEvUDcg30c79YrS
X-Received: by 2002:a63:c74f:: with SMTP id v15mr16416016pgg.143.1600437314670;
        Fri, 18 Sep 2020 06:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA9hEhCK5BgOCduGHc66YcxXr3W4T4GK/zG/fX16vDb2Ffy6oVinpavyGNjAGm+hAibFUXAQ==
X-Received: by 2002:a63:c74f:: with SMTP id v15mr16416009pgg.143.1600437314470;
        Fri, 18 Sep 2020 06:55:14 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j19sm3642016pfe.108.2020.09.18.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:55:13 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH 2/4] erofs: fold in should_decompress_synchronously()
Date:   Fri, 18 Sep 2020 21:54:34 +0800
Message-Id: <20200918135436.17689-2-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200918135436.17689-1-hsiangkao@redhat.com>
References: <20200918135436.17689-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should_decompress_synchronously() has one single condition
for now, so fold it instead.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index df6fa691097f..d483e9fee41c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1297,24 +1297,18 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	return err;
 }
 
-static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
-					    unsigned int nr)
-{
-	return nr <= sbi->ctx.max_sync_decompress_pages;
-}
-
 static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
-	bool sync = should_decompress_synchronously(sbi, readahead_count(rac));
+	unsigned int nr_pages = readahead_count(rac);
+	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(inode, readahead_index(rac),
-			readahead_count(rac), false);
+	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
 	f.headoffset = readahead_pos(rac);
 
-- 
2.18.1

