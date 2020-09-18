Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF727089D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgIRV5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:57:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50960 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:57:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kJONH-00051w-Q8; Fri, 18 Sep 2020 21:56:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto/chcr: fix minor indentation issue
Date:   Fri, 18 Sep 2020 22:56:59 +0100
Message-Id: <20200918215659.49825-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a statement that is indented by one whitespace too deeply,
fix this by removing the whitespace.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/chelsio/chcr_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_core.c b/drivers/crypto/chelsio/chcr_core.c
index 40d51d2bd935..f91f9d762a45 100644
--- a/drivers/crypto/chelsio/chcr_core.c
+++ b/drivers/crypto/chelsio/chcr_core.c
@@ -127,7 +127,7 @@ static void chcr_dev_init(struct uld_ctx *u_ctx)
 
 static int chcr_dev_move(struct uld_ctx *u_ctx)
 {
-	 mutex_lock(&drv_data.drv_mutex);
+	mutex_lock(&drv_data.drv_mutex);
 	if (drv_data.last_dev == u_ctx) {
 		if (list_is_last(&drv_data.last_dev->entry, &drv_data.act_dev))
 			drv_data.last_dev = list_first_entry(&drv_data.act_dev,
-- 
2.27.0

