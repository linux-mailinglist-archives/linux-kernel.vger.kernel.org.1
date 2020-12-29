Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01F2E6F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgL2I4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL2I4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:38 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F465C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:33 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c1so1620254pjo.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oQsgXW2m3Lmb+1g8leuyI0Rqgmihl04oDOtjZgFILuI=;
        b=pjc3NAqBW7CmECssQn/JQztInm5nvNE43XL87fIYpXbl30zM40Lus9TTqhsw5FlwHO
         mHHBl5JdJ8L9pmlfDwuSFEIEKJ3y5G1QaEf0WT9UR3vUiPBhENjNU7Mcghe9FDW2pEqS
         fSJhZqNAeInqqzmMI+qngOOxE9cojB9HFhuXgFdVcYPPQ3Z4Pwr1o8py8Vfb17agRoDk
         K5rpH6h5LAWHBZIpnWYcby2sLy4rrkO4hyle3Zj2PMSCTsUzutWdUihadjmKFYuhwJq6
         uq5AWsZE5f3jhyFFYpxGso+EPIkiDnjTgL6MepxugzXt/K8Po0bLi1z9v+YPdKOEGBbo
         UefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oQsgXW2m3Lmb+1g8leuyI0Rqgmihl04oDOtjZgFILuI=;
        b=NknBuBWiYs4PeSoHoRRV/W4mW08KsXbsyXWtzkz3CuZJEoEQtew/YiyvpkGbJHRD4o
         vM/5lVXuipD2LQKmLqKYVSNJT1OFBrmI+xORI9H1IIuU79EqtB1sEriaH4WEIZ1yNYkq
         uENtpIH3vZVOVN4es3P8ee/lZMPz5RhPANFIM8BmAZo282g3ogDO2fh8mFQX+7OYFrue
         kiID+z1+xX7xQQaPjMi5R+qUfzwb+JhcPF+hWv5GPmpTX807N+mAgl8gYqI34RIkCrbH
         MU0EKe3jrxqnkEBjpMRSSC1HYKeXnfN1ZuuKeE1ot8QDS6iMKflxoQQ+qL+OKAOXFbHP
         PA7w==
X-Gm-Message-State: AOAM530evJ1T3can9Atu6OVdZs7J95Nj4dEY/UypZdW7X3Hhr5JlnDOb
        C22NaVg/ydwvC7ron5EKgvr8qAw/8+Q=
X-Google-Smtp-Source: ABdhPJzmLLIYwSw6PZyRw+ISTt9Qf+Y58eAw1eYKXw/8D8joWkNR7O6foCuOQAFTP3qWqk2KVWjbSGcUX0A=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:902:5997:b029:da:a1cd:3cc2 with SMTP id
 p23-20020a1709025997b02900daa1cd3cc2mr25543598pli.80.1609232133020; Tue, 29
 Dec 2020 00:55:33 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:20 +0000
In-Reply-To: <20201229085524.2795331-1-satyat@google.com>
Message-Id: <20201229085524.2795331-3-satyat@google.com>
Mime-Version: 1.0
References: <20201229085524.2795331-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 2/6] block: keyslot-manager: Introduce functions for device
 mapper support
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

Introduce blk_ksm_update_capabilities() to update the capabilities of
a keyslot manager (ksm) in-place. The pointer to a ksm in a device's
request queue may not be easily replaced, because upper layers like
the filesystem might access it (e.g. for programming keys/checking
capabilities) at the same time the device wants to replace that
request queue's ksm (and free the old ksm's memory). This function
allows the device to update the capabilities of the ksm in its request
queue directly.

Also introduce blk_ksm_is_superset() which checks whether one ksm's
capabilities are a (not necessarily strict) superset of another ksm's.
The blk-crypto framework requires that crypto capabilities that were
advertised when a bio was created continue to be supported by the
device until that bio is ended - in practice this probably means that
a device's advertised crypto capabilities can *never* "shrink" (since
there's no synchronization between bio creation and when a device may
want to change its advertised capabilities) - so a previously
advertised crypto capability must always continue to be supported.
This function can be used to check that a new ksm is a valid
replacement for an old ksm.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c         | 91 +++++++++++++++++++++++++++++++++
 include/linux/keyslot-manager.h |  9 ++++
 2 files changed, 100 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index ac7ce83a76e8..f13ab7410eca 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -424,6 +424,97 @@ void blk_ksm_unregister(struct request_queue *q)
 	q->ksm = NULL;
 }
 
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
+ *			   and DUN bytes that another KSM supports. Here,
+ *			   "superset" refers to the mathematical meaning of the
+ *			   word - i.e. if two KSMs have the *same* capabilities,
+ *			   they *are* considered supersets of each other.
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
+
 /**
  * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
  * @ksm: The keyslot manager to init
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 323e15dd6fa7..164568f52be7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -103,6 +103,15 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
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
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.29.2.729.g45daf8777d-goog

