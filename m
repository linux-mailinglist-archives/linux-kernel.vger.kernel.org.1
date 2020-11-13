Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3E12B1E77
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKMPV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:21:29 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:51695 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgKMPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605280888; x=1636816888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qi4ydAI8o4oJpJGd7zvYmGVBebnhYeEm03dyN/oO0L4=;
  b=TkjknRPnEPZMkNTSDkloq2IcVMqJ7IM9D6MuEMclZogl76RPVDl4gHqy
   HS+d1RUxIgrneZPiGhNGUFKoM+cJu7xXR1k0Yqgd/aAmBPgqACO3CeF7B
   TkIxXPGNW3kZ7D+1Lajz6h8B9qccSSamMgrc9rgE4MxWMJoXOspbCfTyy
   1bKYTAtEIYEdvoQcRgabTuOPidLdSBG1ZhjpC12i6cVfGHvXWXJdWP6av
   KBT4zN85SnAsJP7MkbbmBg8obt2jKKrUk9Koc7Jz7Fm1dgiKagtimhEj1
   A0ymS7UiaRlYci2SYoFS7iY996y9CpTUNemz5is6aFvQIj+k+SVTatHI7
   g==;
IronPort-SDR: VML+9dKlH/GH/6LP1kBWoT7nnsc2ZvvbqZEPi7gs6QQf+q7ff11+BSeaFXkmhXZCAprqlVpCcT
 raC5PY3Ynr1cU1m6T2bYouPi+J/7+f1D0PA5QTB7ExR5KLnQZjdIHPSqG4c4q3IS9oFWcSzok7
 zY7Lbp70vTD0qoXCdu3StobCGgvqnTKcFie4KNuc9jtvSRe+vRHZgi4vRWge/7y72lWBtBjkVa
 g47i4Q+IeqJtXr189IldXvlYFVGjQfBejkEPQcYFcB+WvQNqr26+JePiFNkabASUyoYGBSfosm
 3dc=
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="98340454"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2020 08:21:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 08:21:26 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 13 Nov 2020 08:21:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/6] regulator: core: do not continue if selector match
Date:   Fri, 13 Nov 2020 17:21:06 +0200
Message-ID: <1605280870-32432-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not continue if selector has already been located.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1d0d35f14f37..6724324d372c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4037,6 +4037,9 @@ int regulator_set_voltage_time(struct regulator *regulator,
 		if (i < rdev->desc->linear_min_sel)
 			continue;
 
+		if (old_sel >= 0 && new_sel >= 0)
+			break;
+
 		voltage = regulator_list_voltage(regulator, i);
 		if (voltage < 0)
 			return -EINVAL;
-- 
2.7.4

