Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64B3299476
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788769AbgJZRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:55:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788730AbgJZRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 055161F44FCF
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 09/16] soc: mediatek: pm-domains: Allow bus protection to ignore clear ack
Date:   Mon, 26 Oct 2020 18:55:18 +0100
Message-Id: <20201026175526.2915399-10-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

In some cases the hardware does not create an acknowledgment of the
bus protection clearing. Add a flag to the bus protection indicating
that a clear event will be ignored.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/soc/mediatek/mtk-pm-domains.c |  3 +++
 drivers/soc/mediatek/mtk-pm-domains.h | 23 ++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 4b610929f858..cd70c84ebbb1 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -164,6 +164,9 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 		else
 			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
 
+		if (bpd[i].ignore_clr_ack)
+			continue;
+
 		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
 					       val, !(val & mask),
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 00af9f37c201..dda0feed03ea 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -35,19 +35,23 @@
 
 #define SPM_MAX_BUS_PROT_DATA		3
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {	\
-		.bus_prot_mask = (_mask),		\
-		.bus_prot_set = _set,			\
-		.bus_prot_clr = _clr,			\
-		.bus_prot_sta = _sta,			\
-		.bus_prot_reg_update = _update,		\
+#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
+		.bus_prot_mask = (_mask),			\
+		.bus_prot_set = _set,				\
+		.bus_prot_clr = _clr,				\
+		.bus_prot_sta = _sta,				\
+		.bus_prot_reg_update = _update,			\
+		.ignore_clr_ack = _ignore,			\
 	}
 
-#define BUS_PROT_WR(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, false)
+#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
+		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
+
+#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
+		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
 
 #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, true)
+		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
 
 #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
 		BUS_PROT_UPDATE(_mask,				\
@@ -61,6 +65,7 @@ struct scpsys_bus_prot_data {
 	u32 bus_prot_clr;
 	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
+	bool ignore_clr_ack;
 };
 
 #define MAX_SUBSYS_CLKS 10
-- 
2.28.0

