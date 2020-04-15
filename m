Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84B91A90FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 04:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392969AbgDOCig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 22:38:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37516 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgDOCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:38:30 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03F2cIomD017212, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (ms1.realsil.com.cn[172.29.17.3])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03F2cIomD017212
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 15 Apr 2020 10:38:18 +0800
Received: from localhost (172.29.40.150) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 Apr 2020
 10:38:17 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH] misc: rtsx: Improve compatibility for rts5261
Date:   Wed, 15 Apr 2020 10:37:17 +0800
Message-ID: <1586918237-3016-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

Change initial clock to improve compatibility for rts5261

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index bc4967a6efa1..547db5ffd3f6 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -639,8 +639,13 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 
 	if (initial_mode) {
 		/* We use 250k(around) here, in initial stage */
-		clk_divider = SD_CLK_DIVIDE_128;
-		card_clock = 30000000;
+		if (is_version(pcr, PID_5261, IC_VER_D)) {
+			clk_divider = SD_CLK_DIVIDE_256;
+			card_clock = 60000000;
+		} else {
+			clk_divider = SD_CLK_DIVIDE_128;
+			card_clock = 30000000;
+		}
 	} else {
 		clk_divider = SD_CLK_DIVIDE_0;
 	}
-- 
2.17.1

