Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CA9288A69
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbgJIOL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388192AbgJIOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:11:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC30C0613D5;
        Fri,  9 Oct 2020 07:11:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so9531954edk.0;
        Fri, 09 Oct 2020 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=INgaBC2CtaXS91raCpnmI2DSX5HfMuIxr1e8xfCUBVE=;
        b=ITvNHZ+JbWPmw2t0ZO1/2PFRqKp1Mdo3jbQfvWTS3s30ot46QvjJ5h8XaQBewtl5Hj
         1GibPLjJTxKjtooLXeQ8l3KE85Ps6KFISltZAA9XqhwW38RP63XbjCL/FAw8CgTR3PEy
         qCikQW8pbeq6S0ADmraWfTk9OEucbBoM+ILH8QfxCmCv7bpLmtFfkZimUVUBhhPnnCf3
         k7WZuOqo0fk4wfEYfDEEyUAcVKf7cLoy8EbgO3SXePh84AdD1n/bOyZnWMHeq/tGXrPr
         Lq8UdQ4NAcx3N4L8sFTEDUj6pQ67UmvAV1qeKEFQ6h/8+6qMD+jxqVZANarjnsSqiqQr
         aSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INgaBC2CtaXS91raCpnmI2DSX5HfMuIxr1e8xfCUBVE=;
        b=VN0PZCeBuhMWj2h3Cm4LlntZKDflWmJ9F6SufCKoPpTEwEw4XQmCiAzEvCrpUbUXe+
         9QySUefoOAw7AfXc2QwImoPFUYjiR8dpv4GzdMsXaAFY1MKqMJMUhM/DqpLXgmnyPrOO
         EmGw8ShsnAH/wfTrCE0X6yNYpuSSvOZHpT5K/rGrDM0zzhHPzszZ3VxsG4APG7vC85BF
         dDhtWiW/AeT7eKLH8j0PdY6SgGk02EMYGCom7P1WLw7NvQZ8WrQtK+gtUDhka8g3kzLU
         3wP3/mZSZULOfEONJw16sKe8DThP9oA283sM5qMAoN/ISkv4l3i6K9P+EPdTs+wqmVrR
         CeKg==
X-Gm-Message-State: AOAM532Q3IzCd9bNctxCWO9lrCnRg+RlmAO1u9RXhsEplrFSzHmc+DM5
        klqNPXe2xQmemkmYdKoAC2YQ2gS5oXU=
X-Google-Smtp-Source: ABdhPJzq2QpAJcHF21RP2pGv7Lmf0Uk38nX6CLa6sVSW1pHTWYICHMTeHkmWp4Er1bAGNEyRp87pCA==
X-Received: by 2002:a50:e447:: with SMTP id e7mr11024605edm.263.1602252712302;
        Fri, 09 Oct 2020 07:11:52 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a236.dip0.t-ipconnect.de. [217.229.162.54])
        by smtp.gmail.com with ESMTPSA id a5sm6184108edl.6.2020.10.09.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:11:51 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v4 1/5] platform: Add Surface platform directory
Date:   Fri,  9 Oct 2020 16:11:24 +0200
Message-Id: <20201009141128.683254-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009141128.683254-1-luzmaximilian@gmail.com>
References: <20201009141128.683254-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may make sense to split the Microsoft Surface hardware platform
drivers out to a separate subdirectory, since some of it may be shared
between ARM and x86 in the future (regarding devices like the Surface
Pro X).

Further, newer Surface devices will require additional platform drivers
for fundamental support (mostly regarding their embedded controller),
which may also warrant this split from a size perspective.

This commit introduces a new platform/surface subdirectory for the
Surface device family, with subsequent commits moving existing Surface
drivers over from platform/x86.

A new MAINTAINERS entry is added for this directory. Patches to files in
this directory will be taken up by the platform-drivers-x86 team (i.e.
Hans de Goede and Mark Gross) after they have been reviewed by
Maximilian Luz.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - Do not create a separate MAINTAINERS entry for platform/surface.
   Instead add drivers/platform/surface to x86 platform drivers entry.
   This incorporates recent changes in the x86 platform driver
   MAINTAINERS entry.
 - Fix typo in commit message.

Changes in v3:
 - Add separate MAINTAINERS entry for platform/surface
 - Add Maximilian Luz as reviewer for platform/surface

Changes in v4:
 - Rename MAINTAINERS entry to be similar to platform/chrome.
 - Rename Kconfig options to be similar to platform/chrome
   (PLATFORM -> PLATFORMS)
 - Drop placeholder comments.

---
 MAINTAINERS                       |  9 +++++++++
 drivers/platform/Kconfig          |  2 ++
 drivers/platform/Makefile         |  1 +
 drivers/platform/surface/Kconfig  | 14 ++++++++++++++
 drivers/platform/surface/Makefile |  5 +++++
 5 files changed, 31 insertions(+)
 create mode 100644 drivers/platform/surface/Kconfig
 create mode 100644 drivers/platform/surface/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a2170ff3a91..9fea3ce2db2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11532,6 +11532,15 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
 F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
+MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
+M:	Hans de Goede <hdegoede@redhat.com>
+M:	Mark Gross <mgross@linux.intel.com>
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
+F:	drivers/platform/surface/
+
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 971426bb4302..18fc6a08569e 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -13,3 +13,5 @@ source "drivers/platform/chrome/Kconfig"
 source "drivers/platform/mellanox/Kconfig"
 
 source "drivers/platform/olpc/Kconfig"
+
+source "drivers/platform/surface/Kconfig"
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 6fda58c021ca..4de08ef4ec9d 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MIPS)		+= mips/
 obj-$(CONFIG_OLPC_EC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
 obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
+obj-$(CONFIG_SURFACE_PLATFORMS)	+= surface/
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
new file mode 100644
index 000000000000..b67926ece95f
--- /dev/null
+++ b/drivers/platform/surface/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Microsoft Surface Platform-Specific Drivers
+#
+
+menuconfig SURFACE_PLATFORMS
+	bool "Microsoft Surface Platform-Specific Device Drivers"
+	default y
+	help
+	  Say Y here to get to see options for platform-specific device drivers
+	  for Microsoft Surface devices. This option alone does not add any
+	  kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
new file mode 100644
index 000000000000..3700f9e84299
--- /dev/null
+++ b/drivers/platform/surface/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/surface
+# Microsoft Surface Platform-Specific Drivers
+#
-- 
2.28.0

