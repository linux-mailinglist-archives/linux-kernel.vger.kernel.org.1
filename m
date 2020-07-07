Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2230321649B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 05:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGGDgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 23:36:01 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:17095 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726869AbgGGDgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:36:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U1zux00_1594092948;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U1zux00_1594092948)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 11:35:48 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, vt@altlinux.org, linux-kernel@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH ima-evm-utils 1/3] ima-evm-utils: Fix mismatched type checking
Date:   Tue,  7 Jul 2020 11:35:46 +0800
Message-Id: <20200707033548.21640-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if imaevm_get_hash_algo() returns an error value of -1, it is
forced to be converted to uint8_t type here, resulting in this error
not being checked by the if condition. This patch fixes this error.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/libimaevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index e6947d7..a9419ee 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -922,7 +922,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	hdr->version = (uint8_t) DIGSIG_VERSION_2;
 
 	hdr->hash_algo = imaevm_get_hash_algo(algo);
-	if (hdr->hash_algo == -1) {
+	if (hdr->hash_algo == (uint8_t)-1) {
 		log_err("sign_hash_v2: hash algo is unknown: %s\n", algo);
 		return -1;
 	}
-- 
2.17.1

