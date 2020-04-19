Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB671AFAEE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDSNu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgDSNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:50:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D8EC061A10;
        Sun, 19 Apr 2020 06:50:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a25so8731274wrd.0;
        Sun, 19 Apr 2020 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06l4F0Fbj1OIjrhQursMZ1QtwSUf8beeJ0SuDwg+II8=;
        b=iRS9/7JEnM5hRomC4mx0t/PamdUyzezofG9+VdLTduhoHbrl1wyBV5VN8557KN8vgh
         e1aSmMFjE7tgQinyBWIl/9WlDoB+m8KMo25R1GvfRPe9wjJYftHaKnAg8ViMhMnX4K4y
         up1pFNsK07VZ3j5p2+zGUybwA2MFzFEmr0zyrZskY/vhZlysQ34itjSuUwC7qkjX6NBL
         A6M3gxhBlgBGsdamSVqTTkeMkhuPjrEJVnpMH4nFPHyDoGpDa31FzPcgAmaMtt+WEyYK
         TcqncTwRFzQUyWb3D8c0hHiowKz7UCLAR3Jd1txwxxdeobQsm3y0oin4iPsdMavxD3Kg
         n7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06l4F0Fbj1OIjrhQursMZ1QtwSUf8beeJ0SuDwg+II8=;
        b=jfZMxLLYKC0+KSfigL2SQQZmZ/TFN5mG/4TYqQoi4uCrH1oxbp7AFVub/9xjlFaMdT
         FnON0a+Gp6VSVSqf5VWr/KfNNXvyr0DLBB9iOuAWERSdaksAralZOi16zZcnYUNSr2Zz
         boIw0AWMC1MnTV2oWxRa9HRIayB55/z9OHeEYVJ3m1IASv3+3/29CUzlKUguDfEXjt8e
         y4EjlF7LGLSkZr+GGYYl7RF6QE886CLcxazq5Iy+rh4JBZiX7cL9lxzxYfWVcEDT/hH+
         NXZdKPEC7DtXTrIEJSxnrHQkg2ppDioca6Vb4mGrj5zvH17bvHtouYsMxEoYApnInhC9
         4T3g==
X-Gm-Message-State: AGi0PuZv5wsbfrNYVXFz/U9dMM9jGlRA3s3CStcWXaeGp+kXMa/ScD5k
        ftxvlXW0frSMR+6z8t0xjmA=
X-Google-Smtp-Source: APiQypJn3umlBT9pfxyglivyKGZyVpsYTbHNDV2DNYZllpm6NNO+sP5DyyxYCuauwplZltkyTp9Zsg==
X-Received: by 2002:adf:f091:: with SMTP id n17mr13642050wro.200.1587304218271;
        Sun, 19 Apr 2020 06:50:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id z8sm20183940wrr.40.2020.04.19.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:50:17 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 4/7] arm64: dts: allwinner: h6: Enable CPU opp tables for Orange Pi 3
Date:   Sun, 19 Apr 2020 15:50:08 +0200
Message-Id: <20200419135011.18010-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419135011.18010-1-peron.clem@gmail.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU opp tables for Orange Pi 3.

This needs to change the CPU regulator max voltage to fit
the OPP table.

Also add the ramp-delay information to avoid any out of spec
running as the regulator is slower at reaching the voltage
requested compare to the PLL reaching the frequency.

There is no such information for AXP805 but similar PMIC (AXP813)
has a DVM (Dynamic Voltage scaling Management) ramp rate equal
to 2500uV/us.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 47f579610dcc..15c9dd8c4479 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -257,6 +258,7 @@
 				regulator-always-on;
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -264,6 +266,7 @@
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
 				regulator-name = "vdd-gpu";
 			};
 
-- 
2.20.1

