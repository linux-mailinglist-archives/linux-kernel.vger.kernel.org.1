Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3335321A1B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGIODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgGIODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44D8C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so2536920wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XV7x1Z5zj5Wjg3tK4n9i9paBzVB6Q8ndZsAB3QS+Wh0=;
        b=mLDmywv4Oyl2j8kyqhXiSFxSLl7dO8X7KPFt0TbHLtP1ytCVznMnWvtOeGZIR7L+zR
         dfwYDG8Mu8a0wSLIvXqov/CJ2EP+wNQZQiBeuM/z2BtdzBZOMDUb6hBLJENFWPjUN2GX
         473RKK8BMpuQQJFVYWuPWIlube2JOBKsWOUUNERU5pbipiYMvChMD0UBBXvwlkwoCMwx
         DA3i2d6imdqMm/SrOPB3LDr02ElCh2s3gPwb/f1hd8DSKy7Xrnb0vXCBEwI5iawBJ0D+
         H7c/RkG76Uaak00eC1cC5+yvlcS9wpI9N/wzordOFkOLbpuu/wmfK0M0kUi/sTVdvdjX
         04pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XV7x1Z5zj5Wjg3tK4n9i9paBzVB6Q8ndZsAB3QS+Wh0=;
        b=Tu96Qll/f/6fX3ElYXeJHgjH0BR+Y+EC1jdK+i9jcKxgkCKskWpkvY/1yS5K0yorqi
         orY8xRwL0Rh6tDCQHAy4xvHfEpss8i/w+E74ZwlbF2pG2Fd3xTJTGtgfsJyPcx5Lr9ZE
         Cj6b6REK+BqQYlxQqAI7Dj1fUC+2fnp29/NtMxqNfVMT8WVtNNh0vLKMAwq63+6ijTn8
         QtoiRbcXpeBidvRPKAjmAsrM+/hC/C+xIVUqPzDc7NaAo2YlRdM0nDorwCpEsD8ZM3BZ
         ZSx/B1osLViHbi2Yk1o4CSBQ1noBm0Vzb68C+CgAu9yLvIjxzumcGx63zzo5jLWJqMzl
         +4XQ==
X-Gm-Message-State: AOAM533zRLAMWLuhj3XwgKYn8GgpBhGBiWh8lOnD59NBT0VihX4bHKqM
        9BrvnZC6qkM+eCgQCADPaMQ=
X-Google-Smtp-Source: ABdhPJwXj+/UHrYQECUcRL7M8ks0AHImGxyCFdxtiqE3Z46FlmksIb9RhYX2U7P1Wi4nWCRJsLa0xQ==
X-Received: by 2002:adf:91e1:: with SMTP id 88mr56447637wri.89.1594303422255;
        Thu, 09 Jul 2020 07:03:42 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:41 -0700 (PDT)
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
Subject: [PATCH v3 13/14] [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Thu,  9 Jul 2020 16:03:21 +0200
Message-Id: <20200709140322.131320-14-peron.clem@gmail.com>
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

Add an Operating Performance Points table for the GPU to
enable Dynamic Voltage & Frequency Scaling on the H6.

The voltage range is set with minival voltage set to the target
and the maximal voltage set to 1.2V. This allow DVFS framework to
work properly on board with fixed regulator.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 80 ++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 8f514a2169aa..a69f9e09a829 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -174,6 +174,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
 			#cooling-cells = <2>;
 			status = "disabled";
 		};
@@ -1036,4 +1037,83 @@ map0 {
 			};
 		};
 	};
+
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@216000000 {
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@264000000 {
+			opp-hz = /bits/ 64 <264000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@336000000 {
+			opp-hz = /bits/ 64 <336000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@360000000 {
+			opp-hz = /bits/ 64 <360000000>;
+			opp-microvolt = <820000 820000 1200000>;
+		};
+
+		opp@384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <830000 830000 1200000>;
+		};
+
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <840000 840000 1200000>;
+		};
+
+		opp@420000000 {
+			opp-hz = /bits/ 64 <420000000>;
+			opp-microvolt = <850000 850000 1200000>;
+		};
+
+		opp@432000000 {
+			opp-hz = /bits/ 64 <432000000>;
+			opp-microvolt = <860000 860000 1200000>;
+		};
+
+		opp@456000000 {
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <870000 870000 1200000>;
+		};
+
+		opp@504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <890000 890000 1200000>;
+		};
+
+		opp@540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <910000 910000 1200000>;
+		};
+
+		opp@576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-microvolt = <930000 930000 1200000>;
+		};
+
+		opp@624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <950000 950000 1200000>;
+		};
+
+		opp@756000000 {
+			opp-hz = /bits/ 64 <756000000>;
+			opp-microvolt = <1040000 1040000 1200000>;
+		};
+	};
 };
-- 
2.25.1

