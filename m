Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74D629BAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807435AbgJ0QKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:10:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43026 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1804333AbgJ0Pyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:54:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id a200so1142208pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/dJcq9QxKtdJNhx+nsVsOcHkLZ97Ve8VpsG6zN36Ipk=;
        b=C/S7PhtNmV1VV1Buz0pxqAyvprR9/Ls4erwM4MRF9n8KpZAEi/mLwb/86fwREdEu4s
         z/W5AS4Co+D9EwVOnm1Zi52qThoB/mWxHIiSrqujKGzwCE2jkEpsTdFLqrKYKNbqpXpK
         A4XWshQNqcVuwWH05AY6/UJflMn/V/qRH+r7TlYmDqawiulhrv4FlKOmUIkSbg4whLxj
         yX37UWUK96D8xi3tP/1tGJs3Cs3fdKU350v3sm1jwQ2cyUNLnXfwVulIwYgvqjZ5+fDJ
         Q980dOc+cnWzCj/xzH76Wd0rQdRyfu+BzXqnmKznpZJ58PipZ8k4AdO/ep5a9cygsptF
         2n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/dJcq9QxKtdJNhx+nsVsOcHkLZ97Ve8VpsG6zN36Ipk=;
        b=q1wV/50MP++O0jI95lGTPFmfexN22MtjOJ3XSP+OT5jZuDPwLC2wsYahI/xzT6hoLa
         DkzUzABojlncAy5wLzzhD7pCNUmPHaCbYbd2UG4a6t8tUlroW5sGuNkqPTFP0CfF/nbi
         GH6Cv7XcMNy+wiBTajmukHKwp7DqxH19N521YpzS56R78QkcZ2hg662l8QFADNpIp9hr
         O8g579+hkIfaxUfVjxdThn9zqm+pwewuQWuavpeWBUgYlv6QjM3uWxd1puJF87YVTFxr
         amwj4Wj8PD2FXl7b1yfTeRhjP/PdIWp8Alo1x/XdlCYpSbmRjINdDe+CzKg6dEZtzQvF
         dT7Q==
X-Gm-Message-State: AOAM532RmglIwj23pJaB0pMp6pu6Hd4GB+Lho4d9oheZdEENTKwH/Toj
        zlujHHXfnuYo/a4g3lzcdubb27PvKHqWC0cl
X-Google-Smtp-Source: ABdhPJyHYznHpvc+E8BSBlMuIUcC1nlcg9Aq3NhIkbVP3ZvsTbtcrs7iw0iWnaW/iuROZu55nPrrdg==
X-Received: by 2002:aa7:8652:0:b029:164:1346:7fe4 with SMTP id a18-20020aa786520000b029016413467fe4mr3050522pfo.65.1603814083876;
        Tue, 27 Oct 2020 08:54:43 -0700 (PDT)
Received: from jongpil-desktop ([39.117.32.248])
        by smtp.gmail.com with ESMTPSA id y3sm2527759pfn.167.2020.10.27.08.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 08:54:42 -0700 (PDT)
Date:   Wed, 28 Oct 2020 00:54:38 +0900
From:   Jongpil Jung <jongpuls@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jongpil19.jung@samsung.com, gloria.tsai@ssstc.com,
        jongpuls@gmail.com
Subject: [PATCH 1/1] nvme: Add quirk for LiteON CL1 devices running FW
 220TQ,22001
Message-ID: <20201027155438.GA111754@jongpil-desktop>
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
vendor id and firmware version.

Signed-off-by: Jongpil Jung <jongpuls@gmail.com>
---
 drivers/nvme/host/core.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  |  6 +++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..9ee520aa0100 100644
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

