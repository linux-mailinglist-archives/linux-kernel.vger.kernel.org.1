Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037C02F934B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbhAQPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbhAQPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:10:45 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D3C061757;
        Sun, 17 Jan 2021 07:10:04 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id w1so20100640ejf.11;
        Sun, 17 Jan 2021 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DRG9e23i2SPuZfCW/3STyimbjAw4V/3t5/u6E4VRlYY=;
        b=tNT+TXNvIhPH284c/OIxPeXrPhLGyt2mMyUofjpzH909fsLJ2RsQGxilTPhkBPQvts
         /ArzFD6AHVMff4if19fNp7lHRIrjhkwM+KBGKNnJSwwWntNmGytMhfAdtMPO6B4GRcmL
         eseMz7PLW6Aq+qi5Zcm6zmBLqaGdCZZ3KKCT8LYyh90u8fFMrWD0uWEb6WWr5Fps/J3N
         YBqbqMdxACSdjQWrqlJdnQ/TqU+YAhxmwRnDcEzsVTLEQoD/A/pxAgYYhbCfmPLrITwI
         240QwLtZAjTVxRv5NodQkGmuDK4v0gG+uBb3MHzA9+PXqkNx/RuYT8WBJfOWVYKu9yDX
         CXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DRG9e23i2SPuZfCW/3STyimbjAw4V/3t5/u6E4VRlYY=;
        b=j39C3yek0tjacTY80PgGw2NHAzioK82SeFrKiSkjKlFTAzYdJAUuHj3dKTO6GHtiHJ
         ea9aEJrtjMuQiHNM3oYfk07N7A0A8VPHVdBmR3QSOYl0itRmGv0Kk2SBt3V1aIyE8vO1
         A2PEk//5Ka1tVuILPbP1jqnbpN4zLlfcyoOf7uf27nB3ZZYv1XrGwTwV5gN0C0BAd/C/
         uQ0Og54fCwyRHZesH47V5yXIf0mj9WJgCju2KHReD8dvGwkZCp0YbVf8NqnXIlJXzZSf
         sSg+aSFVgp/WPRyGriLoFTcw3flrkgcNrZYFPyE6sviSm/bWgiTj/9+8s/wsz6Q6GnzR
         wUjg==
X-Gm-Message-State: AOAM533F4+si4yF/XO5ws2zHA0JOerwmDglrL2gsM3RdFvN1tTeulCZi
        5tb/upWwdkluTh3W1JogO/hz6Q9+IIs=
X-Google-Smtp-Source: ABdhPJxldbIelUhlRirTNtJCRL44lRqzuE/9xcwVyyjMHc8YTdAEMsJvdubfCMgPB/f9bWPfuxpBTQ==
X-Received: by 2002:a17:906:80c9:: with SMTP id a9mr8443492ejx.78.1610896203193;
        Sun, 17 Jan 2021 07:10:03 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g3sm6295121eds.69.2021.01.17.07.10.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:10:02 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: rename thermal subnodes for rk3399.dtsi
Date:   Sun, 17 Jan 2021 16:09:53 +0100
Message-Id: <20210117150953.16475-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210117150953.16475-1-jbx6244@gmail.com>
References: <20210117150953.16475-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:
/arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml:
thermal-zones: 'cpu', 'gpu' do not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Rename Rockchip rk3399 thermal subnodes so that it ends
with "-thermal"

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/
thermal/thermal-zones.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index c88295782..b20774081 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -126,7 +126,7 @@
 };
 
 &thermal_zones {
-	cpu_thermal: cpu {
+	cpu_thermal: cpu-thermal {
 		polling-delay-passive = <100>;
 		polling-delay = <1000>;
 		thermal-sensors = <&tsadc 0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4e94b7ebd..3de493ad6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -761,7 +761,7 @@
 	};
 
 	thermal_zones: thermal-zones {
-		cpu_thermal: cpu {
+		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <1000>;
 
@@ -805,7 +805,7 @@
 			};
 		};
 
-		gpu_thermal: gpu {
+		gpu_thermal: gpu-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <1000>;
 
-- 
2.11.0

