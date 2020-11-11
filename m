Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8D2AECA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKKJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:07:42 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43668 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgKKJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605085645; x=1636621645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qi4ydAI8o4oJpJGd7zvYmGVBebnhYeEm03dyN/oO0L4=;
  b=wJUki+qwVON+UfxhReMxmdDbjc+4SSgQVLexYAzeNA4fKwrXR61GIDXK
   jDwxEuHSq9n86U+x5if0UdaRL2gL+r3Rg9cc1p9kvhWkPG5Ien44Bbb51
   EZD4Gc8oZDYoSZz0ex0exqI4N6sM3f2+VYiMdTINm/R4fQ+2/BXHVrRIT
   gToBbV+01MNyjnbrb62bWSBw+txHAxFGQundPqW9Lls7/2rjZx/Vw2I5c
   YHgLJhKCZk6Xibnqk/L0A2jQlttLPFfiNotAdbMGDFw2VioDux7f+Wryo
   f+ckBqRu9dof+5cTe+8JESPUHxE/Xd0eRjaK15tdGNN/9o6ZF/uSB/PWy
   Q==;
IronPort-SDR: qeKFsRDBJkGfBlgTc2lcIKHN1zJvPcWtyFfhip8IpDWl9XJU0d6ncieFhIIynyHnD8xN3LjizU
 85ZKnbTydQlXrwuT4EPnH90HVy92W25eCgrxj8VXAchDlzWtXy8N4MTejibasfbzBSJkguP5da
 UimbWR809BOZ7kIUQZvGo5cm4asGPBnvwfDONFet2tm2i6zLpJJAyAe2fW1EtvRYfJDUE47ffN
 0Hf/dLgDUBZJagu+RLwPAFWiZZdHUdCCeAvie56iJLIRYxHd6SO3arJJBplVTJVXTAsdM6uuVZ
 5Ao=
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="93264667"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2020 02:07:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 11 Nov 2020 02:07:24 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 11 Nov 2020 02:07:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/6] regulator: core: do not continue if selector match
Date:   Wed, 11 Nov 2020 11:06:14 +0200
Message-ID: <1605085578-6783-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
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

