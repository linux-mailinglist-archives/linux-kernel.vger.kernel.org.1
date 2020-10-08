Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4B287626
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgJHOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbgJHOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:35:23 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593A3C0613D2;
        Thu,  8 Oct 2020 07:35:21 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cq12so6093368edb.2;
        Thu, 08 Oct 2020 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtNCbw67YbLJW6dIRonHtVYko94nWetXk5ia2GPrtYI=;
        b=VnoLsccpRPVc1ySdh7heXcOS1+wutuSppKNWlfbYSKDN7SpzxrLszF+5arD1De7Aqf
         yGmISdBlEHupEQABgDd9t47o/cQnowOQoCVjCq170upu0Bt+JcrqVM+xwrA80DXTCjbA
         62wceNkZztR1xXzRp3beoUhsOPgoWS2iR4ttLu8/7AnrXjai6UY7a1LzL2DBjZbPGBk0
         YrpZkwlahk6rPDfH6+m+Z9/GlzVKGWWZNadqcLRB0ll03lRO19r9Qt3hsXW4eOoFrbkG
         cP6fE5+2h0cwRzxH0gSdPzqdrrmQQLXAckXfprD97FvB31Dpa+NyTnujJbKtZGiGMI+p
         X0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtNCbw67YbLJW6dIRonHtVYko94nWetXk5ia2GPrtYI=;
        b=gl+QJ5eosfasosDJOb0wjzSfE971TI7XjZkqRwOfHVETJwk5cyd3HEVQ3UBZhlYV07
         fahX1ZqXawGjsACpMa7jkjPKq4G0kreTRqaqB4f8WzFSVxSzRMnF++DAwHlwlENjPtq8
         gRvliYuJLCQtJYAFDWtAk0te8FdqBLGgtDmbO23mLJj9fsZdnw5Cp2njS1Zchl8owUcm
         7K/TtWj24+7oXl4fqxFiauekNqqdKCS4RPm4vsROXeaiv/xF2PzlB0Ua+ASTKLfmkTAI
         V573srhx7vH3Co/hzyx6TiD7DHna1dUPoLMB4TPLnprh7TZYmTDt5K3s7GtQ3NR5yBsa
         ZOfw==
X-Gm-Message-State: AOAM532siqzexgz0jg9dfUsOOXyCXOoo8m3F8spiyPAX5BsYBOp09di3
        RU/D8rewvsYa4OKfrAIsepaNff6Divo=
X-Google-Smtp-Source: ABdhPJzEvs2j4a2ZoeNMCE5Ul9VvlU2eVJ04A1IilKMzlhra2c77bZQVUe3QFbdqkonkogLm8Wv+EA==
X-Received: by 2002:aa7:dd49:: with SMTP id o9mr9547839edw.331.1602167719489;
        Thu, 08 Oct 2020 07:35:19 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id b8sm4123763edv.20.2020.10.08.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:35:18 -0700 (PDT)
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
Subject: [PATCH v3 1/5] platform: Add Surface platform directory
Date:   Thu,  8 Oct 2020 16:34:51 +0200
Message-Id: <20201008143455.340599-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008143455.340599-1-luzmaximilian@gmail.com>
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
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

---
 MAINTAINERS                       |  9 +++++++++
 drivers/platform/Kconfig          |  2 ++
 drivers/platform/Makefile         |  1 +
 drivers/platform/surface/Kconfig  | 20 ++++++++++++++++++++
 drivers/platform/surface/Makefile |  7 +++++++
 5 files changed, 39 insertions(+)
 create mode 100644 drivers/platform/surface/Kconfig
 create mode 100644 drivers/platform/surface/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index b1c97a16b6ce..1c5be5875769 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11532,6 +11532,15 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
 F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
+MICROSOFT SURFACE PLATFORM DRIVERS
+M:	Hans de Goede <hdegoede@redhat.com>
+M:	Mark Gross <mgross@linux.intel.com>
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+T:	git git://git.infradead.org/linux-platform-drivers-x86.git
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
index 6fda58c021ca..af62d93f0e46 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MIPS)		+= mips/
 obj-$(CONFIG_OLPC_EC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
 obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
+obj-$(CONFIG_SURFACE_PLATFORM)	+= surface/
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
new file mode 100644
index 000000000000..806b088ddae2
--- /dev/null
+++ b/drivers/platform/surface/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Microsoft Surface Platform-Specific Drivers
+#
+
+menuconfig SURFACE_PLATFORM
+	bool "Microsoft Surface Platform-Specific Device Drivers"
+	default y
+	help
+	  Say Y here to get to see options for platform-specific device drivers
+	  for Microsoft Surface devices. This option alone does not add any
+	  kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if SURFACE_PLATFORM
+
+# place Microsoft Surface platform drivers here
+
+endif # SURFACE_PLATFORM
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
new file mode 100644
index 000000000000..11788a44713f
--- /dev/null
+++ b/drivers/platform/surface/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/surface
+# Microsoft Surface Platform-Specific Drivers
+#
+
+# place Microsoft Surface platform drivers here
-- 
2.28.0

