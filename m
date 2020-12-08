Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057422D238B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 07:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgLHGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 01:20:31 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:40708 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgLHGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 01:20:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id ECCC32002574;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZBTPuLp1ntSU; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9C7702002579;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 6C48AC01FB5;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 1FA192002FA; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jack <jack.lo@gtsys.com.hk>
Subject: [PATCH 3/6] mmc: core: add enhanced strobe to mmc_select_hs400()
Date:   Tue,  8 Dec 2020 14:18:36 +0800
Message-Id: <20201208061839.21163-4-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mmc_select_hs400() and mmc_select_hs400es have almost
identical code it seems okay to merge them.
Add the function calls for enhanced strobe to mmc_select_hs400 and
add  a bool variable to the function call to enable them if HS400ES
is selected.
mmc_select_hs400es() becomes obsolate and can be removed.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/mmc/core/mmc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e7b4de3d4f47..84c09d9e0317 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1333,7 +1333,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	return err;
 }
 
-static int mmc_select_hs400(struct mmc_card *card)
+static int mmc_select_hs400(struct mmc_card *card, bool enhancedstrobe)
 {
 	struct mmc_host *host = card->host;
 	unsigned int max_dtr;
@@ -1409,9 +1409,12 @@ static int mmc_select_hs400(struct mmc_card *card)
 		host->ops->hs400_prepare_ddr(host);
 
 	/* Switch card to DDR */
+	val = EXT_CSD_DDR_BUS_WIDTH_8;
+	if (enhancedstrobe)
+		val |= EXT_CSD_BUS_WIDTH_STROBE;
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
-			 EXT_CSD_DDR_BUS_WIDTH_8,
+			 val,
 			 card->ext_csd.generic_cmd6_time);
 	if (err) {
 		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
@@ -1451,6 +1454,13 @@ static int mmc_select_hs400(struct mmc_card *card)
 	if (host->ops->hs400_complete)
 		host->ops->hs400_complete(host);
 
+	if (enhancedstrobe) {
+		/* Controller enable enhanced strobe function */
+		host->ios.enhanced_strobe = true;
+		if (host->ops->hs400_enhanced_strobe)
+			host->ops->hs400_enhanced_strobe(host, &host->ios);
+	}
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
@@ -1465,7 +1475,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 
 int mmc_hs200_to_hs400(struct mmc_card *card)
 {
-	return mmc_select_hs400(card);
+	return mmc_select_hs400(card, false);
 }
 
 /*
@@ -1549,9 +1559,9 @@ static int mmc_select_timing(struct mmc_card *card)
 		goto bus_speed;
 
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
-		err = mmc_select_hs400es(card);
+		err = mmc_select_hs400(card, true);
 	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400)
-		err = mmc_select_hs400(card);
+		err = mmc_select_hs400(card, false);
 	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
 		err = mmc_select_hs200(card);
 	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
-- 
2.20.1

