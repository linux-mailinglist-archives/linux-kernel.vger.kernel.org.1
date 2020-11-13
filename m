Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBB92B1E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgKMPVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:21:46 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43066 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgKMPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605280904; x=1636816904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1NQQGaJt2PCWmF7RL3nHYGDUbhmMDmkT+F9bi77B4mM=;
  b=WT7weI5iPjIwxNzI9ZxvJPj5drS86e7N1fo5wQxdc9IE5/szhIOZmW51
   G74oV19b3bVfcnAmjPQMTZH2JXvDsOKTWsEQdS9SRNTMx6sIKG+suU6gW
   qgPvWkYDcQdGhef8VBwgYKO+g6XdzIdCdsjfXazxwRfqCsoIYs6VKhQoi
   bfGAwlqlVPLsZjhtDsmQCt9Zmwj9IAix8N8F49HZsG5GL4B0FmJmoCOEN
   OjxItw0+L0CnB7h2PXq3RRX9P2nwXzU7+wkEgbNLfI6/HZ/AgL7klOpZM
   kXFjaTi0Cyh+V/BJvkJ8tqbnlwZhfckSqIaFA/TLCC6xwauWHWVmOrSxL
   Q==;
IronPort-SDR: vtWst5nzQZfqRnW//XgMxw5WxPI9/ObxgzDBAULLNPhdk9K79X9QJ8yJXfM9HWC152j13JM/WJ
 vl10EZQjQuOT8kEPkS1LCMPdxTDSHaz9guQQag3F51EvUzN6NRn42sVEyYuUqJmm87HSW4duOd
 AgZnwFdTlzGXiJ84fAsSWhQDipcpqFNsfE1LpdYu8oDsk+HR4ZSv5GDS476jEfn8pHBeoX4ato
 bK70pNIh+ab9PMR8e6lSochmvZ85F8LiXN2AhojjP5UQUV1sG9sfu0QW0FT8gWrL7R5bxeBkGW
 GDA=
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="93552156"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2020 08:21:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 08:21:44 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 13 Nov 2020 08:21:39 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 6/6] regulator: mcp16502: remove void documentation of struct mcp16502
Date:   Fri, 13 Nov 2020 17:21:10 +0200
Message-ID: <1605280870-32432-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mcp16502 has no members called rdev or rmap. Remove the
documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/mcp16502.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index f81afeeddb19..74ad92dc664a 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -135,8 +135,6 @@ enum {
 
 /*
  * struct mcp16502 - PMIC representation
- * @rdev: the regulators belonging to this chip
- * @rmap: regmap to be used for I2C communication
  * @lpm: LPM GPIO descriptor
  */
 struct mcp16502 {
-- 
2.7.4

