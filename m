Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50A02E6F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgL2I4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgL2I4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:51 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21CC0617A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:39 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 26so9791322pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2LL28w8HYDB56TY4Xorb2dz9gBz+2+A0z3a585XX/NA=;
        b=nDEvUHzhbpJUyaY1GFMF8SnI/Bi2pF3NjiPXylvwGkn/R4l7PH/3ZWXIG0oW380SPo
         rXvzQjEX9SLkpAyDFKTaKrWEn+XGPutjCm3a6a4NXMpYJ6+d8OCLoqAxJYbOOGPZABzo
         gTDfXR/4mo+Zq5MbO3/behA5LVrOEiC8YktvStH4eTkl36MwAfyMMWqLAIOJAZldIW55
         dEVeR85wjuzu8G0xmaDcXslZtMJ3b4Bnf46G0y6d8AQIsvajrXFAToJYv6A2usjzBlqS
         6htTTktyeKBEmjvEhJyP4xhMdXvzHFJEBDIDgr9Ic5vrmKA0qEBUQ+uIqnBRqL4Hy3e8
         Rn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2LL28w8HYDB56TY4Xorb2dz9gBz+2+A0z3a585XX/NA=;
        b=uitgZ/bIF8LMP7ZUHkzswxpBZ3sFjpE4D69DAZgePxvZtEvgO2s/wej7Cyb8a3khxD
         FklKMsQ+DlXT1UcaaDRRbU40d4oE89K2MI4QP3Zm93YKuluQMAMG3LrPjRinXcjsuxUq
         zNtlxsoS5v0UnxwoTaxvP6rgJZw2yIVmbgoUYSwlWFxe8hUlMk7WIpC37EnL3Ye6d0JG
         1OvZI34b6HbmoAS+bAP5iu3EyHssRMihLqGcqLb9Fm1KgDR14sNkC5rwtKwjun3iSOB6
         lluVTWXGBdgNmbN69q9nGu4lkmwmLlZ4RoXbQoU6QZv1hCUmONrzRV8Mo1TpkV1o4Xht
         1aUw==
X-Gm-Message-State: AOAM530h/CDgKsybuv4CwwYUJ/wuxUJ8RdVQjCgijvOuDyUEXo93WRz3
        FqpfuOG/jraYMkD5ZbUJebnSZap2Qik=
X-Google-Smtp-Source: ABdhPJy6RhyhTBX3auLabsBxWya+RNuNUROjMBZdQZOWghOMiLaEGenNF5fpXuLFLtCdUUfLnFSYw+uPxJE=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:902:a585:b029:db:feae:425c with SMTP id
 az5-20020a170902a585b02900dbfeae425cmr48031963plb.25.1609232138954; Tue, 29
 Dec 2020 00:55:38 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:23 +0000
In-Reply-To: <20201229085524.2795331-1-satyat@google.com>
Message-Id: <20201229085524.2795331-6-satyat@google.com>
Mime-Version: 1.0
References: <20201229085524.2795331-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 5/6] dm: Verify inline encryption capabilities of new table
 when it is loaded
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

DM only allows the table to be swapped if the new table's inline encryption
capabilities are a superset of the old table's. We only check that this
constraint is true when the table is actually swapped in (in
dm_swap_table()). But this allows a user to load an unacceptable table
without any complaint from DM, only for DM to throw an error when the
device is resumed, and the table is swapped in.

This patch makes DM verify the inline encryption capabilities of the new
table when the table is loaded. DM continues to verify and use the
capabilities at the time of table swap, since the capabilities of
underlying child devices can expand during the time between the table load
and table swap (which in turn can cause the capabilities of this parent
device to expand as well).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-ioctl.c |  8 ++++++++
 drivers/md/dm.c       | 25 +++++++++++++++++++++++++
 drivers/md/dm.h       | 19 +++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 5e306bba4375..055a3c745243 100644
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
@@ -2115,6 +2119,10 @@ int __init dm_early_create(struct dm_ioctl *dmi,
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
index b8844171d8e4..04322de34d29 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2094,6 +2094,31 @@ dm_construct_keyslot_manager(struct mapped_device *md, struct dm_table *t)
 	return ksm;
 }
 
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
+	struct blk_keyslot_manager *ksm = dm_construct_keyslot_manager(md, t);
+
+	if (IS_ERR(ksm))
+		return PTR_ERR(ksm);
+	dm_destroy_keyslot_manager(ksm);
+
+	return 0;
+}
+
 static void dm_update_keyslot_manager(struct request_queue *q,
 				      struct blk_keyslot_manager *ksm)
 {
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
-- 
2.29.2.729.g45daf8777d-goog

