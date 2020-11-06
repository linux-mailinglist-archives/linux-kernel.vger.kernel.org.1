Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568B42A9371
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgKFJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:53:31 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:39423 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgKFJxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656409; x=1636192409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=oJ+RGyeGVQyVkNPY/UxBheZxc6lrcGU0DiW7yQEWRrs=;
  b=kR6i9U0l5H6gISYWG0c4A1BJFeF2+eoQya8zT9N6Os63vRjeU6z7fr3L
   QRsAPKhg9e7F9f06VN0p7C/jh3IEWH39FyDBcwT3KMd+ZXhaRbyNPCrRr
   tOR+CY846hs3rR9PIpohvCR/RtfU4/p1qNxDGPlPq06Y9zMwEjpa+XEAQ
   jsalifklJFA3edSTnCDpUtj4ayZijrEze7OWejg4m3GIkb7gPrvPGa4OF
   wLJ0oIZ+jd0ZmIbcj0lOsg04IdQ5hUhiyqhjtwZed9A3ssB+KKgZoHtUN
   CuRwV5AYlfKfJ7atXNDZuO2iHnMdxwvcl8VI9ilFD5qEJiU367RprV+G0
   Q==;
IronPort-SDR: 9K17/8/MOPoCFLRlChMGWksEAI3cnp0TjE8Omct1g5pBDnAMc+M7emIyiokmkvmCxRDLOXf1Ti
 p6R55d2U0oXaSeqtRYl+5u8YyEjpQf17NtFUh/QKasJoHi9PT+RUv/1SSNSw/bFqk7F5DJhC/Z
 LFasAnEpNq5lgR4XDgQpHuqBwc7cZD6RTY6Bm3w6wHh+k8X8Q8DHGYzdL9EcKjLthqkXqbl110
 zKyZ/xaJr00vFGIAL1myggfm6aUHK7XdOmwp2YhOCByes0wCDF/UXR/Ku/fHI+ViEapMcJYk8I
 zVg=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="95342988"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:53:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:53:29 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:53:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/6] regulator: mcp16502: add linear_min_sel
Date:   Fri, 6 Nov 2020 11:53:01 +0200
Message-ID: <1604656384-827-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
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
index 4fc729aa58cf..92a48a195d59 100644
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

