Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04FC1AF829
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDSHLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 03:11:14 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4377 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSHLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:11:13 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e9bf98210d-b83fb; Sun, 19 Apr 2020 15:10:58 +0800 (CST)
X-RM-TRANSID: 2ee25e9bf98210d-b83fb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e9bf980792-fc83d;
        Sun, 19 Apr 2020 15:10:58 +0800 (CST)
X-RM-TRANSID: 2ee85e9bf980792-fc83d
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] crypto: Delete redundant variable definition
Date:   Sun, 19 Apr 2020 15:12:45 +0800
Message-Id: <20200419071245.3924-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable "i" is redundant to be assigned a value
of zero,because it's assigned in the for loop, so remove
redundant one here.

Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

---
 drivers/crypto/bcm/cipher.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index c8b940854..5db23c18c 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -4724,7 +4724,6 @@ static int spu_dt_read(struct platform_device *pdev)
 	spu->spu_type = matched_spu_type->type;
 	spu->spu_subtype = matched_spu_type->subtype;
 
-	i = 0;
 	for (i = 0; (i < MAX_SPUS) && ((spu_ctrl_regs =
 		platform_get_resource(pdev, IORESOURCE_MEM, i)) != NULL); i++) {
 
-- 
2.20.1.windows.1



