Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B62047A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 04:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgFWCxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 22:53:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731873AbgFWCve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18F55AE83;
        Tue, 23 Jun 2020 02:51:33 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 08/29] soc: realtek: chip: Detect RTD1293
Date:   Tue, 23 Jun 2020 04:50:45 +0200
Message-Id: <20200623025106.31273-9-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logic self-determined by comparing DS418j and DS418 registers.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 TODO: Identify the bit in ISO_CHIP_INFO1:bound_opts and what it really means.
 
 v1 -> v2:
 * Rebased onto iso syscon regmap
 
 drivers/soc/realtek/chip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
index 103f564aad7f..32ed0e4a3646 100644
--- a/drivers/soc/realtek/chip.c
+++ b/drivers/soc/realtek/chip.c
@@ -75,8 +75,11 @@ static const char *rtd1295_name(struct device *dev, const struct dhc_soc *s)
 		ret = regmap_read(regmap, REG_ISO_CHIP_INFO1, &val);
 		if (ret)
 			dev_warn(dev, "Could not read chip_info1 (%d)\n", ret);
-		else if (val & BIT(11))
+		else if (val & BIT(11)) {
+			if (val & BIT(4))
+				return "RTD1293";
 			return "RTD1296";
+		}
 	}
 
 	return "RTD1295";
-- 
2.26.2

