Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966042468F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 17:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgHQPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 11:00:12 -0400
Received: from mxwww.masterlogin.de ([95.129.51.170]:60730 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgHQPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:00:04 -0400
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 592332C50B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:58:01 +0000 (UTC)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id ED0345FC27;
        Mon, 17 Aug 2020 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1597676275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JxtKGSfzAAilxUKwLtaxmOttaDPpQe5ywMco1swezzI=;
        b=ADVwlWEXLFA/o5NoLJkNMKH50lW4l8zhhbBqa6obXkkT6OkBY6qqFrw0sZiuGEWYVRghnI
        3OWFLA8qEnzT2yalBF6sGWtccH+flROqPm7T/woCEeXuvmZr5djc8d1OGZ/LMflVamSoPq
        vkF1UyjGwpFzL4B0dGOKPDPKtsdRacM=
Received: from localhost.localdomain (fttx-pool-217.61.148.252.bambit.de [217.61.148.252])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4ACA2100474;
        Mon, 17 Aug 2020 14:57:54 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
Date:   Mon, 17 Aug 2020 16:57:38 +0200
Message-Id: <20200817145738.986999-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This reverts commit f97dbf48ca43009e8b8bcdf07f47fc9f06149b36 which
breaks bootup of arm/arm64 devices like bananapi-r2/mt7623 and
bananapi-r64/mt7622

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/irqchip/irq-mtk-sysirq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 7299c5ab4d10..6ff98b87e5c0 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -231,6 +231,4 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 	kfree(chip_data);
 	return ret;
 }
-IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
-IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
-IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
+IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
-- 
2.25.1

