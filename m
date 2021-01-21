Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14742FE406
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbhAUHdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:33:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:50408 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbhAUH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:29:40 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10L7SS080018289, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10L7SS080018289
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 15:28:29 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 21 Jan
 2021 15:28:28 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ricky_wu@realtek.corp-partner.google.com>, <sashal@kernel.org>,
        <levinale@google.com>, <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        <kdlnx@doth.eu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtsx: pci: fix device aspm state bug
Date:   Thu, 21 Jan 2021 15:28:23 +0800
Message-ID: <20210121072823.31977-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.corp-partner.google.com>

changed rtsx_pci_disable_aspm() to rtsx_disable_aspm()
make sure pcr->aspm_enabled to sync with aspm state

BUG=b:175338107
TEST=chromeos-kernel-5_4

Signed-off-by: Ricky Wu <ricky_wu@realtek.corp-partner.google.com>
Change-Id: I4b146dcdaaf2f2a965381c32780b0b110d751258
---
 drivers/misc/cardreader/rtsx_pcr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index f07b01125d19..f3645e72ecc4 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1285,8 +1285,15 @@ int rtsx_ms_power_off_card3v3(struct rtsx_pcr *pcr)
 static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 {
 	int err;
+	u8 val;
 
 	pcr->pcie_cap = pci_find_capability(pcr->pci, PCI_CAP_ID_EXP);
+	rtsx_pci_read_config_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL, &val);
+	if (val & 0x02)
+		pcr->aspm_enabled = true;
+	else
+		pcr->aspm_enabled = false;
+
 	rtsx_pci_writel(pcr, RTSX_HCBAR, pcr->host_cmds_addr);
 
 	rtsx_pci_enable_bus_int(pcr);
@@ -1307,7 +1314,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	/* Wait SSC power stable */
 	udelay(200);
 
-	rtsx_pci_disable_aspm(pcr);
+	rtsx_disable_aspm(pcr);
 	if (pcr->ops->optimize_phy) {
 		err = pcr->ops->optimize_phy(pcr);
 		if (err < 0)
-- 
2.17.1

