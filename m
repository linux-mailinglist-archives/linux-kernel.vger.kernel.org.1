Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213372A9370
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgKFJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:53:27 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42612 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgKFJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656406; x=1636192406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vr+gtMlO0d+aHgStpBoppvIDfZfHUUY/5QWzAxSBq08=;
  b=ee3wOXQ4rfnXgEYcdNpQg5wBLIdsIdDG7re9asXAYBQ1wPyrEDIXrHkV
   r8nDNEREZESyOhJA6ulR/uQPdUq0o3izL7yUq1P+Ur791y+EGFYTF587c
   EtT7tE7osqnHgSDfwXyUEs+Y2ZK7TawOlKR1Et+RzKF+WHT6mZu5UNHEn
   CNQQAqs1tOMEEwexyhjJ7YDao8X9zjvibDiX7tqR8KL/QfSU3lb4fd69X
   IHuydI+4rKxJebqjo9U//o4BHUGImIjSW0XTYDurVzbmRfjLLbLuiMekG
   lYJYrjJM3PHn9rNrDg0huqSwJca7ZbZqjpSHaO3lWlDoA7tsLY6BOrxTj
   A==;
IronPort-SDR: KhzFgykHVaNtJ6IUa0kw28rsKanJMXuKYVDNcIC7gk8hBal93diD/D7JuKdlk9ZKR0fDC8cTjD
 N1iff+SC0PQrGvRxhWZF08tQqgt0jLISsxZgrKBB78dSNAhu+TodZeW2zYaKVdY0HwR5mBI+hq
 Xschli/I1j2cOc9EN6lgpJ8UB4QXLLxCtOuTKA7fLkvY6TPhqy4rV+rPu4VALGiJTVj+KMQHWq
 rvxO0KHlHcOhNhTeOpha36EfSpg2L7bpZ+1ZHCAbr5uEuRLQyYulap+wpA7DohhwAg/EceSNcp
 /so=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="97429995"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:53:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:53:24 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:53:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/6] regulator: core: do not continue if selector match
Date:   Fri, 6 Nov 2020 11:53:00 +0200
Message-ID: <1604656384-827-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
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
index 19a330492884..4584b5b988ab 100644
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

