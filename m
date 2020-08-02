Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D072355FB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 10:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHBIfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 04:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHBIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 04:35:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98D1C061757
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 01:35:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so31440273wrh.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWeOEykzpMG2Cw53yqfEgcb8EdReZnui27iCByahu8k=;
        b=Odwr5dnQlxxeq7nnAYc7r4M4OLEp/GYR7Ca7FnhDm45xiG7z476gWeuD/Ye+dFU80W
         yF6u1ln9DArAzDV1he4Dypbqs4/+qSmQrWnvigb5+LKcxOkHwWaGYJM25fIaEZRPcwGC
         C05giYnvs5Sa4zovdbKwLu6vadrtoTRupccM4a2GKt/1UEvMth8e7z1wIk1G6mfs4kym
         EcZyj+4zPbup65n0uo8TUsnHZW71bLjS4BFiLkOyKvlBRnqqkJvJH+S2UbG6pUOPiRqV
         RMc03ez2ntlv3a2degZucfenRvuKaVrxNZq6Mw2r8isAdyRD44z8chAPQbFJtzLFlpH/
         AJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWeOEykzpMG2Cw53yqfEgcb8EdReZnui27iCByahu8k=;
        b=dj8JquktgZ17d3CrTeuK1IfkynAtat3toWgKTed1Z70HbK9aC7oeL/+JNTy+Vi2R77
         U+eOoVhatXNHLfrLjUiXbYMoC6BGZ7m23oiigPTHxDyoihpqdxhrLVm2Ex3M12HsBe4z
         nbh6HyT92N8htufDhTsICSCXloXyhwK1L2MswHECxheuB4jjSkGTFJPFF4BZZklfLGYV
         OVH5ldXKY0mKVmya5JR9M2YnzMPBddIV35+NoZsWtH2jSyGuKvgXjh7gdg3x7q+RpVJv
         bpHEVhndKcbH1DFOGJ5yD6ftcEO2bdXjQt4PaWWFXqfUhuxClwPc0zHNR7tm97sIwiUa
         Dqhg==
X-Gm-Message-State: AOAM531IZux8uM5ZR2jJhSCAdfJSycqdDHAuOECM1iEACSoV0Dt+FGeF
        lOXWUaZ3lHufFl+4Oux9fB9mDw==
X-Google-Smtp-Source: ABdhPJxKfVyRi6t5LbVxjQKeHdJnjlcFkUW5ThdSeo1/NDJhPMSDZStGtc9IbVpxiTwqKpLbvOJ22Q==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr11212856wrs.204.1596357303465;
        Sun, 02 Aug 2020 01:35:03 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id d14sm19281466wre.44.2020.08.02.01.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 01:35:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 1/3] devres: provide devm_krealloc()
Date:   Sun,  2 Aug 2020 10:34:56 +0200
Message-Id: <20200802083458.24323-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200802083458.24323-1-brgl@bgdev.pl>
References: <20200802083458.24323-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement the managed variant of krealloc(). This function works with
all memory allocated by devm_kmalloc() (or devres functions using it
implicitly like devm_kmemdup(), devm_kstrdup() etc.).

Managed realloc'ed chunks can be manually released with devm_kfree().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 65 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 68 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index eaaaafc21134..f318a5c0033c 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -354,6 +354,7 @@ MEM
   devm_kmalloc()
   devm_kmalloc_array()
   devm_kmemdup()
+  devm_krealloc()
   devm_kstrdup()
   devm_kvasprintf()
   devm_kzalloc()
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index ed615d3b9cf1..68a5a7201065 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -837,6 +837,71 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(devm_kmalloc);
 
+/**
+ * devm_krealloc - Resource-managed krealloc()
+ * @dev: Device to re-allocate memory for
+ * @ptr: Pointer to the memory chunk to re-allocate
+ * @new_size: New allocation size
+ * @gfp: Allocation gfp flags
+ *
+ * Managed krealloc(). Resizes the memory chunk allocated with devm_kmalloc().
+ * Behaves similarly to regular krealloc(): if @ptr is NULL or ZERO_SIZE_PTR,
+ * it's the equivalent of devm_kmalloc(). If new_size is zero, it frees the
+ * previously allocated memory and returns ZERO_SIZE_PTR. This function doesn't
+ * change the order in which the release callback for the re-alloc'ed devres
+ * will be called (except when falling back to devm_kmalloc() or when freeing
+ * resources when new_size is zero). The contents of the memory are preserved
+ * up to the lesser of new and old sizes.
+ */
+void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
+{
+	struct devres *old_dr, *new_dr;
+	struct list_head old_head;
+	unsigned long flags;
+	size_t total_size;
+
+	if (unlikely(!new_size)) {
+		devm_kfree(dev, ptr);
+		return ZERO_SIZE_PTR;
+	}
+
+	if (unlikely(ZERO_OR_NULL_PTR(ptr)))
+		return devm_kmalloc(dev, new_size, gfp);
+
+	if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
+		/*
+		 * We cannot reliably realloc a const string returned by
+		 * devm_kstrdup_const().
+		 */
+		return NULL;
+
+	if (!check_dr_size(new_size, &total_size))
+		return NULL;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+	if (!old_dr) {
+		WARN(1, "Memory chunk not managed or managed by a different device.");
+		return NULL;
+	}
+
+	old_head = old_dr->node.entry;
+
+	new_dr = krealloc(old_dr, total_size, gfp);
+	if (!new_dr)
+		return NULL;
+
+	if (new_dr != old_dr) {
+		spin_lock_irqsave(&dev->devres_lock, flags);
+		list_replace(&old_head, &new_dr->node.entry);
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
+	}
+
+	return new_dr->data;
+}
+EXPORT_SYMBOL_GPL(devm_krealloc);
+
 /**
  * devm_kstrdup - Allocate resource managed space and
  *                copy an existing string into that.
diff --git a/include/linux/device.h b/include/linux/device.h
index 79ce404619e6..51fb33400d7a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -206,6 +206,8 @@ int devres_release_group(struct device *dev, void *id);
 
 /* managed devm_k.alloc/kfree for device drivers */
 void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
+void *devm_krealloc(struct device *dev, void *ptr, size_t size,
+		    gfp_t gfp) __must_check;
 __printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
 				     const char *fmt, va_list ap) __malloc;
 __printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
-- 
2.26.1

