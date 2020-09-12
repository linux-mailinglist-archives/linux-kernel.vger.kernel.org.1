Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9AA267C4C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgILUtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgILUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:48:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F262C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b19so15317883lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQhJnEUl8bKAkFa65yFvhmvrLixAqXbiZILnY1ZEMao=;
        b=LRXOF3sWRwcqMNnMYTh5DKEE+LNBd86t5QpHAOKq66KAaB5EtsubTjXFWa8yJKquQH
         t8TmKki29YGZoLNTPRXCBdXCfSN2Kf59BT6fldQ/KBoMTjAIhE3NYbkpj2XnKHhc1VKL
         FsHL4eLuFwUivfLMoxycwcZHWne6+Moa8tsaR7xTJd/jYZzjLiokKGv1PVzIOw9kLmIL
         7/7P3UvWCT7o7OT1OglDrf7iGc568d67pOsFlToT/p/ihJNuqfvOnh0iXCZZyTbaieZ7
         Jxko5+7Gqjcr0Lb+qJesZ3ktmPLljtpcciz/YRrucq1u3+SJTjYQGOA4M594zH6mCYZP
         274w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQhJnEUl8bKAkFa65yFvhmvrLixAqXbiZILnY1ZEMao=;
        b=FpZC/k3nyYk+FuZv0tuzhbb/GZku8T4l2c5o3weckZf+qbgRc/ZIdmHsT+MweZEulx
         xH1iXCHakx4b6EjewSTZvRf6LnJoTGSDBaJDhnfGgYeUktf5iG+UMeuH6RUXODnIZ/bJ
         Iez2agKz9kbeixaiJnVfTngbXQTQB8OZZuHJDSf1LPze9LwiQ0u3Zi8Gr5SyNvS+D9Vz
         gwbSG6fofg2s4hPd7Zzcq50w0iiHOkWP8EwTLmxUn68DaVLEBwV4aixeHOjCDHgfPjuN
         u9000FmcItb3g4iFiTJfUe569+WEhL2ol+UiBrtJMu1bzYET6jSNkgzOm5DqmOqiMxSd
         VzCA==
X-Gm-Message-State: AOAM531G7PywJcEwFMqY7oQONj4mg1sNaw+qjtb/DZei+/uuFvzHwt5w
        X1e3RBRlMQr1zx61aayPUJ0=
X-Google-Smtp-Source: ABdhPJxOBsg83nTFAV5EBS3z819r9J05Y8Lc1BWaSfw75ivW1h8wTX2Z4i9jPjpT9/16tqJ8S2VnmQ==
X-Received: by 2002:a2e:8159:: with SMTP id t25mr2838076ljg.137.1599943731934;
        Sat, 12 Sep 2020 13:48:51 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r7sm1729753lfn.84.2020.09.12.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 13:48:51 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] phy: cadence: torrent: Constify regmap_config structs
Date:   Sat, 12 Sep 2020 22:46:39 +0200
Message-Id: <20200912204639.501669-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
References: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap_config structs are never modified and can be made const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7116127358ee..835bd7563f36 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -331,21 +331,21 @@ static int cdns_regmap_dptx_read(void *context, unsigned int reg,
 	.reg_read = cdns_regmap_read, \
 }
 
-static struct regmap_config cdns_torrent_tx_lane_cdb_config[] = {
+static const struct regmap_config cdns_torrent_tx_lane_cdb_config[] = {
 	TORRENT_TX_LANE_CDB_REGMAP_CONF("0"),
 	TORRENT_TX_LANE_CDB_REGMAP_CONF("1"),
 	TORRENT_TX_LANE_CDB_REGMAP_CONF("2"),
 	TORRENT_TX_LANE_CDB_REGMAP_CONF("3"),
 };
 
-static struct regmap_config cdns_torrent_rx_lane_cdb_config[] = {
+static const struct regmap_config cdns_torrent_rx_lane_cdb_config[] = {
 	TORRENT_RX_LANE_CDB_REGMAP_CONF("0"),
 	TORRENT_RX_LANE_CDB_REGMAP_CONF("1"),
 	TORRENT_RX_LANE_CDB_REGMAP_CONF("2"),
 	TORRENT_RX_LANE_CDB_REGMAP_CONF("3"),
 };
 
-static struct regmap_config cdns_torrent_common_cdb_config = {
+static const struct regmap_config cdns_torrent_common_cdb_config = {
 	.name = "torrent_common_cdb",
 	.reg_stride = 1,
 	.fast_io = true,
@@ -353,7 +353,7 @@ static struct regmap_config cdns_torrent_common_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
-static struct regmap_config cdns_torrent_phy_pcs_cmn_cdb_config = {
+static const struct regmap_config cdns_torrent_phy_pcs_cmn_cdb_config = {
 	.name = "torrent_phy_pcs_cmn_cdb",
 	.reg_stride = 1,
 	.fast_io = true,
@@ -361,7 +361,7 @@ static struct regmap_config cdns_torrent_phy_pcs_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
-static struct regmap_config cdns_torrent_phy_pma_cmn_cdb_config = {
+static const struct regmap_config cdns_torrent_phy_pma_cmn_cdb_config = {
 	.name = "torrent_phy_pma_cmn_cdb",
 	.reg_stride = 1,
 	.fast_io = true,
@@ -369,7 +369,7 @@ static struct regmap_config cdns_torrent_phy_pma_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
-static struct regmap_config cdns_torrent_dptx_phy_config = {
+static const struct regmap_config cdns_torrent_dptx_phy_config = {
 	.name = "torrent_dptx_phy",
 	.reg_stride = 1,
 	.fast_io = true,
-- 
2.28.0

