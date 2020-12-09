Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD32D3EA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgLIJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:25:04 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:40412 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgLIJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=68nKVCDK0GSgHY0Nb3
        KWk5Cx357vv/psfnN2b7AiErU=; b=cx49RQB2kUcg8JQ69Y2iGR8kzU2f+kEDmp
        Yevxi1pGl0ijT7Zc3s2duKYwzWYDD7kgcgekkyBELnHXOcGV5PEB1ZqFMG7pbNRV
        AtNHTJU8BuIm28wVSr5tbLK8Q/VLTP+aXIb645SDchhLa1HuuMoVs+Wg3Uu6tmvN
        X4POZLs64=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp5 (Coremail) with SMTP id HdxpCgD3ryD2ctBfnjE4EQ--.114S4;
        Wed, 09 Dec 2020 14:47:29 +0800 (CST)
From:   Xiaohui Zhang <ruc_zhangxiaohui@163.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] crypto: Fix possible buffer overflows in pkey_protkey_aes_attr_read
Date:   Wed,  9 Dec 2020 14:47:14 +0800
Message-Id: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgD3ryD2ctBfnjE4EQ--.114S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWUKF15ArWUXr1UJFykGrg_yoWkAFX_C3
        48Wr9rur9rXr1DJFy3Ary3KrWDX3yrWr4vkas3ArW5KFy7Xay7WF4vvFZ7WrWUGw4UGFs8
        Aa4UtFyfAan3CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUYFAJUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: puxfs6pkdqw5xldrx3rl6rljoofrz/1tbiTgH1MFUDGc7+rAAAsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>

pkey_protkey_aes_attr_read() calls memcpy() without checking the
destination size may trigger a buffer overflower.

Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
---
 drivers/s390/crypto/pkey_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 99cb60ea6..abc237130 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1589,6 +1589,8 @@ static ssize_t pkey_protkey_aes_attr_read(u32 keytype, bool is_xts, char *buf,
 	if (rc)
 		return rc;
 
+	if (protkey.len > MAXPROTKEYSIZE)
+		protkey.len = MAXPROTKEYSIZE;
 	protkeytoken.len = protkey.len;
 	memcpy(&protkeytoken.protkey, &protkey.protkey, protkey.len);
 
@@ -1599,6 +1601,8 @@ static ssize_t pkey_protkey_aes_attr_read(u32 keytype, bool is_xts, char *buf,
 		if (rc)
 			return rc;
 
+		if (protkey.len > MAXPROTKEYSIZE)
+			protkey.len = MAXPROTKEYSIZE;
 		protkeytoken.len = protkey.len;
 		memcpy(&protkeytoken.protkey, &protkey.protkey, protkey.len);
 
-- 
2.17.1

