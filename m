Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B25B300113
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbhAVK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbhAVKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:52:04 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526EC0612F2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:51:15 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q131so3428751pfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IvP3Ma3+woV2oq3EN9w3VxuCelFndEmoc/p15PUWCoI=;
        b=qIzBgw3jW7F+GTnEAUQS9lOmWPtddtULB+IUna2qDntsPazCkt8S4I/8Q3M8lUHmu/
         JPsMXN23lxyNkHzvrm1qM4sPjxQTnNaX4nwFXRPXKvcNYkqA8t7u+5B9hRxMxyEypf93
         ARgbOWGTEovalb+yr32e2j1tjoUfM39rZquLXDctAZ0wApx8c/X3JMENijj0dhke127L
         x57/iyb8sEPqnhFzYwN99mAAdrB24cfT9ketruUP2ofmPh7cRQusjXqziN/WRk+uEp0X
         FLWnvV96f0YcMBE/2XTtsn/eDck9AnEstu33UxzCsSLJ9paJ44qeHCa5rVW786ByMVUy
         6E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IvP3Ma3+woV2oq3EN9w3VxuCelFndEmoc/p15PUWCoI=;
        b=GfNq+ofS5EVA2WxTHQCxXWCptPZm3xaN3AnLjVrYbM4Rexuyyke4IoSAA5hnMWKwDF
         2O5goY5TPP0xTvFuCawflZw1FdR4sEZsr9QBynzmeq32WIAET7G4RSvLAmntenYl+aHw
         9BvUFNprFSqX5Q4sOzUHvv5ZjEQbX3KxHm1nu7LVdsXlaERt4Nj15OH4RSoaWVTFEV6c
         WG6Oov/a4q0LEZDEwTAQIZ68o6wc6eftF5MQBGtWtQn7Yynbojw+LS3A3YQqoVY3wxkw
         rLvFL/yFD8qaY+5A7+0qIl01qrRg7PzBtI2SxsxhP/h2nwQ0QjCGWx0evj2/F6NsDmRz
         HHKw==
X-Gm-Message-State: AOAM5304n1K5jimMfhkwNcLuNnuQd73rDQsZd6m0Yyfbb7GfSvVOnNjy
        43ybB5nIrmFYf3vz18qtSm0FfQ==
X-Google-Smtp-Source: ABdhPJxJHo1AN1zLtdbhJXU7ak18Jk+r/S30oIKR5lQtHnBNzgcqgiAvAh8RA9KXNPcUxmYgA1ZPBg==
X-Received: by 2002:aa7:8104:0:b029:1ae:684f:d140 with SMTP id b4-20020aa781040000b02901ae684fd140mr4249323pfi.62.1611312675006;
        Fri, 22 Jan 2021 02:51:15 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 6sm9292068pjm.31.2021.01.22.02.51.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 02:51:14 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH V6 5/6] of: unittest: Create overlay_common.dtsi and testcases_common.dtsi
Date:   Fri, 22 Jan 2021 16:20:35 +0530
Message-Id: <94180731aa4a17e4834458a979de7de782dc73d4.1611312122.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611312122.git.viresh.kumar@linaro.org>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to build-test the same unit-test files using fdtoverlay tool,
move the device nodes from the existing overlay_base.dts and
testcases_common.dts files to .dtsi files. The .dts files now include
the new .dtsi files, resulting in exactly the same behavior as earlier.

The .dtsi files can now be reused for compile time tests using
fdtoverlay (will be done in a later patch).

This is required because the base files passed to fdtoverlay tool
shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
tag).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
 drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
 drivers/of/unittest-data/testcases.dts        | 17 +---
 .../of/unittest-data/testcases_common.dtsi    | 18 ++++
 4 files changed, 111 insertions(+), 105 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
 create mode 100644 drivers/of/unittest-data/testcases_common.dtsi

diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dts
index 99ab9d12d00b..ab9014589c5d 100644
--- a/drivers/of/unittest-data/overlay_base.dts
+++ b/drivers/of/unittest-data/overlay_base.dts
@@ -2,92 +2,4 @@
 /dts-v1/;
 /plugin/;
 
-/*
- * Base device tree that overlays will be applied against.
- *
- * Do not add any properties in node "/".
- * Do not add any nodes other than "/testcase-data-2" in node "/".
- * Do not add anything that would result in dtc creating node "/__fixups__".
- * dtc will create nodes "/__symbols__" and "/__local_fixups__".
- */
-
-/ {
-	testcase-data-2 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		electric_1: substation@100 {
-			compatible = "ot,big-volts-control";
-			reg = < 0x00000100 0x100 >;
-			status = "disabled";
-
-			hvac_1: hvac-medium-1 {
-				compatible = "ot,hvac-medium";
-				heat-range = < 50 75 >;
-				cool-range = < 60 80 >;
-			};
-
-			spin_ctrl_1: motor-1 {
-				compatible = "ot,ferris-wheel-motor";
-				spin = "clockwise";
-				rpm_avail = < 50 >;
-			};
-
-			spin_ctrl_2: motor-8 {
-				compatible = "ot,roller-coaster-motor";
-			};
-		};
-
-		rides_1: fairway-1 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "ot,rides";
-			status = "disabled";
-			orientation = < 127 >;
-
-			ride@100 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "ot,roller-coaster";
-				reg = < 0x00000100 0x100 >;
-				hvac-provider = < &hvac_1 >;
-				hvac-thermostat = < 29 > ;
-				hvac-zones = < 14 >;
-				hvac-zone-names = "operator";
-				spin-controller = < &spin_ctrl_2 5 &spin_ctrl_2 7 >;
-				spin-controller-names = "track_1", "track_2";
-				queues = < 2 >;
-
-				track@30 {
-					reg = < 0x00000030 0x10 >;
-				};
-
-				track@40 {
-					reg = < 0x00000040 0x10 >;
-				};
-
-			};
-		};
-
-		lights_1: lights@30000 {
-			compatible = "ot,work-lights";
-			reg = < 0x00030000 0x1000 >;
-			status = "disabled";
-		};
-
-		lights_2: lights@40000 {
-			compatible = "ot,show-lights";
-			reg = < 0x00040000 0x1000 >;
-			status = "disabled";
-			rate = < 13 138 >;
-		};
-
-		retail_1: vending@50000 {
-			reg = < 0x00050000 0x1000 >;
-			compatible = "ot,tickets";
-			status = "disabled";
-		};
-
-	};
-};
-
+#include "overlay_common.dtsi"
diff --git a/drivers/of/unittest-data/overlay_common.dtsi b/drivers/of/unittest-data/overlay_common.dtsi
new file mode 100644
index 000000000000..08874a72556e
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_common.dtsi
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Base device tree that overlays will be applied against.
+ *
+ * Do not add any properties in node "/".
+ * Do not add any nodes other than "/testcase-data-2" in node "/".
+ * Do not add anything that would result in dtc creating node "/__fixups__".
+ * dtc will create nodes "/__symbols__" and "/__local_fixups__".
+ */
+
+/ {
+	testcase-data-2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		electric_1: substation@100 {
+			compatible = "ot,big-volts-control";
+			reg = < 0x00000100 0x100 >;
+			status = "disabled";
+
+			hvac_1: hvac-medium-1 {
+				compatible = "ot,hvac-medium";
+				heat-range = < 50 75 >;
+				cool-range = < 60 80 >;
+			};
+
+			spin_ctrl_1: motor-1 {
+				compatible = "ot,ferris-wheel-motor";
+				spin = "clockwise";
+				rpm_avail = < 50 >;
+			};
+
+			spin_ctrl_2: motor-8 {
+				compatible = "ot,roller-coaster-motor";
+			};
+		};
+
+		rides_1: fairway-1 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "ot,rides";
+			status = "disabled";
+			orientation = < 127 >;
+
+			ride@100 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "ot,roller-coaster";
+				reg = < 0x00000100 0x100 >;
+				hvac-provider = < &hvac_1 >;
+				hvac-thermostat = < 29 > ;
+				hvac-zones = < 14 >;
+				hvac-zone-names = "operator";
+				spin-controller = < &spin_ctrl_2 5 &spin_ctrl_2 7 >;
+				spin-controller-names = "track_1", "track_2";
+				queues = < 2 >;
+
+				track@30 {
+					reg = < 0x00000030 0x10 >;
+				};
+
+				track@40 {
+					reg = < 0x00000040 0x10 >;
+				};
+
+			};
+		};
+
+		lights_1: lights@30000 {
+			compatible = "ot,work-lights";
+			reg = < 0x00030000 0x1000 >;
+			status = "disabled";
+		};
+
+		lights_2: lights@40000 {
+			compatible = "ot,show-lights";
+			reg = < 0x00040000 0x1000 >;
+			status = "disabled";
+			rate = < 13 138 >;
+		};
+
+		retail_1: vending@50000 {
+			reg = < 0x00050000 0x1000 >;
+			compatible = "ot,tickets";
+			status = "disabled";
+		};
+
+	};
+};
+
diff --git a/drivers/of/unittest-data/testcases.dts b/drivers/of/unittest-data/testcases.dts
index a85b5e1c381a..185125085784 100644
--- a/drivers/of/unittest-data/testcases.dts
+++ b/drivers/of/unittest-data/testcases.dts
@@ -2,19 +2,4 @@
 /dts-v1/;
 /plugin/;
 
-/ {
-	testcase-data {
-		changeset {
-			prop-update = "hello";
-			prop-remove = "world";
-			node-remove {
-			};
-		};
-	};
-};
-#include "tests-phandle.dtsi"
-#include "tests-interrupts.dtsi"
-#include "tests-match.dtsi"
-#include "tests-address.dtsi"
-#include "tests-platform.dtsi"
-#include "tests-overlay.dtsi"
+#include "testcases_common.dtsi"
diff --git a/drivers/of/unittest-data/testcases_common.dtsi b/drivers/of/unittest-data/testcases_common.dtsi
new file mode 100644
index 000000000000..05f16606b6a5
--- /dev/null
+++ b/drivers/of/unittest-data/testcases_common.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	testcase-data {
+		changeset {
+			prop-update = "hello";
+			prop-remove = "world";
+			node-remove {
+			};
+		};
+	};
+};
+#include "tests-phandle.dtsi"
+#include "tests-interrupts.dtsi"
+#include "tests-match.dtsi"
+#include "tests-address.dtsi"
+#include "tests-platform.dtsi"
+#include "tests-overlay.dtsi"
-- 
2.25.0.rc1.19.g042ed3e048af

