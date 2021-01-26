Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E330459F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393181AbhAZRp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389666AbhAZIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:10:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC760C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:09:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e15so1906027wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKVzDfUlQORvUNQIyh1sGOYZQD9pBhXKJEodxKHGxUE=;
        b=FIogEhBVacSyx3uxTnBOjRkSnqfQvJa/Qf5CS/5ZgsfB4pQr+sePDse0GY2rMFTiyl
         f7VkQzsEhci/6CxECtBB5SMWVKuIV8sSvmOfqQzfEgKZMyZYM+KXR8rdGDegzssF92I7
         4bFDwCVMi+SsBwHT5tbrlw958MYAG6fnvTptqZPcpVocBA8xtPjegGp/WFmT1t3hwmlV
         fAk4ZTwy+v0y36yz0hxbKwx5jDq2EXlwiT+mERdbmDJV0s7fvFZWnrSzCSdx6DYGzgWG
         qqwY2MkWxo2b8VKMqzBmi20cbBZzWr4402fu5eMeKXW6tq76fQ1cBIwAEaydSxcNlkev
         hXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKVzDfUlQORvUNQIyh1sGOYZQD9pBhXKJEodxKHGxUE=;
        b=pJJgTSU+CI0YtobENEsquCFBhtu08bSQIA+yPfvqu1FS62jn91aH1Y9n47jZOXmWvQ
         RBMVnqFMHwldH6FcJlrdwAGHgZy4XxxBiDUAsEyVpdtbVOYVU8cqhauyU8FOHSkQoxhj
         zdbykiCF4uoWx7cv/BNNdjr+x1Tmkl9MqgMa4VLJO6e/s26SzVzbn5ucShkYotsKvVRZ
         RjBTX/Qi7/MPP30cWttFuiW+rpZTUrYikGTAhm58fyB2+msxX3qyGORgxaZDBbyi3W/X
         C4PuuhAi9FNEwVon7Ko79WX2WGWZFRy/8zZOAPmhX2ZURD7GQ7+Lp8fOWRTWDDncDo/I
         0KOg==
X-Gm-Message-State: AOAM5301OD3yMnYMsTk2f4fJuz/Zy+8mHEN/RldlHeSjIWEIIrKo31mp
        kOL02p4fj0uoZF/eMZCIFZasBw==
X-Google-Smtp-Source: ABdhPJzxiu4+Dwy4IN/+uDif4C1jKhZe+OrFq076G7xg19pOJbsxiSm/zf1EhIGBd+IGBWHNbYNy3g==
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr3381888wmd.121.1611648597861;
        Tue, 26 Jan 2021 00:09:57 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:485d:4b34:2d87:12d5])
        by smtp.gmail.com with ESMTPSA id t25sm2061228wmj.39.2021.01.26.00.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 00:09:57 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH] Revert "arm64: dts: amlogic: add missing ethernet reset ID"
Date:   Tue, 26 Jan 2021 09:09:51 +0100
Message-Id: <20210126080951.2383740-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been reported on IRC and in KernelCI boot tests, this change breaks
internal PHY support on the Amlogic G12A/SM1 Based boards.

We suspect the added signal to reset more than the Ethernet MAC but also
the MDIO/(RG)MII mux used to redirect the MAC signals to the internal PHY.

This reverts commit f3362f0c18174a1f334a419ab7d567a36bd1b3f3 while we find
and acceptable solution to cleanly reset the Ethernet MAC.

Reported-by: Corentin Labbe <clabbe@baylibre.com>
Acked-by: Jérôme Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi Kevin,

This has been reported to also break on 5.10, when this lands on 5.11, I'll send another
patch for 5.10 because meson-axg.dtsi needs a conflict resolution on 5.11.

Jerome gave me his ack off-list.

Neil


 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 2 --
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 --
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index ba1c6dfdc4b6..d945c84ab697 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -280,8 +280,6 @@ ethmac: ethernet@ff3f0000 {
 				      "timing-adjustment";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
-			resets = <&reset RESET_ETHERNET>;
-			reset-names = "stmmaceth";
 			power-domains = <&pwrc PWRC_AXG_ETHERNET_MEM_ID>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 9c90d562ada1..851eeb5e9de1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -224,8 +224,6 @@ ethmac: ethernet@ff3f0000 {
 				      "timing-adjustment";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
-			resets = <&reset RESET_ETHERNET>;
-			reset-names = "stmmaceth";
 			status = "disabled";
 
 			mdio0: mdio {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 726b91d3a905..0edd137151f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -13,7 +13,6 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/meson-gxbb-power.h>
-#include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -576,8 +575,6 @@ ethmac: ethernet@c9410000 {
 			interrupt-names = "macirq";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
-			resets = <&reset RESET_ETHERNET>;
-			reset-names = "stmmaceth";
 			power-domains = <&pwrc PWRC_GXBB_ETHERNET_MEM_ID>;
 			status = "disabled";
 		};
-- 
2.25.1

