Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71BE819EA87
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 12:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDEKta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 06:49:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43005 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgDEKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:49:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so13849852wrx.9;
        Sun, 05 Apr 2020 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5M1R3a7is4s7bwwepv3EX0pn0j+KLFdAxm++0b65K4A=;
        b=hY+kxZoLm7t+ykPwyspwg7QjBtiZa4V3FuUF5t2J7ozPKFA+cOue5u/FSgeh+PN7Eu
         s53xYIxQJ98tdRVYgV68bmdGX1LEZizkea+NuuUX5u0zPlm1DW/q6z5NCs+GuhAtQtCq
         y/pazICPthwnnwWS2Gb0AmtJqb/EtS6qe6XtnDzvyI56WVO85pR94RcgH1kX6VLU+ldt
         KQUYix/xLnvV7FfhFBIW6FboRTdRGZq0SuK1EYedwQYRJYta/lMtIzCMNbHUIrqriWee
         5ZYOXUaoNx0khebDu2e+pPICxqRS8VEF4YW8qqWCkWE9JCHYDYn89WuzVLiARMB794By
         oymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5M1R3a7is4s7bwwepv3EX0pn0j+KLFdAxm++0b65K4A=;
        b=gnYf1ggDdc7oK/rW1XVRfGO3dDDPJkW+qJokzWIPu7CTlrtM/nkmK9xt/yBDoxmkol
         eJm6o6wFAndga5A3FJyg/653FI0BWlb1cE98mvwMNQTDJpchJzTWatC/3CzYYAjZACR0
         Fm8LdUbAE2QoImoT2DwQcgysWzMXDz6q7PJ7GEc5IGMnYlv+4NhZsqG3RogrFnmN0pVa
         ZHuiFiAklL4Nh84DNkSUIvEeTtkxyo9JGY+OehtncMxFcZQICtFXHEtV+4QN84MBMbG+
         BcdqlQ4my+obNHeHdoILXdtt49g1mpfn1pqn9BpVLJZVEFVmDf1hByPFJyy/HzqHp7fJ
         CyWA==
X-Gm-Message-State: AGi0Pua9Jp1tgJEhJx5W7NtogfFrL4tiJ5LitO+C2AEQaESpfsIMg1Bv
        Oqdt/N7QqnfnQCBIA56SYJc=
X-Google-Smtp-Source: APiQypI+or5JqckqQo6EKuF0G6ORDBX841o2j5tvMOu+lvNXt1r7nW6EgTMunoROxGaMkPw7Qo2usA==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr6468645wrp.28.1586083761763;
        Sun, 05 Apr 2020 03:49:21 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id u13sm21606411wru.88.2020.04.05.03.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 03:49:20 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 5/7] arm64: dts: allwinner: h6: Add GPU Operating Performance Points table
Date:   Sun,  5 Apr 2020 12:49:11 +0200
Message-Id: <20200405104913.22806-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405104913.22806-1-peron.clem@gmail.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an Operating Performance Points table for the GPU to
enable Dynamic Voltage & Frequency Scaling on the H6.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
new file mode 100644
index 000000000000..4a1814844fe0
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Clément Péron <peron.clem@gmail.com>
+
+/ {
+	gpu_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+
+		opp@756000000 {
+			opp-hz = /bits/ 64 <756000000>;
+			opp-microvolt = <1040000>;
+		};
+		opp@624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <950000>;
+		};
+		opp@576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-microvolt = <930000>;
+		};
+		opp@540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <910000>;
+		};
+		opp@504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <890000>;
+		};
+		opp@456000000 {
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <870000>;
+		};
+		opp@432000000 {
+			opp-hz = /bits/ 64 <432000000>;
+			opp-microvolt = <860000>;
+		};
+		opp@420000000 {
+			opp-hz = /bits/ 64 <420000000>;
+			opp-microvolt = <850000>;
+		};
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <840000>;
+		};
+		opp@384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <830000>;
+		};
+		opp@360000000 {
+			opp-hz = /bits/ 64 <360000000>;
+			opp-microvolt = <820000>;
+		};
+		opp@336000000 {
+			opp-hz = /bits/ 64 <336000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@264000000 {
+			opp-hz = /bits/ 64 <264000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@216000000 {
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <810000>;
+		};
+	};
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+	#cooling-cells = <2>;
+};
-- 
2.20.1

