Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6DD270EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgISPMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 11:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgISPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 11:12:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB8C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 08:12:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y11so8099739qtn.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTmbpiZJZ36QTZI1/cVqn9PbMiis6W52fV5OuJ825Kw=;
        b=dWqubfN9cccD9q6YpZj9CS3JE+GznVFJzH3/CCpl/ixmcEbKGtIY1WrlZTMX6abAXh
         +/Gd46Ut4Ne/xXXbAKRpWQo3YTxu+75eCwfzr2FkvZT6ndDmjlk9xgB3Gt+N01UTQgZR
         Tg5yugJSK1zSxTefb3/lPJft8a8eMdeF89lBSo1S7LqRa+kHOkBRr28xEDWCiPOpBLLU
         MgOKu+KOC/r1QlFU0H0SneOsXQ4niw7TXL/0u9/aqAokiTO4Q275Mvwtpi10qDf4O+sH
         a/rWaz/OfluUTed1/3ug6cmTNCfG8HVYlCemADDzDgOiJnN438fnOL+BFC944qa+lmiY
         Tv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTmbpiZJZ36QTZI1/cVqn9PbMiis6W52fV5OuJ825Kw=;
        b=J7V2J7x3w5UmWbi48El+mDDUAm3X1Cr//6WdUbGPTXFDV18vXnIgdMVKtJUFQ6CEJc
         8d94xcr2fSS10M3+XgvmRuFzfbEzm/awjAVga6oIaNCmfmPueWXr96sfLW6LR/xNdwue
         BFBZW5P1DQOJSXnLn+eROwFvYRQyEf4i2w4Vwq/C0nbCJHzBkg9SCpL0Cp8nHL9z9Tba
         0F+Nk3IjVaD+/G5D7dZ0W9IzGo+njJEyk5DGPdDqYFVBdcfGMvDThg0h4EGkhA2A/Kma
         2dkxEJAIYNWAnIGpV+/bVI5JiVyNfsaj0etQ8jFbBY2sc8EWraCGFBpY3KKP89skcIOu
         yk8w==
X-Gm-Message-State: AOAM533aOc5PT37UjiuOcdOZ2XVy9ogvFe63LPdMC0cczonvD1zjvdcX
        xgI07JMinrqlNKcePvX0QWpnAKdYN6Y=
X-Google-Smtp-Source: ABdhPJyDkj+15hjnJwPM+dcN3G2ilevN87ZCVWpyw8C8MQtMPz/AaoCpHTdtQ2FGsZhqO8+LYLTi/g==
X-Received: by 2002:aed:2be2:: with SMTP id e89mr38518720qtd.298.1600528352916;
        Sat, 19 Sep 2020 08:12:32 -0700 (PDT)
Received: from localhost.localdomain (dslb-092-073-054-206.092.073.pools.vodafone-ip.de. [92.73.54.206])
        by smtp.gmail.com with ESMTPSA id z3sm4513222qkj.0.2020.09.19.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 08:12:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8192u: clean up comparsions to NULL
Date:   Sat, 19 Sep 2020 17:08:23 +0200
Message-Id: <20200919150823.16923-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200919150823.16923-1-straube.linux@gmail.com>
References: <20200919150823.16923-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comparsions to NULL reported by checkpatch.
if (x == NULL) -> if (!x)
if (x != NULL) -> if (x)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c     | 6 +++---
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 4 ++--
 drivers/staging/rtl8192u/r819xU_phy.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 1d1685d2e908..d853586705fc 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -250,7 +250,7 @@ static int rtl8180_wx_get_range(struct net_device *dev,
 	/* range->old_num_channels; */
 	/* range->old_num_frequency; */
 	/* range->old_freq[6]; */ /* Filler to keep "version" at the same offset */
-	if (priv->rf_set_sens != NULL)
+	if (priv->rf_set_sens)
 		range->sensitivity = priv->max_sens;	/* signal level threshold range */
 
 	range->max_qual.qual = 100;
@@ -666,7 +666,7 @@ static int r8192_wx_get_sens(struct net_device *dev,
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	if (priv->rf_set_sens == NULL)
+	if (!priv->rf_set_sens)
 		return -1; /* we have not this support for this radio */
 	wrqu->sens.value = priv->sens;
 	return 0;
@@ -680,7 +680,7 @@ static int r8192_wx_set_sens(struct net_device *dev,
 	short err = 0;
 
 	mutex_lock(&priv->wx_mutex);
-	if (priv->rf_set_sens == NULL) {
+	if (!priv->rf_set_sens) {
 		err = -1; /* we have not this support for this radio */
 		goto exit;
 	}
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index c58c9cac2599..4cece40a92f6 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -430,7 +430,7 @@ static void cmpk_handle_tx_rate_history(struct net_device *dev, u8 *pmsg)
 
 	ptxrate = (cmpk_tx_rahis_t *)pmsg;
 
-	if (ptxrate == NULL)
+	if (!ptxrate)
 		return;
 
 	for (i = 0; i < 16; i++) {
@@ -479,7 +479,7 @@ u32 cmpk_message_handle_rx(struct net_device *dev,
 	/* 0. Check inpt arguments. It is a command queue message or
 	 * pointer is null.
 	 */
-	if (pstats == NULL)
+	if (!pstats)
 		return 0;	/* This is not a command packet. */
 
 	/* 1. Read received command packet message length from RFD. */
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index aa71ea97a179..eef751d2b12e 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1150,7 +1150,7 @@ static u8 rtl8192_phy_SetSwChnlCmdArray(struct sw_chnl_cmd *CmdTable, u32 CmdTab
 {
 	struct sw_chnl_cmd *pCmd;
 
-	if (CmdTable == NULL) {
+	if (!CmdTable) {
 		RT_TRACE(COMP_ERR, "%s(): CmdTable cannot be NULL\n", __func__);
 		return false;
 	}
-- 
2.28.0

