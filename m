Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA26E27BF96
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgI2IdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbgI2IdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:33:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3BBC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:33:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so3794601pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIcoCSV3EdXkbZuDXxqCtycSPPds0aFZfPA4QHxDFJE=;
        b=hkJvgyTvhXdrm+4FrsoYdnxyrss+dx4swUqdhwA20BIRRTRDsq7AV2Lq2x5iifkpwQ
         T44caxDpBkBz1tZ2POIXvm5rBofFK3NjBYjoHUg8HNiFDuhx+gLqSler5AhQNvSIXKvQ
         CqYHdtbf39NDVJJ+zdNrbgCvxEIJJMo4S2ifg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIcoCSV3EdXkbZuDXxqCtycSPPds0aFZfPA4QHxDFJE=;
        b=M9vZpQY0DWX1UYvBn9oR3Jj9T3YH+9a7JpID5GmnQUgR/Iyn3wh2ADieakxa8eGpKx
         tsdiIREEzCmz0HtOsXeRtOe4SetdV8kVLkobm3YBnMoCpFwrMFv9VtSpcN6LJcGgwjDB
         h2lVZaV297IIQOHkiJWw+YsSwOSOal9BYRrcPG6B0iTvtwEci9UC5In7CwLgtvT9nue7
         ePLBiHFQaSWpFJWNUJk0lyJ3wI5bTAlWwKWkEGNA0G/FeKRHO6nrfmv7npMkFAv0uoyc
         5fSWNzVsGpPZ2UmB1j6D/1HkD+bMJbzaZ103X0fOG/JV/hIo2bzLosG+eF1Z+6RFcWaU
         SG0w==
X-Gm-Message-State: AOAM532OWw580HZgkdZyrJ4gmX75zF0FDxFR8x/hN5vHTNO10wtJsBHU
        Sf3dGZlwmYuCKhNTAG0tZ2tLfA==
X-Google-Smtp-Source: ABdhPJxDi59mzAOZvGeuEOE6J33+Iy0vN4m+HWhnk/da7nUC4K3ZUOxkUe4uvKrNAYuRfAgbygX5mg==
X-Received: by 2002:a62:8806:0:b029:13c:d37c:5e47 with SMTP id l6-20020a6288060000b029013cd37c5e47mr3188060pfd.13.1601368389671;
        Tue, 29 Sep 2020 01:33:09 -0700 (PDT)
Received: from ub-XPS-13-9350.pdxnet.pdxeng.ch ([2405:201:c809:c7d5:b511:310d:8495:d767])
        by smtp.gmail.com with ESMTPSA id 36sm3961241pgl.72.2020.09.29.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 01:33:09 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 7/7] arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
Date:   Tue, 29 Sep 2020 14:02:17 +0530
Message-Id: <20200929083217.25406-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929083217.25406-1-jagan@amarulasolutions.com>
References: <20200929083217.25406-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

PX30.Core needs to mount on top of this Carrier board for creating
complete PX30.Core C.TOUCH 2.0 board.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes for v4:
- new patch
Changes for v3:
- add Amarula Solutions copyright
Changes for v2:
- new patch

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/px30-px30-core-ctouch2.dts   | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 65116fcb7368..958eb57e403a 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-px30-core-ctouch2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-px30-core-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts b/arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
new file mode 100644
index 000000000000..2da01281883a
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "px30.dtsi"
+#include "px30-engicam-ctouch2.dtsi"
+#include "px30-px30-core.dtsi"
+
+/ {
+	model = "Engicam PX30.Core C.TOUCH 2.0";
+	compatible = "engicam,px30-core-ctouch2", "engicam,px30-px30-core",
+		     "rockchip,px30";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+};
-- 
2.25.1

