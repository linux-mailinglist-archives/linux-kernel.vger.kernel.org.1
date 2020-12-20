Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E59F2DF448
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 08:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgLTHOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 02:14:36 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:36276 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbgLTHOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 02:14:35 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Dec 2020 02:14:31 EST
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app4 (Coremail) with SMTP id cS_KCgAHz3DF995fUqhSAA--.51071S4;
        Sun, 20 Dec 2020 15:05:47 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ide: pci: Fix memleak in ide_pci_init_two
Date:   Sun, 20 Dec 2020 15:05:40 +0800
Message-Id: <20201220070541.7515-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgAHz3DF995fUqhSAA--.51071S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyUCry5tF48GF1fJrWrZrb_yoWDAwcEk3
        93Zrs8XrW8uFyUJr47Cr17ZryvkFZ0vrWv9wsFyr4fWasxZa4Durn7AF43CF4UWa1UZFyU
        Ar4DXr4rZryjyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUMBlZdtRf+rwAFsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When do_ide_setup_pci_device() fails, host allocated
by ide_host_alloc() may not have been freed, which
leads to memleak.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/ide/setup-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index fdc8e813170c..c7da5368fcd4 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -586,7 +586,7 @@ int ide_pci_init_two(struct pci_dev *dev1, struct pci_dev *dev2,
 		 * do_ide_setup_pci_device() on the first device!
 		 */
 		if (ret < 0)
-			goto out_free_bars;
+			goto out_free_host;
 
 		/* fixup IRQ */
 		if (ide_pci_is_in_compatibility_mode(pdev[i])) {
@@ -597,11 +597,11 @@ int ide_pci_init_two(struct pci_dev *dev1, struct pci_dev *dev2,
 	}
 
 	ret = ide_host_register(host, d, hws);
-	if (ret)
-		ide_host_free(host);
-	else
+	if (!ret)
 		goto out;
 
+out_free_host:
+	ide_host_free(host);
 out_free_bars:
 	i = n_ports / 2;
 	while (i--)
-- 
2.17.1

