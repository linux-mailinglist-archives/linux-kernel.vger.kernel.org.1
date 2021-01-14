Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3782F6519
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbhANPsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhANPsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:21 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:34 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id i82so5085915qke.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VXMYjn9O4XsIoXbGPi+u1w3+Oc2FJKcjd/08+b6WrBI=;
        b=dpUlfBP7ghRE0W1c/N+pxmSRl/ey4DQezPpbDZN0l+b8RG8CvlIPqIOxB+RvfmiswX
         sDi7LGLRi4EbbiVKyU0CjN8jKrFTsPgcYMgbxcuq3OqFoP8pqZXrV+1LgTVswuOCQvO4
         kNsH7JVDnYv/ZbpRhGecHxPO63rfSqtxAROm9xvp/P5Ra+G2TgNB5TU4rOud1n7g2utY
         EMAh23S6jSqWphe4ZoWFRzaVE9kkUy84pkEAXD1aeGinxhIV4fLxefiyk/ushanWTVdn
         xO6xhFXwKvW9gikMWbc9+PejtCtaq5TTKVuvYlS9qHqgweoRs7VhpqUu0jB3dgpfuZMi
         vhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VXMYjn9O4XsIoXbGPi+u1w3+Oc2FJKcjd/08+b6WrBI=;
        b=nGrb/pqotZ6zKycDBi/2kZHJSsryFcGWni8kMeoqLL4qcsPU5GAHuY8ShHbf0oQvqd
         o47FrHCUNYKGSGTGip14GDG7bn2OSDjixlfMJ/Gu+8hRRz0DgMlBoJpx829li9xcTFst
         tOj1ZwUcEs3hawRs9jrl17IehHDMZg9qep50f008RSi5rIC0/Cga021nXuJpbgxEEHB0
         PKeuVMx1iX1gz0wxEY8tK2xtu4Qm40Z8rqJzfG2ExrCl7mzleyE3Tg6SOzEDN9Pw34tj
         cs/zt1NHKoni/fhnD+k3aGYnmH4H1aR2bbOsFl4nsubdZ1BiN1r9GsQ0m8ZnjV7jeqcM
         /yoQ==
X-Gm-Message-State: AOAM532iDj5GQKcXGWfmk4/nMUPPnE2l/NJ/Q+75bFq0n16on5GNEIj2
        mdnslBgra1i8kImDa3Qka5+d00wHa7g=
X-Google-Smtp-Source: ABdhPJxB4L1wTGhRJSsrgLoO7tHuFYdrw8HNgPGtxULPSi0IZ0JS2biD0BYgq/c95/CXgcqzxvlrPWQSOJw=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:b328:: with SMTP id l40mr11010076ybj.15.1610639253503;
 Thu, 14 Jan 2021 07:47:33 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:18 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-3-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/7] block: blk-crypto: Introduce blk_crypto_bio_sectors_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of any bio must be aligned to the data unit size of the bio crypt
context (if it exists) of that bio. This must also be ensured whenever a
bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns
the required alignment in sectors. The number of sectors passed to
any call of bio_split() should be aligned to
blk_crypto_bio_sectors_alignment().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-internal.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..304e90ed99f5 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,19 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+/*
+ * Returns the alignment requirement for the number of sectors in this bio based
+ * on its bi_crypt_context. Any bios split from this bio must follow this
+ * alignment requirement as well.
+ */
+static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
+{
+	if (!bio_has_crypt_ctx(bio))
+		return 1;
+	return bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size >>
+								SECTOR_SHIFT;
+}
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
@@ -93,6 +106,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static inline unsigned int blk_crypto_bio_sectors_alignment(struct bio *bio)
+{
+	return 1;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

