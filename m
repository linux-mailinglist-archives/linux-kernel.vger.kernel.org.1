Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB52CB512
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLBGci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:32:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:33545 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgLBGch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:32:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B26VS7G0025898, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B26VS7G0025898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 2 Dec 2020 14:31:28 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.36) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 2 Dec 2020 14:31:28 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 2 Dec 2020
 14:31:28 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <ricky_wu@realtek.com>,
        <vaibhavgupta40@gmail.com>, <kdlnx@doth.eu>,
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] misc: rtsx: modify en/disable aspm function
Date:   Wed, 2 Dec 2020 14:31:24 +0800
Message-ID: <20201202063124.18262-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXH365.realtek.com.tw (172.21.6.37) To
 RTEXMBS01.realtek.com.tw (172.21.6.36)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

enable/disable device ASPM function:
changed write ASPM configuration directly to use write register

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 5d15607027e9..c87f791bdcb5 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -89,9 +89,15 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   enable ? pcr->aspm_en : 0);
+	if (pcr->aspm_en & 0x02)
+		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
+			FORCE_ASPM_CTL1, enable ? 0 : FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
+	else
+		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
+			FORCE_ASPM_CTL1, FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
+
+	if (!enable && (pcr->aspm_en & 0x02))
+		mdelay(10);
 
 	pcr->aspm_enabled = enable;
 }
-- 
2.17.1

