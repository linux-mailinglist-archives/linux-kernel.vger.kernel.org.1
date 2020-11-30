Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963D82C7D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgK3DMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:12:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33730 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726332AbgK3DMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:12:18 -0500
X-UUID: 6c9316236f4c4bcbaddb16bff1161f5a-20201130
X-UUID: 6c9316236f4c4bcbaddb16bff1161f5a-20201130
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <lumi.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1355198473; Mon, 30 Nov 2020 11:11:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 30 Nov 2020 11:11:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Nov 2020 11:11:30 +0800
From:   Lumi Lee <Lumi.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <wsd_upstream@mediatek.com>,
        <jiaxin.yu@mediatek.com>, <eason.yen@mediatek.com>,
        <Shane.Chien@mediatek.com>, Lumi Lee <lumi.lee@mediatek.com>
Subject: [PATCH] ASoC: mediatek: btcvsd fix tx stream assign
Date:   Mon, 30 Nov 2020 11:11:15 +0800
Message-ID: <1606705875-1940-1-git-send-email-Lumi.Lee@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lumi Lee <lumi.lee@mediatek.com>

Fix tx/rx stream assign in write.
Write should use tx instead of rx.

Signed-off-by: Lumi Lee <lumi.lee@mediatek.com>
---
 sound/soc/mediatek/common/mtk-btcvsd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 668fef3..a554c57 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -808,7 +808,7 @@ static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
 		spin_unlock_irqrestore(&bt->tx_lock, flags);
 
 		if (!avail) {
-			int ret = wait_for_bt_irq(bt, bt->rx);
+			int ret = wait_for_bt_irq(bt, bt->tx);
 
 			if (ret)
 				return written_size;
-- 
1.7.9.5

