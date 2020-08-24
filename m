Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0924F156
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 05:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHXDAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 23:00:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40325 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgHXDAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 23:00:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07O30E9g8004967, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07O30E9g8004967
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Aug 2020 11:00:14 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 24 Aug 2020 11:00:14 +0800
Received: from localhost (172.22.88.222) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 24 Aug
 2020 11:00:13 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <ricky_wu@realtek.com>,
        <vaibhavgupta40@gmail.com>, <rui_feng@realsil.com.cn>,
        <kdlnx@doth.eu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: rtsx: do not setting OC_POWER_DOWN reg in rtsx_pci_init_ocp()
Date:   Mon, 24 Aug 2020 11:00:06 +0800
Message-ID: <20200824030006.30033-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMB01.realtek.com.tw (172.21.6.94) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

this power saving action in rtsx_pci_init_ocp() cause INTEL-NUC6 platform
missing card reader

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 37ccc67f4914..3a4a7b0cc098 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1155,10 +1155,6 @@ void rtsx_pci_init_ocp(struct rtsx_pcr *pcr)
 			rtsx_pci_write_register(pcr, REG_OCPGLITCH,
 				SD_OCP_GLITCH_MASK, pcr->hw_param.ocp_glitch);
 			rtsx_pci_enable_ocp(pcr);
-		} else {
-			/* OC power down */
-			rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
-				OC_POWER_DOWN);
 		}
 	}
 }
-- 
2.17.1

