Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1882CA431
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbgLANpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391166AbgLANpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:45:07 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B615C061A4B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:43:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p6so1149702plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOB84R26CoZQA91b93xytogHngTBkirbQivQiUAvSZ8=;
        b=WF6NTtrljoUI8VDrrXKRQNZMUo3sZpPtwXncI77Eh5b/yLWbwXVVDd2e5GxzmBehWM
         iLJgca6ShKHyZ+hteIe0wcmc4NmhcpaYU4vdpEt3HE20RVTDJDvtId2319wiU4s7OuST
         cywS02e7AegSTmHZMU4BhxjYvObD7HE5zCKOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOB84R26CoZQA91b93xytogHngTBkirbQivQiUAvSZ8=;
        b=MFlHl8GBtdc4qv6CAXwm4cTTQ2LOEDwBufPjRTQK1Noycg5kKkfi9R/fe+4zfZYWxb
         F74E8/rsysdLRKbOQ7hLShE5HWsE+AHft0y9bcF2RCWPcJ2HleaviGq2Tn4AcKXpH/7u
         yNOzj0Zh7kJ93GrHEp3aqtZYPooWP4N4REA9FJt+8CJteP/Uip9y0dDr5X4FqU2P7FA+
         PDJAwIDhqOWfJIdxlb3IkHixiYaRpIF17eEp/WCLghZLj3AjTOXOs9pXUBngsCe+GGwt
         9xAdvFmh4Fd4rBWWG8iKTeIeIbmwbckcOYYpt743R9dDUx+aQBJ0/Yqov+eeuVGCnkAo
         yxSg==
X-Gm-Message-State: AOAM530LVvMKh/itx/8OGJBnVxj0UrhVNP5YivslM06OGCPLWsP3cfSN
        4Ly1YbCTazOw0+1A1VwoQf/Hrg==
X-Google-Smtp-Source: ABdhPJwc0NvZ68gepyb5EB381x8XYKBVMFc2+YBBRdd8e2c6Zew+ZunZVzKA2CFEiB5+u1J7MgYlAw==
X-Received: by 2002:a17:90b:4b11:: with SMTP id lx17mr2824634pjb.154.1606830229035;
        Tue, 01 Dec 2020 05:43:49 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id g14sm2839248pji.32.2020.12.01.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:43:48 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v2 04/10] ARM: mstar: Add infinity2m support
Date:   Tue,  1 Dec 2020 22:43:24 +0900
Message-Id: <20201201134330.3037007-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201134330.3037007-1-daniel@0x0f.com>
References: <20201201134330.3037007-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infinity2m series of chips are like the other Mstar/Sigmastar
chips in that they have a Cortex A7 system with DDR memory integrated
in a single package.

The infinity2m chips are intended for recording the incoming streams
from IP cameras. So instead of video encoders they have video decoders,
instead of a camera interface they have display hardware and so on.

Aside from the above points the big difference about these chips is that
they include a second Cortex A7 core.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/mstar-v7.dtsi         |  2 +-
 arch/arm/mach-mstar/mstarv7.c           |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m.dtsi

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
new file mode 100644
index 000000000000..02adb9fe9d3c
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "mstar-infinity.dtsi"
+
+&cpus {
+	cpu1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a7";
+		reg = <0x1>;
+	};
+};
diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 07fc46c7b4d4..2862b32c7f63 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -13,7 +13,7 @@ / {
 	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/mach-mstar/mstarv7.c b/arch/arm/mach-mstar/mstarv7.c
index 81a4cbcab206..1aa748fa006e 100644
--- a/arch/arm/mach-mstar/mstarv7.c
+++ b/arch/arm/mach-mstar/mstarv7.c
@@ -35,6 +35,7 @@ static void __iomem *l3bridge;
 
 static const char * const mstarv7_board_dt_compat[] __initconst = {
 	"mstar,infinity",
+	"mstar,infinity2m",
 	"mstar,infinity3",
 	"mstar,mercury5",
 	NULL,
-- 
2.29.2

