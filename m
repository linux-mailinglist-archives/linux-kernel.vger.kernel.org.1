Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57452F9348
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbhAQPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbhAQPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:10:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD967C061574;
        Sun, 17 Jan 2021 07:10:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r12so8773838ejb.9;
        Sun, 17 Jan 2021 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j9PRWzzs1VCnzZhzvE9WLio7jj+fP82Dt/QONc1WWeE=;
        b=JNHuAa2LKAmjkB+NLBzKLAdxUJuRy1wJjbJh6YLZ+y2LPMqBge1rAwbhLc0hmHchyK
         oqHABnaUt6adkFi5RyVrgvANo5UznA81mY3tuR70cdfsMAL8xIwji7Q6tYjMoUHOVRq/
         68KzIPUcXI+996jY9ajZQB8WrhwHrIWRLZrtKKTvfAtJoM2UjxBjPD2scs/l/pHJ8/TR
         wJVAQdJrv0xB5E2Jf2Z7sAtCUh7VDBlHcrt7lfnkPeli+eUMIstrsq0WFKenNCEovoC2
         cLYxh3Z3tgoKNL3h+gL30D4ZPL6WN+EHFgRUiA1H+ieeKaf3dOuD4+y8W0H7fc+VauK9
         wPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j9PRWzzs1VCnzZhzvE9WLio7jj+fP82Dt/QONc1WWeE=;
        b=M1wRXrCwvVGKlbNHUTtD703pk8gjfxeEUsfKVzNoGf60rXYWP4RFy+0j/ZjOFof11i
         YCdxxEhwcEMq5UEOiZf9D+zcmgVOdEi4HJDyOIyTqWSxmqaqfxs+awx9hGETwkk3GFl5
         PiUeiX8G5mX/eKnXAPWJoYJP+u07tFzhkrq4JPFPC2UQ+eoAhdCxuYd6N/uPWIlNxb5p
         hrGKn+5E8AVFOzRhRDZQnhlpaNoj6GxRWgAKZ6SXhO1prrenqgelp6PVEdUkoqCPSgJW
         GefiGC2LW0AnIKZZ087UnxG5raqp4wR1XyLSpJU0cBlMwb3mvXaGuwN2hIvJmVG1XRjs
         hDdg==
X-Gm-Message-State: AOAM5335WK22G3sj5MmnfgJziidCC/jvm4kLZcJRl/ztpPFStF1PWFNx
        ha3yGUyScB/MPVsBiscZuLo=
X-Google-Smtp-Source: ABdhPJwZWXCJ0UvvQw7hz2eYcZ9L/c1mFBT6Jbep82MAc0b+Zmzykwrx83D0+xw5LGgyXhfAE4KJGQ==
X-Received: by 2002:a17:906:f246:: with SMTP id gy6mr3171712ejb.264.1610896201577;
        Sun, 17 Jan 2021 07:10:01 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g3sm6295121eds.69.2021.01.17.07.10.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:10:00 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: rockchip: rename thermal subnodes for rk3288.dtsi
Date:   Sun, 17 Jan 2021 16:09:51 +0100
Message-Id: <20210117150953.16475-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:
/arch/arm/boot/dts/rk3288-tinker.dt.yaml:
thermal-zones: 'cpu_thermal', 'gpu_thermal', 'reserve_thermal'
do not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Rename Rockchip rk3288 thermal subnodes
so that it ends with "-thermal"

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/
thermal/thermal-zones.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 01ea1f170..29ffe2eb9 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -488,14 +488,14 @@
 	};
 
 	thermal-zones {
-		reserve_thermal: reserve_thermal {
+		reserve_thermal: reserve-thermal {
 			polling-delay-passive = <1000>; /* milliseconds */
 			polling-delay = <5000>; /* milliseconds */
 
 			thermal-sensors = <&tsadc 0>;
 		};
 
-		cpu_thermal: cpu_thermal {
+		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <100>; /* milliseconds */
 			polling-delay = <5000>; /* milliseconds */
 
@@ -539,7 +539,7 @@
 			};
 		};
 
-		gpu_thermal: gpu_thermal {
+		gpu_thermal: gpu-thermal {
 			polling-delay-passive = <100>; /* milliseconds */
 			polling-delay = <5000>; /* milliseconds */
 
-- 
2.11.0

