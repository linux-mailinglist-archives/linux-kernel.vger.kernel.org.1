Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FF02B40F6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgKPKUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728832AbgKPKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:30 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B157222E8;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=js84ZgGHWrr4G6ZbrEp+3qfBF3y+4j27kugX1PPwPo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hwyqm/0Eu5mNLSwf3lorMTDBa9AQVGPU/LEK8Fs/EmQY1m+aVP+y5T2lOnxRhbvm2
         qc9Cuq3KThOsc8MOcrNMoLqBFEkOoYmPovGeQM4tSy2DkVxpQipJw2VTw/mdabe5YO
         FbEoQhCT3JvsZfY0veVKBtzVZNSvy0EC1Qxe/z8Q=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwE9-5s; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/27] rapidio: fix kernel-doc a markup
Date:   Mon, 16 Nov 2020 11:18:05 +0100
Message-Id: <d287d2af8e7cf4d68cd60ce65c9f165ab529f990.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
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
index 606986c5ba2c..16b59b472b3d 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -732,41 +732,41 @@ EXPORT_SYMBOL_GPL(rio_unmap_inb_region);
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
-- 
2.28.0

