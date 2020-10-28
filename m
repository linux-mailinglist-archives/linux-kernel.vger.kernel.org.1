Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0562C29D680
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgJ1WPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgJ1WPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:15:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3666C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:15:30 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a20so1033653ilk.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=eWk+xuEMaHfrOGisaJcZDQbnFBzO+EQMbeijQobGVcc=;
        b=PjVBgzX+sh1RxzD3ktOd8/ozXdm5p9XLmy/oyVryGtVhQdVO9HwhyoudLy3mi7ueEL
         x5gw3EpaEShErO19sXzKxwBr63LNqptSi/jG2AHuVDsujI2tYilcT1MLqlORLAUX4CbC
         gDAIWeemVUf/hf1+PQbK2dAkyfnZmgseqXdAyn+sBOTf8GWg6ybTn7cSs+6I/rr8cOeE
         KPj2t2xUeyiljQO/wWiJ2s/Lb7Bszv/CVXm/VVyKsDwwOFzh0pbc9gzqvym44KiJNhfI
         CNMGP5+Of24kkDeR3bNvVU7/bhD5QjbKxZQs7fjZ6fgYLOWKWeEs8MwZiCI9GKDFljw6
         f3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eWk+xuEMaHfrOGisaJcZDQbnFBzO+EQMbeijQobGVcc=;
        b=Yegr8y7RyP9WicOb92JnwzZWS+N2UszebRrOi39dTCB41lysI1eiZPgxXPJf1vzHdr
         SUASy5yIkZeixr9T41jYENZyuyrZJvsh91Jee9nLPxkO53quJbTnD/ZX2hhwqKUN2c6e
         7+Z/BSCXc1W6FnS5c497nykCogaqkC/R0frIzsc+OwbAVgNHwiJPEoqoDl+524ZKhvNY
         VReX9qt3D3X7YJHmfAYzsgQI3rUAogW4cpzqipl1jY3duh2IlSL1iEb8FFrLpY+jSk6m
         kzV6FSU49hCLttl+3ywLfL0UfuPbI/Xcr5KETCiFusUtzZK/h85dDi5YLP+IyLmT2ZMy
         HZ4Q==
X-Gm-Message-State: AOAM532+6IL6FhSL8NQ5W5PbMnqpbyZwz90FGkemul4pPwXt758+np4R
        GxDrt7zX3UnOR9jY6K6dPpXD8Vl2cTnS5Q==
X-Google-Smtp-Source: ABdhPJxVjWpSRS4Nb8Iu/QS0NZTm8+kPTdp6s2/OIIweLfLW5kHpDsNn1BRM/vpYVu7OUxUdHle35A==
X-Received: by 2002:a63:4d0f:: with SMTP id a15mr5431900pgb.250.1603876466122;
        Wed, 28 Oct 2020 02:14:26 -0700 (PDT)
Received: from image-900X5T-900X5U ([220.120.123.224])
        by smtp.gmail.com with ESMTPSA id g16sm4621282pgm.38.2020.10.28.02.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 02:14:25 -0700 (PDT)
Date:   Wed, 28 Oct 2020 18:14:21 +0900
From:   Jongpil Jung <jongpuls@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gloria.tsai@ssstc.com, jongpil19.jung@samsung.com,
        jongpuls@gmail.com, jongheony.kim@samsung.com,
        dj54.sohn@samsung.com
Subject: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201028091421.GA667673@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LiteON(SSSTC) CL1 device running FW 220TQ,22001 has bugs with simple
suspend.

When NVMe device receive D3hot from host, NVMe firmware will do
garbage collection. While NVMe device do Garbage collection,
firmware has chance to going incorrect address.
In that case, NVMe storage device goes to no device available state.
Finally, host can't access the device any more.

Quirk devices will not use simple suspend even if HMB is enabled.
In case of poweroff scenario, NVMe receive "PME turn off".
So garbage collection will not be happening.

Liteon(SSSTC) will fix the issue, that's why quirk apply on specific
vendor id and firmware version on specific platform.

Signed-off-by: Jongpil Jung <jongpuls@gmail.com>
---
 drivers/nvme/host/core.c | 43 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  |  6 +++++-
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..414775a77013 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/compat.h>
+#include <linux/dmi.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/hdreg.h>
@@ -2637,6 +2638,36 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
+	},
+	{
+		/*
+		 * This LiteON CL1-3D256 CR22001 firmware version has some
+		 * issue in simple suspend.
+		 * Simple Suspend issue will be fixed in future firmware
+		 */
+		.vid = 0x14a4,
+		.fr = "CR22001",
+		.quirks = NVME_QUIRK_NORMAL_SUSPEND_HMB,
+	},
+		{
+		/*
+		 * This LiteON CL1-3D256 CR220TQ firmware version has some
+		 * issue in simple suspend.
+		 * Simple Suspend issue will be fixed in future firmware
+		 */
+		.vid = 0x14a4,
+		.fr = "CR220TQ",
+		.quirks = NVME_QUIRK_NORMAL_SUSPEND_HMB,
+	},
+	{
+		/*
+		 * This SSSTC CL1-3D256 CR22001 firmware version has some
+		 * issue in simple suspend.
+		 * Simple Suspend issue will be fixed in future firmware
+		 */
+		.vid = 0x1e95,
+		.fr = "CR22001",
+		.quirks = NVME_QUIRK_NORMAL_SUSPEND_HMB,
 	}
 };
 
@@ -3007,10 +3038,18 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		 * could re-scan for quirks every time we reinitialize
 		 * the device, but we'd have to make sure that the driver
 		 * behaves intelligently if the quirks change.
+		 * For NVME_QUIRK_NORMAL_SUSPEND_HMB, need to check board
+		 * as well.
 		 */
 		for (i = 0; i < ARRAY_SIZE(core_quirks); i++) {
-			if (quirk_matches(id, &core_quirks[i]))
-				ctrl->quirks |= core_quirks[i].quirks;
+			if (quirk_matches(id, &core_quirks[i])) {
+				if (core_quirks[i].quirks == NVME_QUIRK_NORMAL_SUSPEND_HMB) {
+					if (dmi_match(DMI_BOARD_VENDOR, "Google") &&
+					    dmi_match(DMI_BOARD_NAME, "Kohaku"))
+						ctrl->quirks |= core_quirks[i].quirks;
+				} else
+					ctrl->quirks |= core_quirks[i].quirks;
+			}
 		}
 	}
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc111136a981..2fde019dad8e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -144,6 +144,10 @@ enum nvme_quirks {
 	 * NVMe 1.3 compliance.
 	 */
 	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
+	/*
+	 * Force noraml suspend/resume path for HMB enabled devices.
+	 */
+	NVME_QUIRK_NORMAL_SUSPEND_HMB		= (1 << 16),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df8f3612107f..1b1221cfb257 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3014,10 +3014,14 @@ static int nvme_suspend(struct device *dev)
 	 * specification allows the device to access the host memory buffer in
 	 * host DRAM from all power states, but hosts will fail access to DRAM
 	 * during S3.
+	 *
+	 * If NVME_QUIRK_NORMAL_SUSPEND_HMB is enabled,
+	 * do not use SIMPLE_SUSPEND for HMB device.
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    ndev->nr_host_mem_descs ||
+	    (ndev->nr_host_mem_descs &&
+	     !(ndev->ctrl.quirks & NVME_QUIRK_NORMAL_SUSPEND_HMB)) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
-- 
2.25.1

