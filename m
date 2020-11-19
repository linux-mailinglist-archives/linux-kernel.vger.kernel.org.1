Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC872B94D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgKSOiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:38:52 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:60490 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKSOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605796730; x=1637332730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5kPPY8aoeoIt3eWzwt2rrqZVySb3GOzC6e0UsowoKcY=;
  b=Ty3qalRwo/DZJgoWXGbwLye6dxmS4ufyhDKopAEGQaoRY954UIWgAhd2
   AogNixW1Fe5PE7PG0dZ72F+TdSd01WtihdI7UEDTReUcYuWCXUupU6zDk
   7udwmpirG8AM8nR6sRz2PAPstZC/edBw7aW5SpJxjqhyp+TASXjIsdymP
   ECz7jLXsFLRwNWmjnuCAbYxrDWybh0HAkq3HyBZfVQrYxBnJPNNeNHsGv
   Cnsh7gubmxaGr1HL9uI78y/XBa1Edof3A6mbBc7Zjsq0xoHLEczj3Opar
   5DAUQMH5jVhV4nMUKpBtkwslE7o2gXBQSy/5joAqPbT8hV3GcLv7ShusZ
   w==;
IronPort-SDR: 2z/KAlWBM888TBWpQ1EiryugNmKEtUxH57YhPg0h7l0WcKbP7/u2NIACPlS1uR0Pme3715ni7j
 urWat73OCIoQnh/34H2gry7c4hUOI+eDrJ1+FJLbWUtZATQ0BECzakHOKf6xCmy+Ykb0x41116
 9lq4ArW7qIiQ4EjOY6IVdTRL1OxYfvLsX+CQTVqySr6im/8dIanynabH2vQVHijQGdqHzegzbN
 O6bHdhRoICp9q5MF6VcNNRN6Rk386/aKW++3VSeK0tL0DJ/gX9li9nFwxEYC7osTObSYYYuFtE
 rX0=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="99678033"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:38:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:38:50 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 07:38:46 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 03/11] clk: at91: sama7g5: allow SYS and CPU PLLs to be exported and referenced in DT
Date:   Thu, 19 Nov 2020 16:38:19 +0200
Message-ID: <1605796707-8378-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605796707-8378-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Allow SYSPLL and CPUPLL to be referenced as a PMC_TYPE_CORE clock
from phandle in DT.

Suggested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[claudiu.beznea@microchip.com: adapt commit message, add CPU PLL]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 7ef7963126b6..d3c3469d47d9 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -117,7 +117,8 @@ static const struct {
 		  .p = "cpupll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1, },
+		  .c = 1,
+		  .eid = PMC_CPUPLL, },
 	},
 
 	[PLL_ID_SYS] = {
@@ -131,7 +132,8 @@ static const struct {
 		  .p = "syspll_fracck",
 		  .l = &pll_layout_divpmc,
 		  .t = PLL_TYPE_DIV,
-		  .c = 1, },
+		  .c = 1,
+		  .eid = PMC_SYSPLL, },
 	},
 
 	[PLL_ID_DDR] = {
-- 
2.7.4

