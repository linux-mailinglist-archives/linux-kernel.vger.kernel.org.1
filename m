Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791EB2E6F28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgL2I4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgL2I4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41658C06179B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o9so22698651yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nINvkj7xQmHV3l4zgYQQKWCc+dYml9+Tq+RFchIuJGw=;
        b=Couj0a2fvM+6P4UxIylQWY7zBSiexCetcULpqxUiJFm/DMzaxkocp+7tge08NPHsXA
         zj2LGTz8s0jIHrJfFihZFw+bncl7iBINQVy3ZikRZKrcETT6LonWTN8xY42qWhilmUaZ
         KIUKpk8CvMjV0N1YnBFzSYlOewOfnzGZRVO5+UKhxybNZirGshYnVOc0FAizoDj8WM40
         OTA1QoPVs4nvNKn4b1xwZO4ylfpldrPcTTkpY4P25sCNj1ylY6QShQfJKyKf5q2rkmXg
         M3w1WcEgDS3OkizftmIgQY6apYCu2ENwyT2nWZeqzB6ZXs2D9++GfiqNHQt8Qlr/wb+3
         CXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nINvkj7xQmHV3l4zgYQQKWCc+dYml9+Tq+RFchIuJGw=;
        b=Al5WGiNyQQpZKzi+dRyAcKUqjcaqtTykrOd0pcQweGuI6ijoE4Y/WWNWhjis6ntyoP
         Dd+/vK9g5ZNqjApUDhva8kriIxlIgcUrjbDHHrcijrVG1fTmcGup54S3e34W0GQWs4gQ
         HRB9GyR/Z4PiB5dqYOR3etvNZ0rwC0avdy5bWvCdSH0L7u0gtk+s0R1jjWC9NXfPfL22
         Ixp/lHFxf9+fDH3zEl6tOZ/D51hPfx+z32jpLbMlg2y5dX5Rgeielrh8FLz9vst+xfMo
         MhSPpsAtj6E1R4VEbEnDSZkotVRQxfYDVeMPbep7pfnBmr+2Md3mVxMRUwYJajiaduYP
         4iiA==
X-Gm-Message-State: AOAM532N6i2dL2fZMLJdTDHqBglWVMNRlBT2W5doYpeECmCwE1fhpboc
        YU6wV5rcWUfLIhvv8qa4IsbWSTDNnOM=
X-Google-Smtp-Source: ABdhPJxwsYdpKcT2mmdMyHo0vo/Kn+HW8jaFKNkt+9WZdufx64WkCtTrB6gg4x2l8R4HU19Dt8AAXIh9Ugs=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:bccc:: with SMTP id l12mr69868142ybm.295.1609232131046;
 Tue, 29 Dec 2020 00:55:31 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:19 +0000
In-Reply-To: <20201229085524.2795331-1-satyat@google.com>
Message-Id: <20201229085524.2795331-2-satyat@google.com>
Mime-Version: 1.0
References: <20201229085524.2795331-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 1/6] block: keyslot-manager: Introduce passthrough keyslot manager
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

The device mapper may map over devices that have inline encryption
capabilities, and to make use of those capabilities, the DM device must
itself advertise those inline encryption capabilities. One way to do this
would be to have the DM device set up a keyslot manager with a
"sufficiently large" number of keyslots, but that would use a lot of
memory. Also, the DM device itself has no "keyslots", and it doesn't make
much sense to talk about "programming a key into a DM device's keyslot
manager", so all that extra memory used to represent those keyslots is just
wasted. All a DM device really needs to be able to do is advertise the
crypto capabilities of the underlying devices in a coherent manner and
expose a way to evict keys from the underlying devices.

There are also devices with inline encryption hardware that do not
have a limited number of keyslots. One can send a raw encryption key along
with a bio to these devices (as opposed to typical inline encryption
hardware that require users to first program a raw encryption key into a
keyslot, and send the index of that keyslot along with the bio). These
devices also only need the same things from the keyslot manager that DM
devices need - a way to advertise crypto capabilities and potentially a way
to expose a function to evict keys from hardware.

So we introduce a "passthrough" keyslot manager that provides a way to
represent a keyslot manager that doesn't have just a limited number of
keyslots, and for which do not require keys to be programmed into keyslots.
DM devices can set up a passthrough keyslot manager in their request
queues, and advertise appropriate crypto capabilities based on those of the
underlying devices. Blk-crypto does not attempt to program keys into any
keyslots in the passthrough keyslot manager. Instead, if/when the bio is
resubmitted to the underlying device, blk-crypto will try to program the
key into the underlying device's keyslot manager.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 block/keyslot-manager.c         | 39 +++++++++++++++++++++++++++++++++
 include/linux/keyslot-manager.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 86f8195d8039..ac7ce83a76e8 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -62,6 +62,11 @@ static inline void blk_ksm_hw_exit(struct blk_keyslot_manager *ksm)
 		pm_runtime_put_sync(ksm->dev);
 }
 
+static inline bool blk_ksm_is_passthrough(struct blk_keyslot_manager *ksm)
+{
+	return ksm->num_slots == 0;
+}
+
 /**
  * blk_ksm_init() - Initialize a keyslot manager
  * @ksm: The keyslot_manager to initialize.
@@ -205,6 +210,10 @@ blk_status_t blk_ksm_get_slot_for_key(struct blk_keyslot_manager *ksm,
 	int err;
 
 	*slot_ptr = NULL;
+
+	if (blk_ksm_is_passthrough(ksm))
+		return BLK_STS_OK;
+
 	down_read(&ksm->lock);
 	slot = blk_ksm_find_and_grab_keyslot(ksm, key);
 	up_read(&ksm->lock);
@@ -325,6 +334,16 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 	struct blk_ksm_keyslot *slot;
 	int err = 0;
 
+	if (blk_ksm_is_passthrough(ksm)) {
+		if (ksm->ksm_ll_ops.keyslot_evict) {
+			blk_ksm_hw_enter(ksm);
+			err = ksm->ksm_ll_ops.keyslot_evict(ksm, key, -1);
+			blk_ksm_hw_exit(ksm);
+			return err;
+		}
+		return 0;
+	}
+
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
 	if (!slot)
@@ -360,6 +379,9 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm)
 {
 	unsigned int slot;
 
+	if (blk_ksm_is_passthrough(ksm))
+		return;
+
 	/* This is for device initialization, so don't resume the device */
 	down_write(&ksm->lock);
 	for (slot = 0; slot < ksm->num_slots; slot++) {
@@ -401,3 +423,20 @@ void blk_ksm_unregister(struct request_queue *q)
 {
 	q->ksm = NULL;
 }
+
+/**
+ * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
+ * @ksm: The keyslot manager to init
+ *
+ * Initialize a passthrough keyslot manager.
+ * Called by e.g. storage drivers to set up a keyslot manager in their
+ * request_queue, when the storage driver wants to manage its keys by itself.
+ * This is useful for inline encryption hardware that doesn't have the concept
+ * of keyslots, and for layered devices.
+ */
+void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm)
+{
+	memset(ksm, 0, sizeof(*ksm));
+	init_rwsem(&ksm->lock);
+}
+EXPORT_SYMBOL_GPL(blk_ksm_init_passthrough);
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 18f3f5346843..323e15dd6fa7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -103,4 +103,6 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.29.2.729.g45daf8777d-goog

