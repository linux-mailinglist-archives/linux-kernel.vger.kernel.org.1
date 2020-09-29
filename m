Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9119E27BF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgI2Ic7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgI2Ic5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:32:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B5C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:32:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so2268203pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPMAxinxPrny8XKDKZApjaR0cwFKYuGXtLocmsgKqno=;
        b=YRXs8qyK8nrK5Au2iu+Ubh+KAvNkaHroGhmSYPROwxF8KuMFOio+EDoVidcDuPBACO
         ZGCjkHTVa8lgnGinagFqSMWS2wtk68TQabWd0nlzY2tzEqlqV/XpdUFjLVNGbrLUQnL5
         dzHezhYvhlZUK5KRrnkcUn8DaxzynUfkKlFvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPMAxinxPrny8XKDKZApjaR0cwFKYuGXtLocmsgKqno=;
        b=B0FsYvPipMhgIB/9CdeIHMqkbgMW3gp/BGOO0LI3Ehaxf+Su6N8QC512/RBez116Ed
         5FjxydpSF5WID/ynL0FUs0Il05rYZ0Wyi1HrTOULQKfd7xmQ4yQSDgIiBfIMRoDTwnh9
         PB/FWUzeynbXN4bWhyyroSPe2QPCyc+RMXwlmL/w2bf1xRLmCDaezMxk7EWjR22/D1pJ
         T7FPGNWENXiC+GPrgRDkXRQUL7/iJAduF59U4z4Qj+aQLPiTsFqv9M5s1hDyE89hB+HI
         k5co8q+mDyy+9dKDrg5n6XZwiIqw/5bpW72yUjnJ4aVdSbBT1t8ByD3rOZaHEyY41MJd
         iNQA==
X-Gm-Message-State: AOAM531tfwOmq0dM4ZDMptPTUt64u3nZvSOdxaHjPsg/+xDkPuURwM//
        NgWe96Poz3+mPYEaJtuT9q9l/A==
X-Google-Smtp-Source: ABdhPJwPYL5Rb0z85CfSR710/Zlh7ijJX0QyVaOChLEgecop8yvFJnAIVtAQyhrxI963gP1ePOwCcA==
X-Received: by 2002:a17:90a:6a4e:: with SMTP id d14mr2740937pjm.63.1601368377343;
        Tue, 29 Sep 2020 01:32:57 -0700 (PDT)
Received: from ub-XPS-13-9350.pdxnet.pdxeng.ch ([2405:201:c809:c7d5:b511:310d:8495:d767])
        by smtp.gmail.com with ESMTPSA id 36sm3961241pgl.72.2020.09.29.01.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 01:32:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 4/7] arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
Date:   Tue, 29 Sep 2020 14:02:14 +0530
Message-Id: <20200929083217.25406-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929083217.25406-1-jagan@amarulasolutions.com>
References: <20200929083217.25406-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board from Engicam.

PX30.Core needs to mount on top of this Evaluation board for
creating complete PX30.Core EDIMM2.2 Starter Kit.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4, v3, v2:
- none

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/px30-px30-core-edimm2.2.dts  | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 02cdb3c4a6c1..65116fcb7368 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-px30-core-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
diff --git a/arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts b/arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
new file mode 100644
index 000000000000..c36280ce7fc7
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "px30.dtsi"
+#include "px30-engicam-edimm2.2.dtsi"
+#include "px30-px30-core.dtsi"
+
+/ {
+	model = "Engicam PX30.Core EDIMM2.2 Starter Kit";
+	compatible = "engicam,px30-core-edimm2.2", "engicam,px30-px30-core",
+		     "rockchip,px30";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+};
-- 
2.25.1

