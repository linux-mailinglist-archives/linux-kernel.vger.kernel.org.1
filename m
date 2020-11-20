Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B3C2BB051
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgKTQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbgKTQV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:21:57 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4539223BE;
        Fri, 20 Nov 2020 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889316;
        bh=jD4Bn4VQyoQtrvqTo3OyWnBnEvZ0eaqrOfZgmShItzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yp2Y80CBDdX73HEUGWtTvWl/tu3dFo7lweglcdheEbEKOiVfWLuI+gr7nIWn0elMM
         lIlWKkkmE8R/gezRIc5YV9dlaaZ8P84QGB6d6Ta3AByW2gUy7BcAwhkguncUNK1nNO
         snWXO2FnrOH0Z0V9vpSOBfwKkqATETZLOrgRwd/c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 04/16] mfd: da9063: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:21 +0100
Message-Id: <20201120162133.472938-4-krzk@kernel.org>
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

  drivers/mfd/da9063-i2c.c:348:34: warning: ‘da9063_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/da9063-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index b8217ad303ce..3781d0bb7786 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -455,7 +455,7 @@ MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
 static struct i2c_driver da9063_i2c_driver = {
 	.driver = {
 		.name = "da9063",
-		.of_match_table = of_match_ptr(da9063_dt_ids),
+		.of_match_table = da9063_dt_ids,
 	},
 	.probe    = da9063_i2c_probe,
 	.id_table = da9063_i2c_id,
-- 
2.25.1

