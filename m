Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E327B8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgI2AMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgI2AMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:12:35 -0400
Received: from mail-pg1-x563.google.com (mail-pg1-x563.google.com [IPv6:2607:f8b0:4864:20::563])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD20C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:12:35 -0700 (PDT)
Received: by mail-pg1-x563.google.com with SMTP id e18so2370607pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kpxs0tKdiJaNkv2hZQp/1pWF5jxYDz1DVB5JJCg58f4=;
        b=JPULGqXOXgG6/Qqir79nSlpmC5OYl2h4+nSm01CpMdcNdYH/runtEKvn/tgMEXvg+Y
         YHbDHXrd2Fq7kfI9Rqb86PEDtvj6YRSkm40eIEbpLkJlvqiAHfdrJ0r8qFjwDlCSRdvH
         iTXQmDN8rsGEVdvIJvE/cVXfol/SDYJMjHfu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpxs0tKdiJaNkv2hZQp/1pWF5jxYDz1DVB5JJCg58f4=;
        b=UcIhRnSKVJaPy5ECiWHB6q+OcBjUcoEaUaezgGMj2R3hyYKfLtachpgeKisgwacl7w
         VPLUu277oM131jDp6tAPZpts+Y+ajDtHFBlD9HgVmObohwM1ZwbYE8qc7HiE2+UNwdsU
         S5ft27YkQaSujaIu+IZyQavTxtwjbBdXyFPNHaFqU5UJXzw6j0AmpZonTjeW6QBkX2JE
         qZZfSsnh3L/3YV55zO85+hoBBX8VUlWXE/gfak782nD4iGRyVQ7Czt62p9zn/AmP+D5T
         SVRYgyrGPY+HSKjmkRXcSBHzjAS/TOMZ0+4iKy2EXgcX4OeZ58YeRDQLha7fDvPtYAME
         fA3w==
X-Gm-Message-State: AOAM531Wxnb2M2erUkR1sjLQnifC0PltqgBJq11Ckp4LZU5/1nP072m+
        GlC2TY+bS5MK3ILiLM/qf7ULb5morHz36UH4hZy3CHHvAm2P
X-Google-Smtp-Source: ABdhPJxlgim+AVuo+ElbRShMTCxIhJmQ8+BfSv/+z89YWkA9ficY03pYug9xBZDDjsxvDEkGEYkGH1TW+qhi
X-Received: by 2002:a63:405:: with SMTP id 5mr1121203pge.309.1601338355071;
        Mon, 28 Sep 2020 17:12:35 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id t1sm1047973pjr.8.2020.09.28.17.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:12:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v4 01/16] bcm-vk: add bcm_vk UAPI
Date:   Mon, 28 Sep 2020 17:11:54 -0700
Message-Id: <20200929001209.16393-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929001209.16393-1-scott.branden@broadcom.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
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
index 000000000000..5f1fc403bc67
--- /dev/null
+++ b/include/uapi/linux/misc/bcm_vk.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
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

