Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C711A46EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgDJNeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 09:34:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36161 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgDJNeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 09:34:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jMtnL-0006u4-4j; Fri, 10 Apr 2020 13:34:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: tps80031: remove redundant assignment to variables ret and val
Date:   Fri, 10 Apr 2020 14:34:06 +0100
Message-Id: <20200410133406.24458-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variables ret and val are being initialized with values that are
never read and are being updated later with a new value.  The
initializations are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/tps80031-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index 85a6a8ca8c1b..a29e65230132 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -271,7 +271,7 @@ static int tps80031_vbus_is_enabled(struct regulator_dev *rdev)
 {
 	struct tps80031_regulator *ri = rdev_get_drvdata(rdev);
 	struct device *parent = to_tps80031_dev(rdev);
-	int ret = -EIO;
+	int ret;
 	uint8_t ctrl1 = 0;
 	uint8_t ctrl3 = 0;
 
@@ -322,7 +322,7 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 {
 	struct tps80031_regulator *ri = rdev_get_drvdata(rdev);
 	struct device *parent = to_tps80031_dev(rdev);
-	int ret = 0;
+	int ret;
 
 	if (ri->config_flags & TPS80031_VBUS_DISCHRG_EN_PDN) {
 		ret = tps80031_write(parent, TPS80031_SLAVE_ID2,
@@ -530,7 +530,8 @@ static int tps80031_regulator_config(struct device *parent,
 	case TPS80031_REGULATOR_LDOUSB:
 		if (ri->config_flags & (TPS80031_USBLDO_INPUT_VSYS |
 			TPS80031_USBLDO_INPUT_PMID)) {
-			unsigned val = 0;
+			unsigned val;
+
 			if (ri->config_flags & TPS80031_USBLDO_INPUT_VSYS)
 				val = MISC2_LDOUSB_IN_VSYS;
 			else
-- 
2.25.1

