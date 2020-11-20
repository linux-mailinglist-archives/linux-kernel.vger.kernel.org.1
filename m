Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44D82BAC92
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgKTPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgKTPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:03:57 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E9FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:03:55 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so10295858wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iZ+W7DQCe9o+mnGwK40d1ggPjKeowkaQExedpZm74A=;
        b=PSjQrXjvs6/4henYPLPz2/D+ZO1Gps8HQF1dGJBEw4T2h8NqTpjDdwowRcT/4qa6hi
         HaTXNzRDdxiQlEqR+1YnGV1rgaUPLJoK9FmsLH7OXuN0qtRKf1zBUouyElencwTajLkD
         gcXCl1IHTLA75JBJ5kSu3pGQUECgcumAUZ7WS4dhMGFbDT3SwYooLzb59VUZodmw7gmr
         CcZd/ftgvfQdQ62HtqKBR1pa2TADkb5LrIwHDIF9AxVfOyBk1DSb79KdAIlGhFtlxWVc
         lDyT2B2D7oJd7sk3hBoYFZzFvE1kAeeZKdYhTqmNyo/05PKBS7+gRSX0EBtQbNCCOqa3
         t/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iZ+W7DQCe9o+mnGwK40d1ggPjKeowkaQExedpZm74A=;
        b=pIJRvmg0Y4++qKGz3Pn056Jbv0e9f4FjuDtNG7jH7ZEN3XfJ1j7cekfJwbkLUPRiwI
         x1VR7s7W/H/qRU5dP3wWCtJzEvHwtE32B2F/9pZootNIhWugb2gt4pGxLE0cQTOaRExE
         HuRkBSo5PktF10C1Odjdkyg+XyHcTxSSmSliOnf2oLYEWyW/yzjDuJ0GR6lfJXWPq1O+
         kihz7zEyZGGgDgDPtK3ncGVwyjvKS4bFRneiREHgYOlbuOT/5kDq8rCbEA1Hp9/qMYVw
         B6mv7Bk6I634p8G/hQjKG9F06dte9uavfR8WBfxJMPCErI/IAAXXzls+dlcwdxAfB0jW
         nyCA==
X-Gm-Message-State: AOAM533rvT/mi7SaAgYhbh48tI/y1gymYxo6pPzH851j2rij4uwxIIc8
        vRyY81chVPPz16pfrED8AH0PrQ==
X-Google-Smtp-Source: ABdhPJy7/hLn5ooKuW02nArAMZH3ladnIRrNkwhmo3ERpmjX+UWKTV6MR8UI3eZVfUN9ANs2YHEznA==
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr17237180wrv.95.1605884633065;
        Fri, 20 Nov 2020 07:03:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id h17sm6772175wrp.54.2020.11.20.07.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:03:52 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, repk@triplefau.lt,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] phy: amlogic: meson-axg-mipi-pcie-analog: replace DSI_LANE definitions with BIT() macro
Date:   Fri, 20 Nov 2020 16:03:47 +0100
Message-Id: <20201120150347.3914901-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency, replace DSI_LANE definitions with BIT() macro and remove the unused
DSI_LANE_MASK definition.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
index 6eb21551bdd9..1027ece6ca12 100644
--- a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
+++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
@@ -38,12 +38,11 @@
 #define		HHI_MIPI_CNTL2_CH_EN		GENMASK(15, 11)
 #define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
 
-#define DSI_LANE_0              (1 << 4)
-#define DSI_LANE_1              (1 << 3)
-#define DSI_LANE_CLK            (1 << 2)
-#define DSI_LANE_2              (1 << 1)
-#define DSI_LANE_3              (1 << 0)
-#define DSI_LANE_MASK		(0x1F)
+#define DSI_LANE_0              BIT(4)
+#define DSI_LANE_1              BIT(3)
+#define DSI_LANE_CLK            BIT(2)
+#define DSI_LANE_2              BIT(1)
+#define DSI_LANE_3              BIT(0)
 
 struct phy_axg_mipi_pcie_analog_priv {
 	struct phy *phy;
-- 
2.25.1

