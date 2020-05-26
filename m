Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DAF1B57C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 11:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgDWJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 05:07:49 -0400
Received: from mailomta30-sa.btinternet.com ([213.120.69.36]:41402 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDWJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:07:49 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20200423090746.GEMB3922.sa-prd-fep-041.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Thu, 23 Apr 2020 10:07:46 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.51.225.56]
X-OWM-Source-IP: 31.51.225.56 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecukfhppeefuddrhedurddvvdehrdehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehhvghnrhihrdhhohhmvgdpihhnvghtpeefuddrhedurddvvdehrdehiedpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeorgigsghovgeskhgvrhhnvghlrdgukheqpdhrtghpthhtohepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoehlihhnuhigqdhiuggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeolhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.51.225.56) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5E3A27DB0CE250A7; Thu, 23 Apr 2020 10:07:46 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH] ata: sata_inic162x fixed a spelling issue
Date:   Thu, 23 Apr 2020 10:07:42 +0100
Message-Id: <20200423090742.20590-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a warning message spelling issue.

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/ata/sata_inic162x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index a6b76cc12a66..e517bd8822a5 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -145,7 +145,7 @@ enum {
 
 	/* PORT_IDMA_CTL bits */
 	IDMA_CTL_RST_ATA	= (1 << 2),  /* hardreset ATA bus */
-	IDMA_CTL_RST_IDMA	= (1 << 5),  /* reset IDMA machinary */
+	IDMA_CTL_RST_IDMA	= (1 << 5),  /* reset IDMA machinery */
 	IDMA_CTL_GO		= (1 << 7),  /* IDMA mode go */
 	IDMA_CTL_ATA_NIEN	= (1 << 8),  /* ATA IRQ disable */
 
-- 
2.17.1

