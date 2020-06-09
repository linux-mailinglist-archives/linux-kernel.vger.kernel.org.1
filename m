Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD511F32E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 06:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgFIEID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 00:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgFIEH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 00:07:56 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD72C03E97C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 21:07:56 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n70so3076014ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMg2il5dniGzMXIHwihjljl4tLmzag0BAtIr3O3mqAQ=;
        b=VA2fALAh42LUAhCCSTv58KpD6aOh3+xBzPG/+HNE6VsS9HCewFOJxOndV2wxZFvhMJ
         oTrF3TyopvWJPk5jW0GIIsCDSDlRfJ05B/0UI/B/3wIRD0GsBve1kCAYWH64ihxFB2kT
         7RbpqbgC2YF3BwjNMEoV8/C0Xk8Mr/99aQ/sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMg2il5dniGzMXIHwihjljl4tLmzag0BAtIr3O3mqAQ=;
        b=qhquewfI5/IU/JET50isWMhjTPvG0lbCaTM45Yk4hQFbgQFTdMJkLLUB7PTVdnXM9m
         Zj2d2Sgh/YAAqRl8PcZeQvk4EfZGgFNHEbT8lJkdRiylydgzTVEeSleiPd36t4knt0Pe
         g2yyK9rsL9WjhUtZkTtNNSbTWrOMN2ciEumWAm6q5FKF1FZ5aHStzAcd28lFUQn1d29k
         5KEekI1NB4D+WoptPHfEyF3kFWFllsYrTAaKmIYii9GBik9hffERL6qlo7w6Fi0zB2k3
         KlEU3zJOGPDmzeL8pymVdtxEz3aglE6oYmqAxEsxGsl0Z7Ee+zhPiGZL+C2gJ9Gagve6
         EJEA==
X-Gm-Message-State: AOAM531vTPr1P8Rx6jRDW6YC5c4kgFuSuChoXzNvF2c1H4cVSLJPDA72
        h2jB+t3Zid2NFt7+1YgvOxhppQ==
X-Google-Smtp-Source: ABdhPJyMRt4Jx9GfhTFpeOBe+1dzdOpcXxEWOzfCRGyKoVegXldX32pMvuAZeGa2GSvdcZ8CPMbo3Q==
X-Received: by 2002:a9d:67ce:: with SMTP id c14mr18286246otn.337.1591675676002;
        Mon, 08 Jun 2020 21:07:56 -0700 (PDT)
Received: from mezcal.netflix.com ([2600:1700:3ec3:2450:25ca:3996:acb2:84a6])
        by smtp.gmail.com with ESMTPSA id b3sm2846415ooq.36.2020.06.08.21.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 21:07:54 -0700 (PDT)
From:   Josh Snyder <joshs@netflix.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Snyder <josh@code406.com>, Josh Snyder <joshs@netflix.com>
Subject: [RFC 2/2] Track io_ticks at microsecond granularity.
Date:   Mon,  8 Jun 2020 21:07:24 -0700
Message-Id: <20200609040724.448519-3-joshs@netflix.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609040724.448519-1-joshs@netflix.com>
References: <20200609040724.448519-1-joshs@netflix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we performed truncation of I/O issue/completion times during
calculation of io_ticks, counting only I/Os which cross a jiffy
boundary. The effect is a sampling of I/Os: at every boundary between
jiffies we ask "is there an outstanding I/O" and increment a counter if
the answer is yes. This produces results that are accurate (they don't
systematically over- or under-count), but not precise (there is high
variance associated with only taking 100 samples per second).

This change modifies the sampling rate from 100Hz to 976562.5Hz (1
sample per 1024 nanoseconds). I chose this sampling rate by simulating a
workload in which I/Os are issued randomly (by a Poisson process), and
processed in constant time: an M/D/∞ system (Kendall's notation). My
goal was to produce a sampled utilization fraction which was correct to
one part-per-thousand given one second of samples.

The tradeoff of the higher sampling rate is increased synchronization
overhead caused by more frequent compare-and-swap operations. The
technique of commit 5b18b5a73760 ("block: delete part_round_stats and
switch to less precise counting") is to allow multiple I/Os to complete
while performing only one synchronized operation. As we are increasing
the sample rate by a factor of 10000, we will less frequently be able to
exercise the synchronization-free code path.

Included below is the Python script I used to perform the simulation. It
estimates the correct (calculated without sampling) value of %util, and
then reports the root-mean-squared error of the as-sampled estimates.
The parameters `io_rate`, `sample_rates`, and `avgqu_sz` are meant to be
tweaked to fit characteristics of a given workload. I have chosen to
simulate against a difficult workload: 1000 I/Os per second with an
average queue size of 0.01, implying that each I/O takes 10
microseconds. This I/O latency is on par with some of the fastest
production block devices available today, and an order of magnitude
faster than a typical datacenter-grade SSD. With this change, an
estimate of disk %util will not fluctuate as displayed by iostat with
four decimal places, at a refresh rate of 1 Hz.

    #!/usr/bin/env python3
    from math import log
    from math import sqrt
    from random import random

    GIGA = 1_000_000_000
    SECOND = GIGA

    def times(interval, avgqu_sz, sample_rates):
        time = 0
        correct = 0

        est_counters = [0] * len(sample_rates)

        while time < SECOND:
            gap = -log(random()) * interval
            busy = svctm if gap > svctm else gap
            finish_time = time + busy

            correct += busy
            for i, rate in enumerate(sample_rates):
                est_counters[i] += (
                    float(int(finish_time * rate)) - int(time * rate)
                )

            time += gap

        return correct, [
            correct - (counter / rate)
            for counter, rate in zip(est_counters, sample_rates)
        ]

    # How many I/Os per second?
    io_rate = 1000
    # How frequently are we sampling? (GHz)
    sample_rates = [
        100 / GIGA,  #      100 Hz
        1000 / GIGA, #     1000 Hz
        1 / 65536,   #    15259 Hz
        1 / 16384,   #    61035 Hz
        1 / 1024,    #   976563 Hz
        1 / 64,      # 15625000 Hz
    ]
    avgqu_sz = 0.01

    interval = SECOND / io_rate
    svctm = interval * avgqu_sz
    total = 0
    total_errors = [0] * len(sample_rates)
    count = 0
    while True:
        correct, errors = times(interval, svctm, sample_rates)
        for i, error in enumerate(errors):
            total_errors[i] += error * error
        total += correct / SECOND
        count += 1

        # prints [{RMS error} for rate in sample_rates]
        to_print = [
           "{:05.2f}".format(100 * sqrt(error / count) / SECOND)
            for error in total_errors
        ]
        print(' '.join(to_print))

Signed-off-by: Josh Snyder <joshs@netflix.com>
Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
---
 block/blk-core.c          | 16 +++++++++++-----
 block/genhd.c             |  4 ++--
 include/linux/genhd.h     |  2 +-
 include/linux/part_stat.h |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0bbd9e099b9..2749c52d649c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -62,6 +62,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(block_unplug);
 
 DEFINE_IDA(blk_queue_ida);
 
+#define IO_TICKS_COARSENESS 10
+
 /*
  * For queue allocation
  */
@@ -1396,10 +1398,14 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
-static void update_io_ticks(struct hd_struct *part, unsigned long now, unsigned long start)
+static void update_io_ticks(struct hd_struct *part, u64 now, u64 start)
 {
-	unsigned long stamp;
-	unsigned long elapsed;
+	u64 stamp;
+	u64 elapsed;
+
+	start &= ~((1<<IO_TICKS_COARSENESS) - 1);
+	now &= ~((1<<IO_TICKS_COARSENESS) - 1);
+
 again:
 	stamp = READ_ONCE(part->stamp);
 	if (unlikely(stamp != now)) {
@@ -1447,7 +1453,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_lock();
 		part = req->part;
 
-		update_io_ticks(part, jiffies, nsecs_to_jiffies(req->start_time_ns));
+		update_io_ticks(part, now, req->start_time_ns);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1493,7 +1499,7 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 	unsigned long duration = now - start_time;
 
 	part_stat_lock();
-	update_io_ticks(part, now, start_time);
+	update_io_ticks(part, jiffies_to_nsecs(now), jiffies_to_nsecs(start_time));
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index 1a7659327664..045cc9cd7a2c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1296,7 +1296,7 @@ ssize_t part_stat_show(struct device *dev,
 		(unsigned long long)stat.sectors[STAT_WRITE],
 		(unsigned int)div_u64(stat.nsecs[STAT_WRITE], NSEC_PER_MSEC),
 		inflight,
-		jiffies_to_msecs(stat.io_ticks),
+		(unsigned int)div_u64(stat.io_ticks, NSEC_PER_MSEC),
 		(unsigned int)div_u64(stat.nsecs[STAT_READ] +
 				      stat.nsecs[STAT_WRITE] +
 				      stat.nsecs[STAT_DISCARD] +
@@ -1601,7 +1601,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
 							NSEC_PER_MSEC),
 			   inflight,
-			   jiffies_to_msecs(stat.io_ticks),
+			   (unsigned int)div_u64(stat.io_ticks, NSEC_PER_MSEC),
 			   (unsigned int)div_u64(stat.nsecs[STAT_READ] +
 						 stat.nsecs[STAT_WRITE] +
 						 stat.nsecs[STAT_DISCARD] +
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 392aad5e29a2..ce13f47a4674 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -62,7 +62,7 @@ struct hd_struct {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	seqcount_t nr_sects_seq;
 #endif
-	unsigned long stamp;
+	u64 stamp;
 	struct disk_stats __percpu *dkstats;
 	struct percpu_ref ref;
 
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 24125778ef3e..208904b2447d 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -9,7 +9,7 @@ struct disk_stats {
 	unsigned long sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
-	unsigned long io_ticks;
+	u64 io_ticks;
 	local_t in_flight[2];
 };
 
-- 
2.25.1

