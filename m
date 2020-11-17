Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359132B724E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgKQXYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKQXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:24:05 -0500
Received: from mail-ot1-x362.google.com (mail-ot1-x362.google.com [IPv6:2607:f8b0:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:24:05 -0800 (PST)
Received: by mail-ot1-x362.google.com with SMTP id o3so10686837ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ttrytKrDltyetQ23KnDSb5EbKfcjrjhXOBSWCLEssE=;
        b=UK9O4TfiQCqjdUoT8cUcFEjn3CulqCnMojtcqmD96z/wBpdNwmS59iSs9Jgu33AU1E
         mm5Z9vZfyFi1zWwjeBLquqyy8cMO0X9nwDfa+jSHcUJbrfcEh9xlhuZ7UV2jSbhFWBD8
         L+iPS3wPL+XSrb0nDTkLrIah8iwzGumFCR8DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ttrytKrDltyetQ23KnDSb5EbKfcjrjhXOBSWCLEssE=;
        b=YS/b84xuRA2ZixWFz53H83wy4Os7w2gLMJvLlT/tPDcP+zXI9slCl+wGbhzJJtq8Uh
         Bl5CCHR4w8qFYJP7Hr4WAfgv/GtYiDu7sVmUZfn/QxVfwX7nPrqegN7ek0TnH11nooRs
         mN3/znVh9GnGeDq8TELgMnYwCpnVRB/L9QgnLQT+YYaxfPWYoUGbWUqwVQo/dY7C1NLG
         AsKGCNzfq8GpxY6MjoAg/yw2Tw1dXSZ/JwnnzKPbOzLZIZhr6cHfvbK9CB4zjees7aJj
         mivAyIgvU7xo/J1g+Y701udDJkounRAEh9Ki2BsoOxgi8Z2tyZBM8bD4eH1ZYRIQnCSB
         vKPg==
X-Gm-Message-State: AOAM533KptaE1ppPDokeqv0EJ/e6m+TqzcPnkSKYvybVYwA26qtwI9s+
        AF5Cv2vOoDRo3OgNj0o53QsMMTG7I5hE7/sXVOIgiDWTGhfm
X-Google-Smtp-Source: ABdhPJxz2VvPBfoIxReZX23mmBqwVBCjOaZ2FZ/XoiNSz6ErP82LUS7g0ZEafYS9xyG3KtJG3z00eVWPhFlN
X-Received: by 2002:a05:6830:1bcb:: with SMTP id v11mr4496804ota.115.1605655444763;
        Tue, 17 Nov 2020 15:24:04 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id q22sm5867076otg.13.2020.11.17.15.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:24:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v7 01/13] bcm-vk: add bcm_vk UAPI
Date:   Tue, 17 Nov 2020 15:23:08 -0800
Message-Id: <20201117232320.4958-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117232320.4958-1-scott.branden@broadcom.com>
References: <20201117232320.4958-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add user space api for bcm-vk driver.

Provide ioctl api to load images and issue reset command to card.
FW status registers in PCI BAR space also defined as part
of API so that user space is able to interpret these memory locations
as needed via direct PCIe access.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 include/uapi/linux/misc/bcm_vk.h | 84 ++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
new file mode 100644
index 000000000000..ec28e0bd46a9
--- /dev/null
+++ b/include/uapi/linux/misc/bcm_vk.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright 2018-2020 Broadcom.
+ */
+
+#ifndef __UAPI_LINUX_MISC_BCM_VK_H
+#define __UAPI_LINUX_MISC_BCM_VK_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define BCM_VK_MAX_FILENAME 64
+
+struct vk_image {
+	__u32 type; /* Type of image */
+#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
+#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
+	__u8 filename[BCM_VK_MAX_FILENAME]; /* Filename of image */
+};
+
+struct vk_reset {
+	__u32 arg1;
+	__u32 arg2;
+};
+
+#define VK_MAGIC		0x5e
+
+/* Load image to Valkyrie */
+#define VK_IOCTL_LOAD_IMAGE	_IOW(VK_MAGIC, 0x2, struct vk_image)
+
+/* Send Reset to Valkyrie */
+#define VK_IOCTL_RESET		_IOW(VK_MAGIC, 0x4, struct vk_reset)
+
+/*
+ * Firmware Status accessed directly via BAR space
+ */
+#define VK_BAR_FWSTS			0x41c
+#define VK_BAR_COP_FWSTS		0x428
+/* VK_FWSTS definitions */
+#define VK_FWSTS_RELOCATION_ENTRY	(1UL << 0)
+#define VK_FWSTS_RELOCATION_EXIT	(1UL << 1)
+#define VK_FWSTS_INIT_START		(1UL << 2)
+#define VK_FWSTS_ARCH_INIT_DONE		(1UL << 3)
+#define VK_FWSTS_PRE_KNL1_INIT_DONE	(1UL << 4)
+#define VK_FWSTS_PRE_KNL2_INIT_DONE	(1UL << 5)
+#define VK_FWSTS_POST_KNL_INIT_DONE	(1UL << 6)
+#define VK_FWSTS_INIT_DONE		(1UL << 7)
+#define VK_FWSTS_APP_INIT_START		(1UL << 8)
+#define VK_FWSTS_APP_INIT_DONE		(1UL << 9)
+#define VK_FWSTS_MASK			0xffffffff
+#define VK_FWSTS_READY			(VK_FWSTS_INIT_START | \
+					 VK_FWSTS_ARCH_INIT_DONE | \
+					 VK_FWSTS_PRE_KNL1_INIT_DONE | \
+					 VK_FWSTS_PRE_KNL2_INIT_DONE | \
+					 VK_FWSTS_POST_KNL_INIT_DONE | \
+					 VK_FWSTS_INIT_DONE | \
+					 VK_FWSTS_APP_INIT_START | \
+					 VK_FWSTS_APP_INIT_DONE)
+/* Deinit */
+#define VK_FWSTS_APP_DEINIT_START	(1UL << 23)
+#define VK_FWSTS_APP_DEINIT_DONE	(1UL << 24)
+#define VK_FWSTS_DRV_DEINIT_START	(1UL << 25)
+#define VK_FWSTS_DRV_DEINIT_DONE	(1UL << 26)
+#define VK_FWSTS_RESET_DONE		(1UL << 27)
+#define VK_FWSTS_DEINIT_TRIGGERED	(VK_FWSTS_APP_DEINIT_START | \
+					 VK_FWSTS_APP_DEINIT_DONE  | \
+					 VK_FWSTS_DRV_DEINIT_START | \
+					 VK_FWSTS_DRV_DEINIT_DONE)
+/* Last nibble for reboot reason */
+#define VK_FWSTS_RESET_REASON_SHIFT	28
+#define VK_FWSTS_RESET_REASON_MASK	(0xf << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_SYS_PWRUP	(0x0 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_MBOX_DB		(0x1 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_M7_WDOG		(0x2 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_TEMP		(0x3 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_FLR		(0x4 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_HOT		(0x5 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_WARM		(0x6 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_PCI_COLD		(0x7 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_L1		(0x8 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_L0		(0x9 << VK_FWSTS_RESET_REASON_SHIFT)
+#define VK_FWSTS_RESET_UNKNOWN		(0xf << VK_FWSTS_RESET_REASON_SHIFT)
+
+#endif /* __UAPI_LINUX_MISC_BCM_VK_H */
-- 
2.17.1

