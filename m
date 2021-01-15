Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C72F7636
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbhAOKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:04:58 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43589 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbhAOKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:04:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ULo5zww_1610705034;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULo5zww_1610705034)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Jan 2021 18:03:59 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] drivers/tty: Use bitwise instead of arithmetic operator for flags
Date:   Fri, 15 Jan 2021 18:03:51 +0800
Message-Id: <1610705031-20332-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/tty/synclink_gt.c:4384:15-16: WARNING: sum of probable
bitmasks, consider |
./drivers/tty/synclink_gt.c:4342:39-40: WARNING: sum of probable
bitmasks, consider |
./drivers/tty/synclink_gt.c:4280:48-49: WARNING: sum of probable
bitmasks, consider |
./drivers/tty/synclink_gt.c:2221:20-21: WARNING: sum of probable
bitmasks, consider |

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/tty/synclink_gt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index c0b384e..d302c08 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -2219,7 +2219,7 @@ static void isr_tdma(struct slgt_info *info)
 	 */
 	wr_reg32(info, TDCSR, status);	/* clear pending */
 
-	if (status & (BIT5 + BIT4 + BIT3)) {
+	if (status & (BIT5 | BIT4 | BIT3)) {
 		// another transmit buffer has completed
 		// run bottom half to get more send data from user
 		info->pending_bh |= BH_TRANSMIT;
@@ -4265,7 +4265,9 @@ static void sync_mode(struct slgt_info *info)
 	case MGSL_MODE_XSYNC:
 		val |= BIT15 + BIT13;
 		break;
-	case MGSL_MODE_MONOSYNC: val |= BIT14 + BIT13; break;
+	case MGSL_MODE_MONOSYNC:
+		val |= BIT14 | BIT13;
+		break;
 	case MGSL_MODE_BISYNC:   val |= BIT15; break;
 	case MGSL_MODE_RAW:      val |= BIT13; break;
 	}
@@ -4278,7 +4280,9 @@ static void sync_mode(struct slgt_info *info)
 	case HDLC_ENCODING_NRZI_MARK:     val |= BIT11; break;
 	case HDLC_ENCODING_NRZI:          val |= BIT11 + BIT10; break;
 	case HDLC_ENCODING_BIPHASE_MARK:  val |= BIT12; break;
-	case HDLC_ENCODING_BIPHASE_SPACE: val |= BIT12 + BIT10; break;
+	case HDLC_ENCODING_BIPHASE_SPACE:
+		val |= BIT12 | BIT10;
+		break;
 	case HDLC_ENCODING_BIPHASE_LEVEL: val |= BIT12 + BIT11; break;
 	case HDLC_ENCODING_DIFF_BIPHASE_LEVEL: val |= BIT12 + BIT11 + BIT10; break;
 	}
@@ -4382,7 +4386,7 @@ static void sync_mode(struct slgt_info *info)
 		// reference clock, so take TxC from BRG/16 to get
 		// transmit clock at actual data rate
 		if (info->params.flags & HDLC_FLAG_RXC_DPLL)
-			val |= BIT6 + BIT5;	/* 011, txclk = BRG/16 */
+			val |= BIT6 | BIT5;	/* 011, txclk = BRG/16 */
 		else
 			val |= BIT6;	/* 010, txclk = BRG */
 	}
-- 
1.8.3.1

