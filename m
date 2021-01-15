Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762292F72E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbhAOGbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:31:37 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43265 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbhAOGbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:31:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BDCAA5C0151;
        Fri, 15 Jan 2021 01:30:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 15 Jan 2021 01:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=5cJMz4MozLzvx4dLK3xvc7v4a/
        +uoO5QyfAy1IyqwCk=; b=X+jitGhPuM9Qh3ZypQH/dBf912PqJ7MRxGHHmQcRd1
        oknV951WmiNtebl7B+cKkJ2PyrUXFX27sG3rw1vDneFknzam+OtxZAMxvUoUTd7m
        3VxWTA8w9NcWZGxVTocPJtPeCh5/W+toHeRqHGcQLxO7p5aLsTlKen3t2IYloT8i
        VJ8WoMXmq1dWpbj0A1wic6jc9EkW4x1iMMW7o9mY1uBbdjxOjcPeh6BDuD1BsX/u
        vkcVzd9h+lh9+0WY7ltt5XBASC3+wPszP05cKsDH6uGLlxMGYpqe2fhMnX9LvI7h
        VDifv66QsdAXM20fMiryvkO7vHrDin+MLorI0LbGcqrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5cJMz4MozLzvx4dLK
        3xvc7v4a/+uoO5QyfAy1IyqwCk=; b=oMJ7Iu5F7Jb4XrOfFIs8wN6CyIf/CL7kz
        5X2REhF39rparOM1Wx7h5aV+MWIKp+Kuf+vNIa7JhRIUPac/3lUoFWE7QNgi9q1+
        IB5Op4hbJ3pqzAxBfTRFOKyhJHMPjzY1EmvW5uAIr3c2+CdRnwZWHC71dglxx4qr
        eMvDiyBi+C5MsknFgVTUpzPyJfQKSnPSe57GlG4fF7xG4VJOwLDNX+wXMmyY76pV
        YfRxyxn7g5bnspSCb1PQ8rTijECJagq3lnled88KA9sS/1X4mQ4bsm3wpak40IKP
        UgUxnr/XFv1ae/7/6KH7xcytWUWApXZB6lOb40ppzL5Nof49Lq6fQ==
X-ME-Sender: <xms:mDYBYEOu133gN-8QLSRjT2E4PM1XhLmXa74OjWVMEtlzOeAzMCE2kA>
    <xme:mDYBYK-AH2M1d-hFZ2--dXiRv1_DTqW227isqOwdRj2_q17798mwl7dK6iev7NbeB
    t_L0tqqQYvHB-jjQRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddugdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
    nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
    epfeevledvieekudeuffetgeegfeehvdffffejueeuleduhedvgeejveejhfdtteehnecu
    kfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:mDYBYLRcu9y7sSctEJAMf9Dicc1pqGhdfs6SkKkDsmi9ltIa91ogGg>
    <xmx:mDYBYMuc4yO7WGAOwXCFQIWj6HghCEpwk_F7PP2N8s54nrF4frM8DA>
    <xmx:mDYBYMfoL5hR4zb2tizZNhI61b3ydR6SiCoVPFHjLVon6_q4YVpZrg>
    <xmx:mTYBYBFk9XuIsMaPYvuVM8bTKNs3SDkoe6yCejutwd_1bv-oyYoGTg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E284108005F;
        Fri, 15 Jan 2021 01:30:47 -0500 (EST)
From:   Klaus Jensen <its@irrelevant.dk>
To:     linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@fb.com>, Klaus Jensen <its@irrelevant.dk>,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v2] nvme: allow use of cmb on v1.4 controllers
Date:   Fri, 15 Jan 2021 07:30:46 +0100
Message-Id: <20210115063046.274495-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Klaus Jensen <k.jensen@samsung.com>

Since NVMe v1.4 the Controller Memory Buffer must be explicitly enabled
by the host.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/nvme/host/pci.c | 13 ++++++++++++-
 include/linux/nvme.h    |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50d9a20568a2..62eb83030a5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -23,6 +23,7 @@
 #include <linux/t10-pi.h>
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
@@ -1787,7 +1788,7 @@ static u32 nvme_cmb_size(struct nvme_dev *dev)
 
 static void nvme_map_cmb(struct nvme_dev *dev)
 {
-	u64 size, offset;
+	u64 size, offset, cmbmsc;
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int bar;
@@ -1795,6 +1796,9 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (dev->cmb_size)
 		return;
 
+	if (NVME_CAP_CMBS(dev->ctrl.cap))
+		writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
+
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
@@ -1808,6 +1812,13 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (offset > bar_size)
 		return;
 
+	if (NVME_CAP_CMBS(dev->ctrl.cap)) {
+		cmbmsc = pci_bus_address(pdev, bar) + offset;
+		cmbmsc |= (NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE);
+
+		hi_lo_writeq(cmbmsc, dev->bar + NVME_REG_CMBMSC);
+	}
+
 	/*
 	 * Controllers may support a CMB size larger than their BAR,
 	 * for example, due to being behind a bridge. Reduce the CMB to
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d92535997687..bfed36e342cc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -116,6 +116,9 @@ enum {
 	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer
 					 * Location
 					 */
+	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory
+					 * Space Control
+					 */
 	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
 	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
 	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
@@ -135,6 +138,7 @@ enum {
 #define NVME_CAP_CSS(cap)	(((cap) >> 37) & 0xff)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+#define NVME_CAP_CMBS(cap)	(((cap) >> 57) & 0x1)
 
 #define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
 #define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
@@ -192,6 +196,8 @@ enum {
 	NVME_CSTS_SHST_OCCUR	= 1 << 2,
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
 	NVME_CSTS_SHST_MASK	= 3 << 2,
+	NVME_CMBMSC_CRE		= 1 << 0,
+	NVME_CMBMSC_CMSE	= 1 << 1,
 };
 
 struct nvme_id_power_state {
-- 
2.30.0

