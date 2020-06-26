Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B380220AC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 08:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgFZG5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgFZG5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6867C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so8361215wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sD07a6En2jWPWH2kq8TUsn+RVkOBsvIFsWTqmBLW7Y=;
        b=V+f/N1sh9o182ePat9lbQamPC/xUQtqafZxm5ypirNrQKbDKBqQ4bjIcONYNaxl3bT
         SOVYt7m9hF2UYTxbT6EE1TVluOIxfDnbWgmea430ebNS8wCS8vBhHomJYiPwr3dEw7nC
         BEfJ83GZIJxiNxsokwodTwezX9wpLi5ZXnRjQ9jRvzdWxNoh+R56OGC3sRqBw2Mznu3Y
         HRU8Tb95/BKVOjFpbvDZbTd2016NZeX+SU7QjLc8cZed6J4jfxNf8yNYRNAiphrQYfo+
         +5Vhrl7fj0n00G1l4XVsH0+wvvgUzFYgutMbkcK/ayG549z0zXCUKOd4GUhIXV2+r/vu
         vlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sD07a6En2jWPWH2kq8TUsn+RVkOBsvIFsWTqmBLW7Y=;
        b=QlA/AhdcRYIsOHFbs/g/hvEym+kAR9Cu8nOIRhCpkHJulD1R7fNDd2H0RG3acMp6YB
         DfV+nXzcULYmwdb2EW//t6qICF1H3bx2O+/Q06DaCuohbdNWukKkz6yeTbaU/3GQy1sq
         DRy0TbXK0p0ivtNgawoOUtaF/VVADjemyB+aF2ejNzIk8St3ZM0sNj0A2lLetD7BnyJK
         TR5pQFV+L0/1+H1nesfAGHZParMia47XjxmWdKe/X105UI8q9k4W8M2LA1yKGDoSwiW2
         YsnGGh3U933QdzQi1WRFsjMPcQnrAsEmaGgfwZvgc/7jC+nINlGxeURxqOQkb8VrlyjT
         G5Kg==
X-Gm-Message-State: AOAM530VW/O+ponI2o85TLrUnoc7yZe5rZKw+tRzYCntO1PnC5F10Pcd
        LEKUx8mR7qlgZfVMzWKDisjCUA==
X-Google-Smtp-Source: ABdhPJxS9JeaA9nugKhk00ilscAGO+mjKuClzKn+M1SFU8Zww2GY/t5YayskghAfrWlTh0txvkRTVw==
X-Received: by 2002:adf:f546:: with SMTP id j6mr2063748wrp.167.1593154667581;
        Thu, 25 Jun 2020 23:57:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Russ Dill <Russ.Dill@ti.com>,
        Keerthy <j-keerthy@ti.com>, AnilKumar Ch <anilkumar@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 5/9] regulator: tps65217-regulator: Remove pointless 'is unsigned int <0' check
Date:   Fri, 26 Jun 2020 07:57:34 +0100
Message-Id: <20200626065738.93412-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'rid' is declared as unsigned int, so there is little point checking for <0.

Removing these checks fixes the following W=1 warnings:

 drivers/regulator/tps65217-regulator.c: In function ‘tps65217_pmic_set_suspend_enable’:
 drivers/regulator/tps65217-regulator.c:127:10: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
 127 | if (rid < TPS65217_DCDC_1 || rid > TPS65217_LDO_4)
 | ^
 drivers/regulator/tps65217-regulator.c: In function ‘tps65217_pmic_set_suspend_disable’:
 drivers/regulator/tps65217-regulator.c:140:10: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
 140 | if (rid < TPS65217_DCDC_1 || rid > TPS65217_LDO_4)
 | ^

Cc: Russ Dill <Russ.Dill@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/tps65217-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index d27dbbafcf721..f2d3a4a9f3e77 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -124,7 +124,7 @@ static int tps65217_pmic_set_suspend_enable(struct regulator_dev *dev)
 	struct tps65217 *tps = rdev_get_drvdata(dev);
 	unsigned int rid = rdev_get_id(dev);
 
-	if (rid < TPS65217_DCDC_1 || rid > TPS65217_LDO_4)
+	if (rid > TPS65217_LDO_4)
 		return -EINVAL;
 
 	return tps65217_clear_bits(tps, dev->desc->bypass_reg,
@@ -137,7 +137,7 @@ static int tps65217_pmic_set_suspend_disable(struct regulator_dev *dev)
 	struct tps65217 *tps = rdev_get_drvdata(dev);
 	unsigned int rid = rdev_get_id(dev);
 
-	if (rid < TPS65217_DCDC_1 || rid > TPS65217_LDO_4)
+	if (rid > TPS65217_LDO_4)
 		return -EINVAL;
 
 	if (!tps->strobes[rid])
-- 
2.25.1

