Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAED2339AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 22:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgG3Udt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 16:33:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgG3Uds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:33:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UKVk3n092644;
        Thu, 30 Jul 2020 20:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=KDmZ4K839CtgY3+CjQFMFKo0j3KRLrXEcsTbQplB16U=;
 b=QDKBpp6vQGpFA+lv74YyWMhRVGlV+2OYXTzGzT40xCCk+dDJJdgh7lRa4Hv3LBa131YX
 VjIwehKN1mRhUMtUujbz5DMWgF/NJe89orxZJdy0GbIb/Pzr/O6ZbOltSAoqqaezBC1/
 JjcOHyUnf3sKiENlxvQhSNdFWiVZj8uOkc38jzvOhTIgI7EBZD59aXDaK54K4JJIt9bO
 yg/vvJ6u+gI0PWxd++xzoRGGd2wZbw3RNuU61BEMfP2YZCqn7dtX/n2CxHwWJgqwoOh/
 d768FQuwAFkUFcmvtr8JgR4yiYUJJsFl33pSRQRo/U7tqoHa5KXmS0hfnDxr6ccMQkoK nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32hu1jwuh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 20:33:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UKXSNH116512;
        Thu, 30 Jul 2020 20:33:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32hu5xc6t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 20:33:43 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UKXgk8003266;
        Thu, 30 Jul 2020 20:33:43 GMT
Received: from [192.168.1.106] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 13:33:42 -0700
From:   John Donnelly <John.P.donnelly@oracle.com>
Subject: [PATCH v2: [linux-4.14.y] ] dm cache: submit writethrough writes in
 parallel to origin and cache
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     john.p.donnelly@oracle.com, Mike Snitzer <snitzer@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Message-ID: <48659508-86e7-8107-75db-584b2896ad48@oracle.com>
Date:   Thu, 30 Jul 2020 15:33:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=970 mlxscore=0
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=961
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=2 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

Discontinue issuing writethrough write IO in series to the origin and
then cache.

Use bio_clone_fast() to create a new origin clone bio that will be
mapped to the origin device and then bio_chain() it to the bio that gets
remapped to the cache device.  The origin clone bio does _not_ have a
copy of the per_bio_data -- as such check_if_tick_bio_needed() will not
be called.

The cache bio (parent bio) will not complete until the origin bio has
completed -- this fulfills bio_clone_fast()'s requirements as well as
the requirement to not complete the original IO until the write IO has
completed to both the origin and cache device.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>

(cherry picked from commit 2df3bae9a6543e90042291707b8db0cbfbae9ee9)

Fixes: 4ec34f2196d125ff781170ddc6c3058c08ec5e73 (dm bio record:
save/restore bi_end_io and bi_integrity )

4ec34f21 introduced a mkfs.ext4 hang on a LVM device that has been
modified with lvconvert --cachemode=writethrough.

CC:stable@vger.kernel.org for 4.14.x .

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Reviewed-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>

conflicts:
	drivers/md/dm-cache-target.c. -  Corrected usage of
	writethrough_mode(&cache->feature) that was caught by
	compiler, and removed unused static functions : writethrough_endio(),
	defer_writethrough_bio(), wake_deferred_writethrough_worker()
	that generated warnings.
---
  drivers/md/dm-cache-target.c | 94 
++++++++++++++++++--------------------------
  1 file changed, 38 insertions(+), 56 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 69cdb29ef6be..2d9566bfe08b 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1,5 +1,5 @@
  /*
- * Copyright (C) 2012 Red Hat. All rights reserved.
+ i Copyright (C) 2012 Red Hat. All rights reserved.
   *
   * This file is released under the GPL.
   */
@@ -450,6 +450,7 @@ struct cache {
  	struct work_struct migration_worker;
  	struct delayed_work waker;
  	struct dm_bio_prison_v2 *prison;
+	struct bio_set *bs;
   	mempool_t *migration_pool;
  @@ -537,11 +538,6 @@ static void wake_deferred_bio_worker(struct cache 
*cache)
  	queue_work(cache->wq, &cache->deferred_bio_worker);
  }
  -static void wake_deferred_writethrough_worker(struct cache *cache)
-{
-	queue_work(cache->wq, &cache->deferred_writethrough_worker);
-}
-
  static void wake_migration_worker(struct cache *cache)
  {
  	if (passthrough_mode(&cache->features))
@@ -868,16 +864,23 @@ static void check_if_tick_bio_needed(struct cache 
*cache, struct bio *bio)
  	spin_unlock_irqrestore(&cache->lock, flags);
  }
  -static void remap_to_origin_clear_discard(struct cache *cache, struct 
bio *bio,
-					  dm_oblock_t oblock)
+static void __remap_to_origin_clear_discard(struct cache *cache, struct 
bio *bio,
+					    dm_oblock_t oblock, bool bio_has_pbd)
  {
-	// FIXME: this is called way too much.
-	check_if_tick_bio_needed(cache, bio);
+	if (bio_has_pbd)
+		check_if_tick_bio_needed(cache, bio);
  	remap_to_origin(cache, bio);
  	if (bio_data_dir(bio) == WRITE)
  		clear_discard(cache, oblock_to_dblock(cache, oblock));
  }
  +static void remap_to_origin_clear_discard(struct cache *cache, struct 
bio *bio,
+					  dm_oblock_t oblock)
+{
+	// FIXME: check_if_tick_bio_needed() is called way too much through 
this interface
+	__remap_to_origin_clear_discard(cache, bio, oblock, true);
+}
+
  static void remap_to_cache_dirty(struct cache *cache, struct bio *bio,
  				 dm_oblock_t oblock, dm_cblock_t cblock)
  {
@@ -937,57 +940,26 @@ static void issue_op(struct bio *bio, void *context)
  	accounted_request(cache, bio);
  }
  -static void defer_writethrough_bio(struct cache *cache, struct bio *bio)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&cache->lock, flags);
-	bio_list_add(&cache->deferred_writethrough_bios, bio);
-	spin_unlock_irqrestore(&cache->lock, flags);
-
-	wake_deferred_writethrough_worker(cache);
-}
-
-static void writethrough_endio(struct bio *bio)
-{
-	struct per_bio_data *pb = get_per_bio_data(bio, PB_DATA_SIZE_WT);
-
-	dm_unhook_bio(&pb->hook_info, bio);
-
-	if (bio->bi_status) {
-		bio_endio(bio);
-		return;
-	}
-
-	dm_bio_restore(&pb->bio_details, bio);
-	remap_to_cache(pb->cache, bio, pb->cblock);
-
-	/*
-	 * We can't issue this bio directly, since we're in interrupt
-	 * context.  So it gets put on a bio list for processing by the
-	 * worker thread.
-	 */
-	defer_writethrough_bio(pb->cache, bio);
-}
-
  /*
- * FIXME: send in parallel, huge latency as is.
   * When running in writethrough mode we need to send writes to clean 
blocks
- * to both the cache and origin devices.  In future we'd like to clone the
- * bio and send them in parallel, but for now we're doing them in
- * series as this is easier.
+ * to both the cache and origin devices.  Clone the bio and send them 
in parallel.
   */
-static void remap_to_origin_then_cache(struct cache *cache, struct bio 
*bio,
-				       dm_oblock_t oblock, dm_cblock_t cblock)
+static void remap_to_origin_and_cache(struct cache *cache, struct bio *bio,
+				      dm_oblock_t oblock, dm_cblock_t cblock)
  {
-	struct per_bio_data *pb = get_per_bio_data(bio, PB_DATA_SIZE_WT);
+	struct bio *origin_bio = bio_clone_fast(bio, GFP_NOIO, cache->bs);
+
+	BUG_ON(!origin_bio);
  -	pb->cache = cache;
-	pb->cblock = cblock;
-	dm_hook_bio(&pb->hook_info, bio, writethrough_endio, NULL);
-	dm_bio_record(&pb->bio_details, bio);
+	bio_chain(origin_bio, bio);
+	/*
+	 * Passing false to __remap_to_origin_clear_discard() skips
+	 * all code that might use per_bio_data (since clone doesn't have it)
+	 */
+	__remap_to_origin_clear_discard(cache, origin_bio, oblock, false);
+	submit_bio(origin_bio);
  -	remap_to_origin_clear_discard(pb->cache, bio, oblock);
+	remap_to_cache(cache, bio, cblock);
  }
   /*----------------------------------------------------------------
@@ -1873,7 +1845,7 @@ static int map_bio(struct cache *cache, struct bio 
*bio, dm_oblock_t block,
  		} else {
  			if (bio_data_dir(bio) == WRITE && 
writethrough_mode(&cache->features) &&
  			    !is_dirty(cache, cblock)) {
-				remap_to_origin_then_cache(cache, bio, block, cblock);
+				remap_to_origin_and_cache(cache, bio, block, cblock);
  				accounted_begin(cache, bio);
  			} else
  				remap_to_cache_dirty(cache, bio, block, cblock);
@@ -2132,6 +2104,9 @@ static void destroy(struct cache *cache)
  		kfree(cache->ctr_args[i]);
  	kfree(cache->ctr_args);
  +	if (cache->bs)
+		bioset_free(cache->bs);
+
  	kfree(cache);
  }
  @@ -2589,6 +2564,13 @@ static int cache_create(struct cache_args *ca, 
struct cache **result)
  	cache->features = ca->features;
  	ti->per_io_data_size = get_per_bio_data_size(cache);
  +	if (writethrough_mode(&cache->features)) {
+		/* Create bioset for writethrough bios issued to origin */
+		cache->bs = bioset_create(BIO_POOL_SIZE, 0, 0);
+		if (!cache->bs)
+			goto bad;
+	}
+
  	cache->callbacks.congested_fn = cache_is_congested;
  	dm_table_add_target_callbacks(ti->table, &cache->callbacks);
  -- 1.8.3.1

