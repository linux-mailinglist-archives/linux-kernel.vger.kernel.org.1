Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9621A1B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGIOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgGIODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65374C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so2487189wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGSDRqVm1JOZ64MgS3vkOb+1FLTRNpff/hgpbfnfooY=;
        b=QltWwipSdHi08KdX6oNOYrCOU3nuRZ2oqlCna2xNWmwU93UXHzqIe6EhlAVKTSoKYg
         RC12Xg33XJ6+bMKWAoKIhFaPw4BpbWY6BCUiue1z5RTvYl7ilsYPhf1Ceo+Lw0BGFAL9
         uJTV6imSHnZj/Zsj0nCjEaK50qaHZZ7IcyF84LWWEFTQq53BTWRBjA1DcYAZi3xMMPXj
         Txr/SOUOwjuRevz5DC4m7GosDUgWqm4YEaCcw9u+TiMgLxMz8bM1U/W+Ocv/6Vf3fyE9
         J385tuU3tSivLhmwdnC6mFCLKTkdC+kx9kthXrtarIhU/d/5k16B4W1LgC1HekkobzU9
         iaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGSDRqVm1JOZ64MgS3vkOb+1FLTRNpff/hgpbfnfooY=;
        b=GXaV5y4TNFKO5GlWd7anQ9yqZmCUIGacXWi6CTWhB2QEVNjg6RmIsJTZkPPCkqWNIh
         BDDqucwLyUSiUyJ6LWANdbanWG+Sf9LI87Uhf8X0oR/dsGIug8dbB7ySe9A8Ck+PZtn0
         xKptaaz9bkeE+tu9IFrgmgY/PzutZiH6U8AybLVA4W8OBRMkZfXUBf2eqn5BkKJnORrH
         p8pjQcVSzFeTBgl9iqh9a8p2suCop0+qooIekBaX064HqJCir/5GkLP6yy51j/44wOgv
         PFSrOd/L+5XvxdSY9j3Lij/pAgPl1ycHL2bawUHXnVmWsKRvZnWb+kRt8fweMxNz44ZO
         iAQw==
X-Gm-Message-State: AOAM532rUTmEWoVztCIUMeZ3876sV7/LJZnHJMLdexkdbBBC7hXZ1GbG
        HEgSsA/AfbkOs7HaztuJm6c=
X-Google-Smtp-Source: ABdhPJyHqIxm58EdIGIO13FCV6nEuBJUZ9dl18TlYFSgwLEHFySc4yWbcI5jJYl+BM0LfhDROjoK8Q==
X-Received: by 2002:adf:f34c:: with SMTP id e12mr60699527wrp.46.1594303421047;
        Thu, 09 Jul 2020 07:03:41 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:40 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 12/14] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Thu,  9 Jul 2020 16:03:20 +0200
Message-Id: <20200709140322.131320-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709140322.131320-1-peron.clem@gmail.com>
References: <20200709140322.131320-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple cooling map for the GPU.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 78b1361dfbb9..8f514a2169aa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -174,6 +174,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			#cooling-cells = <2>;
 			status = "disabled";
 		};
 
@@ -1012,6 +1013,27 @@ gpu-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu_alert: gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };
-- 
2.25.1

