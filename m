Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700202CA233
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgLAMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:10:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbgLAMKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:37 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D89208DB;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=7+MrY1WrN8CDi9cbAqIMfEyllcqyO4ZWnXvGZ5sNbpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8C5zV2xSG7tnSlYEHex3QTXooLo6Tz0BDDjZQ2V91/QE/vN7zDulSmnSgR8xJP05
         T4AmslJbHvlEbjyBqhyVV/ewdkmMzjIt3Lk8MCTa6tmMZz/SPY7AGmowrTBSYdGT/s
         YROCKs9wmX+aX5tfrZFI10gov62Y4G5rOG6IzIQ4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T2-00DGd0-US; Tue, 01 Dec 2020 13:09:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/16] rapidio: fix kernel-doc a markup
Date:   Tue,  1 Dec 2020 13:08:57 +0100
Message-Id: <9299aecea32ac196fd1c12c4d34933d875db05b3.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probaly this was due to a cut and paste issue.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/rapidio/rio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index c2b79736a92b..e74cf09eeff0 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -720,65 +720,65 @@ EXPORT_SYMBOL_GPL(rio_unmap_inb_region);
 /**
  * rio_map_outb_region -- Map outbound memory region.
  * @mport: Master port.
  * @destid: destination id window points to
  * @rbase: RIO base address window translates to
  * @size: Size of the memory region
  * @rflags: Flags for mapping.
  * @local: physical address of memory region mapped
  *
  * Return: 0 -- Success.
  *
  * This function will create the mapping from RIO space to local memory.
  */
 int rio_map_outb_region(struct rio_mport *mport, u16 destid, u64 rbase,
 			u32 size, u32 rflags, dma_addr_t *local)
 {
 	int rc;
 	unsigned long flags;
 
 	if (!mport->ops->map_outb)
 		return -ENODEV;
 
 	spin_lock_irqsave(&rio_mmap_lock, flags);
 	rc = mport->ops->map_outb(mport, destid, rbase, size,
 		rflags, local);
 	spin_unlock_irqrestore(&rio_mmap_lock, flags);
 
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rio_map_outb_region);
 
 /**
- * rio_unmap_inb_region -- Unmap the inbound memory region
+ * rio_unmap_outb_region -- Unmap the inbound memory region
  * @mport: Master port
  * @destid: destination id mapping points to
  * @rstart: RIO base address window translates to
  */
 void rio_unmap_outb_region(struct rio_mport *mport, u16 destid, u64 rstart)
 {
 	unsigned long flags;
 
 	if (!mport->ops->unmap_outb)
 		return;
 
 	spin_lock_irqsave(&rio_mmap_lock, flags);
 	mport->ops->unmap_outb(mport, destid, rstart);
 	spin_unlock_irqrestore(&rio_mmap_lock, flags);
 }
 EXPORT_SYMBOL_GPL(rio_unmap_outb_region);
 
 /**
  * rio_mport_get_physefb - Helper function that returns register offset
  *                      for Physical Layer Extended Features Block.
  * @port: Master port to issue transaction
  * @local: Indicate a local master port or remote device access
  * @destid: Destination ID of the device
  * @hopcount: Number of switch hops to the device
  * @rmap: pointer to location to store register map type info
  */
 u32
 rio_mport_get_physefb(struct rio_mport *port, int local,
 		      u16 destid, u8 hopcount, u32 *rmap)
 {
 	u32 ext_ftr_ptr;
 	u32 ftr_header;
-- 
2.28.0

