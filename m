Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7E2C8D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgK3SnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgK3SnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:43:09 -0500
Received: from mail-oi1-x264.google.com (mail-oi1-x264.google.com [IPv6:2607:f8b0:4864:20::264])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BACAC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:29 -0800 (PST)
Received: by mail-oi1-x264.google.com with SMTP id h3so15257228oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ttrytKrDltyetQ23KnDSb5EbKfcjrjhXOBSWCLEssE=;
        b=h0d2a4vnL57sKltgwLEIhN11kVn+kxXcJcQsv94ULhdDI+823fDasug9NPl0sJIvLz
         awB8KRqnnEcc9sfLjuTIEfGHXjo/7oKI1C4cDlb9fMEdlK+YcULIt99vl1BLtm1uK8jK
         9dl71Jf793BRwUtdtsfh5U7zgoZitca79Z/Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ttrytKrDltyetQ23KnDSb5EbKfcjrjhXOBSWCLEssE=;
        b=P/aZUz6aJUDwiS1CBmAFR3CCO2ZPkjZRJUlB0nB6RNN72srRuwrc65u8OimYh4pRjv
         GxLpTlYWqnS9w7t7AnXYvbIHh9ynUrFOY7aQ3tanvbG8cQxjf1x84mZg/6YXNJmGKKcM
         jo9VcIXVQfyd/MX/kwBZbujoVDU0bfWESLrxZqIirvNCC3NRH2COTg98OAJ8If5fkcD9
         ArbtJjcUehSJX2f0EqgsYT9yF6si2rKOBnwdH0VekojfRHG8/HGadxpIdp7IDFN03NiU
         WcTwY1bJC4CHypqQEihvaaUeYLpqduXrA5Q4qOSYwv1dHRkfXmEgEb8Udi7Q7jvreoNQ
         3ZqA==
X-Gm-Message-State: AOAM532qhzCS8AopOsXuJIUxaKWuumaXpDVGf2fDsL6AtGznCiCocliT
        wbofx9WDMAD3OCCPDAHlYATs5cmquCUot2jqDGpGRuKR9JET
X-Google-Smtp-Source: ABdhPJwkujaoIe9YyoW+VRvGbWRE4zYaeQizRY54lYaHEGxlzPMEhbQeYmhLyj6fg/xWFiPpUtg59hdDnCqw
X-Received: by 2002:aca:2311:: with SMTP id e17mr192366oie.50.1606761748371;
        Mon, 30 Nov 2020 10:42:28 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:42:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 01/13] bcm-vk: add bcm_vk UAPI
Date:   Mon, 30 Nov 2020 10:41:48 -0800
Message-Id: <20201130184200.5095-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
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

