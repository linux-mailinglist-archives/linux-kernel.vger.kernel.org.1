Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A02AECA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKKJIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:08:00 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43704 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgKKJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605085660; x=1636621660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eCi4EukJCBANf6WBfNViz9r4o2Ea2mcX7pgqcbOIWRM=;
  b=ePPNxjRRTFVazLnGX7MoIp1iZhXhXwBZBLVVCF2B/buBPMDoKWMdzVcD
   tpWALH/d2L6X9h21JNRLl8oeCu+K9iTU4An0pNhWLedspsOwd1E9tMvHX
   uXp6aXR5U0G7YnMXMYrIn+e0YE7IRqufYJlYHFnJIhuDaOxtQla1GB07f
   Cw53WmVDMyeyJNm97Ud+Vgfq0fKcv+ELcjvhs6MMcjgH7Nbyxf+gjbxHe
   X1KMKdtgRZjQjYZEKN+FuS9LsL0HljzAIZnWjfrNYEYsBoW+/ETG136Jy
   0Sjzxami7h0tX0PhlyAxYxx2ZaOshEZz/LWwpXtf2L6HV8X3nvQTNtAiW
   w==;
IronPort-SDR: IvBPkPUmi/apBFjGWLNvLSriTL0FZ2AYUwa+ee50sR9BggGktNCsxH+jmO+hBGbEkdcswdC6w9
 Feq5jPnn2uk6qmrNTUiQQU+2bDj7HysCxDp3wYDcpqxQVE5pPoc1Y+dCJe3ZIfyt+kIIaqMrr1
 p/xwcab3w+V0xz7C7IPOhSWI4nMbnfLRJ7+twTFQ9lfCrX+GyVAphanhtHyFniZC0IDehIrPCa
 Z7uWpsfSzIk/9QPwQv+bkA0DdyRVcX9yd5dWiMqu+jGn3zynIYa3k3F+HF+Z7BTAHTsaG0elOX
 thk=
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="93264687"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2020 02:07:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 11 Nov 2020 02:07:39 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 11 Nov 2020 02:07:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 6/6] regulator: mcp16502: remove void documentation of struct mcp16502
Date:   Wed, 11 Nov 2020 11:06:18 +0200
Message-ID: <1605085578-6783-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
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
index 777d1a6cd1c5..c6b72d1d38a9 100644
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

