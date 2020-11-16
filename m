Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8E2B3D35
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgKPGlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgKPGly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:41:54 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3578C0613CF;
        Sun, 15 Nov 2020 22:41:53 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so17392490wrw.10;
        Sun, 15 Nov 2020 22:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8abYbNHeOAKQO+ZnwqKzB6uY0HVsB9/O47UXrKWrphc=;
        b=ms0KGcSEoD6prNcUVV6jXCA5mwD5UL1h/dM/06oqjlm2pib1Qm4MGGYgmubv10K5rD
         OOTfTd5AW2vT/MJmB/ewnwIXD5jdKknpKHk05AYL4hx3G/Y6N94Lnc4qxRZG1+JG7M4n
         E/Rj7K2vPCw8ty0ag89sHgrtLQOkWDCRW/yulZpG+uGCrrljHsivpUMvj3SQsGQ0VgRU
         OEBrA2FOwUL0ETHeuydj4BadVgHk4pSE50kNiRaKvAjejzrYUUbZ+WgQjpjQOL15ogra
         8Euo67DgEkw4xJpCIDwwE1AtwQfT+0xBJTVhThy+z5+i+0a7yyYyGb5HtV8Sx5cUZoye
         czow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8abYbNHeOAKQO+ZnwqKzB6uY0HVsB9/O47UXrKWrphc=;
        b=GKElWlF7zugPWG9dZnkbiMHvJXm5anAcZbp/hhixjqGpTGEa/sPs0/qH8hZCZfN0/K
         40P/HnQ3oTtexVgthkPK0Qyln4yvEcNqotssYgps6k7xlgg2+hTiqILDr1D0yx6uipXc
         EhkGxgpbVbWTlFSs6VB7ErBMykxzOe2HUA4I+YOoWgjtDuBBjdnqCUsOza/s7Z+MsQ30
         to8JVKUUq1cIBWj7nSavXivZ2vCF+DTSPLO0qZUTABx4+ifl7C0jTaAGgkaaLbZwwkHY
         gy2RvaW4/RN93IQSp0m4sOLlGYHe+ivBI5A/W/a17R8DvnDuYaQuGTlbJQ8+1FuoVT5b
         n/jA==
X-Gm-Message-State: AOAM532k31pbZjYm95W31EPAEBa3xxXNbtzQG4Q4Q91x1g99igK81U7m
        8QNfzIeOkAjt3a2qmtOhx8A=
X-Google-Smtp-Source: ABdhPJzN0JvWNHwbBHX8nxXHawQXm8cIFplFzvAQL5EiogeRN+gqI26t/xG8oPw4S+m57psA1CPsGA==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr18535487wrt.38.1605508912575;
        Sun, 15 Nov 2020 22:41:52 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r8sm21262631wrq.14.2020.11.15.22.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:41:51 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>
Subject: [PATCH] arm64: dts: meson: enable rtc node on Khadas VIM1/VIM2 boards
Date:   Mon, 16 Nov 2020 06:41:47 +0000
Message-Id: <20201116064147.12062-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the rtc node on VIM1/VIM2 boards so users can simply attach a power
cell and use the on-board RTC without modifying the device-tree.

Cold boot with no cell attached is gracefully handled:

VIM2:~ # dmesg | grep rtc
[    7.716150] rtc-hym8563 1-0051: no valid clock/calendar values available
[    7.716957] rtc-hym8563 1-0051: registered as rtc0
[    7.729850] rtc-hym8563 1-0051: no valid clock/calendar values available
[    7.729877] rtc-hym8563 1-0051: hctosys: unable to read the hardware clock
[    8.126768] rtc-hym8563 1-0051: no valid clock/calendar values available

Warm boot (and any boot with cell attached) recalls stored values resulting
in consistently faster (re)boot times:

VIM2:~ # dmesg | grep rtc
[    7.441671] rtc-hym8563 1-0051: registered as rtc0
[    7.442663] rtc-hym8563 1-0051: setting system clock to 2020-11-16T05:49:59 UTC (1605505799)

Suggested-by: Artem Lapkin <art@khadas.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---

This supersedes other recent attempts by Art to make the same change [0]
and [1] which were rejected for lack of justification for the change and
leaving comments behind. I have been using the same changes in my own
tree for a while.

Christian

[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20200925033017.1790973-8-art@khadas.com/
[1] https://patchwork.kernel.org/project/linux-amlogic/patch/20200925033017.1790973-9-art@khadas.com/

 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts      | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 8bcdffdf55d0..638a5992d760 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -97,8 +97,7 @@
 	pinctrl-names = "default";
 
 	rtc: rtc@51 {
-		/* has to be enabled manually when a battery is connected: */
-		status = "disabled";
+		status = "okay";
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index bff8ec2c1c70..da000c10b945 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -228,8 +228,7 @@
 	pinctrl-names = "default";
 
 	rtc: rtc@51 {
-		/* has to be enabled manually when a battery is connected: */
-		status = "disabled";
+		status = "okay";
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-- 
2.17.1

