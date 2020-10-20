Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC628FAD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgJOVq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbgJOVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:46:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:46:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l23so533504ybl.23
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Xpv963PJoR/Q9u54qgIX7lQfjSvh4ubpqrXt/Pc8BU0=;
        b=Su4wRPphTCrlbOf0Twbj6JK5xBjftH+HlspeG8WiApQFV9dQsR80hEBEX5K50HJWYJ
         gEas0QMd0ygwjFkXpAJ4sQp3L05LEeALEYJqxtVkG210Q4ngfSAMyQ6cKHP/PQz4yNCh
         WGd38wdYNlhlImJVIkl1EThuSL6loIrwbVSmtiUf+ql/ElkMsJ0XlikHECKWBMjK5T6n
         eRUhMF/uhX73Znt+X+x1XAKqEwEjmnniL6snvele/CZ1WTfOBbzHvTq2UJiV39kuSkvE
         pOPbnvP71Xb9Kcv+WBiU5Q6c7lal531Dve0vf3yA2nhkGWImDj8Lnb9VZ20Mo1wgfrPD
         WuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xpv963PJoR/Q9u54qgIX7lQfjSvh4ubpqrXt/Pc8BU0=;
        b=FNGSuzv57nY0AtGKcrA8zbIqkugKBFtOIeNU/8Ug3g3K7yd7QT2vTq6sf3/ni7n+to
         IZ1omcFh4ZUHlMF15mXu/dCPy9PgqV69iiOm7zYS8i5KPPDqAAkcjNBMWXczMTU24Fj7
         4dYZAtjQUefDT4f5Bt0+BktX7YBh/I4SC26SFTpxmdQffV4sZhT1ReI1OgVopqZ2y0YB
         XB4+eLKSBwY5j0vAPIgi//GETL7BadBBofJyUmlCmze2eiXPb4YiGVUVAX2xCpvG/8kp
         P+PGxiu17gi+qOsDQlG1BdZw4flbkS+BUmaH0k3P+1KvmI0fP8BrWOHRvlMv6bx88ZUh
         eBjQ==
X-Gm-Message-State: AOAM530viWbZ57ZK53nO3LnpV6el44GN8HKImaGnvWA0v5Xy9lUMVifI
        Eh/U/Kd0O4dIlRSXZ5LvfFNI8Wp/UU4=
X-Google-Smtp-Source: ABdhPJxK+5fYwBvzgWRN7AaEe1trxo3iT7pOH1LISxoJKM04a6kzs6z031Ebk8WaNSI5syNgC+EIXnB0goM=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:909:: with SMTP id 9mr654744ybj.460.1602798404092;
 Thu, 15 Oct 2020 14:46:44 -0700 (PDT)
Date:   Thu, 15 Oct 2020 21:46:31 +0000
In-Reply-To: <20201015214632.41951-1-satyat@google.com>
Message-Id: <20201015214632.41951-4-satyat@google.com>
Mime-Version: 1.0
References: <20201015214632.41951-1-satyat@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 3/4] dm: add support for passing through inline crypto support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

A DM device's table can only be changed if the "new" inline encryption
capabilities are a superset of the "old" inline encryption capabilities.
Attempts to make changes to the table that result in some inline encryption
capability becoming no longer supported will be rejected.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto.c              |   1 +
 block/keyslot-manager.c         |  89 +++++++++++++
 drivers/md/dm-ioctl.c           |   8 ++
 drivers/md/dm.c                 | 217 +++++++++++++++++++++++++++++++-
 drivers/md/dm.h                 |  19 +++
 include/linux/device-mapper.h   |   6 +
 include/linux/keyslot-manager.h |  17 +++
 7 files changed, 356 insertions(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 5da43f0973b4..c2be8f15006c 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -409,3 +409,4 @@ int blk_crypto_evict_key(struct request_queue *q,
 	 */
 	return blk_crypto_fallback_evict_key(key);
 }
+EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 5ad476dafeab..e16e4a074765 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -416,6 +416,95 @@ void blk_ksm_unregister(struct request_queue *q)
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
+
+/**
+ * blk_ksm_is_superset() - Check if a KSM supports a superset of crypto modes
+ *			   and DUN bytes that another KSM supports.
+ * @ksm_superset: The KSM that we want to verify is a superset
+ * @ksm_subset: The KSM that we want to verify is a subset
+ *
+ * Return: True if @ksm_superset supports a superset of the crypto modes and DUN
+ *	   bytes that @ksm_subset supports.
+ */
+bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
+			 struct blk_keyslot_manager *ksm_subset)
+{
+	int i;
+
+	if (!ksm_subset)
+		return true;
+
+	if (!ksm_superset)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(ksm_superset->crypto_modes_supported); i++) {
+		if (ksm_subset->crypto_modes_supported[i] &
+		    (~ksm_superset->crypto_modes_supported[i])) {
+			return false;
+		}
+	}
+
+	if (ksm_subset->max_dun_bytes_supported >
+	    ksm_superset->max_dun_bytes_supported) {
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_is_superset);
+
+/**
+ * blk_ksm_update_capabilities() - Update the restrictions of a KSM to those of
+ *				   another KSM
+ * @target_ksm: The KSM whose restrictions to update.
+ * @reference_ksm: The KSM to whose restrictions this function will update
+ *		   @target_ksm's restrictions to,
+ */
+void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
+				 struct blk_keyslot_manager *reference_ksm)
+{
+	memcpy(target_ksm->crypto_modes_supported,
+	       reference_ksm->crypto_modes_supported,
+	       sizeof(target_ksm->crypto_modes_supported));
+
+	target_ksm->max_dun_bytes_supported =
+				reference_ksm->max_dun_bytes_supported;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_update_capabilities);
 
 /**
  * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index cd0478d44058..2b3efa9f9fae 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1358,6 +1358,10 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 		goto err_unlock_md_type;
 	}
 
+	r = dm_verify_inline_encryption(md, t);
+	if (r)
+		goto err_unlock_md_type;
+
 	if (dm_get_md_type(md) == DM_TYPE_NONE) {
 		/* Initial table load: acquire type of table. */
 		dm_set_md_type(md, dm_table_get_type(t));
@@ -2114,6 +2118,10 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 	if (r)
 		goto err_destroy_table;
 
+	r = dm_verify_inline_encryption(md, t);
+	if (r)
+		goto err_destroy_table;
+
 	md->type = dm_table_get_type(t);
 	/* setup md->queue to reflect md's type (may block) */
 	r = dm_setup_md_queue(md, t);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c18fc2548518..22bb2c90583d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -28,6 +28,7 @@
 #include <linux/refcount.h>
 #include <linux/part_stat.h>
 #include <linux/blk-crypto.h>
+#include <linux/keyslot-manager.h>
 
 #define DM_MSG_PREFIX "core"
 
@@ -1721,6 +1722,8 @@ static const struct dax_operations dm_dax_ops;
 
 static void dm_wq_work(struct work_struct *work);
 
+static void dm_destroy_inline_encryption(struct mapped_device *md);
+
 static void cleanup_mapped_device(struct mapped_device *md)
 {
 	if (md->wq)
@@ -1742,8 +1745,10 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		put_disk(md->disk);
 	}
 
-	if (md->queue)
+	if (md->queue) {
+		dm_destroy_inline_encryption(md);
 		blk_cleanup_queue(md->queue);
+	}
 
 	cleanup_srcu_struct(&md->io_barrier);
 
@@ -1949,6 +1954,206 @@ static void event_callback(void *context)
 	dm_issue_global_event();
 }
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
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
+	struct mapped_device *md = ksm->priv;
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
+ * Constructs and returns a keyslot manager that represents the crypto
+ * capabilities of the devices described by the dm_table. However, if the
+ * constructed keyslot manager does not support a superset of the crypto
+ * capabilities supported by the currect keyslot manager of the mapped_device,
+ * it returns an error instead, since we don't support restricting crypto
+ * capabilities on table changes.
+ */
+static struct blk_keyslot_manager *
+dm_init_inline_encryption(struct mapped_device *md, struct dm_table *t)
+{
+	struct blk_keyslot_manager *ksm;
+	struct dm_target *ti;
+	unsigned int i;
+
+	ksm = kmalloc(sizeof(*ksm), GFP_KERNEL);
+	if (!ksm)
+		return ERR_PTR(-EINVAL);
+	blk_ksm_init_passthrough(ksm);
+	ksm->ksm_ll_ops = dm_ksm_ll_ops;
+	ksm->max_dun_bytes_supported = UINT_MAX;
+	memset(ksm->crypto_modes_supported, 0xFF,
+	       sizeof(ksm->crypto_modes_supported));
+	ksm->priv = md;
+
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->may_passthrough_inline_crypto) {
+			blk_ksm_intersect_modes(ksm, NULL);
+			break;
+		}
+		if (!ti->type->iterate_devices)
+			continue;
+		ti->type->iterate_devices(ti, device_intersect_crypto_modes,
+					  ksm);
+	}
+
+	if (!blk_ksm_is_superset(ksm, md->queue->ksm)) {
+		DMWARN("Inline encryption capabilities of new DM table were more restrictive than the old table's. This is not supported!");
+		blk_ksm_destroy(ksm);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	return ksm;
+}
+
+/**
+ * dm_verify_inline_encryption() - Verifies that the current keyslot manager of
+ *				   the mapped_device can be replaced by the
+ *				   keyslot manager of a given dm_table.
+ * @md: The mapped_device
+ * @t: The dm_table
+ *
+ * In particular, this function checks that the keyslot manager that will be
+ * constructed for the dm_table will support a superset of the capabilities that
+ * the current keyslot manager of the mapped_device supports.
+ *
+ * Return: 0 if the table's keyslot_manager can replace the current keyslot
+ *	   manager of the mapped_device. Negative value otherwise.
+ */
+int dm_verify_inline_encryption(struct mapped_device *md, struct dm_table *t)
+{
+	struct blk_keyslot_manager *ksm = dm_init_inline_encryption(md, t);
+
+	if (IS_ERR(ksm))
+		return PTR_ERR(ksm);
+	blk_ksm_destroy(ksm);
+
+	return 0;
+}
+
+static void dm_update_keyslot_manager(struct mapped_device *md,
+				      struct blk_keyslot_manager *ksm)
+{
+	bool ksm_is_empty = true;
+	int i;
+
+	/*
+	 * If the new KSM doesn't actually support any crypto modes, we may as
+	 * well set a NULL ksm.
+	 */
+	ksm_is_empty = true;
+	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
+		if (ksm->crypto_modes_supported[i]) {
+			ksm_is_empty = false;
+			break;
+		}
+	}
+
+	if (ksm_is_empty) {
+		blk_ksm_destroy(ksm);
+
+		/* At this point, md->queue->ksm must also be NULL, since we're
+		 * guaranteed that ksm is a superset of md->queue->ksm, and we
+		 * never set md->queue->ksm to a non-null empty ksm.
+		 */
+		if (WARN_ON(md->queue->ksm))
+			blk_ksm_register(NULL, md->queue);
+		return;
+	}
+
+	/* Make the ksm less restrictive */
+	if (!md->queue->ksm) {
+		blk_ksm_register(ksm, md->queue);
+	} else {
+		blk_ksm_update_capabilities(md->queue->ksm, ksm);
+		blk_ksm_destroy(ksm);
+	}
+}
+
+static void dm_destroy_inline_encryption(struct mapped_device *md)
+{
+	if (!md->queue->ksm)
+		return;
+	blk_ksm_destroy(md->queue->ksm);
+	blk_ksm_unregister(md->queue);
+}
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline struct blk_keyslot_manager *
+dm_init_inline_encryption(struct mapped_device *md, struct dm_table *t)
+{
+	return NULL;
+}
+
+static void dm_update_keyslot_manager(struct mapped_device *md,
+				      struct blk_keyslot_manager *ksm)
+{
+}
+
+static inline void dm_destroy_inline_encryption(struct mapped_device *md)
+{
+}
+
+#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
+
 /*
  * Returns old map, which caller must destroy.
  */
@@ -1959,6 +2164,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	struct request_queue *q = md->queue;
 	bool request_based = dm_table_request_based(t);
 	sector_t size;
+	struct blk_keyslot_manager *ksm;
 	int ret;
 
 	lockdep_assert_held(&md->suspend_lock);
@@ -1994,12 +2200,21 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		md->immutable_target = dm_table_get_immutable_target(t);
 	}
 
+	ksm = dm_init_inline_encryption(md, t);
+	if (IS_ERR(ksm)) {
+		old_map = ERR_PTR(PTR_ERR(ksm));
+		goto out;
+	}
+
 	ret = __bind_mempools(md, t);
 	if (ret) {
+		blk_ksm_destroy(ksm);
 		old_map = ERR_PTR(ret);
 		goto out;
 	}
 
+	dm_update_keyslot_manager(md, ksm);
+
 	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
 	rcu_assign_pointer(md->map, (void *)t);
 	md->immutable_target_type = dm_table_get_immutable_target_type(t);
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index fffe1e289c53..eaf92e4cbe70 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -208,4 +208,23 @@ void dm_free_md_mempools(struct dm_md_mempools *pools);
  */
 unsigned dm_get_reserved_bio_based_ios(void);
 
+/*
+ *  Inline Encryption
+ */
+struct blk_keyslot_manager;
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
+int dm_verify_inline_encryption(struct mapped_device *md, struct dm_table *t);
+
+#else /* !CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline int dm_verify_inline_encryption(struct mapped_device *md,
+					      struct dm_table *t)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_BLK_INLINE_ENCRYPTION */
+
 #endif
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 61a66fb8ebb3..6d05a6a8a129 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -325,6 +325,12 @@ struct dm_target {
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
index 37f1022b256f..4047f8cec01a 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -11,6 +11,8 @@
 
 struct blk_keyslot_manager;
 
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+
 /**
  * struct blk_ksm_ll_ops - functions to manage keyslots in hardware
  * @keyslot_program:	Program the specified key into the specified slot in the
@@ -106,6 +108,21 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
+			     const struct blk_keyslot_manager *child);
+
 void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
 
+bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
+			 struct blk_keyslot_manager *ksm_subset);
+
+void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
+				 struct blk_keyslot_manager *reference_ksm);
+
+#else /* CONFIG_BLK_INLINE_ENCRYPTION */
+
+static inline void blk_ksm_destroy(struct blk_keyslot_manager *ksm) { }
+
+#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.29.0.rc1.297.gfa9743e501-goog

