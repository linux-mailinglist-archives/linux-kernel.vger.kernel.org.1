Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B4C2FE7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbhAUKie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:38:34 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46948 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbhAUKhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:37:01 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10LAa6gS5029293, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10LAa6gS5029293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 18:36:06 +0800
Received: from localhost (172.22.88.222) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 21 Jan
 2021 18:36:05 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <bhelgaas@google.com>, <ricky_wu@realtek.com>,
        <vaibhavgupta40@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: rtsx: init value of aspm_enabled
Date:   Thu, 21 Jan 2021 18:35:59 +0800
Message-ID: <20210121103559.2574-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

make sure ASPM state sync with pcr->aspm_enabled
init value pcr->aspm_enabled

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 2aa6648fa41f..5a491d2cd1ae 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1512,6 +1512,7 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 	struct pcr_handle *handle;
 	u32 base, len;
 	int ret, i, bar = 0;
+	u8 val;
 
 	dev_dbg(&(pcidev->dev),
 		": Realtek PCI-E Card Reader found at %s [%04x:%04x] (rev %x)\n",
@@ -1577,7 +1578,11 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
 	pcr->host_cmds_addr = pcr->rtsx_resv_buf_addr;
 	pcr->host_sg_tbl_ptr = pcr->rtsx_resv_buf + HOST_CMDS_BUF_LEN;
 	pcr->host_sg_tbl_addr = pcr->rtsx_resv_buf_addr + HOST_CMDS_BUF_LEN;
-
+	rtsx_pci_read_register(pcr, ASPM_FORCE_CTL, &val);
+	if (val & FORCE_ASPM_CTL0 && val & FORCE_ASPM_CTL1)
+		pcr->aspm_enabled = false;
+	else
+		pcr->aspm_enabled = true;
 	pcr->card_inserted = 0;
 	pcr->card_removed = 0;
 	INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
-- 
2.17.1

