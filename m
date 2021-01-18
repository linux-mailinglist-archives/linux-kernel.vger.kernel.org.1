Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE92FA837
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436722AbhARSCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407439AbhARSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:01:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F8C061573;
        Mon, 18 Jan 2021 10:01:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b2so18566860edm.3;
        Mon, 18 Jan 2021 10:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t9C6m1Bp+7ojBwZjrpoSk7AZP13lnZCWBFDi9dyawb8=;
        b=T7xA2Fg3WnborDBN+VfiJCWwtJa4Txobvi+h19s7rwTI+pMe/bLXTKA7WcQGuek0NE
         9+Zs5map31SnyxvvGzYCLuYSUejNcsqH0V9lrwTwnjPeooJmRmhZSUC8kS0tF6A0ZsNt
         k42Twv+5qGejIVQ81vsP34cyAkM2jCqSyvdWQ6uvjBu6vPJUbIBx1i8A48vgOO07Qqes
         c6kpRHIfkkbfCxtcG1vZ4JV511Qpj2vTt3Tej5G7OD6SrxD98wt3JTcFi3eA8EnzXZqN
         GJq3AssRXz5/suu+SiHslnNh3Ft5zZeiuQz+HbaOXKcj4RQIRtin76gfglix2V9Fq/EB
         q7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t9C6m1Bp+7ojBwZjrpoSk7AZP13lnZCWBFDi9dyawb8=;
        b=tN4ExU083G9xoLkZ6+pkKtrF797s/2vnFT5bKHxVzYgNWMKMoTMc3VAOVG+IQV9BbU
         nwmSqrkfSJVo+tcgvRRwr7hlY7IH8sCvBx8T3QJbv9s1N3pAJjUXTygji2fsnTDCVcPi
         jNfOMPx/IYosKSctKS5bk1whVLl0BkrpNQLtOFif8lZvNWWetN5acm4Y8rkUqMO5GMXE
         KuX4pAI1vgrKRn7WK1meRUyRe4F+YMhCSXqyBwsm+T+YVtmyy531AzygzRMcgJCCOrq/
         RHs+nN5cMWd8f8rVPlnr409hSrbSXGYxOPzkrLIFkeSkExWc18t3CcgNT9dQcFyXZ7GF
         U+Iw==
X-Gm-Message-State: AOAM533nsLgHXEKq0WENY+nX9ZZFXYNSpKv7YLXEOBcrCKdhKOAvJkVV
        8YvqihGFk+sulXVnYQsQJuI=
X-Google-Smtp-Source: ABdhPJwaKfyxX61XGB9UTG9bK8k96xqpEtLIU7WIxVaNUGPzsrB8xueLvnSEP0lvu/gG7alLl2UGWA==
X-Received: by 2002:a05:6402:50ca:: with SMTP id h10mr481300edb.181.1610992863042;
        Mon, 18 Jan 2021 10:01:03 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id gb14sm9447178ejc.61.2021.01.18.10.01.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:01:02 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: cleanup cpu_thermal node of rk3399-rock960.dts
Date:   Mon, 18 Jan 2021 19:00:54 +0100
Message-Id: <20210118180054.9360-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_thermal node in the rk3399-rock960.dts file does not
reference &cpu_thermal directly to add the board-specific parts,
but also repeats all the SoC default properties.
Clean the whole thing up and fix alignment.
Place new nodes in the correct alphabetical order.
Compered to rk3399.dtsi the temperature property in
cpu_alert0 changes from <70000> to <65000>.
A sustainable-power property was added.
The trip property in cooling map0 points to <&cpu_alert1>
instead of <&cpu_alert0>.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 53 +++++++------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index b20774081..1a23e8f3c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -63,6 +63,20 @@
 
 };
 
+&cpu_alert0 {
+	temperature = <65000>;
+};
+
+&cpu_thermal {
+	sustainable-power = <1550>;
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu_alert1>;
+		};
+	};
+};
+
 &pcie0 {
 	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
 };
@@ -125,45 +139,6 @@
 	status = "okay";
 };
 
-&thermal_zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive = <100>;
-		polling-delay = <1000>;
-		thermal-sensors = <&tsadc 0>;
-		sustainable-power = <1550>;
-
-		trips {
-			cpu_alert0: cpu_alert0 {
-				    temperature = <65000>;
-				    hysteresis = <2000>;
-				    type = "passive";
-			};
-
-			cpu_alert1: cpu_alert1 {
-				    temperature = <75000>;
-				    hysteresis = <2000>;
-				    type = "passive";
-			};
-
-			cpu_crit: cpu_crit {
-				  temperature = <95000>;
-				  hysteresis = <2000>;
-				  type = "critical";
-			};
-		};
-
-		cooling-maps {
-			     map0 {
-
-			     trip = <&cpu_alert1>;
-			     cooling-device =
-					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-			};
-		};
-	};
-};
-
 &usbdrd_dwc3_0 {
 	dr_mode = "otg";
 };
-- 
2.11.0

