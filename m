Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABDC21D154
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgGMIFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:05:36 -0400
Received: from mail.ispras.ru ([83.149.199.84]:38370 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:05:35 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 327C140AAD8D;
        Mon, 13 Jul 2020 08:05:33 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] fbdev: sm712fb: handle ioremap() errors in probe
Date:   Mon, 13 Jul 2020 11:05:32 +0300
Message-Id: <20200713080532.15504-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smtcfb_pci_probe() does not handle ioremap() errors for case 0x720. The
patch fixes that exactly like for case 0x710/2.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/sm712fb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6a1b4a853d9e..0171b23fa211 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1602,6 +1602,14 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		sfb->fb->fix.mmio_start = mmio_base;
 		sfb->fb->fix.mmio_len = 0x00200000;
 		sfb->dp_regs = ioremap(mmio_base, 0x00200000 + smem_size);
+		if (!sfb->dp_regs) {
+			dev_err(&pdev->dev,
+				"%s: unable to map memory mapped IO!\n",
+				sfb->fb->fix.id);
+			err = -ENOMEM;
+			goto failed_fb;
+		}
+
 		sfb->lfb = sfb->dp_regs + 0x00200000;
 		sfb->mmio = (smtc_regbaseaddress =
 		    sfb->dp_regs + 0x000c0000);
-- 
2.16.4

