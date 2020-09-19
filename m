Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D1C270B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 09:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgISH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 03:28:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37831 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgISH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600500496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2bEftFKQeg7t1a3m+CntScYxnb1LsdZSJyYIcNndeZc=;
        b=gyjOq5b4es+zHr9O2VR4mqLVSUifDiU+eCMR0K1uRcKP2POE+y1oTGKltyvpo5ZZEyJqTG
        9v9LfitilsztQpd81TBVXM9gmYynzekC9GsWPrgpIvnaMId84QxUjQb3xIEMBN9NSCZLoj
        s1pDc6Y92XtXn9CvaH2im7dsNhoMi6k=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-aKuJLpWePe6RzT0xL_RAPw-1; Sat, 19 Sep 2020 03:28:14 -0400
X-MC-Unique: aKuJLpWePe6RzT0xL_RAPw-1
Received: by mail-pf1-f197.google.com with SMTP id y76so5089328pfb.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 00:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2bEftFKQeg7t1a3m+CntScYxnb1LsdZSJyYIcNndeZc=;
        b=bmdIyhlNI+nbXv/3Pb4pULruetSAc8S4xGwp/8o1oNb/mU8nBjbGE7nDYBRg4/A6oE
         iDxgciIsUmnIy9gtNuVw4Hit61NGrE3Vu5Hg9jwp4XCQ8Sp5F6q4mg8HPJp+b3Ky0ucQ
         STLE58IIsDxr5ikrL3LlwtSoHTPtlDd6EkrAkpWOqw+XvzowSgoMUtfxtus/TfuGMqsT
         R9PYSqah6A1cnSpTHbhmZUfBzJHHjKvFKflqX6Q/WGjLu5ZDeacKoBntXtuxcCOhwmFl
         NVXtlCsJ9Cn4pEVH5IFmaROioAWTA3o1lVZ7bAqXAx5TFA6s86lixmeoxRu+GtdI78g5
         jO/w==
X-Gm-Message-State: AOAM531/79I0sS5XsV1sGdJzwsFddPPqFLZ/2b2Lkh5lC2bQ7FrbFjBN
        5IELJRezm9as4AVqbFr068I8RA3vHmTFN3ESAhkUNUJTa42lWxI/2FIHntztWuAzhz9zZyWlMAs
        Gvsb3MBSAsL1WuY+YBKVqBhfr
X-Received: by 2002:a05:6a00:1695:b029:142:2501:34e4 with SMTP id k21-20020a056a001695b0290142250134e4mr18419835pfc.61.1600500493153;
        Sat, 19 Sep 2020 00:28:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnwDQjBN6SIpBsTZ/BuU2boz5JzVyUzKod6irPW+vMbploZ5tevrUsGCQUeZu55MR50+cEPg==
X-Received: by 2002:a05:6a00:1695:b029:142:2501:34e4 with SMTP id k21-20020a056a001695b0290142250134e4mr18419820pfc.61.1600500492812;
        Sat, 19 Sep 2020 00:28:12 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s3sm5407381pfe.116.2020.09.19.00.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 00:28:12 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 1/3] erofs: avoid unnecessary variable `err'
Date:   Sat, 19 Sep 2020 15:27:28 +0800
Message-Id: <20200919072730.24989-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable `err' in z_erofs_submit_queue() isn't useful
here, remove it instead.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
no change since v1.

 fs/erofs/zdata.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ac6cb73df192..e43684b23fdd 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1190,7 +1190,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 		do {
 			struct page *page;
-			int err;
 
 			page = pickup_page_for_submission(pcl, i++, pagepool,
 							  MNGD_MAPPING(sbi),
@@ -1216,8 +1215,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 				++nr_bios;
 			}
 
-			err = bio_add_page(bio, page, PAGE_SIZE, 0);
-			if (err < PAGE_SIZE)
+			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
 				goto submit_bio_retry;
 
 			last_index = cur;
-- 
2.18.1

