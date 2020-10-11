Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA1728AAB1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgJKVWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387570AbgJKVWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 17:22:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA9BC0613CE;
        Sun, 11 Oct 2020 14:22:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o21so12314560qtp.2;
        Sun, 11 Oct 2020 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1SI67RBBtDiSYCd7igvyTTY/wfEnfAVpHIYHQEDBdk=;
        b=o4RtIxrlPXh79GWZ1nNuQZXpnwKphNXfdGSumWnQzcxLNLzdtlHf0ACSeT1KaaYl+4
         HLtVlcRjqrIBqGCMOvEiXwr0mQOPhY3V5cQzXSmr8nnmrOgwWHXn/HKQYanNoV6WCkRY
         iXNoxHP5g7/gqTiNHNNkqE0/7siy0HqiJca4Z95Y1TKYCE2qo5qOuwZGX7vabc4/8L70
         +cEYZfYdDeaMO70ZECZ5kt3THjSKnu0NUuOQFQGl3n8QAhMKdHEptlCEh/Df9MnIAgLC
         dQHcyQRs/OJ05UGjJaXIaeXlQ/ZjNWXxW+wRNoxkDFQ6zDdMkQKNPNDy4R8K5s5Z8dEh
         BuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1SI67RBBtDiSYCd7igvyTTY/wfEnfAVpHIYHQEDBdk=;
        b=ro8vYhiS5XqYZOHytqa3Qny29PuB+4atbySLIkWTpPf+F7h+Otq9T0F1iXPCZZM9aK
         sSYBEtuVyNDnWF98STTjMZSiqo5OVxQW3Q3A33FE0Yipx5l+iT9EAvLE3chOT/99Yb65
         7BXlTvLx1hT/TChMe0SmXP6QPqj3TW3Pl25oxE8RX7X6ASbC0dS2x1abiIaZp3CXEGnu
         cMBwJC/9S0HToJYCmTOlGnFUfix8Q5vsJ6fc7rsOCQBSFHWyL12Vjs/2cHXDUpbu3Mv3
         zJcyn2K27CRt9qIKeOi+jrJ04F5akmYTfjsds1JmkHjgFHlKUsQcRip7AEQm281A8scz
         PBmQ==
X-Gm-Message-State: AOAM533LBn/MPPQqklMF8qTcglNGpWQGvDvWjFK08wAbMRP2+lQ4XSxQ
        9GzSwXh/g4JoGssnZjIDFOhVqs/YWeUWEg==
X-Google-Smtp-Source: ABdhPJwq/vY+A+tu9stmwLntgGUCCnOhT/fgZUY+Oyg7gAteUDF40lRNIdZJH8F/LawsigqDCkT58w==
X-Received: by 2002:ac8:5cc1:: with SMTP id s1mr7263061qta.379.1602451362784;
        Sun, 11 Oct 2020 14:22:42 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n57sm11526658qtf.52.2020.10.11.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 14:22:42 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: allwinner: beelink-gs1: Update LED power node
Date:   Sun, 11 Oct 2020 23:22:37 +0200
Message-Id: <20201011212238.174792-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 LED trigger a warning when running dtbs_check.

Update the node with a valid pattern property.

Also add the function and the color of the LED and drop the
label which is deprecated.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..a364cb4e5b3f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -7,6 +7,7 @@
 #include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "Beelink GS1";
@@ -43,8 +44,9 @@ ext_osc32k: ext_osc32k_clk {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
-			label = "beelink:white:power";
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_WHITE>;
 			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
 			default-state = "on";
 		};
-- 
2.25.1

