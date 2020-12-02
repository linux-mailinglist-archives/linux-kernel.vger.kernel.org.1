Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA982CB513
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgLBGdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:33:32 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:33715 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgLBGdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:33:32 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B26WZ4s8026289, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B26WZ4s8026289
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 2 Dec 2020 14:32:35 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.36) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 2 Dec 2020 14:32:35 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 2 Dec 2020
 14:32:34 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <ricky_wu@realtek.com>,
        <vaibhavgupta40@gmail.com>, <kdlnx@doth.eu>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] misc: rtsx: modify and fix init_hw function
Date:   Wed, 2 Dec 2020 14:32:28 +0800
Message-ID: <20201202063228.18319-1-ricky_wu@realtek.com>
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

changed rtsx_pci_disable_aspm() to rtsx_disable_aspm()
do not access ASPM configuration directly

changed pcie_capability_write_word() to _clear_and_set_word()
make sure only change PCI_EXP_LNKCTL bit8

make sure ASPM disable after extra_init_hw()

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index c87f791bdcb5..3612063cab09 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1289,7 +1289,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	/* Wait SSC power stable */
 	udelay(200);
 
-	rtsx_pci_disable_aspm(pcr);
+	rtsx_disable_aspm(pcr);
 	if (pcr->ops->optimize_phy) {
 		err = pcr->ops->optimize_phy(pcr);
 		if (err < 0)
@@ -1363,8 +1363,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	rtsx_pci_init_ocp(pcr);
 
 	/* Enable clk_request_n to enable clock power management */
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_CLKREQ_EN);
+	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
+					0, PCI_EXP_LNKCTL_CLKREQ_EN);
 	/* Enter L1 when host tx idle */
 	pci_write_config_byte(pdev, 0x70F, 0x5B);
 
@@ -1374,6 +1374,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 			return err;
 	}
 
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
+
 	/* No CD interrupt if probing driver with card inserted.
 	 * So we need to initialize pcr->card_exist here.
 	 */
-- 
2.17.1

