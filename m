Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4778A1C80A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 05:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEGDsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 23:48:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGDsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:48:18 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E933DA39FC9FCBC8410B;
        Thu,  7 May 2020 11:48:06 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 11:47:58 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>
CC:     <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] ALSA: sound/ppc: Use bitwise instead of arithmetic operator for flags
Date:   Thu, 7 May 2020 11:54:07 +0800
Message-ID: <1588823647-12480-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccinelle warnings:

sound/ppc/pmac.c:729:57-58: WARNING: sum of probable bitmasks, consider |
sound/ppc/pmac.c:229:37-38: WARNING: sum of probable bitmasks, consider |

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 sound/ppc/pmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 592532c..2e750b3 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -226,7 +226,7 @@ static int snd_pmac_pcm_prepare(struct snd_pmac *chip, struct pmac_stream *rec,
 		offset += rec->period_size;
 	}
 	/* make loop */
-	cp->command = cpu_to_le16(DBDMA_NOP + BR_ALWAYS);
+	cp->command = cpu_to_le16(DBDMA_NOP | BR_ALWAYS);
 	cp->cmd_dep = cpu_to_le32(rec->cmd.addr);
 
 	snd_pmac_dma_stop(rec);
@@ -726,7 +726,7 @@ void snd_pmac_beep_dma_start(struct snd_pmac *chip, int bytes, unsigned long add
 	chip->extra_dma.cmds->xfer_status = cpu_to_le16(0);
 	chip->extra_dma.cmds->cmd_dep = cpu_to_le32(chip->extra_dma.addr);
 	chip->extra_dma.cmds->phy_addr = cpu_to_le32(addr);
-	chip->extra_dma.cmds->command = cpu_to_le16(OUTPUT_MORE + BR_ALWAYS);
+	chip->extra_dma.cmds->command = cpu_to_le16(OUTPUT_MORE | BR_ALWAYS);
 	out_le32(&chip->awacs->control,
 		 (in_le32(&chip->awacs->control) & ~0x1f00)
 		 | (speed << 8));
-- 
2.6.2

