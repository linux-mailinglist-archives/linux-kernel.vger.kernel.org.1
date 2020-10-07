Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD26E2860E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgJGOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgJGOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:05:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42191C061755;
        Wed,  7 Oct 2020 07:05:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y13so2473895iow.4;
        Wed, 07 Oct 2020 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+DCnJEicoCU1/vpp+wjrTHhiVCn5Rx4QLEMzph/RDQ=;
        b=D0D5ZmKyabVh9PjCpDOiVuxtJkxfDygSUjVgpeanIdHgYCy/UQ5syh8N44cgLGqFpg
         dCLP6y6jBmKu/fdtOwfmGRsvgYg2vSGupYGR+hE2h9fi7T0WkMiMSpPao3TK1WoJRGe9
         SnJttD2iA/Qxtykw8Zt0QyIuGxk7iJ8SHUA2AnyluB/gesFGdJ13QK0jgRgK+bdx9//n
         rvAsU4E4A0Mx0KcaufFZc59Egzr7YQbeDhTxBm4j8piNxeM/hP7VNHzN2r0rickh93S6
         ao6ofp1LMrdqYyZ6XtyjdVk1EmlChzB/Yn2hyLnSDNU18YJVpG4Elvpcu0KHt6EYjksP
         eJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g+DCnJEicoCU1/vpp+wjrTHhiVCn5Rx4QLEMzph/RDQ=;
        b=D/91Hg3Seh1DWq+InliO3irAXO7Aov/mNqsZoXYtwO649CTl3deTH8qhuyHoHnCQ1Q
         UgwNDzsXH6W8eNv3mGGdu0GDwhSiVc8zar6GowUZxvs276dxnOBKFJdiSsInlSxxZUx2
         1VGO+a5/LNkQQHbSRBP4eh/7y00wJDVXGsjMGtqrMtDhsjxl6vq1q7hYzCNSXsjCgdw9
         seInARm9dPEhGpBJOLCO6uWmet5OiflqCZ7yB+dLSN0NQWvux2nxoIvt7maqFxecjmvR
         krh3EUYd9U9G0waPm6g89KtGII/2KLNwEhFXLZM0lCPiST8D3g1WbGr1OzPkqtk9y6EA
         MeLA==
X-Gm-Message-State: AOAM532gamjr9K3l2yF2s0RLaxpZq902R1/p7bvKYc5zacbfGsIr5pnd
        bxemvFhWwwrN9eLUpy6tolw=
X-Google-Smtp-Source: ABdhPJyTCTKoBdK/Nk6z7TtrU/dPMcrzNyWpWAFTkcFBic0zmvYYyDYZ9MZo2a6F9VXv9PNZvXTQiQ==
X-Received: by 2002:a02:ca48:: with SMTP id i8mr2992534jal.133.1602079509486;
        Wed, 07 Oct 2020 07:05:09 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7c62:dd9d:b755:cfbd])
        by smtp.gmail.com with ESMTPSA id j11sm1106886ili.83.2020.10.07.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:05:08 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon-som: Configure supplies on secondary cpus
Date:   Wed,  7 Oct 2020 09:04:57 -0500
Message-Id: <20201007140457.233697-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each cpu core should have a corresponding supply, but only cpu0 does.
This patch adds a supply for each of the secondary cpus.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index b88c3c99b007..397cf8b2f29b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -24,6 +24,18 @@ &A53_0 {
 	cpu-supply = <&buck2_reg>;
 };
 
+&A53_1 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2_reg>;
+};
+
 &ddrc {
 	operating-points-v2 = <&ddrc_opp_table>;
 
-- 
2.25.1

