Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021632B2D74
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKNNwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgKNNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:52:32 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835CC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:52:30 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id ie6so1634220pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zw/uZzxvI3UePDC2yxEHCw/8K7dNDmlYTPIl068JGQ=;
        b=mg0e+Lsq9YBtl68lnopxGRDi8ylTs8lx0VoMPRqPwAEwR0QdW0KbXa1TdF8we1ikSe
         GVAzhcyNhOtFjqwg8nkvTrp8SZwsWGZuqVDcW58kHzOtub60XF2D7Il2NicDXmVumvK4
         iHtllgespAnnBNAXFTOBu3U5C3BjVl1oQiszA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zw/uZzxvI3UePDC2yxEHCw/8K7dNDmlYTPIl068JGQ=;
        b=CucLFnEYI5zJVixXCjKfDlk6wkjIzMs1wN5McxMcbg/QwA/bb1ZdwEsP6b355QuOPf
         UEC6JT6etSu3QmkUnn8j+bOSx/QSmG1utl5teCSonhdtASEzosf1AEx9byHb0ZrRuzt4
         fi+095gOxEgO06i83sTomQJHKPhTZSuUGSFG8yuDN4ebabp6MhOwZmpyz63ugDw3+9B7
         5p9HWrrmJ4PggHwgKO7zzBlF0fvolO9LGM8y2VR/xANK42wuw0n8LIDh/25PNA5O9tIg
         pl1yctxCUzT6qN2yqLd2DmyGIhosedhdyQnzL7nlrEIAX5JluSXHkshFX35Chizx9nmZ
         Zdog==
X-Gm-Message-State: AOAM530E/gubTdc/1XozW37q/dsJWp/1OLCFEEIYsf9Ahz2EnwAQ1SF0
        F0RrHu/e5NbBf3Nw29k3r2nXYw==
X-Google-Smtp-Source: ABdhPJyDJ55HiTcpPgKtU/DqaqSzQFSOJX7ii1TD1oASOYYXg6/75aNAlX05C72x7GfTj7cjMhhM9g==
X-Received: by 2002:a17:902:c113:b029:d6:e921:bfc7 with SMTP id 19-20020a170902c113b02900d6e921bfc7mr6082374pli.19.1605361950160;
        Sat, 14 Nov 2020 05:52:30 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id r205sm13008023pfr.25.2020.11.14.05.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 05:52:29 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 5/6] ARM: mstar: Add the external clocks to the base dsti
Date:   Sat, 14 Nov 2020 22:50:43 +0900
Message-Id: <20201114135044.724385-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114135044.724385-1-daniel@0x0f.com>
References: <20201114135044.724385-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the currently known MStar/SigmaStar ARMv7 SoCs have an "xtal"
clock input that is usually 24MHz and an "RTC xtal" that is usually 32KHz.

The xtal input has to be connected to something so it's enabled by default.

The MSC313 and MSC313E do not bring the RTC clock input out to the pins
so it's impossible to connect it. The SSC8336 does bring the input
out to the pins but it's not always actually connected to something.

The RTC node needs to always be present because in the future the nodes
for the clock muxes will refer to it even if it's not usable.

The RTC node is disabled by default and should be enabled at the board
level if the RTC input is wired up.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 81369bc07f78..6749d421dbf4 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -46,6 +46,21 @@ pmu: pmu {
 		interrupt-affinity = <&cpu0>;
 	};
 
+	clocks: clocks {
+		xtal: xtal {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		rtc_xtal: rtc_xtal {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			status = "disabled";
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.29.2

