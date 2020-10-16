Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A82290DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbgJPWWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:22:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59833 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390822AbgJPWWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:22:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kTY7P-0008VX-98; Fri, 16 Oct 2020 22:22:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: lp872x: make a const array static, makes object smaller
Date:   Fri, 16 Oct 2020 23:22:35 +0100
Message-Id: <20201016222235.686981-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate const array lp872x_num_regulators  on the stack but
instead make it static. Makes the object code smaller by 29 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  18441	   4624	     64	  23129	   5a59	drivers/regulator/lp872x.o

After:
   text	   data	    bss	    dec	    hex	filename
  18316	   4720	     64	  23100	   5a3c	drivers/regulator/lp872x.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/lp872x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 303d7e2dc838..e84be29533f4 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -892,7 +892,7 @@ static int lp872x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 	struct lp872x *lp;
 	struct lp872x_platform_data *pdata;
 	int ret;
-	const int lp872x_num_regulators[] = {
+	static const int lp872x_num_regulators[] = {
 		[LP8720] = LP8720_NUM_REGULATORS,
 		[LP8725] = LP8725_NUM_REGULATORS,
 	};
-- 
2.27.0

