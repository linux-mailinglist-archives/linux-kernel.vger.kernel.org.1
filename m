Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBD2AECA6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgKKJHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:07:48 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33345 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgKKJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605085649; x=1636621649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2XK5086b4/MoCuZ+5zlGoPQBBXPieOKx5f8lfuzIdtM=;
  b=s6ROAJMOA/2L7OBSzOIV7M3yVfSwrLGdBuJBEwfrqCsz3uwnvjKRHzNP
   RF/PhTwqIF5b8P4+K/9jL1cpCzGXt0bRT60f5yHbeG5/YjsePhk5hD7zY
   qrzPZkYEOaBgHLksZG6cLNR9xlTEgqMiBBK2P9tPl/92OhJ/gyEfiTcso
   ASiN26TVZ+CX11Ay7Q/s2p422Ul1qqSsFgykMyfJOGAaCEBIP3CPJDFg8
   RfydUeDXDqlWpFhn0tL/AjlN0JwQARPGihlN1gHBaRU4TSx8ub177Elj4
   H4RE7uHw8ClDKZtyYLb434BnlsGsHlbVEOkleA/mPutnaq+QHYQjjhgos
   A==;
IronPort-SDR: T/bf+MrKpolLffhcRK8MsDJGib57H4fMZfNyUUoWL9MaifZIaJWPFKO9QRzcRi9csX9Iw1XXZu
 FwHZt55pfzEtKhtWiGmZaUxy4XOOTvf5FWAEbqNt2CgQPlgBaKdrcrMIFcsCxNkpgqSqL7XgZl
 ITVR8nohICEYVaA6ZWSqYIuVruidIVT5Yru7D18DVD8eYHujfhbtvviovq61iGqA0tKtrnJ2th
 hp4HKUnuiPKD2rhPWIhpITPvg/v/VJFtRoRrw6/tWGKkmZa7EIm29Pynq3zBJIZIldzbF1Knzx
 wzk=
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="95887113"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2020 02:07:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 11 Nov 2020 02:07:28 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 11 Nov 2020 02:07:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/6] regulator: mcp16502: add linear_min_sel
Date:   Wed, 11 Nov 2020 11:06:15 +0200
Message-ID: <1605085578-6783-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selectors b/w zero and VDD_LOW_SEL are not valid. Use linear_min_sel.

Fixes: 919261c03e7ca ("regulator: mcp16502: add regulator driver for MCP16502")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/mcp16502.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 6d0ad74935b3..ab78f831f5bf 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -93,6 +93,7 @@ static unsigned int mcp16502_of_map_mode(unsigned int mode)
 		.owner			= THIS_MODULE,			\
 		.n_voltages		= MCP16502_VSEL + 1,		\
 		.linear_ranges		= _ranges,			\
+		.linear_min_sel		= VDD_LOW_SEL,			\
 		.n_linear_ranges	= ARRAY_SIZE(_ranges),		\
 		.of_match		= of_match_ptr(_name),		\
 		.of_map_mode		= mcp16502_of_map_mode,		\
-- 
2.7.4

