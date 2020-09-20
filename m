Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65082714FF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgITOY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 10:24:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57300 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 10:24:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kK0Gs-0007a9-Cv; Sun, 20 Sep 2020 14:24:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: fix indentation issue
Date:   Sun, 20 Sep 2020 15:24:54 +0100
Message-Id: <20200920142454.33352-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a return statement that is indented with an extra
space, fix this by removing it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7fed8cd134f8..6aa648019702 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3070,7 +3070,7 @@ int regulator_get_hardware_vsel_register(struct regulator *regulator,
 	*vsel_reg = rdev->desc->vsel_reg;
 	*vsel_mask = rdev->desc->vsel_mask;
 
-	 return 0;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(regulator_get_hardware_vsel_register);
 
-- 
2.27.0

