Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF072BB056
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgKTQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbgKTQWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:06 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70CA22269;
        Fri, 20 Nov 2020 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889325;
        bh=agFLxC3mtKTcAs7ANkNVWcbi6mAYm1OGmqWipy+YV5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fo9q/f0iERt6G37kFs1oubhs1P15Nm/dtK1SSfaTZzNigKlV4dCE62iqwtydAWcQ2
         lWiqHTBxmXeNCtukm/iGsnaP1FW5pRFTjKOcG3T7PtEgZm2+fLl3Jb4/blqLoVhc6R
         EmEphC3xDexv6FdP+zLD38k7Jwvp7bgmjzLUPZTI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 09/16] mfd: max77686: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:26 +0100
Message-Id: <20201120162133.472938-9-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162133.472938-1-krzk@kernel.org>
References: <20201120162133.472938-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  drivers/mfd/max77686.c:148:34: warning: ‘max77686_pmic_dt_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/max77686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 71faf503844b..2ad554b921d9 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -270,7 +270,7 @@ static struct i2c_driver max77686_i2c_driver = {
 	.driver = {
 		   .name = "max77686",
 		   .pm = &max77686_pm,
-		   .of_match_table = of_match_ptr(max77686_pmic_dt_match),
+		   .of_match_table = max77686_pmic_dt_match,
 	},
 	.probe_new = max77686_i2c_probe,
 };
-- 
2.25.1

