Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853FC2E32A4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 21:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgL0UAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 15:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgL0UAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 15:00:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF757C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 12:00:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w5so8782119wrm.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=k1BpqDrLIxjJCwX+FDaIrNploNKz7RU64Z1q2+uIcRs=;
        b=gKy/F/eR8+MQv8/ZNVa2cPLx0waXLCVf2qd426mCfCMJL2yVCI4AFNNmv4zFJM3HbD
         /gHcpSGjYNd9V9NqGIv2rV3MwNjtLRm8jPBIMENWWe713B9WXtrq1IQyi/pHUZRLkrNi
         W1+pgt08sODHaUXIrYk5rJ0ZrngVl/iHCp8q69UhPB/+AYqJal/Q1y/Ka3yGduPv0anD
         Dlbf5DiuxALIGg8CVqw5Dc+quRLq75Dp4WbUVfkQ53hGXgbY29NlgUfEGJzwTtUjEdcC
         P2oDxRAVxZA6GK0ZNmB0gK+j4OL9INaEAkdYeLDag8hd/yygIcrQkd7XdIQAg2Amym/K
         cJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k1BpqDrLIxjJCwX+FDaIrNploNKz7RU64Z1q2+uIcRs=;
        b=dXqdmJMrWwVn0z4ndlaRmtbAqcPfs0BM2CElITThRjqozOuLxABpmQTxn+4QN19LhG
         Z0A/P54tBVJWf2fXYaVrXrltJimo5v+KUq2axtDJ1K5vfQ20vlb1Lx2q2BfYsUmxPjkX
         x3HBASBm0bCOI8LVKPbUDNra5z/jMWU2UhZiyVtSFOd93sUGs5ImEMJK8ThBQ+hwcpZM
         ZuAmE5DgadSQMvJ3f8ptftEgTBv+N1lhDpE/9qi+aLON/mPtkF0t8yN/55p6Q+RDEU4S
         Tj2GvyOVdfSHhC5G1PntDsZzJfNCsuv3StsxYdfblfJojL25zcso+pp0iYmomxnGCwzj
         t+AQ==
X-Gm-Message-State: AOAM530TCgc0kv2DceDuPFEYiB2uoVTZ3c4qI28hbhHOCYXI3RbOW7jT
        ZqazKhN2sCJ3qYQpfPzWG8ANw+FVt5guow==
X-Google-Smtp-Source: ABdhPJxRuFAjZMihIl0VdyMjBOwgjyCqvj1tlS863MyYDzucazsO5DqIYglI3G0ZSbRC7BR3Fs8DVA==
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr47642644wrw.386.1609099210310;
        Sun, 27 Dec 2020 12:00:10 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id x66sm16337484wmg.26.2020.12.27.12.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 12:00:09 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jernej.skrabec@siol.net, linux@armlinux.org.uk, mripard@kernel.org,
        wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RESEND] ARM: configs: sunxi: enable brcm wireless
Date:   Sun, 27 Dec 2020 20:00:00 +0000
Message-Id: <20201227200000.28526-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lot of sunxi boards have BRCM wireless device, so let's enable necessary
options for it in our defconfig.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/configs/sunxi_defconfig | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index a60c134c5e04..4891aefdef7d 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -52,7 +52,28 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=y
-# CONFIG_WLAN is not set
+CONFIG_WLAN=y
+# CONFIG_WLAN_VENDOR_ADMTEK is not set
+# CONFIG_WLAN_VENDOR_ATH is not set
+# CONFIG_WLAN_VENDOR_ATMEL is not set
+CONFIG_WLAN_VENDOR_BROADCOM=y
+# CONFIG_WLAN_VENDOR_CISCO is not set
+# CONFIG_WLAN_VENDOR_INTEL is not set
+# CONFIG_WLAN_VENDOR_INTERSIL is not set
+# CONFIG_WLAN_VENDOR_MARVELL is not set
+# CONFIG_WLAN_VENDOR_MEDIATEK is not set
+# CONFIG_WLAN_VENDOR_MICROCHIP is not set
+# CONFIG_WLAN_VENDOR_RALINK is not set
+# CONFIG_WLAN_VENDOR_REALTEK is not set
+# CONFIG_WLAN_VENDOR_RSI is not set
+# CONFIG_WLAN_VENDOR_ST is not set
+# CONFIG_WLAN_VENDOR_TI is not set
+# CONFIG_WLAN_VENDOR_ZYDAS is not set
+# CONFIG_WLAN_VENDOR_QUANTENNA is not set
+CONFIG_CFG80211=y
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=y
+CONFIG_BRCMFMAC=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=y
 # CONFIG_INPUT_MOUSE is not set
-- 
2.26.2

