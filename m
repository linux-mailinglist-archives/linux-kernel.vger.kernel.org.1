Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064011B0C10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgDTNAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727887AbgDTNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAA1C061A0F;
        Mon, 20 Apr 2020 06:00:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so12053683wrx.4;
        Mon, 20 Apr 2020 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/ha8QAQ1qR8D+PPkPVAqbB8YM+gWp3JsCHNoS/IoFE=;
        b=cdmJShbdbv82snqqRJomqiBvxdAUZ5Dgvi2EJyoCE/1WCLFZy6YL7WImfQT+eQ35tS
         G1xfbV1Z6craGQsmgwNz3LzTtTcBpOH+CP0I6w9OnQ46ZkL3wEuBjx9cnrG0Vs1cIvE9
         QH79Ix04mcncOVF1Ca4m+vq+NPfGLLqtqUDivqk8sr5EQN60KI1XM4FqKspSe60KZ9gT
         Izd7wcY2kUleAe3vIMu3J/3SztQBW6M9IeZtdTbfsLb55beajAbyrIbr6BoOo/w74+5M
         ifP7ArfTRBmyxzdVODVybKmAin3a7tPqLXiC1cqsGXnml7vYLS9KGgcKFQpFjBN67gA7
         LDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/ha8QAQ1qR8D+PPkPVAqbB8YM+gWp3JsCHNoS/IoFE=;
        b=EO4wZCSM7dS4mCjQVvXckwZJnTR3SvGa2Gy9vGJzqsDaibA2dpEbmbOQd5h7lvo1kP
         IfNDXkbAcJWSLzympk4sbo5Eov+Az5Bk8jhxab1mKVGlCckuWMesUe1T7WQ6Z3J66rVC
         O4CjFtJosBcSlXo03JXPUQZ8a9tFHhFg5I7zbAHCXfAeBMAu8WFtoTw/Xv9osi60Y5ND
         yDuSeIoLL9QEy99Hoj95OFrJyllMDU1L+f6mTqP/IaTotG05saHOINCHTilsCl9A3hM8
         qlvM2fH0jjYfUYBjt60mt40Y6DKR/wSlXZZCxEpnZvq+MEJR04momNwra+jFiUqpEQJf
         NNnQ==
X-Gm-Message-State: AGi0PuZzPfMACSyD6jIhYFKYqs5nmbqJ8ja9MgzlK/zNYm+Xof4XggET
        Ou7eiXjtlexfzYwhcgNkOyP+tx6iLag=
X-Google-Smtp-Source: APiQypLggeqYjcs9Ri9QTBejIU/lrPlEYyp15iGU2P8zOXlo+G8kog8CnpwtCqUOfdgyG1iigznQqg==
X-Received: by 2002:adf:f342:: with SMTP id e2mr17742612wrp.146.1587387626909;
        Mon, 20 Apr 2020 06:00:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:26 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 2/9] arm64: dts: allwinner: h6: Add thermal trip points/cooling map
Date:   Mon, 20 Apr 2020 15:00:14 +0200
Message-Id: <20200420130021.3841-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420130021.3841-1-peron.clem@gmail.com>
References: <20200420130021.3841-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This enables passive cooling by down-regulating CPU voltage
and frequency.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 370e77b86fe1..60da1627772b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -964,6 +964,30 @@
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu-thermal {
-- 
2.20.1

