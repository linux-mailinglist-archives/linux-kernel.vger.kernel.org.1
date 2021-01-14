Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF32F6522
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbhANPsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbhANPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:48:32 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76FEC06179A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:39 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 18so4032682pgp.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=g2xCDGkf1QV8m2oT6FSaZhKIqRrYyoL3mQeF9dlubXk=;
        b=P8luqrH5fshKRy49UY321ccjqfMF+1nPrvcMgYsQRGwWvzW/T10vlEN+9nLbYE+bLf
         NsB5qJP6UoUga+wSwzCUgpPYoUTykzMHGpgY54Dk0ey2sF18Cai0yXtv6Pn8xgAJgqSN
         D0cvYGOQWpyl2O1Qp1p61+R5otk3CSYbHjPKSRCmZBe7yxYdsyxWWNC3O5uxD9+azrUS
         me2JZj16nNfGby1IxHjCh6NMlxx2RqfWyGNkkEI8zh4PzJfRJz1NlS5l0zN82Qps7rRB
         SD8uLJwWUCRC2jsiIthRvO1rU8da7j0B1yjDT/4oMNOmUTBcrWG6RaWlYYxQ369Wsd8O
         SwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g2xCDGkf1QV8m2oT6FSaZhKIqRrYyoL3mQeF9dlubXk=;
        b=OAtylZZARCXVOmEndHBH64mmEWCJ+nNikndKC9UY0npIZeDtcFBC+S4J5bMfaclq9a
         oteCfqlmjSxBgqaJaAFPkI902g+HpyvL4yDMHt11hIuBtiBsRWJq30civueYm2aJYoD0
         VZkRPF8h+xt9778+fUuwVVEvOL/yT1SOlTTenESsQiLnZp61Y1RpRIt7q65FC6g2POIi
         be00ebv4WrxjC+86O+hVQX7CRC8cds6DXMQHnrreNFZjcDGtN/ubtmo1hN/NLsOJZzxb
         ezgo4zVnaYeo6GcqwrCdOUGN5Ovra7W1au3gkIa0DDYUGs88kZWBJ3MT3Ntpj2N9AKvQ
         reRA==
X-Gm-Message-State: AOAM5315P/5A4HDMzp3WElPRX9P5PrVW8Z4VhlpZVtW5cxmb31wnmQ79
        day2WW/olp416TwFmkS1xUQSe2Lxs4U=
X-Google-Smtp-Source: ABdhPJwoueZO6ismwa6iFeqnJ2iy7LZ1F+RkesR2OnxUVW0OhtcSuObGIvf/i3mP2BWIbkcszBYJMxFg97c=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:aa7:96d9:0:b029:1a1:c2c4:bdb8 with SMTP id
 h25-20020aa796d90000b02901a1c2c4bdb8mr7961145pfq.72.1610639259410; Thu, 14
 Jan 2021 07:47:39 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:21 +0000
In-Reply-To: <20210114154723.2495814-1-satyat@google.com>
Message-Id: <20210114154723.2495814-6-satyat@google.com>
Mime-Version: 1.0
References: <20210114154723.2495814-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 5/7] block: respect blk_crypto_bio_sectors_alignment() in blk-merge
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make blk_bio_segment_split() respect blk_crypto_bio_sectors_alignment()
when calling bio_split(). The number of sectors is rounded down to the
required alignment just before the call to bio_split(). This makes it
possible for nsegs to be overestimated, but this solution is a lot
simpler than trying to calculate the exact number of nsegs required
for the aligned number of sectors. A future patch will attempt to
calculate nsegs more accurately.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-merge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a23a91e12e24..45cda45c1066 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -236,6 +236,8 @@ static bool bvec_split_segs(const struct request_queue *q,
  * following is guaranteed for the cloned bio:
  * - That it has at most get_max_io_size(@q, @bio) sectors.
  * - That it has at most queue_max_segments(@q) segments.
+ * - That the number of sectors in the returned bio is aligned to
+ *   blk_crypto_bio_sectors_alignment(@bio)
  *
  * Except for discard requests the cloned bio will point at the bi_io_vec of
  * the original bio. It is the responsibility of the caller to ensure that the
@@ -292,6 +294,9 @@ static int blk_bio_segment_split(struct request_queue *q,
 	 */
 	bio->bi_opf &= ~REQ_HIPRI;
 
+	sectors = round_down(sectors, blk_crypto_bio_sectors_alignment(bio));
+	if (WARN_ON(sectors == 0))
+		return -EIO;
 	*split = bio_split(bio, sectors, GFP_NOIO, bs);
 	return 0;
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

