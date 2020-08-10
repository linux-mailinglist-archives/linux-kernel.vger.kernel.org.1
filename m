Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE624042D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHJJje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 05:39:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53726 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHJJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:39:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k54HD-0004Nd-Fa; Mon, 10 Aug 2020 09:39:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: fix spelling mistake "Cant" -> "Can't"
Date:   Mon, 10 Aug 2020 10:39:31 +0100
Message-Id: <20200810093931.50624-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/fixed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index d54830e48b8d..142a70a89153 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -182,7 +182,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 		drvdata->enable_clock = devm_clk_get(dev, NULL);
 		if (IS_ERR(drvdata->enable_clock)) {
-			dev_err(dev, "Cant get enable-clock from devicetree\n");
+			dev_err(dev, "Can't get enable-clock from devicetree\n");
 			return -ENOENT;
 		}
 	} else {
-- 
2.27.0

