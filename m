Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092BF2B1E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgKMPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:21:33 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:51695 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgKMPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605280893; x=1636816893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2XK5086b4/MoCuZ+5zlGoPQBBXPieOKx5f8lfuzIdtM=;
  b=Zy/KmYrzLcgX5ftW0RzlJz81vleMHfXCA1SSydofHnnamKwJtwNAl4pv
   cKuGpg+Ytu7RWh0lWqc6WCPj4LcgP5KK4VFAPaopK0UBf5v32+EJ7Yr8C
   zQC6RmXtqNRNAerwOlKpwjD9pHPOMXwEL0KS4IL0sH5tI1Y1aFIE7o7Kp
   bt2m61ctLAb6avxT4azzIofYhAX9VDtIxEsbJ1eX3aJBT4gNh7xqT5uCi
   GdHsJerThH/k9dvJW4TYqH8uwnIm1qH29Y/kZuU1/i2jVVQ8BoQsctY8y
   LlOrelOAe+3laagu3aEYJLwxEPEWufb8NW+EM64uDTjaBBvQfyoT6MA4Y
   A==;
IronPort-SDR: i+Ow6Ye+6KtA6WDXjbnpdWfjmv1xz9AU/D0Q96KTy4uK10t68iNn/0SjH56itQ/f7lYOmG71vL
 wmlYdNZ7CE2PTkjwhfSu3CO4kkL/G01rrFklzWjgom22lRIMB/v1VsFafsf+4SYCe1zNp2qH0l
 539zZaaGKJDgdoq0a37co5tQyNhpoIt2OPBucAWSMkBnHAVQAf7S6JvdIbdy4LRoORb5uWJDCk
 W3BH9DLQCXfzB2KjPgn+wSW4652xwUkZiu1QF3CkDQE5UO0GVgsqXWwbmGxZxu7wldz6/2TzrC
 /Q4=
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="98340472"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2020 08:21:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 08:21:31 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 13 Nov 2020 08:21:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/6] regulator: mcp16502: add linear_min_sel
Date:   Fri, 13 Nov 2020 17:21:07 +0200
Message-ID: <1605280870-32432-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
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

