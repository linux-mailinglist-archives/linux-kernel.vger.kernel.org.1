Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F622A932C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgKFJrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:47:04 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41893 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgKFJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656020; x=1636192020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FrCYjC2ukUCDH3p6+EqKIEI32HKV++foBRusYDNEF6Q=;
  b=DdbLEBLcdGBY5y8qrQ/aFLnKk7XqTsW9TX48yShNKDvyqrIH1dSdXbCx
   frlnyDPq6I30SGdnpjL6HpIOjt2hSKRh1DDaewdBeqs+iDoIDz9s6+isj
   fR3lT5cwU6TWFbhRuosq7Wk21Obs2ILh/g5CbYrm/ns/BK0DwKg4tqdDs
   8MgJx0Pi5Cg3Lm4sSXUE/q1IX4SaLejz9bfdXLpcJM8gxznbdYt8rB3wv
   XUK/53sSzNJBN4hH2NLWSmvRTlXu998PupjjfSC48JHaTN9jWXXfWyE7d
   gbsOVcX2/WwdLfhC+DaXAjkO+SUFlvhU5GAR0OpyQL5E91lJt3BypfGVS
   Q==;
IronPort-SDR: 6zMEl2oH2MGoPxYrOs9s+p7VaFD2M5kJsiTL3t5X11WwqHdHZRWbtDjkNzPU5iVCAQg7asfG82
 YLQadWSLRvcYx1JebweijVzWdTxsD94HM+AF5reitboWcNMUrmS/gyNVZtPtpqBqlaGLIFWAPI
 gswd+mADTYM0OAWFH/+eOeJbT4eO4ldJ4m4jOh1AGT+YIcOJKmwddCH4Y/3pu89XSaC8Vxh4BY
 ckhK9pQRMADx02HEKON3krykH2MdfFJr+8man0EYLj2C+JwS953OK8WDk7H5jR4TqFqNfZ9Jcq
 bEE=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97428351"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:47:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:46:59 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:46:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 04/11] clk: at91: clk-master: add 5th divisor for mck master
Date:   Fri, 6 Nov 2020 11:46:21 +0200
Message-ID: <1604655988-353-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

clk-master can have 5 divisors with a field width of 3 bits
on some products.

Change the mask and number of divisors accordingly.

Reported-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-master.c | 2 +-
 drivers/clk/at91/pmc.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index bd0d8a69a2cf..aafd003b30cf 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -15,7 +15,7 @@
 #define MASTER_PRES_MASK	0x7
 #define MASTER_PRES_MAX		MASTER_PRES_MASK
 #define MASTER_DIV_SHIFT	8
-#define MASTER_DIV_MASK		0x3
+#define MASTER_DIV_MASK		0x7
 
 #define PMC_MCR			0x30
 #define PMC_MCR_ID_MSK		GENMASK(3, 0)
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 7b86affc6d7c..0a9364bde339 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -48,7 +48,7 @@ extern const struct clk_master_layout at91sam9x5_master_layout;
 
 struct clk_master_characteristics {
 	struct clk_range output;
-	u32 divisors[4];
+	u32 divisors[5];
 	u8 have_div3_pres;
 };
 
-- 
2.7.4

