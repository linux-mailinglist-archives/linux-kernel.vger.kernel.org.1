Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B281F32E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 06:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFIEH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 00:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFIEHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 00:07:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A0C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 21:07:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e5so15516042ote.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7zOtqod2Euqhm9iPREHnkIF3DMLeaqYFlNU4Ij6xdk=;
        b=FjJ89Zz6Zabh55WwWSyHLMdGbn5+ZFUnV6t0J4lfHeTg00n0S0+g8tH9fTOkD0RYr/
         RzIVBW0H6YDPgXdXrYZKJ6lZYVU/K0QfZSqn3dQ4FK20UCoaSekAe6gtD6QlMZ2qyTeH
         5yLlAKUl3b+hJcp+Uv0sljcQDADG5EiRc+a40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7zOtqod2Euqhm9iPREHnkIF3DMLeaqYFlNU4Ij6xdk=;
        b=BVDdFxZo3cN+0MShN64nDFTjUkJUxu31keCFt8WFbzLEvG7BF4nvuj4cVGozo4IWI1
         uA0U5h8r9DZWSF81PoIoNPfPpR8QB66bJyzsC6hU2VA8feDDTI0B9i9YLFRUoSyOGB4H
         QScfXor8PY2Rhk2NHherGTU0DqZ7Ryp0ttOn+KjbvEwwfZB3GuTKp4BlgdLj2VievU/K
         4waHB/cSb0dU+zpG+bNgOkPQ+cOu2I2/Lb7SIKiBfp+DUsNt0x+fHVJZ7fdaMjFzo2RS
         RCSiiLUcHbS3fRd7YC97eYdXHESvdo1ZbCYONUerA18vtmo8u+ypiNn2i1MjGk5d9IfQ
         9t/g==
X-Gm-Message-State: AOAM531q3aiNjkLVgLjMcsQcH6jRvTRcPc6F3ZQyaYs3GzJ1V34LOqwC
        z1DB2Ry5PdrQl2ScRXRyjZkTPQ==
X-Google-Smtp-Source: ABdhPJwP/NC7Rz1dQpnWz1DmgZJM92ITSowkH3VJ4YhuIZEkyCo1sN/KCWDtAIyorO3x4PkBBKqhqQ==
X-Received: by 2002:a9d:5ad:: with SMTP id 42mr20480281otd.268.1591675673016;
        Mon, 08 Jun 2020 21:07:53 -0700 (PDT)
Received: from mezcal.netflix.com ([2600:1700:3ec3:2450:25ca:3996:acb2:84a6])
        by smtp.gmail.com with ESMTPSA id b3sm2846415ooq.36.2020.06.08.21.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 21:07:52 -0700 (PDT)
From:   Josh Snyder <joshs@netflix.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Snyder <josh@code406.com>, Josh Snyder <joshs@netflix.com>
Subject: [RFC 1/2] Eliminate over- and under-counting of io_ticks
Date:   Mon,  8 Jun 2020 21:07:23 -0700
Message-Id: <20200609040724.448519-2-joshs@netflix.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609040724.448519-1-joshs@netflix.com>
References: <20200609040724.448519-1-joshs@netflix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, io_ticks could be under-counted. Consider these I/Os along
the time axis (in jiffies):

  t          012345678
  io1        |----|
  io2            |---|

Under the old approach, io_ticks would count up to 6, like so:

  t          012345678
  io1        |----|
  io2            |---|
  stamp      0   45  8
  io_ticks   1   23  6

With this change, io_ticks instead counts to 8, eliminating the
under-counting:

  t          012345678
  io1        |----|
  io2            |---|
  stamp      0    5  8
  io_ticks   0    5  8

It was also possible for io_ticks to be over-counted. Consider a
workload that issues I/Os deterministically at intervals of 8ms (125Hz).
If each I/O takes 1ms, then the true utilization is 12.5%. The previous
implementation will increment io_ticks once for each jiffy in which an
I/O ends. Since the workload issues an I/O reliably for each jiffy, the
reported utilization will be 100%. This commit changes the approach such
that only I/Os which cross a boundary between jiffies are counted. With
this change, the given workload would count an I/O tick on every eighth
jiffy, resulting in a (correct) calculated utilization of 12.5%.

Signed-off-by: Josh Snyder <joshs@netflix.com>
Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
---
 block/blk-core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d1b79dfe9540..a0bbd9e099b9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1396,14 +1396,22 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
-static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
+static void update_io_ticks(struct hd_struct *part, unsigned long now, unsigned long start)
 {
 	unsigned long stamp;
+	unsigned long elapsed;
 again:
 	stamp = READ_ONCE(part->stamp);
 	if (unlikely(stamp != now)) {
-		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
+		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
+			// stamp denotes the last IO to finish
+			// If this IO started before stamp, then there was overlap between this IO
+			// and that one. We increment only by the non-overlap time.
+			// If not, there was no overlap and we increment by our own time,
+			// disregarding stamp.
+			elapsed = now - (start < stamp ? stamp : start);
+			__part_stat_add(part, io_ticks, elapsed);
+		}
 	}
 	if (part->partno) {
 		part = &part_to_disk(part)->part0;
@@ -1439,7 +1447,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_lock();
 		part = req->part;
 
-		update_io_ticks(part, jiffies, true);
+		update_io_ticks(part, jiffies, nsecs_to_jiffies(req->start_time_ns));
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1456,7 +1464,6 @@ void blk_account_io_start(struct request *rq)
 	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
 
 	part_stat_lock();
-	update_io_ticks(rq->part, jiffies, false);
 	part_stat_unlock();
 }
 
@@ -1468,7 +1475,6 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 	unsigned long now = READ_ONCE(jiffies);
 
 	part_stat_lock();
-	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
@@ -1487,7 +1493,7 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 	unsigned long duration = now - start_time;
 
 	part_stat_lock();
-	update_io_ticks(part, now, true);
+	update_io_ticks(part, now, start_time);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
-- 
2.25.1

