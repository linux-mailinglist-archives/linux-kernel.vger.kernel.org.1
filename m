Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601E2293AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405105AbgJTMBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405063AbgJTMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:01:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A16C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:01:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so1789116wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gfqE4Zbkh5Lcg19ZhxoF1Xl/vo9JD6QrpOKZu//If4=;
        b=MgBruow4GBjUkLxhyLeZpDEx3hDjFQMfJNV+Kheh5hUPpbnOEzaXY0lrCio3y+HmyL
         4dC2SJz0yeHTGPHWIWOWwGyHtKnk3P/UM8FaEtYj2qzjmx4FVT+spQGPbOhuCg0E6BLz
         7GvNoVgB5Uzib/jjHaa821cXnXU+wY/UnYIK9+K6DdHbpl92yJ2BRzgAmwXkzZUBUnN0
         YbcmdQpyU3R3UaRTmard/coRidSvMrt3x112Rg2+CP5yAHIZh1g4HExK8cEiok7YB13b
         Hyf2oqS2MyqIgpUuHqiVOIDfH15jnYPU7sOPTmowO1DVKw9jsB3aXWzDxl9+szbKFm6p
         BpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gfqE4Zbkh5Lcg19ZhxoF1Xl/vo9JD6QrpOKZu//If4=;
        b=opKnA2sW6/dddDa+3Mb+Sgx/8iEc+yR44TM7PDwYroTki749ckHKSlUF9AzC4sW5lM
         h9wazy4tRsWT8K1mKhfJVVKJwsJIdKoNgG9GGrxUD+x5piicVS8AW3M5BlNkM/fxaah8
         qCsCEPH9FdeCaePGwX/5XZmxVGCl6M+pKKaWf03u4SIlRmZKEy2Wv8f0B9wNk5KQHBLg
         21QvO+3707hYH50iWy+GLZaI61Q4KjqCIuhA5rSB5ySQ5GzFEYJcyoUBmMAtt3Lpazbg
         QKwYNKmHJunmDGy2U8qpbXWO8ua0zoZxJPp3dWwPKUJPpvMb6iQf0fOEdnP2xYVz+YDt
         EnQA==
X-Gm-Message-State: AOAM532gwgfYTeTyvGpjh6pTKn3dcIX42ZFdq0xGCoZGdW8oYv3QKDcO
        yGRjDDMtv1jL3hxfCDffH9iTEA==
X-Google-Smtp-Source: ABdhPJwYsAEY697v1x5cu0ayp0Ec2C/YVhqqChvB7hmBccgNvdxMoWINpe055G0INBwpz53FMea+8w==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr3315537wrn.188.1603195311447;
        Tue, 20 Oct 2020 05:01:51 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id 67sm2402264wmb.31.2020.10.20.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:01:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] arm64: dts: amlogic: add missing ethernet reset ID
Date:   Tue, 20 Oct 2020 14:01:41 +0200
Message-Id: <20201020120141.298240-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Moon <linux.amoon@gmail.com>

Add reset external reset of the ethernet mac controller

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 2 ++
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index fae48efae83e..724ee179b316 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -227,6 +227,8 @@ ethmac: ethernet@ff3f0000 {
 				      "timing-adjustment";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
+			resets = <&reset RESET_ETHERNET>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index c95ebe615176..8514fe6a275a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -224,6 +224,8 @@ ethmac: ethernet@ff3f0000 {
 				      "timing-adjustment";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
+			resets = <&reset RESET_ETHERNET>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 
 			mdio0: mdio {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 0edd137151f8..726b91d3a905 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/meson-gxbb-power.h>
+#include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -575,6 +576,8 @@ ethmac: ethernet@c9410000 {
 			interrupt-names = "macirq";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
+			resets = <&reset RESET_ETHERNET>;
+			reset-names = "stmmaceth";
 			power-domains = <&pwrc PWRC_GXBB_ETHERNET_MEM_ID>;
 			status = "disabled";
 		};
-- 
2.25.4

