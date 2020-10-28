Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42E29DAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbgJ1X02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390350AbgJ1XYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:24:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C067C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:24:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c16so828534wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVHMlW22zmaanqCjAj9gyZ0CY+vafwHwsjZbqglXk8k=;
        b=veFAPiZyFsSmJXmi9irDlTKHloisSwa7nr74nI3pF16WZtERGK+wWWsdI7u0BJsyXG
         wUOO9LJuBTKZVBYdZzhsrcojGMaXo5HTNVZBhQsc7o3qKXmJdK+Rh2ckoIrAjlysz8Co
         wgqmU18bR7AkKkt+hSBFArJq7PhcX/yJryJhN33JFo2iU/7Noz/USuwmkidqDWqxwb/z
         lrPnnHPES12W9CiSIw/KCxcRrCwjLN/j8bf3VqNZPrtn+eN5v3PeaGv9F7fKXvGzm86L
         WyM6Uq5zLG/m+imwGYKh5+8jQe/Kc/MA2M6psKtrPMzFh+8xs2mBBgsNS40Tcs9jyXKC
         YPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVHMlW22zmaanqCjAj9gyZ0CY+vafwHwsjZbqglXk8k=;
        b=sKPV7f/N7RoRUiyYL9b8JEmF0ykVQmrB0hz7vfdaBG/CPhqi6MPztaq12VS2hbKdbO
         FTuW/G6AIESuuBxzQBHuW7jeOg5PLEifFpmS/jp9Q2jX964Eso+N5+2X97S9yoH6cqnh
         R50JudxWJyfVkvd3+qjhcImDe3oTeownWUMZsCpVWZCen8qu4cdJbQYBS7Wx0Ec5YJuz
         13mpb7Lo5eiksR3kNVBVNRiFvA2uNISXNGKJG31LqyWZQCjdtzr5DtewEDawW2ddGLUz
         zQNmLvB5M9pZEgpUSh8oC6ILmKk+/7UrPFP4aTNsG2nJFrcbU/tfE5pkMmCxM3csvNsJ
         PfWQ==
X-Gm-Message-State: AOAM530/8jXkrd94Iq29XYJNp8qUno1KOuAN/qNP87aAU/Gh4WSFNOAg
        DMc8leEpBhCrQ6JrsxbhVvScUhGwUsYsyXek
X-Google-Smtp-Source: ABdhPJyKz5guLKOqCVYJSQrDJXqIRFVuywXz7JzPFuyH4l9n5f6+308R+xigyx6rhdERKFPKBz98Og==
X-Received: by 2002:a1c:1b53:: with SMTP id b80mr5643874wmb.16.1603851556467;
        Tue, 27 Oct 2020 19:19:16 -0700 (PDT)
Received: from localhost.localdomain ([109.175.166.67])
        by smtp.googlemail.com with ESMTPSA id o3sm4540177wru.15.2020.10.27.19.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:19:15 -0700 (PDT)
From:   Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: core: rtw_cmd: Fixed multiple brace coding style issues
Date:   Wed, 28 Oct 2020 02:17:16 +0000
Message-Id: <20201028021716.622-1-manuelpalenzuelamerino@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed multiple brace coding style issues in rtw_cmd.c

Signed-off-by: Manuel Palenzuela <manuelpalenzuelamerino@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 27 ++++++++----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 3ac286bbfc4e..4cf09d947d32 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -229,9 +229,8 @@ void _rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 
 	while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
 		void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
-		if (c2h && c2h != (void *)pevtpriv) {
+		if (c2h && c2h != (void *)pevtpriv)
 			kfree(c2h);
-		}
 	}
 	kfree(pevtpriv->c2h_queue);
 
@@ -339,9 +338,8 @@ int rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	int res = _FAIL;
 	struct adapter *padapter = pcmdpriv->padapter;
 
-	if (cmd_obj == NULL) {
+	if (cmd_obj == NULL)
 		goto exit;
-	}
 
 	cmd_obj->padapter = padapter;
 
@@ -543,9 +541,8 @@ int rtw_cmd_thread(void *context)
 
 		if (pcmd->cmdcode == GEN_CMD_CODE(_Set_Drv_Extra)) {
 			extra_parm = (struct drvextra_cmd_parm *)pcmd->parmbuf;
-			if (extra_parm->pbuf && extra_parm->size > 0) {
+			if (extra_parm->pbuf && extra_parm->size > 0)
 				kfree(extra_parm->pbuf);
-			}
 		}
 
 		rtw_free_cmd_obj(pcmd);
@@ -571,9 +568,8 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	struct cmd_priv 	*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SCAN, 1);
-	}
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (ph2c == NULL)
@@ -826,9 +822,8 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	/*  If not,  we have to copy the connecting AP's MAC address to it so that */
 	/*  the driver just has the bssid information for PMKIDList searching. */
 
-	if (pmlmepriv->assoc_by_bssid == false) {
+	if (pmlmepriv->assoc_by_bssid == false)
 		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.MacAddress[0], ETH_ALEN);
-	}
 
 	psecnetwork->IELength = rtw_restruct_sec_ie(padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0], pnetwork->network.IELength);
 
@@ -1349,9 +1344,8 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 
 				/* DBG_871X("Set TrafficTransitionCount to %d\n", pmlmepriv->LinkDetectInfo.TrafficTransitionCount); */
 
-				if (pmlmepriv->LinkDetectInfo.TrafficTransitionCount > 30/*TrafficTransitionLevel*/) {
+				if (pmlmepriv->LinkDetectInfo.TrafficTransitionCount > 30/*TrafficTransitionLevel*/)
 					pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 30;
-				}
 			}
 		} else {
 			/* DBG_871X("(+)Tx = %d, Rx = %d\n", pmlmepriv->LinkDetectInfo.NumTxOkInPeriod, pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod); */
@@ -1405,9 +1399,8 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter)
 	struct mlme_priv *pmlmepriv;
 	pmlmepriv = &(padapter->mlmepriv);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
 		expire_timeout_chk(padapter);
-	}
 
 	/* for debug purpose */
 	_linked_info_dump(padapter);
@@ -1606,9 +1599,8 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 
 static void rtw_dm_ra_mask_hdl(struct adapter *padapter, struct sta_info *psta)
 {
-	if (psta) {
+	if (psta)
 		set_sta_rate(padapter, psta);
-	}
 }
 
 u8 rtw_dm_ra_mask_wk_cmd(struct adapter *padapter, u8 *psta)
@@ -1977,9 +1969,8 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
 		break;
 	}
 
-	if (pdrvextra_cmd->pbuf && pdrvextra_cmd->size > 0) {
+	if (pdrvextra_cmd->pbuf && pdrvextra_cmd->size > 0)
 		kfree(pdrvextra_cmd->pbuf);
-	}
 
 	return H2C_SUCCESS;
 }
-- 
2.26.2

