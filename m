Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D42568F7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgH2QBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 12:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgH2P6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:58:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A97C0611E0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so901158pjr.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rStBfOvl55pQq+rvM4nD151B6wU+azvewrI4r70NPhk=;
        b=MmQA+6oMSBG55PrNJwwvYnXOb5T+65eG8XgSF4v7ZHYfEwwntd0zsg4SkY5h9snNe4
         dPXZwFnHQh5g46eOHNthEXnBEb9/cfIcEQcgAPszhsafIZOm4nFziHqUgL0XJjIGltU4
         ku526pk2OLUs+36hwBwejevZ5ud7q3Nn4rsO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rStBfOvl55pQq+rvM4nD151B6wU+azvewrI4r70NPhk=;
        b=DuwrmmnhtRc2xC1e/N/dEB0tl288oVyXXo+GeqNJoXeWLYeASGj0KPaZIC/EknnFPQ
         y2M1SmJPXKzM2cFAQA6ErKkqosFubttseI7q9of8nNoCaj0yzqCz66sb4EbER9/3VN+s
         ovSR6TW8HCj3XzbAD5bycIzdPTGppJtj39ImqUK5akQVjwKR2+dnPOypndUvHAt2+6DT
         yxTFi4jhZakcElz3TCxTZkT95PTx1O2yc2/WZCVmN1MRlE8bqoSLGGvapReP9MkueB/1
         +qlNQVN9rO4slvjQkcZ5rRKgV8rdVwfsxK7mWVcCXUJc7C5Ok/J3Ns/xQtbwfamvSeD6
         owSQ==
X-Gm-Message-State: AOAM5317DSxD4psvq1r7pTzNeZElvMsbn1sTP/eXihmM8+fHw8so4p0S
        ZGhSh8adBQA5YrOcT/0qBH+nzw==
X-Google-Smtp-Source: ABdhPJzoCuCELOP2WoaUKlUJCsFhhYn+hNPXO+xXMd3L2bA+kETEMwyKuSgNHgRGyEJ8wK1hAk2mPA==
X-Received: by 2002:a17:902:c1cb:: with SMTP id c11mr3089735plc.153.1598716730011;
        Sat, 29 Aug 2020 08:58:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id j20sm3131714pfi.122.2020.08.29.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:58:49 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 4/7] arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
Date:   Sat, 29 Aug 2020 21:28:20 +0530
Message-Id: <20200829155823.247360-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829155823.247360-1-jagan@amarulasolutions.com>
References: <20200829155823.247360-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
Changes for v2:
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

