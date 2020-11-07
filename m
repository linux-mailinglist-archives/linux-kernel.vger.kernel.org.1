Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D902AA6C1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgKGRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 12:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKGRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 12:01:15 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E7C0613CF;
        Sat,  7 Nov 2020 09:01:15 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id s25so6339516ejy.6;
        Sat, 07 Nov 2020 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iYx7Zu5YxaAUOh2wUpaIISnZwmtTFG2J3DAA0bojnps=;
        b=U6ov5KOO2oi2Nbht9hCtXqab7Nl5JNHRBuG2cGOcEmZehAEFGMxDJPKid9uRJra3Hu
         wXveMDyHCGG4IlCFMoKbDof6WKIsjNzhYUmtqozgiHAS9rl/MF2WVmX5Q8O+BTQXQA95
         xjytFKJKXoJwLuVZ72bN7HAW7mcY/roG2oov0WHgSfWuBGU2bM9KEN1RExG3LLM0d315
         LX2lq1Neg+ttDjRv7ODqXnwEjKijlMTILjVlAXGfbN7jO3uVi/wjlBzpXh27qGvoaPNl
         Qq37y+Rc9AVAUGdH1VmhvQIF3sB6doxnncX1LVdWHRrJ/CvHwABvGwQ4orrRXxWY3cun
         QLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iYx7Zu5YxaAUOh2wUpaIISnZwmtTFG2J3DAA0bojnps=;
        b=dYvvUVdVDF9OXuAv8RYw/CDJnR19I73oCDVAViZ1B+nnqvz+mSBSvQ2H8T4ancNX9i
         drag92fcgXdu7VlXaXsZz3/nmQ2X8o4L/gtQutjm3ftpUjoMHKF26vnNn4U5pZF/mhuw
         wvAx5LWK+Flw2oL7hBjNQofi7Dc2c0uAdRhyv2KoZQlbtaFbnx9iFKMUdcQh88B5vXYu
         6ILaZ9E/XJhpHBTxw5Wk9K8WyueiJH2x0RwJtt6kzf7UVl8TJsKSt/KM/F5skyZueU+3
         aT3qV7yKzjV5UerruAqaVsBGCXpd5Pn0MgmwqGE6tWlK9+MSoarGz5LTySs562V+xLH7
         EHhQ==
X-Gm-Message-State: AOAM533nTerIGqcaKKk4r5pRZ0EQZAGNUjzSbfgSCZc9weHXRKQeM7m5
        TQ55dWod2HhoQh2ayVmZs9I=
X-Google-Smtp-Source: ABdhPJz7mUoi1CzwS6zfSfBUvQiJhIoTCcqt4t0soJXcWdAdtGuxARn9QJ+kqdJCcMLoEqPNwRU+XA==
X-Received: by 2002:a17:906:512:: with SMTP id j18mr7744965eja.370.1604768474402;
        Sat, 07 Nov 2020 09:01:14 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t22sm3729700edq.64.2020.11.07.09.01.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 09:01:13 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] dt-binding: mfd: syscon: add Rockchip QoS register compatibles
Date:   Sat,  7 Nov 2020 18:00:59 +0100
Message-Id: <20201107170103.25608-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of syscon.yaml minItems for compatibles
was set to 2. Current Rockchip dtsi files only use "syscon" for
QoS registers. Add Rockchip QoS compatibles to reduce notifications
produced with:

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 8f4764a9e..f14ae6da0 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -44,6 +44,10 @@ properties:
               - hisilicon,peri-subctrl
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
+              - rockchip,px30-qos
+              - rockchip,rk3066-qos
+              - rockchip,rk3288-qos
+              - rockchip,rk3399-qos
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
               - samsung,exynos5-sysreg
-- 
2.11.0

