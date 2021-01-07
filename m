Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565C22ED19D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbhAGORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:17:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16454 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbhAGORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610029021; x=1641565021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4QhHyeujT+lb+gqqtezm3Ek1N0lMijNnWzOwgiYQ6aw=;
  b=wVvkAl9Z2CgA3x7EtI+vJRoWNmP05D6WoFAdy9Ck16OmVKquZyXX3SNK
   YBsaqFWTw5qVHyhCuteY7MQ2Pk9B0y+EDTuMu4maINF7awdthlL3RTi9z
   fOa+UVX7Qis34Fm1SBrq5p5/a3+Uhu9bbdn7g3opCYpznAsvihiKpKdh7
   6pSRKaxVgtnoz9sDWjBNAxYN5kmPlrQtuNV308cp/hsp94IaVcUd16rlm
   z/rQsC+h68xX8A+qTBV5p9ULZUsQAOisKb6r9R9kZplKrpnight5fYqEt
   rL6Ymb/bNGjZpYPRnHM9WVca7/kJD0Tl5wVq1uoWGuE3Hju+1U9frPcaR
   g==;
IronPort-SDR: MDVW/CHkblbwjqyN+JUvhkMuSLkzJ0tGMxlH8dz0yxa+j+asTh7/LJujfhSo7W2Z8SZpH8RDFe
 CoDW/YFy6JSzJQDkPGp5RSB4yubaygNKBaGOvNpiVrYBhWcF7OyLLlqcL70dXn8/WA8//8cv7F
 04woakvam5HcGIKJdATWOo8gSylc9jyZC54dBk+PMmNgWekUJqeRVaDAyfHP1Pn++nsEU883So
 yrkZdxzQd+b3cnzh7HZJTCTgFtRjkn++lpXTL79Q6Hx5g9MplToCoLboDg7uA/zhc00eHoIo+B
 6rI=
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="39654793"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2021 07:15:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 07:15:45 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 7 Jan 2021 07:15:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] MAINTAINERS: add myself as maintainer for mcp16502
Date:   Thu, 7 Jan 2021 16:15:27 +0200
Message-ID: <1610028927-9842-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
References: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei is no longer with Microchip. Add myself as maintainer for
MCP16502. Along with this change the status from maintained to
supported.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..1cd9914b95eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11690,9 +11690,9 @@ F:	drivers/video/fbdev/atmel_lcdfb.c
 F:	include/video/atmel_lcdc.h
 
 MICROCHIP MCP16502 PMIC DRIVER
-M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
+S:	Supported
 F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
 F:	drivers/regulator/mcp16502.c
 
-- 
2.7.4

