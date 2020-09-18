Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17E126FF36
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIRNzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:55:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbgIRNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600437311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Fob8e2a9nGW8sR1cLDiz2AvMl4FxYk2sgoIACLAIhco=;
        b=QlydPNlRZbnjQExITz4BBcHMyvKSMxVvUzB78quby7q8vUOAzfj42CWXUNOUs6WF5cNlQC
        Y5vUVL5G+nrcSJWrEmcHZdLjL0xSKgACKqVUE/K7jIH9AdET3a+4TYgcp4spBikvhS9mwd
        eX0wb4j+w9as9Lciy7P15449xLpTpN8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-DCDFX03lMJORRwwV2x42SQ-1; Fri, 18 Sep 2020 09:55:09 -0400
X-MC-Unique: DCDFX03lMJORRwwV2x42SQ-1
Received: by mail-pg1-f197.google.com with SMTP id t3so3513636pgc.21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fob8e2a9nGW8sR1cLDiz2AvMl4FxYk2sgoIACLAIhco=;
        b=iGpsCBTzN8SLhlIPwwXY5fv30hjhjwwZrNHPFiUTwFNYzhj3K8gMZcqK2yx0PjBb6p
         8afyIee71NuvbuGfb6G3UvQVMpR4y1gocE05ERHkTypXIlOENpM43dmMA09lgzZSjSkG
         amsUrjCvtqvE3+MKE1XJHZ+h24zMdyo42aUs5HHakNWKwIT8vmREFco8ooVPZNrMDrQ+
         ggkwlSf/veI6OmnjEHZRNsP21Rti1GLQaAmAOdARRaV/jKJTNYcQcwb4VN3feT+VVBbT
         bbArgj1gMRP3q17ii7M8rBuOmE9q4J4EYZkX2MCRDq2zHvJd1TJ/cko5h4+nrOmaCSOp
         08Lw==
X-Gm-Message-State: AOAM5332DTr5Dbu6hoKwccav1DexkZzna6sksjbQv0JC5g1V5MBh5H0V
        frg8G4jT0ABbgJmhy58OmkNZL0zgfyChujm1daUJ7QGIJjx52iDk/FegCYU8aMVXeqkE3W39oHy
        wMmDUy+mRrRmEOXUsCWzxoD4X
X-Received: by 2002:a17:902:9006:b029:d2:341:6520 with SMTP id a6-20020a1709029006b02900d203416520mr5516701plp.37.1600437308859;
        Fri, 18 Sep 2020 06:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytckQsFmDdTGAEynQGk/nocBz8UclubNVkwkGFO1F2FUPlpGYRyvYg1rCXDtWbmXiv3T63Ww==
X-Received: by 2002:a17:902:9006:b029:d2:341:6520 with SMTP id a6-20020a1709029006b02900d203416520mr5516683plp.37.1600437308626;
        Fri, 18 Sep 2020 06:55:08 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j19sm3642016pfe.108.2020.09.18.06.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:55:08 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH 1/4] erofs: avoid unnecessary variable `err'
Date:   Fri, 18 Sep 2020 21:54:33 +0800
Message-Id: <20200918135436.17689-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable `err' in z_erofs_submit_queue() isn't useful
here, remove it instead.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6c939def00f9..df6fa691097f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1193,7 +1193,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 		do {
 			struct page *page;
-			int err;
 
 			page = pickup_page_for_submission(pcl, i++, pagepool,
 							  MNGD_MAPPING(sbi),
@@ -1219,8 +1218,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 				++nr_bios;
 			}
 
-			err = bio_add_page(bio, page, PAGE_SIZE, 0);
-			if (err < PAGE_SIZE)
+			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
 				goto submit_bio_retry;
 
 			last_index = cur;
-- 
2.18.1

