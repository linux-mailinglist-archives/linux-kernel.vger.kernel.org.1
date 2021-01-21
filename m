Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B42FF8DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAUX21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbhAUXFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:05:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A2C061797
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:03:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d38so3663757ybe.15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BAlJPK4qVbFO+YocbKUqMkxk0C4PzWuOV8MSNSKCIhI=;
        b=QpJhHzvp1GXeEjDGYNxaJ+4dbtZiUzLq85/2LS484mjd4YFHF0DMU88K4lo+zwGWkM
         9LWilqjyHM5F5TtGZpKac7DrVr7HfcqlaVQK2F+DnPn7HQ1OpLiTN2syMLwN6sUYSfyq
         kMRuDoXMZo7mTk3nzJtbmwY7+bGtriVPvGjQkk+MnGqGoiLkOelUThpM6hXWK0x36ohG
         e4kaG1rglU1iTZ1tDhy7HPk7x9BjPJ8bIRyrdO3svNhEMvqS/Hns9be4EINUxvy/KNns
         rOQqszDYyJegCrtkYY9PpwY9HTVsvA0YScQQg5XyqxRJ8fMZK7LQEekKi+Z66tBXsO7I
         6JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BAlJPK4qVbFO+YocbKUqMkxk0C4PzWuOV8MSNSKCIhI=;
        b=lPSe0mgSkulvVdlBYIzG1ZMeEs/LGYoOe04jbqjawCjfZM8pO402bUtBUyYGohjlAx
         Gom6kWHMYgyygLuheyVHud2U2AmOkKOcvsiajNjXza3Y2eIRboipaRxSu1CvrqkEaflk
         vCY3I5IuuHkTYY1Ywo2x9/k/7zdsxkyXPAgskC71yYdAGtztYtMvIZjcIJdDbjEbiPIT
         oiFnWhMwzMTdzcKJLFKT7nQSRPvqXMcZSa1XvZK14tNFQ+oIJDOalhxloEq0SmGzOQLl
         4h/dK9cVUNI6fBdhUi6kRlANHpmjvFP1tq1xp+FxAhqdriewVhIcLcyiaP82P9Qq6uYG
         EeMg==
X-Gm-Message-State: AOAM5338HMjQ01ZIryDjVIj0h5NTPn741KhpB70TGO5Uo8sOGnzxxtxC
        orSLK8cuQ1SYzcbTDbT1Gzchfg07yjA=
X-Google-Smtp-Source: ABdhPJwxayAKSF6mXmBJ8++TA75KLd08uhG910WxJC5CctiAVx3ai3oKRw6joRzYaCJBGp4lZOg1Q76giQM=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:9d83:: with SMTP id v3mr2313605ybp.368.1611270223182;
 Thu, 21 Jan 2021 15:03:43 -0800 (PST)
Date:   Thu, 21 Jan 2021 23:03:30 +0000
In-Reply-To: <20210121230336.1373726-1-satyat@google.com>
Message-Id: <20210121230336.1373726-3-satyat@google.com>
Mime-Version: 1.0
References: <20210121230336.1373726-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v8 2/8] block: blk-crypto: relax alignment requirements for
 bvecs in bios
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk-crypto only accepted bios whose bvecs' offsets and lengths were aligned
to the crypto data unit size, since blk-crypto-fallback required that to
work correctly.

Now that the blk-crypto-fallback has been updated to work without that
assumption, we relax the alignment requirement - blk-crypto now only needs
the total size of the bio to be aligned to the crypto data unit size.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 5da43f0973b4..fcee0038f7e0 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -200,22 +200,6 @@ bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
 	return !bc1 || bio_crypt_dun_is_contiguous(bc1, bc1_bytes, bc2->bc_dun);
 }
 
-/* Check that all I/O segments are data unit aligned. */
-static bool bio_crypt_check_alignment(struct bio *bio)
-{
-	const unsigned int data_unit_size =
-		bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size;
-	struct bvec_iter iter;
-	struct bio_vec bv;
-
-	bio_for_each_segment(bv, bio, iter) {
-		if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size))
-			return false;
-	}
-
-	return true;
-}
-
 blk_status_t __blk_crypto_init_request(struct request *rq)
 {
 	return blk_ksm_get_slot_for_key(rq->q->ksm, rq->crypt_ctx->bc_key,
@@ -271,7 +255,8 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 		goto fail;
 	}
 
-	if (!bio_crypt_check_alignment(bio)) {
+	if (!IS_ALIGNED(bio->bi_iter.bi_size,
+			bc_key->crypto_cfg.data_unit_size)) {
 		bio->bi_status = BLK_STS_IOERR;
 		goto fail;
 	}
-- 
2.30.0.280.ga3ce27912f-goog

