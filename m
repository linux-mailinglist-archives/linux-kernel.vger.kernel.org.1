Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB92BBE1D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 09:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgKUIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 03:37:51 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:45845 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgKUIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 03:37:50 -0500
Received: from localhost.localdomain ([81.185.161.242])
        by mwinf5d61 with ME
        id uwdl2300M5E5lq903wdmYS; Sat, 21 Nov 2020 09:37:47 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Nov 2020 09:37:47 +0100
X-ME-IP: 81.185.161.242
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     perex@perex.cz, tiwai@suse.com, dan.carpenter@oracle.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH V2] ALSA: emu10k1: Use dma_set_mask_and_coherent to simplify code
Date:   Sat, 21 Nov 2020 09:37:47 +0100
Message-Id: <20201121083747.1330299-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: do not update the dev_err message, to keep consistency with other dev_err
---
 sound/pci/emu10k1/emu10k1x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index def8161cde4c..f2b6fd434474 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -894,8 +894,8 @@ static int snd_emu10k1x_create(struct snd_card *card,
 
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	if (pci_set_dma_mask(pci, DMA_BIT_MASK(28)) < 0 ||
-	    pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(28)) < 0) {
+
+	if (dma_set_mask_and_coherent(&pci->dev, DMA_BIT_MASK(28)) < 0) {
 		dev_err(card->dev, "error to set 28bit mask DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
-- 
2.27.0

