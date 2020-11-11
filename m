Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2A2AE7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKKFTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKFTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:19:48 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:19:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id j205so1485382lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xHgO6xQjRtzCqJvgfsirBMsV6gq7sad2fSKmrTwmkk=;
        b=bEQ+m0X2CTWHLyFuF4wxigLJkCQRl1Rxh2Sjtj32Z0NJjEBbcMuMg9xVkLWdomzwcC
         pWqAGSn5CC4FjFjf9RGLMRaaT6lhL8dls7hngnhyhX/A/oW1+Et1Su2s/y1Cdbu7nZWy
         sg0MyMiqFkG431SPFAtoLTPdlYVEPaGchnl2/yF//gokU9vXLAh9LwWSjxqpLC8D3Y7k
         0vcFoEk4BIv8YQF0N5c8SI1pcPb3H/giOpe93nzJk0ee/KKhKmFR+iI+oXYdQGjwmomw
         UMVBYeBk+tnB8LFf8u4bSFSEgtIzIhekXbRRdhV3gaXRAciyqIdRJvHmcMqG+NyCYl9w
         nqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xHgO6xQjRtzCqJvgfsirBMsV6gq7sad2fSKmrTwmkk=;
        b=rQLrAaUrt1NS9yvp+EGqgxQDmFF6LRHIIfdahXwcuSPvHgzv/eOzJ4QFGOXQotW7OA
         8A96X2RDnIGtNmSNzzDIROfq7GlNGh4mi5UYjzcUQhRYbn17GSI9vgaKpuRtuoKgk5XY
         TRJijep4I66LUrWYexrFYrzTKggXNIaOOtDxkoSHd0r13JcSoyAXNxS1XiBi5ReGu3i4
         jpqDb7TRIYkkN6l/ouApcJjuBBwyWmuNYBX7bvsjwADUef2KYc5I5/85SbdKIC9mNfxh
         ywhW6MywvVBcqB6CKr/6+/R+sNWZEQ7gxgFZrXgBQf8HrsQ0U91P0as8qixs9PQtCvv0
         6Fmw==
X-Gm-Message-State: AOAM5335fNjCqfgXdVW7h6/wmz9/o6PG5vJzf0GtW8d3G3+MxgP+KzpV
        w5auhixaP6PLlggWkdmFHzgXjQ==
X-Google-Smtp-Source: ABdhPJzjeJH600Eg/zOViULX0bJFOViqmDpeDCPayjttfgfTfmTTpZMRGBKx9K5ltKxc5tgpG2sE+A==
X-Received: by 2002:a19:8c7:: with SMTP id 190mr8297227lfi.74.1605071984759;
        Tue, 10 Nov 2020 21:19:44 -0800 (PST)
Received: from localhost.localdomain (95-30-131-0.broadband.corbina.ru. [95.30.131.0])
        by smtp.googlemail.com with ESMTPSA id x9sm109572lfg.93.2020.11.10.21.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 21:19:43 -0800 (PST)
From:   Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Evgeny Boger <boger@wirenboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mxs: Add serial number support for i.MX23, i.MX28 SoCs
Date:   Wed, 11 Nov 2020 08:18:59 +0300
Message-Id: <20201111051859.2776-1-ivan.zaentsev@wirenboard.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX23 and i.MX28 SoCs unique identifiers are factory-programmed
in On-Chip OTP memory. i.MX28's 64-bit unique id is in
HW_OCOTP_OPS2:HW_OCOTP_OPS3 (see MCIMX28 Ref. Man., sec. 20.4.22-23).

i.MX23 provides 32-bit long unique id in HW_OCOTP_OPS3.
Though not clearly documented, there is a clue in sec. 35.9.3.

The unique id is reported in /sys/devices/soc0/serial_number
and in /proc/cpuinfo

Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Suggested-by: Evgeny Boger <boger@wirenboard.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index c109f47e9cbc..af96368cc16a 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -23,6 +23,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
+#include <asm/system_info.h>
 
 #include "pm.h"
 
@@ -51,6 +52,9 @@
 #define MXS_CLR_ADDR		0x8
 #define MXS_TOG_ADDR		0xc
 
+#define HW_OCOTP_OPS2       19	/* offset 0x150 */
+#define HW_OCOTP_OPS3       20	/* offset 0x160 */
+
 static u32 chipid;
 static u32 socid;
 
@@ -379,6 +383,8 @@ static void __init mxs_machine_init(void)
 	struct device *parent;
 	struct soc_device *soc_dev;
 	struct soc_device_attribute *soc_dev_attr;
+	u64 soc_uid = 0;
+	const u32 *ocotp = mxs_get_ocotp();
 	int ret;
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
@@ -394,8 +400,22 @@ static void __init mxs_machine_init(void)
 	soc_dev_attr->soc_id = mxs_get_soc_id();
 	soc_dev_attr->revision = mxs_get_revision();
 
+	if (socid == HW_DIGCTL_CHIPID_MX23) {
+		soc_uid = system_serial_low = ocotp[HW_OCOTP_OPS3];
+	} else if (socid == HW_DIGCTL_CHIPID_MX28) {
+		soc_uid = system_serial_high = ocotp[HW_OCOTP_OPS2];
+		soc_uid <<= 32;
+		system_serial_low = ocotp[HW_OCOTP_OPS3];
+		soc_uid |= system_serial_low;
+	}
+
+	if (soc_uid)
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+
 	soc_dev = soc_device_register(soc_dev_attr);
+
 	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->serial_number);
 		kfree(soc_dev_attr->revision);
 		kfree(soc_dev_attr);
 		return;
-- 
2.25.1

