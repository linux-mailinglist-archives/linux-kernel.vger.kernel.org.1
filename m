Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4C82D02E1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgLFKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgLFKiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:38:05 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE05C0613D0;
        Sun,  6 Dec 2020 02:37:19 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id m19so15171592ejj.11;
        Sun, 06 Dec 2020 02:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cvwYqmCIRPdXNktVSRsny/sYz3R2ctp4JTUSP8UZAlo=;
        b=NXMUS0AKQwIKdfL3LpT+DEGWW0kJG4Pk+Hpxi4f4KZdwfVY6CcOpZKXJL1IGQys59I
         LwMWbkmH5xy6XmkLRzrUmWPVy0K2l4Otg2VX4d8O51pGFZkKT/5/lnUzngIoVg1Lh2jq
         nRNc9nfc+09MYSmc11hUlRMmbTDQzjth5QXSuD+G2MsBa5Q6uBKd8IHcyyRfeObQZLYz
         iv5l+FPeMoa27jX8+zgyF2p54OmLyardyYiHdYEDeMWds/hU/mi5HsiifQsexOVuXaeM
         arnYvXEJ69Ix41guCLok0199sIgo7GYKUf9hP6GU5+xX4eX7Ibk7GmbMs1enPLPY+uCg
         PlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cvwYqmCIRPdXNktVSRsny/sYz3R2ctp4JTUSP8UZAlo=;
        b=o2I7ZLESO2wtGKD5IaXJOpFOFvXpLgdnp9tJB2yK0xSUvUuAV+eGP3AjdKMtQVeAb6
         dHuyVOSTew8Y10WJ0ryFzNbKSV+KEphETfP9N87FzhbZuAkr4mDqPDkOgldQ9dd8ygVb
         AKOp9DN1NExjPxTYZ7Zw45SLAeT/0oMcmdIAMPW8unVNdvjJGRgf3uCDQIC4ge6wzl/j
         gva3oNWc3qTh85HV/dmWHp464dEoSPHPluvuVK2n/f16C9/bIyZOeNvuP5KYqtY2RrYv
         oQIlUuw5TrZiJbmnOhxVZhO541Xw125k7dAUPxcHMi7YRNKRaPNFrWr3765qzfWlZoK9
         moGw==
X-Gm-Message-State: AOAM5333sLu/UrGsJpOs7we6LhNH+cCL9rOc606qovMylWN42YiaKYov
        t+4zQUTR6UXdC1uWIiBH+bU=
X-Google-Smtp-Source: ABdhPJzBGFCyoZgaS437Jqs/oH/9Gprd0j90q7vrUi4o5BpVTBJdakKuh8rSwLQlpGMpIT5fDncZ3A==
X-Received: by 2002:a17:906:614:: with SMTP id s20mr14320287ejb.202.1607251038455;
        Sun, 06 Dec 2020 02:37:18 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cc8sm7811556edb.17.2020.12.06.02.37.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:37:17 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: rockchip: add QoS register compatibles for rk3066/rk3188
Date:   Sun,  6 Dec 2020 11:37:08 +0100
Message-Id: <20201206103711.7465-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of syscon.yaml minItems for compatibles
was set to 2. Current Rockchip dtsi files only use "syscon" for
QoS registers. Add Rockchip QoS compatibles for rk3066/rk3188
to reduce notifications produced with:

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed v2:
  add space
---
 arch/arm/boot/dts/rk3xxx.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 859a74779..49bcdf46d 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -151,42 +151,42 @@
 	};
 
 	qos_gpu: qos@1012d000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos", "syscon";
 		reg = <0x1012d000 0x20>;
 	};
 
 	qos_vpu: qos@1012e000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos", "syscon";
 		reg = <0x1012e000 0x20>;
 	};
 
 	qos_lcdc0: qos@1012f000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos", "syscon";
 		reg = <0x1012f000 0x20>;
 	};
 
 	qos_cif0: qos@1012f080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos", "syscon";
 		reg = <0x1012f080 0x20>;
 	};
 
 	qos_ipp: qos@1012f100 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos", "syscon";
 		reg = <0x1012f100 0x20>;
 	};
 
 	qos_lcdc1: qos@1012f180 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos", "syscon";
 		reg = <0x1012f180 0x20>;
 	};
 
 	qos_cif1: qos@1012f200 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos", "syscon";
 		reg = <0x1012f200 0x20>;
 	};
 
 	qos_rga: qos@1012f280 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos", "syscon";
 		reg = <0x1012f280 0x20>;
 	};
 
-- 
2.11.0

