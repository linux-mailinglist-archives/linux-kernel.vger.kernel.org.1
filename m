Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836EA2FE8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbhAULXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:23:40 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36685 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbhAULVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611228085; x=1642764085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kRZXc300p60UJfVkYg5FlShWwQxkCBZFRuUKh/65ln0=;
  b=oHsRAzeOMzi2Ya8out5iM36QhQmXmpXSYqX/L7UL5tNKqebTXn+E1O1O
   k0YxBj0MOqSMd6cgLAaOG3Xi6K/cuUz/EjuOf3reeF4THdg51jGs/yhPj
   dWGrWKLNttQZTBkKP6GQqTdiO/C3yWl2mzkGztZUFmxDkkZIO5u4gqZ1i
   JIwrt3Ov0JQykNIsr2con/IHuslJTxS6tXp8QdYeXNjHE0dLLroeNyfIA
   KmzrJR0wgWtzTGuJM/Dmk0jL43hPkHgnMp3FeDsV6qFOLt27edKaEm8BD
   phWv7T9KAeqSdLrZwGjoQW/dVJfDGHiITQygR2djhFeug3qG1tPl4n9m/
   A==;
IronPort-SDR: nPZaVjtTdwT8oNhl4Jp4+1NNWxeljVH3rMQKXxTeR8/iU4gBQcAN5eIv1rBPbT2jrfk/Yh5pNb
 ZKYylzZZMPh2f+MKixtxMf+8xO61kyB9WGX/4ei/jkUdYuZZ+12RBdz5rW014ci5jyL656i+n0
 7088xuyUK6Xmp9tT1sZeehshtYHlkODCq1CUwMr1ZxAogxEWDoAE/d3nlrXIfHZnF4TjsDjMkN
 9mBp6E+3di31NfDOasOafd8Cn5KPfBtVvuHsqIctwG3C0UH4dfmQCAunfwk2zy9j3cpi92f2WS
 ToM=
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="100892447"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 04:19:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 04:19:41 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 21 Jan 2021 04:19:36 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <viresh.kumar@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/5] clk: at91: sama7g5: add securam's peripheral clock
Date:   Thu, 21 Jan 2021 13:19:09 +0200
Message-ID: <1611227951-4590-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
References: <1611227951-4590-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SECURAM's peripheral clock.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index a6e20b35960e..28e26fb90417 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -377,6 +377,7 @@ static const struct {
 	u8 id;
 } sama7g5_periphck[] = {
 	{ .n = "pioA_clk",	.p = "mck0", .id = 11, },
+	{ .n = "securam_clk",	.p = "mck0", .id = 18, },
 	{ .n = "sfr_clk",	.p = "mck1", .id = 19, },
 	{ .n = "hsmc_clk",	.p = "mck1", .id = 21, },
 	{ .n = "xdmac0_clk",	.p = "mck1", .id = 22, },
-- 
2.7.4

