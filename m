Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B429D55B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgJ1WAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgJ1WAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:00:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF318C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:00:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j18so606944pfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uWpU6Cbk1aGPWbnOgnXvEXIQsry1Zp6WwkjkIQDF1pk=;
        b=TAzKVcpLBAdpInkYodiDIcerz0RCdZmucUXjIqnmqEga7wjsIAbASg9yjo8wLwKvwR
         sjkDQcyUUfh1glCmD9i9OmGYu6Fc9LqQNUtMS+K2gUsJFgkNvAOcTv4qqKElmX9IIyxs
         GJpzxx6koV2Unrzz5abr/Q910yATeGB1XNnM9McqEj+ZYb72E5O2U1RTde0g+MJ3CADC
         Iu/UHipclHoALN2UU22o27OsKjpAUhsakbZHKLJmX7gyykcNNmLaG7XJR+TxVzMYhJKI
         ZULgmwl+LRqq8m/7lLDAKm0vefJAcbdtoeCYyddoL/zk+MGz0+R+o2DIwXCaKpcCcxO5
         Ca4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uWpU6Cbk1aGPWbnOgnXvEXIQsry1Zp6WwkjkIQDF1pk=;
        b=N+7ZoxgcFgR140v0i9WJJK7ZW2Fwsk3t0OkLXoEqPxOzwAC32hZhZn5vPPgjYPYU6M
         VRY1lPvW+ILhBrNjzRqiJM0RgqLKAtH8k6iXOhMG5jEciV/5dsdq3rHJX9Dxjde2KaIG
         8nHYk/reXq4MbBdEn6cnjq3IOInj8CuwbXOC7NttrAE32PLZdG3mf/Q0QkGGia88vC0X
         rits9jrOPkzhD85GBcg0Ule1uUpnmbRo0ttNGLIk2FXlrPSWRa8cFYFzjlwWLHKu8pgo
         uzmNgtV/XYvZShtrdWezSEk8ZigBrYVjxN4g8i2XLpXr1Asm9jYW/NMl3ro9+6uAzp1m
         TfPA==
X-Gm-Message-State: AOAM531F4riWAj0lLNGyK4FA0Ey2OJ+RbdURxK66bsO0mqOvFFeYxKMk
        IJsZU23s9NSXyvNJLuPcPHCZbpEhqmGB4Q==
X-Google-Smtp-Source: ABdhPJzNHDjPq12DKVOMMp7sPMfgvQDx3KtKAchmy91Ap7NTk+WyPBqbmnVih1DHbG+MWSBKNfwKIQ==
X-Received: by 2002:a63:845:: with SMTP id 66mr5191372pgi.318.1603870805475;
        Wed, 28 Oct 2020 00:40:05 -0700 (PDT)
Received: from image-900X5T-900X5U ([220.120.123.224])
        by smtp.gmail.com with ESMTPSA id e4sm4088830pgg.37.2020.10.28.00.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 00:40:04 -0700 (PDT)
Date:   Wed, 28 Oct 2020 16:40:00 +0900
From:   Jongpil Jung <jongpuls@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gloria.tsai@ssstc.com, jongpil19.jung@samsung.com,
        jongpuls@gmail.com, jongheony.kim@samsung.com,
        dj54.sohn@samsung.com
Subject: [PATCH V2 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201028074000.GA320668@image-900X5T-900X5U>
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
 drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  |  6 +++++-
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..b7b0b694ee21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2637,6 +2637,36 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
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
 
@@ -3007,10 +3037,18 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
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

