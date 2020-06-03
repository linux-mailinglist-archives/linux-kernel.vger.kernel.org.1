Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC01ECF66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgFCMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 08:05:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48256 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgFCMFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:05:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jgS98-00045d-8Y; Wed, 03 Jun 2020 12:05:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: master-ast-cf: fix spelling mistake "firwmare" -> "firmware"
Date:   Wed,  3 Jun 2020 13:05:26 +0100
Message-Id: <20200603120526.16178-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/fsi/fsi-master-ast-cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 04d10ea8d343..85d9be38b32b 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -838,7 +838,7 @@ static int load_copro_firmware(struct fsi_master_acf *master)
 	rc = request_firmware(&fw, FW_FILE_NAME, master->dev);
 	if (rc) {
 		dev_err(
-			master->dev, "Error %d to load firwmare '%s' !\n",
+			master->dev, "Error %d to load firmware '%s' !\n",
 			rc, FW_FILE_NAME);
 		return rc;
 	}
-- 
2.25.1

