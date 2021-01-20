Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF92FD122
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbhATNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389679AbhATMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:19:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC2C0613CF;
        Wed, 20 Jan 2021 04:18:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s15so12416956plr.9;
        Wed, 20 Jan 2021 04:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mqAhlazB0SRDyqFw9Uz/8oCO5pD/0R05kZThxcmH60=;
        b=u1f60RJ67haSYTi8zoiDv7XeaScUzURB95gPu/mg2R03NX2D40lzZ73EReLAhR8Uke
         /jW9y4d5qHXxdoS5kvbFIM+uMn9dEG6v3DqvBcDWg6OkGSX9CKq0fj10q7SSHlk+WLl7
         cmj+6kPiDD+ixI3VxIWFV7WViIWFUQY+4aB0QGIqwhwrjHtN0ovDIOLGojz/nIZJkKRj
         th7zmB7APsDrhN3T6mJlD0L9G12OBhmNEcTd00KkYgX4NG5/EoqFNAR/S4ITwAd7KomN
         vADC6tvs5TWGPxBckaAbuFpsmzdiShnX7DNpRYJvGYCAq/9EIP9viCWY0ZHgDz8oaX2/
         iCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mqAhlazB0SRDyqFw9Uz/8oCO5pD/0R05kZThxcmH60=;
        b=tbPGpHsE4pa3pwX9N44sZH4QyBpGGyMzt80gtvTwSnhwt6RUICYXBGa/yeUEfeO6lF
         6QiCTXYzmJj/rcUvj6Y1gJb4gQBdudnx1/UWXT80xgktaEzBlDdztRg41eHmb3HOUn5J
         Kp8gKJEFjfBAyUjMB4k60oDDW562dJCulGUCO1IlVpA7Yj6BT0BV36kFGI1Iw9IlFoFf
         yS25gKtdTZROnHjmWHbh5G8nVHW6UXBowolQLa7WhYE3KQpud32Oowi8NvdFe2JPiHU/
         llk7lSzeQKqil7n/Z/c7361CM8UmhJbXeR2ZKwmHydGXXKPp21HayD/Y2kvi6MmymK6H
         b/4g==
X-Gm-Message-State: AOAM5308Uw7zpThDlaexQiquQgBs4gUQxzztD2uIkvnEZV5Ftw0bpREk
        FBL4/ONCPBkpApugJGHQz/A=
X-Google-Smtp-Source: ABdhPJyJREkYeJ4+gjaFDER5NGBPywqsNMtITYNjL0YaVV9llFiWiPkBPf1GR+KImIcgF/nVZKzT+w==
X-Received: by 2002:a17:90a:46cd:: with SMTP id x13mr3886196pjg.194.1611145122339;
        Wed, 20 Jan 2021 04:18:42 -0800 (PST)
Received: from localhost.localdomain ([45.77.27.82])
        by smtp.gmail.com with ESMTPSA id w1sm2431693pjt.23.2021.01.20.04.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:18:41 -0800 (PST)
From:   Dongdong Tao <tdd21151186@gmail.com>
To:     colyli@suse.de
Cc:     dongdong tao <dongdong.tao@canonical.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] bcache: consider the fragmentation when update the writeback rate
Date:   Wed, 20 Jan 2021 20:01:52 +0800
Message-Id: <20210120120153.3782-1-tdd21151186@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dongdong tao <dongdong.tao@canonical.com>

Current way to calculate the writeback rate only considered the
dirty sectors, this usually works fine when the fragmentation
is not high, but it will give us unreasonable small rate when
we are under a situation that very few dirty sectors consumed
a lot dirty buckets. In some case, the dirty bucekts can reached
to CUTOFF_WRITEBACK_SYNC while the dirty data(sectors) not even
reached the writeback_percent, the writeback rate will still
be the minimum value (4k), thus it will cause all the writes to be
stucked in a non-writeback mode because of the slow writeback.

We accelerate the rate in 3 stages with different aggressiveness,
the first stage starts when dirty buckets percent reach above
BCH_WRITEBACK_FRAGMENT_THRESHOLD_LOW (50), the second is
BCH_WRITEBACK_FRAGMENT_THRESHOLD_MID (57), the third is
BCH_WRITEBACK_FRAGMENT_THRESHOLD_HIGH (64). By default
the first stage tries to writeback the amount of dirty data
in one bucket (on average) in (1 / (dirty_buckets_percent - 50)) second,
the second stage tries to writeback the amount of dirty data in one bucket
in (1 / (dirty_buckets_percent - 57)) * 100 millisecond, the third
stage tries to writeback the amount of dirty data in one bucket in
(1 / (dirty_buckets_percent - 64)) millisecond.

the initial rate at each stage can be controlled by 3 configurable
parameters writeback_rate_fp_term_{low|mid|high}, they are by default
1, 10, 1000, the hint of IO throughput that these values are trying
to achieve is described by above paragraph, the reason that
I choose those value as default is based on the testing and the
production data, below is some details:

A. When it comes to the low stage, there is still a bit far from the 70
   threshold, so we only want to give it a little bit push by setting the
   term to 1, it means the initial rate will be 170 if the fragment is 6,
   it is calculated by bucket_size/fragment, this rate is very small,
   but still much reasonable than the minimum 8.
   For a production bcache with unheavy workload, if the cache device
   is bigger than 1 TB, it may take hours to consume 1% buckets,
   so it is very possible to reclaim enough dirty buckets in this stage,
   thus to avoid entering the next stage.

B. If the dirty buckets ratio didn’t turn around during the first stage,
   it comes to the mid stage, then it is necessary for mid stage
   to be more aggressive than low stage, so i choose the initial rate
   to be 10 times more than low stage, that means 1700 as the initial
   rate if the fragment is 6. This is some normal rate
   we usually see for a normal workload when writeback happens
   because of writeback_percent.

C. If the dirty buckets ratio didn't turn around during the low and mid
   stages, it comes to the third stage, and it is the last chance that
   we can turn around to avoid the horrible cutoff writeback sync issue,
   then we choose 100 times more aggressive than the mid stage, that
   means 170000 as the initial rate if the fragment is 6. This is also
   inferred from a production bcache, I've got one week's writeback rate
   data from a production bcache which has quite heavy workloads,
   again, the writeback is trigged by the writeback percent,
   the highest rate area is around 100000 to 240000, so I believe this
   kind aggressiveness at this stage is reasonable for production.
   And it should be mostly enough because the hint is trying to reclaim
   1000 bucket per second, and from that heavy production env,
   it is consuming 50 bucket per second on avarage in one week's data.

Option writeback_consider_fragment is to control whether we want
this feature to be on or off, it's on by default.

Lastly, below is the performance data for all the testing result,
including the data from production env:
https://docs.google.com/document/d/
1AmbIEa_2MhB9bqhC3rfga9tp7n9YX9PLn0jSUxscVW0/edit?usp=sharing

Signed-off-by: dongdong tao <dongdong.tao@canonical.com>
---
 drivers/md/bcache/bcache.h    |  4 ++++
 drivers/md/bcache/sysfs.c     | 23 +++++++++++++++++++
 drivers/md/bcache/writeback.c | 42 +++++++++++++++++++++++++++++++++++
 drivers/md/bcache/writeback.h |  4 ++++
 4 files changed, 73 insertions(+)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 1d57f48307e6..d7a84327b7f1 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -373,6 +373,7 @@ struct cached_dev {
 	unsigned int		partial_stripes_expensive:1;
 	unsigned int		writeback_metadata:1;
 	unsigned int		writeback_running:1;
+	unsigned int		writeback_consider_fragment:1;
 	unsigned char		writeback_percent;
 	unsigned int		writeback_delay;
 
@@ -385,6 +386,9 @@ struct cached_dev {
 	unsigned int		writeback_rate_update_seconds;
 	unsigned int		writeback_rate_i_term_inverse;
 	unsigned int		writeback_rate_p_term_inverse;
+	unsigned int		writeback_rate_fp_term_low;
+	unsigned int		writeback_rate_fp_term_mid;
+	unsigned int		writeback_rate_fp_term_high;
 	unsigned int		writeback_rate_minimum;
 
 	enum stop_on_failure	stop_when_cache_set_failed;
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 00a520c03f41..eef15f8022ba 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -117,10 +117,14 @@ rw_attribute(writeback_running);
 rw_attribute(writeback_percent);
 rw_attribute(writeback_delay);
 rw_attribute(writeback_rate);
+rw_attribute(writeback_consider_fragment);
 
 rw_attribute(writeback_rate_update_seconds);
 rw_attribute(writeback_rate_i_term_inverse);
 rw_attribute(writeback_rate_p_term_inverse);
+rw_attribute(writeback_rate_fp_term_low);
+rw_attribute(writeback_rate_fp_term_mid);
+rw_attribute(writeback_rate_fp_term_high);
 rw_attribute(writeback_rate_minimum);
 read_attribute(writeback_rate_debug);
 
@@ -195,6 +199,7 @@ SHOW(__bch_cached_dev)
 	var_printf(bypass_torture_test,	"%i");
 	var_printf(writeback_metadata,	"%i");
 	var_printf(writeback_running,	"%i");
+	var_printf(writeback_consider_fragment,	"%i");
 	var_print(writeback_delay);
 	var_print(writeback_percent);
 	sysfs_hprint(writeback_rate,
@@ -205,6 +210,9 @@ SHOW(__bch_cached_dev)
 	var_print(writeback_rate_update_seconds);
 	var_print(writeback_rate_i_term_inverse);
 	var_print(writeback_rate_p_term_inverse);
+	var_print(writeback_rate_fp_term_low);
+	var_print(writeback_rate_fp_term_mid);
+	var_print(writeback_rate_fp_term_high);
 	var_print(writeback_rate_minimum);
 
 	if (attr == &sysfs_writeback_rate_debug) {
@@ -303,6 +311,7 @@ STORE(__cached_dev)
 	sysfs_strtoul_bool(bypass_torture_test, dc->bypass_torture_test);
 	sysfs_strtoul_bool(writeback_metadata, dc->writeback_metadata);
 	sysfs_strtoul_bool(writeback_running, dc->writeback_running);
+	sysfs_strtoul_bool(writeback_consider_fragment, dc->writeback_consider_fragment);
 	sysfs_strtoul_clamp(writeback_delay, dc->writeback_delay, 0, UINT_MAX);
 
 	sysfs_strtoul_clamp(writeback_percent, dc->writeback_percent,
@@ -331,6 +340,16 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_p_term_inverse,
 			    dc->writeback_rate_p_term_inverse,
 			    1, UINT_MAX);
+	sysfs_strtoul_clamp(writeback_rate_fp_term_low,
+			    dc->writeback_rate_fp_term_low,
+			    1, dc->writeback_rate_fp_term_mid - 1);
+	sysfs_strtoul_clamp(writeback_rate_fp_term_mid,
+			    dc->writeback_rate_fp_term_mid,
+			    dc->writeback_rate_fp_term_low + 1,
+			    dc->writeback_rate_fp_term_high - 1);
+	sysfs_strtoul_clamp(writeback_rate_fp_term_high,
+			    dc->writeback_rate_fp_term_high,
+			    dc->writeback_rate_fp_term_mid + 1, UINT_MAX);
 	sysfs_strtoul_clamp(writeback_rate_minimum,
 			    dc->writeback_rate_minimum,
 			    1, UINT_MAX);
@@ -499,9 +518,13 @@ static struct attribute *bch_cached_dev_files[] = {
 	&sysfs_writeback_delay,
 	&sysfs_writeback_percent,
 	&sysfs_writeback_rate,
+	&sysfs_writeback_consider_fragment,
 	&sysfs_writeback_rate_update_seconds,
 	&sysfs_writeback_rate_i_term_inverse,
 	&sysfs_writeback_rate_p_term_inverse,
+	&sysfs_writeback_rate_fp_term_low,
+	&sysfs_writeback_rate_fp_term_mid,
+	&sysfs_writeback_rate_fp_term_high,
 	&sysfs_writeback_rate_minimum,
 	&sysfs_writeback_rate_debug,
 	&sysfs_io_errors,
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index a129e4d2707c..82d4e0880a99 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -88,6 +88,44 @@ static void __update_writeback_rate(struct cached_dev *dc)
 	int64_t integral_scaled;
 	uint32_t new_rate;
 
+	/*
+	 * We need to consider the number of dirty buckets as well
+	 * when calculating the proportional_scaled, Otherwise we might
+	 * have an unreasonable small writeback rate at a highly fragmented situation
+	 * when very few dirty sectors consumed a lot dirty buckets, the
+	 * worst case is when dirty buckets reached cutoff_writeback_sync and
+	 * dirty data is still not even reached to writeback percent, so the rate
+	 * still will be at the minimum value, which will cause the write
+	 * stuck at a non-writeback mode.
+	 */
+	struct cache_set *c = dc->disk.c;
+
+	int64_t dirty_buckets = c->nbuckets - c->avail_nbuckets;
+
+	if (dc->writeback_consider_fragment &&
+		c->gc_stats.in_use > BCH_WRITEBACK_FRAGMENT_THRESHOLD_LOW && dirty > 0) {
+		int64_t fragment =
+			div_s64((dirty_buckets *  c->cache->sb.bucket_size), dirty);
+		int64_t fp_term;
+		int64_t fps;
+
+		if (c->gc_stats.in_use <= BCH_WRITEBACK_FRAGMENT_THRESHOLD_MID) {
+			fp_term = dc->writeback_rate_fp_term_low *
+			(c->gc_stats.in_use - BCH_WRITEBACK_FRAGMENT_THRESHOLD_LOW);
+		} else if (c->gc_stats.in_use <= BCH_WRITEBACK_FRAGMENT_THRESHOLD_HIGH) {
+			fp_term = dc->writeback_rate_fp_term_mid *
+			(c->gc_stats.in_use - BCH_WRITEBACK_FRAGMENT_THRESHOLD_MID);
+		} else {
+			fp_term = dc->writeback_rate_fp_term_high *
+			(c->gc_stats.in_use - BCH_WRITEBACK_FRAGMENT_THRESHOLD_HIGH);
+		}
+		fps = div_s64(dirty, dirty_buckets) * fp_term;
+		if (fragment > 3 && fps > proportional_scaled) {
+			/* Only overrite the p when fragment > 3 */
+			proportional_scaled = fps;
+		}
+	}
+
 	if ((error < 0 && dc->writeback_rate_integral > 0) ||
 	    (error > 0 && time_before64(local_clock(),
 			 dc->writeback_rate.next + NSEC_PER_MSEC))) {
@@ -977,6 +1015,7 @@ void bch_cached_dev_writeback_init(struct cached_dev *dc)
 
 	dc->writeback_metadata		= true;
 	dc->writeback_running		= false;
+	dc->writeback_consider_fragment = true;
 	dc->writeback_percent		= 10;
 	dc->writeback_delay		= 30;
 	atomic_long_set(&dc->writeback_rate.rate, 1024);
@@ -984,6 +1023,9 @@ void bch_cached_dev_writeback_init(struct cached_dev *dc)
 
 	dc->writeback_rate_update_seconds = WRITEBACK_RATE_UPDATE_SECS_DEFAULT;
 	dc->writeback_rate_p_term_inverse = 40;
+	dc->writeback_rate_fp_term_low = 1;
+	dc->writeback_rate_fp_term_mid = 10;
+	dc->writeback_rate_fp_term_high = 1000;
 	dc->writeback_rate_i_term_inverse = 10000;
 
 	WARN_ON(test_and_clear_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags));
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index 3f1230e22de0..02b2f9df73f6 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -16,6 +16,10 @@
 
 #define BCH_AUTO_GC_DIRTY_THRESHOLD	50
 
+#define BCH_WRITEBACK_FRAGMENT_THRESHOLD_LOW 50
+#define BCH_WRITEBACK_FRAGMENT_THRESHOLD_MID 57
+#define BCH_WRITEBACK_FRAGMENT_THRESHOLD_HIGH 64
+
 #define BCH_DIRTY_INIT_THRD_MAX	64
 /*
  * 14 (16384ths) is chosen here as something that each backing device
-- 
2.17.1

