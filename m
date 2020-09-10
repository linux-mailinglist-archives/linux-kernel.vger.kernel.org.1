Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC39263A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 04:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgIJCg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 22:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbgIJCdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:33:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA64C0617BF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 16:44:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t127so3711854ybf.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Os3da9nFjMt73a4eualiesBSJv78kcIEnxCFYtpLmoI=;
        b=CNfeWydvw+qZ+wnfAvHjkgMhXVOVb1to35ASuzcBPiUvQ5WCQ+3X+k3LWA4wcHMRVD
         1f9B1t5grGRJrS5SSOx9N+Xx5+d6PpP8oYm+RgHEYtymgxMROB+SArKfT9JKR5ZlpL1G
         79OwZhwtWRWIYEqw0E5SsHA+A+xyCoWPZM2mKUMug0caTaxuQfraGVq5AqCQnOqhyC/w
         vn6KlJxvSyX2vqyX/w7ViSaxo/AGTlqdR3rBcyp44B1WHNDDyfvZ4IpXcqsLNrSFrX/0
         SZX2jqAUKDPyQXHMmwq55FxxOC4R50uGmh/PWig7s8MaAwgF/OIpgWgXX8LVCatakten
         w9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Os3da9nFjMt73a4eualiesBSJv78kcIEnxCFYtpLmoI=;
        b=As9ZLXssZNf78JMMeMbl34pugnhE8tVKhZD5Aa4enDEcTUreya/1WuHEB1NgHbWrAM
         /bSU8NeAu0MKGdHFzc4mMO4A9oSERyH6dQlJs5VUaZDt4s++bRGPRCX4XemnHMKFVU0b
         x7XDqkgoKcVUnLp2x7JaVHNOUIFjZBodJpD6OSXe6b8MWHBO8K+7oUomgkI0oxuu8EmN
         G5jqbRJ9KZvCNT37Kl4QnpUqOmdt25h8jeNRFKgjFE8x+1Fj2c62a351sopdju5L1cx2
         1hdVH4eZWKl/R1f+46/MW5bW0A8o0EZEsKJMoRQ7ooBKNQLnKcIjfugGn4geXUkROucV
         WG5Q==
X-Gm-Message-State: AOAM532Dvz5m1pOFxiR6ozbq80wKOo0xZraOYfQjVRXP1+q5DCqxrXY8
        EngljNrmo/F1eryTBaAl8sT9Xyy25K0=
X-Google-Smtp-Source: ABdhPJyzGBo5AelWEpWhdQPgVuFV2CqaWrUEA117nkxG0YAbUHbSqm3664Mi0AjVSR6WwQ9x/bDsUmp8D6M=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2d8e])
 (user=satyat job=sendgmr) by 2002:a5b:bcf:: with SMTP id c15mr9992965ybr.277.1599695072984;
 Wed, 09 Sep 2020 16:44:32 -0700 (PDT)
Date:   Wed,  9 Sep 2020 23:44:21 +0000
In-Reply-To: <20200909234422.76194-1-satyat@google.com>
Message-Id: <20200909234422.76194-3-satyat@google.com>
Mime-Version: 1.0
References: <20200909234422.76194-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 2/3] dm: add support for passing through inline crypto support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Update the device-mapper core to support exposing the inline crypto
support of the underlying device(s) through the device-mapper device.

This works by creating a "passthrough keyslot manager" for the dm
device, which declares support for encryption settings which all
underlying devices support.  When a supported setting is used, the bio
cloning code handles cloning the crypto context to the bios for all the
underlying devices.  When an unsupported setting is used, the blk-crypto
fallback is used as usual.

Crypto support on each underlying device is ignored unless the
corresponding dm target opts into exposing it.  This is needed because
for inline crypto to semantically operate on the original bio, the data
must not be transformed by the dm target.  Thus, targets like dm-linear
can expose crypto support of the underlying device, but targets like
dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)

When a key is evicted from the dm device, it is evicted from all
underlying devices.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto.c              |  1 +
 block/keyslot-manager.c         | 34 ++++++++++++
 drivers/md/dm-core.h            |  4 ++
 drivers/md/dm-table.c           | 52 +++++++++++++++++++
 drivers/md/dm.c                 | 92 ++++++++++++++++++++++++++++++++-
 include/linux/device-mapper.h   |  6 +++
 include/linux/keyslot-manager.h |  7 +++
 7 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 2d5e60023b08..33555cf0e3e7 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -402,3 +402,4 @@ int blk_crypto_evict_key(struct request_queue *q,
 	 */
 	return blk_crypto_fallback_evict_key(key);
 }
+EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 60ac406d54b9..e0f776c38d8a 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -416,6 +416,40 @@ void blk_ksm_unregister(struct request_queue *q)
 {
 	q->ksm = NULL;
 }
+EXPORT_SYMBOL_GPL(blk_ksm_unregister);
+
+/**
+ * blk_ksm_intersect_modes() - restrict supported modes by child device
+ * @parent: The keyslot manager for parent device
+ * @child: The keyslot manager for child device, or NULL
+ *
+ * Clear any crypto mode support bits in @parent that aren't set in @child.
+ * If @child is NULL, then all parent bits are cleared.
+ *
+ * Only use this when setting up the keyslot manager for a layered device,
+ * before it's been exposed yet.
+ */
+void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
+			     const struct blk_keyslot_manager *child)
+{
+	if (child) {
+		unsigned int i;
+
+		parent->max_dun_bytes_supported =
+			min(parent->max_dun_bytes_supported,
+			    child->max_dun_bytes_supported);
+		for (i = 0; i < ARRAY_SIZE(child->crypto_modes_supported);
+		     i++) {
+			parent->crypto_modes_supported[i] &=
+				child->crypto_modes_supported[i];
+		}
+	} else {
+		parent->max_dun_bytes_supported = 0;
+		memset(parent->crypto_modes_supported, 0,
+		       sizeof(parent->crypto_modes_supported));
+	}
+}
+EXPORT_SYMBOL_GPL(blk_ksm_intersect_modes);
 
 /**
  * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index c4ef1fceead6..4542050eebfc 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -12,6 +12,7 @@
 #include <linux/kthread.h>
 #include <linux/ktime.h>
 #include <linux/blk-mq.h>
+#include <linux/keyslot-manager.h>
 
 #include <trace/events/block.h>
 
@@ -49,6 +50,9 @@ struct mapped_device {
 
 	int numa_node_id;
 	struct request_queue *queue;
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	struct blk_keyslot_manager ksm;
+#endif
 
 	atomic_t holders;
 	atomic_t open_count;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 5edc3079e7c1..09ad65e582a8 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -21,6 +21,8 @@
 #include <linux/blk-mq.h>
 #include <linux/mount.h>
 #include <linux/dax.h>
+#include <linux/bio.h>
+#include <linux/keyslot-manager.h>
 
 #define DM_MSG_PREFIX "table"
 
@@ -1579,6 +1581,54 @@ static void dm_table_verify_integrity(struct dm_table *t)
 	}
 }
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+static int device_intersect_crypto_modes(struct dm_target *ti,
+					 struct dm_dev *dev, sector_t start,
+					 sector_t len, void *data)
+{
+	struct blk_keyslot_manager *parent = data;
+	struct blk_keyslot_manager *child = bdev_get_queue(dev->bdev)->ksm;
+
+	blk_ksm_intersect_modes(parent, child);
+	return 0;
+}
+
+/*
+ * Update the inline crypto modes supported by 'q->ksm' to be the intersection
+ * of the modes supported by all targets in the table.
+ *
+ * For any mode to be supported at all, all targets must have explicitly
+ * declared that they can pass through inline crypto support.  For a particular
+ * mode to be supported, all underlying devices must also support it.
+ *
+ * Assume that 'q->ksm' initially declares all modes to be supported.
+ */
+static void dm_calculate_supported_crypto_modes(struct dm_table *t,
+						struct request_queue *q)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->may_passthrough_inline_crypto) {
+			blk_ksm_intersect_modes(q->ksm, NULL);
+			return;
+		}
+		if (!ti->type->iterate_devices)
+			continue;
+		ti->type->iterate_devices(ti, device_intersect_crypto_modes,
+					  q->ksm);
+	}
+}
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+static inline void dm_calculate_supported_crypto_modes(struct dm_table *t,
+						       struct request_queue *q)
+{
+}
+#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
+
 static int device_flush_capable(struct dm_target *ti, struct dm_dev *dev,
 				sector_t start, sector_t len, void *data)
 {
@@ -1895,6 +1945,8 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 
 	dm_table_verify_integrity(t);
 
+	dm_calculate_supported_crypto_modes(t, q);
+
 	/*
 	 * Some devices don't use blk_integrity but still want stable pages
 	 * because they do their own checksumming.
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fb0255d25e4b..9cfc2b63323d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -28,6 +28,7 @@
 #include <linux/refcount.h>
 #include <linux/part_stat.h>
 #include <linux/blk-crypto.h>
+#include <linux/keyslot-manager.h>
 
 #define DM_MSG_PREFIX "core"
 
@@ -1869,6 +1870,8 @@ static const struct dax_operations dm_dax_ops;
 
 static void dm_wq_work(struct work_struct *work);
 
+static void dm_destroy_inline_encryption(struct request_queue *q);
+
 static void cleanup_mapped_device(struct mapped_device *md)
 {
 	if (md->wq)
@@ -1890,8 +1893,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		put_disk(md->disk);
 	}
 
-	if (md->queue)
+	if (md->queue) {
+		dm_destroy_inline_encryption(md->queue);
 		blk_cleanup_queue(md->queue);
+	}
 
 	cleanup_srcu_struct(&md->io_barrier);
 
@@ -2253,6 +2258,88 @@ struct queue_limits *dm_get_queue_limits(struct mapped_device *md)
 }
 EXPORT_SYMBOL_GPL(dm_get_queue_limits);
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+struct dm_keyslot_evict_args {
+	const struct blk_crypto_key *key;
+	int err;
+};
+
+static int dm_keyslot_evict_callback(struct dm_target *ti, struct dm_dev *dev,
+				     sector_t start, sector_t len, void *data)
+{
+	struct dm_keyslot_evict_args *args = data;
+	int err;
+
+	err = blk_crypto_evict_key(bdev_get_queue(dev->bdev), args->key);
+	if (!args->err)
+		args->err = err;
+	/* Always try to evict the key from all devices. */
+	return 0;
+}
+
+/*
+ * When an inline encryption key is evicted from a device-mapper device, evict
+ * it from all the underlying devices.
+ */
+static int dm_keyslot_evict(struct blk_keyslot_manager *ksm,
+			    const struct blk_crypto_key *key, unsigned int slot)
+{
+	struct mapped_device *md = container_of(ksm, struct mapped_device, ksm);
+	struct dm_keyslot_evict_args args = { key };
+	struct dm_table *t;
+	int srcu_idx;
+	int i;
+	struct dm_target *ti;
+
+	t = dm_get_live_table(md, &srcu_idx);
+	if (!t)
+		return 0;
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+		if (!ti->type->iterate_devices)
+			continue;
+		ti->type->iterate_devices(ti, dm_keyslot_evict_callback, &args);
+	}
+	dm_put_live_table(md, srcu_idx);
+	return args.err;
+}
+
+static struct blk_ksm_ll_ops dm_ksm_ll_ops = {
+	.keyslot_evict = dm_keyslot_evict,
+};
+
+static void dm_init_inline_encryption(struct mapped_device *md)
+{
+	blk_ksm_init_passthrough(&md->ksm);
+	md->ksm.ksm_ll_ops = dm_ksm_ll_ops;
+
+	/*
+	 * Initially declare support for all crypto settings. Anything
+	 * unsupported by a child device will be removed later when calculating
+	 * the device restrictions.
+	 */
+	md->ksm.max_dun_bytes_supported = UINT_MAX;
+	memset(md->ksm.crypto_modes_supported, 0xFF,
+	       sizeof(md->ksm.crypto_modes_supported));
+
+	blk_ksm_register(&md->ksm, md->queue);
+}
+
+static void dm_destroy_inline_encryption(struct request_queue *q)
+{
+	blk_ksm_destroy(q->ksm);
+	blk_ksm_unregister(q);
+}
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+static inline void dm_init_inline_encryption(struct mapped_device *md)
+{
+}
+
+static inline void dm_destroy_inline_encryption(struct request_queue *q)
+{
+}
+#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
+
 /*
  * Setup the DM device's queue based on md's type
  */
@@ -2284,6 +2371,9 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 		DMERR("Cannot calculate initial queue limits");
 		return r;
 	}
+
+	dm_init_inline_encryption(md);
+
 	dm_table_set_restrictions(t, md->queue, &limits);
 	blk_register_queue(md->disk);
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 93096e524e43..104f364866f9 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -320,6 +320,12 @@ struct dm_target {
 	 * whether or not its underlying devices have support.
 	 */
 	bool discards_supported:1;
+
+	/*
+	 * Set if inline crypto capabilities from this target's underlying
+	 * device(s) can be exposed via the device-mapper device.
+	 */
+	bool may_passthrough_inline_crypto:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 323e15dd6fa7..bfe7f35da4a8 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -9,6 +9,8 @@
 #include <linux/bio.h>
 #include <linux/blk-crypto.h>
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
 struct blk_keyslot_manager;
 
 /**
@@ -103,6 +105,11 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
+			     const struct blk_keyslot_manager *child);
+
 void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
 
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.28.0.618.gf4bc123cb7-goog

