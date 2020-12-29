Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4FE2E6F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgL2I4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgL2I4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417FC0617A1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o9so22698995yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r1uNbK6vumQ2S39nZ29dwK/wuBEGW5LyLS9BAyhIDUk=;
        b=CJKxr1tVDbYCd2gmA9SkBlYMe/ogzmzQaqOpt1dUZGkoIDBPIu1TyahgJ7yLlRVXEI
         LVG0HbaYzdac4yPQ0G7ui2cqw5sX7rYggjiQqRykh65ZunCCnZyDAzGWeltD30dZhlnr
         LYa7svxRhbbIWLHyOdX7ITnNIGogLwGFr8srfk0KQfhLFA/n4ArBGyaXSVrXR0gDzcH6
         lBL6XUo1JLCrndsuJfcsi/VGUEWbZMw7epOZDz1iVnkIC+kngniOvW8ZjOkezb8XPvKV
         w1/0aWTrOtjLGLST7ViOHYpgtbAjURTsyQtYnbECoCKcxDM4J7/vvMgVvziWklqD85JT
         XqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r1uNbK6vumQ2S39nZ29dwK/wuBEGW5LyLS9BAyhIDUk=;
        b=KbzmE2RsuvIRnBDRLtX/mYKbtuvmc96nmE1sfCDkBZxvBGTmUPU4J5bv3553Udr6bV
         wVhCGX45AuvrN3G2KkIiFjJnVUhB0P8cjPBVs2s0bS7kGFwkKa8BHfb6w+FyC1ImCzmE
         vkAWVnEXon+5lpN/mxDTolk9WNU288Ydu43Z2WdTIE6Ot3z7SBnW4BaL1JJQxVZd8wBh
         KgY7ev/UqxbvFE7pbEBIlx6sOdZ0asSGRP9TjfCTlY7yazgulu5/0QByJOx3DLJWTO/f
         qQyRAzI33J3GGMszj6CgesJykplGhmHni/WGOfU9KMtt1EyMAqYoBce/Cd6bw0GdiOLL
         uy7g==
X-Gm-Message-State: AOAM532s9iInZgYv5nT/1LLmq5DNO5ahlJHWpl5zV202hjND/MFDYxuG
        JFokeSHYajiLgZ8gIMqqTtqhbdhP4wA=
X-Google-Smtp-Source: ABdhPJwAOebr5YmlpPKNLl4A1ee+wOmB1Pjbxc5UpF9vjNQ+t39UJhcZfwlSIs9MpPG+YVcV9uIsQgPy5Q0=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:aa91:: with SMTP id t17mr63938387ybi.394.1609232137422;
 Tue, 29 Dec 2020 00:55:37 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:22 +0000
In-Reply-To: <20201229085524.2795331-1-satyat@google.com>
Message-Id: <20201229085524.2795331-5-satyat@google.com>
Mime-Version: 1.0
References: <20201229085524.2795331-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 4/6] dm: Support key eviction from keyslot managers of
 underlying devices
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

Now that device mapper supports inline encryption, add the ability to
evict keys from all underlying devices. When an upper layer requests
a key eviction, we simply iterate through all underlying devices
and evict that key from each device.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto.c |  1 +
 drivers/md/dm.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 5da43f0973b4..c2be8f15006c 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -409,3 +409,4 @@ int blk_crypto_evict_key(struct request_queue *q,
 	 */
 	return blk_crypto_fallback_evict_key(key);
 }
+EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 13b9c8e2e21b..b8844171d8e4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1949,6 +1949,58 @@ struct dm_keyslot_manager {
 	struct mapped_device *md;
 };
 
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
+	struct dm_keyslot_manager *dksm = container_of(ksm,
+						       struct dm_keyslot_manager,
+						       ksm);
+	struct mapped_device *md = dksm->md;
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
 static int device_intersect_crypto_modes(struct dm_target *ti,
 					 struct dm_dev *dev, sector_t start,
 					 sector_t len, void *data)
@@ -1998,6 +2050,7 @@ dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
 
 	ksm = &dksm->ksm;
 	blk_ksm_init_passthrough(ksm);
+	ksm->ksm_ll_ops = dm_ksm_ll_ops;
 	ksm->max_dun_bytes_supported = UINT_MAX;
 	memset(ksm->crypto_modes_supported, 0xFF,
 	       sizeof(ksm->crypto_modes_supported));
-- 
2.29.2.729.g45daf8777d-goog

