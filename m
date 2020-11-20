Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C022BAEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgKTPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbgKTPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:21:39 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC3C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:21:37 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so10140826wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jm+LFDsAuAlmnsLcsYBo3X+JB70zBAzOQ+j9Y6X8SV8=;
        b=B1o8QfhUaAkuDIE7zaKnwLdUJFGU9EpmJ/AXRnkr8n1lQGNN7X3z0DIbbN4eAWvudC
         8TIIDQu6AeNW1hSPtPgSlUHoxholmvzgWme/IKqlQ4aAP9xohTrtxRFsZb4PfttaW7dH
         SUKggtOCIaIDPmjLGlhq/w7xRED2gzY/nWNWXNs9bZhxsUv8UBHh8NwuBa3bytOz1MZU
         wU8S5J3Yc9Bgvv4iW/ju59WMnxzIx4yhYncmn8xBeJAlAalEdNORAQcwDTjLjAqEIlbt
         VaNB4M7kVv0CWrERBdHTGZ6VzuvOBiJ1qNXyYbWAZ8w0OAs8vP0H/lAXnUHhHTckDUOE
         jOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jm+LFDsAuAlmnsLcsYBo3X+JB70zBAzOQ+j9Y6X8SV8=;
        b=ddZUsWdvuiO/ZOXDauQNS9W2IC7QTE/OI9m0q6N7gZdJDhuWRehYP5R/RMZvOVnKGk
         ssx7GJ9SPFtE/ez3WQU+awscZII/wCq4Y7Y3kgQ+oTcZItY9r7IU1uH050meWnx3LNqv
         E9rvrqr74ije7tBU/+nus2iP94mUaSrLzJxSUb/hzfQxtqshu+6IKE7X+QUFrCeEwsun
         g+nAP17yrhnvgJ8HljwNwdMYBqMn8RczahrM2D8bqjTFO6qP4CYWN880tZcs73mGIsNR
         8McrgaDl2o9e8z+fHposjTszYdIWWeAd6WKmvcLSfW1Mep4x+tj3l+p+aCUyYdAhYZSL
         4QVw==
X-Gm-Message-State: AOAM5320QtE16DVRHHswhNy8DwKvf/mWyS9iNUIkEIo1ie+0mFzFwZIh
        til5aNlOYxWuX1AkuAJirrjVkg==
X-Google-Smtp-Source: ABdhPJxW9wpHe9bTMR1XYCVyzhK/t1cjxnWRn6ytW2lmjiPCB6+Pbl5traLKq5nBRBvk8p66drVzvQ==
X-Received: by 2002:a7b:c950:: with SMTP id i16mr2987010wml.136.1605885696147;
        Fri, 20 Nov 2020 07:21:36 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id j71sm4773757wmj.10.2020.11.20.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:21:35 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] arm64: dts: meson-axg: add PWRC node
Date:   Fri, 20 Nov 2020 16:21:30 +0100
Message-Id: <20201120152131.3918814-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120152131.3918814-1-narmstrong@baylibre.com>
References: <20201120152131.3918814-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the power controller PWRC node and the corresponding ethernet power domain.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b9efc8469265..288667699ec0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
+#include <dt-bindings/power/meson-axg-power.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -187,6 +188,7 @@ ethmac: ethernet@ff3f0000 {
 				      "timing-adjustment";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
+			power-domains = <&pwrc PWRC_AXG_ETHERNET_MEM_ID>;
 			status = "disabled";
 		};
 
@@ -1117,6 +1119,46 @@ clkc: clock-controller {
 					clocks = <&xtal>;
 					clock-names = "xtal";
 				};
+
+				pwrc: power-controller {
+					compatible = "amlogic,meson-axg-pwrc";
+					#power-domain-cells = <1>;
+					amlogic,ao-sysctrl = <&sysctrl_AO>;
+					resets = <&reset RESET_VIU>,
+						 <&reset RESET_VENC>,
+						 <&reset RESET_VCBUS>,
+						 <&reset RESET_VENCL>,
+						 <&reset RESET_VID_LOCK>;
+					reset-names = "viu", "venc", "vcbus",
+						      "vencl", "vid_lock";
+					clocks = <&clkc CLKID_VPU>,
+						 <&clkc CLKID_VAPB>;
+					clock-names = "vpu", "vapb";
+					/*
+					 * VPU clocking is provided by two identical clock paths
+					 * VPU_0 and VPU_1 muxed to a single clock by a glitch
+					 * free mux to safely change frequency while running.
+					 * Same for VAPB but with a final gate after the glitch free mux.
+					 */
+					assigned-clocks = <&clkc CLKID_VPU_0_SEL>,
+							  <&clkc CLKID_VPU_0>,
+							  <&clkc CLKID_VPU>, /* Glitch free mux */
+							  <&clkc CLKID_VAPB_0_SEL>,
+							  <&clkc CLKID_VAPB_0>,
+							  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
+					assigned-clock-parents = <&clkc CLKID_FCLK_DIV4>,
+								 <0>, /* Do Nothing */
+								 <&clkc CLKID_VPU_0>,
+								 <&clkc CLKID_FCLK_DIV4>,
+								 <0>, /* Do Nothing */
+								 <&clkc CLKID_VAPB_0>;
+					assigned-clock-rates = <0>, /* Do Nothing */
+							       <250000000>,
+							       <0>, /* Do Nothing */
+							       <0>, /* Do Nothing */
+							       <250000000>,
+							       <0>; /* Do Nothing */
+				};
 			};
 		};
 
-- 
2.25.1

