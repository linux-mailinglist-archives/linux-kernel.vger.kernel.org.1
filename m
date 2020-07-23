Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AFA22B317
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgGWQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 12:01:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53581 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:01:00 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jydbH-0001b3-Hf; Thu, 23 Jul 2020 15:57:40 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        kyounghwan sohn <kyounghwan.sohn@sk.com>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] nvme/pci: Add new quirk for SK hynix PC400 NLB off-by-one bug
Date:   Thu, 23 Jul 2020 23:57:31 +0800
Message-Id: <20200723155731.22313-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417083641.28205-1-kai.heng.feng@canonical.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
command"), SK hynix PC400 becomes very slow with the following error
message:
[  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]

SK Hynix PC400 has a buggy firmware that treats NLB as max value instead
of a range, so the NLB passed isn't a valid value to the firmware.

According to SK hynix there are three commands are affected:
- Write Zeroes
- Compare
- Write Uncorrectable

Write Uncorrectable isn't implemented yet, so add a new quirk to
workaround the former two commands.

BugLink: https://bugs.launchpad.net/bugs/1872383
Cc: kyounghwan sohn <kyounghwan.sohn@sk.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- SK hynix found the root cause so change the approach accordingly.
- lspci is wrong, the device is PC400 instead of SC300.

 drivers/nvme/host/core.c | 11 ++++++++++-
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index add040168e67..1b51b6f5e2dd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -659,15 +659,21 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
+	u16 length;
+
 	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		return nvme_setup_discard(ns, req, cmnd);
 
+	length = (blk_rq_bytes(req) >> ns->lba_shift) - 1;
+	if (ns->ctrl->quirks & NVME_QUIRK_SKHYNIX_NLB_BUG)
+		length--;
+
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
 	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->write_zeroes.slba =
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
-		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+		cpu_to_le16(length);
 	cmnd->write_zeroes.control = 0;
 	return BLK_STS_OK;
 }
@@ -1302,6 +1308,9 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	}
 
 	length = (io.nblocks + 1) << ns->lba_shift;
+	if (ns->ctrl->quirks & NVME_QUIRK_SKHYNIX_NLB_BUG && io.opcode == nvme_cmd_compare)
+		length--;
+
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = nvme_to_user_ptr(io.metadata);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1de3f9b827aa..4cbced5062a8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -129,6 +129,11 @@ enum nvme_quirks {
 	 * Don't change the value of the temperature threshold feature
 	 */
 	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	= (1 << 14),
+
+	/*
+	 * SK Hynix PC400 NLB off-by-one bug
+	 */
+	NVME_QUIRK_SKHYNIX_NLB_BUG		= (1 << 15),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0633c7..b5a54e6726e4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3122,6 +3122,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
+		.driver_data = NVME_QUIRK_SKHYNIX_NLB_BUG, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
-- 
2.17.1

