Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6062F6526
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbhANPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhANPs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:28 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EA4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:38 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id g26so5099184qkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T+AWygX7OH80QXvfOzs3n7xe/G6bC11ON9WcWWdoQ+8=;
        b=U4LFD2nsz8xQHgT0rhZ1G/AMQ+FWnUzAzA6avnsMxwvpUEx7V1inLTHZQPW/o8yTam
         aw46GWdNFUsm2oO00a4n4ZmI7vlVdSmBFGetcUXDRbc/Udqh/xgSCv552WA2uRnnQXdI
         B9T9yIsTX6ts6jNo5CxgjE0vidmRPd2x+ooyvuit2hN7D5/lYkONfYd/jISnYd8Ote2W
         8/hBCTJ3FEndjzU/0YlKBd32qdMUY0sFawi+o0QqDVhiCVy8rHWSaHFWA6WgRnd+4+j4
         fLqFb0kBmx5FANNwVGnto0X18SlLpCMkazzi262K7CAjO3YV36X3Pun3EMS+IJLJvORo
         L05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T+AWygX7OH80QXvfOzs3n7xe/G6bC11ON9WcWWdoQ+8=;
        b=s+rdR7q/EgaiQgtH7jRIb78gyELgMk7RUSrqLucPEBR7Ex8fHdUNxw6A7gOoAyuGSd
         6IZ3d8+2fc+WU9EmTiGLAAoc+A8MJ0ur0ARUVZrzKIL70ddeOcaxlj9dmEO4REQ0rKTE
         LYuM5Gd5Vrb2D1AFQ5RgkUQ4Y0DHpACAdHO01Er7Fe+EDavXo4w5coEtLltpLmh5eZ1I
         c3MRw5y4w9qEz+KKdn4wrAmJTWONd87zwUm8TXlUZInOcNWLmXJbGblRhmbwymMxNtFI
         6ujQKSrGAp/9ziYm95rcULQH9gzw+85Rn/lbz054AaI2vePgXvxl4f2eYvVmmhOOdkV/
         oZwQ==
X-Gm-Message-State: AOAM532tAJScw8ESZ+NFDBt7K1F+t/NzB7fDiuhkw+kr3FkoFXkD7iPX
        Fmf8uxxRhuJv5h5F/e4MOfExIu/QIM0=
X-Google-Smtp-Source: ABdhPJzTX4rjIJNaqVFSCnwwKO5HfCbqTP33xZ/K20KnPSIjDpsOY8CWYUyJncST7orNHt+rk2kmGBrif0Q=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:ad4:4a70:: with SMTP id cn16mr7421032qvb.38.1610639257345;
 Thu, 14 Jan 2021 07:47:37 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:20 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-5-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 4/7] block: respect blk_crypto_bio_sectors_alignment() in blk-crypto-fallback
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make blk_crypto_split_bio_if_needed() respect
blk_crypto_bio_sectors_alignment() when calling bio_split().

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-fallback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c162b754efbd..77e20175df40 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -222,6 +222,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
 
+		num_sectors = round_down(len,
+					 blk_crypto_bio_sectors_alignment(bio));
 		split_bio = bio_split(bio, num_sectors, GFP_NOIO, NULL);
 		if (!split_bio) {
 			bio->bi_status = BLK_STS_RESOURCE;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

