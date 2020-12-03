Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA452CCF07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgLCGQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgLCGQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:16:50 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ABAC061A4D;
        Wed,  2 Dec 2020 22:16:10 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so635960wrc.8;
        Wed, 02 Dec 2020 22:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gJfgbMx5UCVGZoNqzKdjkvqOZ2ILsN+qlvohK/C4/eg=;
        b=tjINT1s6ViX3a5aTZOZFp2S9ZYVBKaOeEVq24XEoMGu0j9P1Ng1fVtwceZOUouewzd
         O8ySkp7JpSMpOS2Tql/L4VwPc07fk9kZixP5l56AEVuZwNmX0UV1FI96CM3wldQDEzqJ
         U0mEGkSWBoQ3dPEGtrMBv7LV2qnSjitWjQuNXj9m0w5h878jaIHq7aGZHf1gy8DraC+l
         KIY4Rd+cynUAoN/q3PvzzK2DJMIVqEYdtiX6dtaEPwHGuLvq/diuVktZfXTf0nNmNRUP
         2Gs6madbXIcIh6OFC9z6pqqxRUys1dVb+N5EdsU1AvpeR/s/vVbFIHvPslPlqq5nmCHu
         wjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gJfgbMx5UCVGZoNqzKdjkvqOZ2ILsN+qlvohK/C4/eg=;
        b=Wr1H3YDWV6R9aI97f35/VO6AbNmxv19Z45FzvQp35O+qgmmWm3O+kVEiILjnDE0kSL
         nXfuxAH2+RcRBRY4VimRdKN4Ta0ZIoEEOd/gI3ZAWNX0iYrX0BS9UJ23m/pCFtudG7ek
         /OcikP8Ad4N8ryZk1TGORX6XnTZQ+nj8xwlGiLCcj7GE63sHPHzwO3ctNeBP6d2Dq1MN
         cQeVPSKmPXg+4ZAvSCeNs7XT+u72MEXfYnhIswPNJz+V/V6J2dKwOqx4U24RFPCR0Ul4
         nC0FoJclJH450W+1g6f0wn/WOwvwuZunoOEKvA53xl/eDW1uYXMsNOT2mR4SYlCgwLa6
         AvfQ==
X-Gm-Message-State: AOAM531NtycaFHF2By0c3VGV300uooWxiXIfPHGsBvyf58M9NrAjBcd+
        wglVQ8Zkf7GdJw2/dXdSJac=
X-Google-Smtp-Source: ABdhPJzI7F2jC8UlYveoOW71/rRyzpdMhwuemS5A5oZfn8s3w2a02yBYz+Bgz8Nchl4yBdBV1Ue+mg==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr1767372wrr.351.1606976169182;
        Wed, 02 Dec 2020 22:16:09 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c187sm48081wmd.23.2020.12.02.22.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:16:08 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: minor fixups for Khadas VIM/VIM2 dts
Date:   Thu,  3 Dec 2020 06:16:05 +0000
Message-Id: <20201203061605.9603-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the VIM/VIM2 includes/bindings to follow the format of other dts
in the Amlogic tree and remove a stray empty line in the VIM2 dts.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
This patch depends on the v4 "arm64: dts: meson: add more GX soundcards" series [0]
being merged first.

[0] http://lists.infradead.org/pipermail/linux-amlogic/2020-December/009236.html

 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts      | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 7aa08f74c49b..6fe589cd2ba2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -5,9 +5,8 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-
 #include "meson-gxl-s905x-p212.dtsi"
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/sound/meson-aiu.h>
 
 / {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 0250c98dbe9e..955a63aaa5ed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -7,9 +7,8 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-
 #include "meson-gxm.dtsi"
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/sound/meson-aiu.h>
 
 / {
@@ -194,7 +193,6 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
-
 &cpu_cooling_maps {
 	map0 {
 		cooling-device = <&gpio_fan THERMAL_NO_LIMIT 1>;
-- 
2.17.1
