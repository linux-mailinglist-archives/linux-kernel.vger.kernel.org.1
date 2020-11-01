Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE642A1BAE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 03:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKACKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 22:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgKACKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 22:10:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D3C0617A6;
        Sat, 31 Oct 2020 19:10:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k21so5903342wmi.1;
        Sat, 31 Oct 2020 19:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KLsJmKNArZL6Pckf4sczu0a6felhVt96z+x2zjsh5BU=;
        b=sjrvHAWeIWkM7yXyzWCni0Qd5/o/ydUKaPVGM5u6gdnPDe3koYkEfIzbYiDwWzDNto
         w9cC9ZpcDrO0DMdjig0zVRG0YDlRqZ6LNGdKLlrmNW5eNhP+vb9DzKDDUwzMAZOWN/0O
         aLNkMw/6DBtegeKJ/0pnoMzcMWNvhoDM8CrFaYHFSi0lTA97ZqIwNBzZhkYAi895KDJL
         b5OGC6lfJYcdJCQJ1WzrNRftz8nEicb7kgJyH7panxdA5atChMfEjVeu3FwoXsRGOLxY
         athr3hSBYU5UB42DeUFuUY9PnrhwezwjdoZ1iQ0PMxP7WTvL5N/lRGP1PIvHB3Mwgz7+
         MlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KLsJmKNArZL6Pckf4sczu0a6felhVt96z+x2zjsh5BU=;
        b=McKQrdM0ppiH2jx39NF7U4tncr2Uq5wo7ttrOctpk6EguMRFPOY5xdcFgtWAF5AswS
         3dd/V5WmeBHzTDeTWLlt2zaDzcW/MIToxasokk5quAdcIk0krcexHpD497NHZkm4OJ4y
         v0Vj5mDRexJwrSKPR6xyowdZknUPrdfmFWymlbwNB1W8mHf5tgIfMepyRFiaAj0f5IBs
         Inlbf64B1QwDlRQkI4C3L4oR9HCtRWPeK7/fiauUU7xx80+gK10oux2skHaHQxvdrHny
         nNAYOoVOjiOcl2QrjF37nf9FH7A5rZIDSiz+eUf8tPPQ1lRgTNVknt2BWVMcyz96mfK9
         0VWA==
X-Gm-Message-State: AOAM533HeWTXAO+FkSJKX1QB2kJ1DsPl0vd6CX/N8cGxleIt5MmCngyi
        P59UUpsEhRZQkS0fbs8Z4FI=
X-Google-Smtp-Source: ABdhPJzcMo1M6zDwKr7uToTCOAo8Gc/0y8/1UPRhbLyRpSvyCQuMifM4miONOBZtMBHC60wlCvoDGA==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr10760131wmj.72.1604196617939;
        Sat, 31 Oct 2020 19:10:17 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h81sm2291971wmf.44.2020.10.31.19.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 19:10:17 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add watchdog to g12-common dtsi
Date:   Sun,  1 Nov 2020 02:10:12 +0000
Message-Id: <20201101021012.24519-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G12 vendor kernels show the watchdog on the same address as AXG
so add the node to meson-g12-common.dtsi. GX boards inherit the
same from meson-gx.dtsi.

v2 fix typo in node name (s/wtd/wdt)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 1e83ec5b8c91..314095b79a45 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2179,6 +2179,12 @@
 				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
 			};
 
+			watchdog: wdt@f0d0 {
+				compatible = "amlogic,meson-gxbb-wdt";
+				reg = <0x0 0xf0d0 0x0 0x10>;
+				clocks = <&xtal>;
+			};
+
 			spicc0: spi@13000 {
 				compatible = "amlogic,meson-g12a-spicc";
 				reg = <0x0 0x13000 0x0 0x44>;
-- 
2.17.1

