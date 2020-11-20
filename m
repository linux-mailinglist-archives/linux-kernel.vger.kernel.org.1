Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735452BB04F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgKTQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgKTQVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:21:45 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FBB22269;
        Fri, 20 Nov 2020 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889305;
        bh=Ri0geEDPBNaIDp5ynWbEvv/T+M69W04BgBU8VY7J8S0=;
        h=From:To:Cc:Subject:Date:From;
        b=kP15HsS14kmEQE8GBYs7ieD3+qZdCeMlPPvYvQHXKPVbyz+aOk9523sY9eYtk+adc
         kOM+fgWuEEks64f/BRRakuXZN27JrZxNGlTmikkrgcuE9xHfHOwAXsgo6h6nfFHuCb
         1eXtUxQqtURHimr6F8m0cRyPYJ4ItrWJ+eKIA6k0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 01/16] mfd: bcm590xx: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:18 +0100
Message-Id: <20201120162133.472938-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
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

  drivers/mfd/bcm590xx.c:95:34: warning: ‘bcm590xx_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/bcm590xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index bfac5dc091ca..6ca337cde84c 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(i2c, bcm590xx_i2c_id);
 static struct i2c_driver bcm590xx_i2c_driver = {
 	.driver = {
 		   .name = "bcm590xx",
-		   .of_match_table = of_match_ptr(bcm590xx_of_match),
+		   .of_match_table = bcm590xx_of_match,
 	},
 	.probe = bcm590xx_i2c_probe,
 	.id_table = bcm590xx_i2c_id,
-- 
2.25.1

