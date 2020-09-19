Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73669270B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgISH2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 03:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgISH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600500503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=xApC2kZG8EcnsErnZQz6jR2tMYwegUZKMG/mP3N+5Ys=;
        b=T3aEMEC8STkXWws2Ubo1qr8hxRVJbBgeMuxFB1TV6rUJot5TPnj08L+0HqMMU0OtXkS/2E
        E/pj2RUvh2o6WjLfeT/AoIuuDotYvqQT+E85lGAxJeLQ4+wUg9dy3aMnucW0PrTWBC19jL
        T9pjOYadB8okDWSv5k1kdmz8fgUenUs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-4o6iXLOoNnepOJbOKgv7kQ-1; Sat, 19 Sep 2020 03:28:19 -0400
X-MC-Unique: 4o6iXLOoNnepOJbOKgv7kQ-1
Received: by mail-pl1-f199.google.com with SMTP id 93so4640606plc.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 00:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xApC2kZG8EcnsErnZQz6jR2tMYwegUZKMG/mP3N+5Ys=;
        b=N+psUlqbviyEZmI35itx4IllsAW2gJWjWgeONajTcAECV7448KtlSEzhb38ZoARP2V
         XiBKzR28Lc0FPo2MpVSE0gGRFTVt885EVWuurDbSuO7gCUBvfWexgUqSlTjUZaGnyfLG
         Hc4PeoC+kVpGtMg1QYpyCVzmstsbYDtH29DCCKiWKYetJKH2uo4wkHqoeb3t3vM5cGh/
         nrdE8vYy4bAMwetZRB+eSNwljyb+ZZ8nyzqhC/Mz+iPU/anQ03JhRYN2gd9YBbLoGIhR
         8RVttQd4HdguuN1KxFFck+Y6h5u5sEI41pZxCuyDE7bNRif5LUBURDPk37jQFynO1Mgk
         UKDA==
X-Gm-Message-State: AOAM530oQQ2Ix5X9r1Y3+4Cd27esDpiCfhZpdmGNVYHDsaJdTLZ0puaW
        UuBQ/e9fCj90t92fWECOanZyPt4Y5BKoVhnNhC0CC6uef2kN6BdokDidWIWU8BD+BreLGZ5W52Q
        IbAdTx6j9Rb4Di0/Fr8u2wrmP
X-Received: by 2002:a17:902:b591:b029:d1:e598:740a with SMTP id a17-20020a170902b591b02900d1e598740amr18712750pls.61.1600500498737;
        Sat, 19 Sep 2020 00:28:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgH359QIQRd5hI5pfwvsaJgzRNMzTB3Y/mwN8BxuqR/YT5E+surSi5i6c5ZEg3h2BdrgyJRg==
X-Received: by 2002:a17:902:b591:b029:d1:e598:740a with SMTP id a17-20020a170902b591b02900d1e598740amr18712739pls.61.1600500498497;
        Sat, 19 Sep 2020 00:28:18 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s3sm5407381pfe.116.2020.09.19.00.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 00:28:18 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 2/3] erofs: fold in should_decompress_synchronously()
Date:   Sat, 19 Sep 2020 15:27:29 +0800
Message-Id: <20200919072730.24989-2-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200919072730.24989-1-hsiangkao@redhat.com>
References: <20200919072730.24989-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should_decompress_synchronously() has one single condition
for now, so fold it instead.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
no change since v1.

 fs/erofs/zdata.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e43684b23fdd..bee6ce783c64 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1294,24 +1294,18 @@ static int z_erofs_readpage(struct file *file, struct page *page)
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

