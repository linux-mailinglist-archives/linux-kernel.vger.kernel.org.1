Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2E3045E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391500AbhAZSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:03:51 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57360 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390905AbhAZJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:10:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UMyJhuB_1611652154;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMyJhuB_1611652154)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 17:09:17 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     hca@linux.ibm.com
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] s390: Simplify the calculation of variables
Date:   Tue, 26 Jan 2021 17:09:12 +0800
Message-Id: <1611652152-58139-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./arch/s390/include/asm/scsw.h:528:48-50: WARNING !A || A && B is
equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 arch/s390/include/asm/scsw.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index c00f7b0..a7c3ccf 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -525,8 +525,7 @@ static inline int scsw_cmd_is_valid_pno(union scsw *scsw)
 	return (scsw->cmd.fctl != 0) &&
 	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
 	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
-		 ((scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
-		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED)));
+		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED));
 }
 
 /**
-- 
1.8.3.1

