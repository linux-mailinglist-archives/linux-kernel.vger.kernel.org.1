Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF82F282922
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 08:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgJDGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 02:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgJDGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 02:04:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EAFC0613CE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 23:04:34 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 133so1474269ljj.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 23:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkwHEUvvT9CYveZ0RPl2bYKL+9nPO/XwtWy0kGlFlV0=;
        b=PwnGTnW7mg7ygJDJEX6tWdQ3vp+U/XKfJWVVKWKJykq/d34DEdq7cVh7So/9bJSxOG
         wQLdpVTVL7BvSZk32RXlbRATQIKFwBZ+xrFVZ8JJwdCuwo7gl7Jb2qQFgW/w4t8ix+6f
         KHJ82YPTwb/aTubPaAt6YiriaI1TR2jItFaHCoiDAf1Fd5uIjSH6+vwhnJbbZy5KeEin
         IaS6sSZI4tGAFC8Vvn9KKbQWTg2mgxYLtDXOhobP+qjMT/xoVsvcEqpvPgeWcMIMOiYY
         drutnqLld2vkMb9Qus8vedBsAox06L+dcGSOjRO0Lw4GJp+RFv5uJwhWuqtBddJpyl/A
         wccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkwHEUvvT9CYveZ0RPl2bYKL+9nPO/XwtWy0kGlFlV0=;
        b=hL/YDvjrV0yPxrshzIC9GaHETy5CvdYyrwlFEF6gx2sTD8J+GrChptBrbk+b5f8+km
         /CYeofR1z5k6rdLhD+P0bzHUcg9TRbxp8VJgoE2omhE9+svRUU7TMdqI6yjXxP8QT5G9
         q38PbW6kHUlkOZfq3DdcAO9t1PXHCn3my95QLxCqy/y+uifBGBzGe/r+1Ktl0Sbknad0
         L73XP9RmNh3NySZ6V7Y5yFiSyn6Au/B9qYQec+v96o2dowjnnM0+Z6ihGjLDHpahJItu
         ch56KwTxxNxdv9HsfxeXGg0OI/vcGz0NoBwze6JBjfYgPTORVNNr24TrY6cXLgBx4xO1
         E8aA==
X-Gm-Message-State: AOAM530FfFPXIr+HvrFoxgM9PC1BhacPHjMMLgqg7IiFV1uJfKcLCt66
        k6fZu/v5c0o0FXo0o8vb6KY=
X-Google-Smtp-Source: ABdhPJwbDVXzOQqaGuMPSQqvO/6paxEWEO2Y3Ict+a09ikvZf86s/2fkf/vI18YLCKBTpAMz6YVvbg==
X-Received: by 2002:a05:651c:1352:: with SMTP id j18mr2399111ljb.343.1601791473081;
        Sat, 03 Oct 2020 23:04:33 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id d1sm2325443lfq.225.2020.10.03.23.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 23:04:32 -0700 (PDT)
Received: (nullmailer pid 8963 invoked by uid 1000);
        Sun, 04 Oct 2020 06:09:36 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Soumyajit Deb <debsoumyajit100@gmail.com>,
        R Veera Kumar <vkor@vkten.in>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Andre Pinto <andrealmeidap1996@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unnecessary type casts (struct wlan_bssid_ex *)
Date:   Sun,  4 Oct 2020 09:09:22 +0300
Message-Id: <20201004060921.8908-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce line length, simplify refactoring.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c       | 10 +++++-----
 drivers/staging/rtl8188eu/core/rtw_cmd.c      |  4 ++--
 drivers/staging/rtl8188eu/core/rtw_mlme.c     |  2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 20 +++++++++----------
 .../staging/rtl8188eu/core/rtw_wlan_util.c    |  4 ++--
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 41535441f82c..2078d87055bf 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -422,7 +422,7 @@ static void update_bmc_sta(struct adapter *padapter)
 	int i, supportRateNum = 0;
 	unsigned int tx_ra_bitmap = 0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct wlan_bssid_ex *pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
+	struct wlan_bssid_ex *pcur_network = &pmlmepriv->cur_network.network;
 	struct sta_info *psta = rtw_get_bcmc_stainfo(padapter);
 
 	if (psta) {
@@ -599,7 +599,7 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	struct registry_priv	 *pregpriv = &padapter->registrypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
+	struct wlan_bssid_ex *pnetwork = &pmlmepriv->cur_network.network;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
@@ -711,7 +711,7 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	update_wireless_mode(padapter);
 
 	/* update capability after cur_wireless_mode updated */
-	update_capinfo(padapter, rtw_get_capability((struct wlan_bssid_ex *)pnetwork));
+	update_capinfo(padapter, rtw_get_capability(pnetwork));
 
 	/* let pnetwork_mlmeext == pnetwork_mlme. */
 	memcpy(pnetwork_mlmeext, pnetwork, pnetwork->Length);
@@ -745,7 +745,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct wlan_bssid_ex *pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
+	struct wlan_bssid_ex *pbss_network = &pmlmepriv->cur_network.network;
 	u8 *ie = pbss_network->ies;
 
 	/* SSID */
@@ -982,7 +982,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		HT_info_handler(padapter, (struct ndis_802_11_var_ie *)pHT_info_ie);
 	}
 
-	pbss_network->Length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pbss_network);
+	pbss_network->Length = get_wlan_bssid_ex_sz(pbss_network);
 
 	/* issue beacon to start bss network */
 	start_bss_network(padapter, (u8 *)pbss_network);
diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index a97d50081071..5c300865eeb3 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -330,7 +330,7 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 	INIT_LIST_HEAD(&pcmd->list);
 	pcmd->cmdcode = _CreateBss_CMD_;
 	pcmd->parmbuf = (unsigned char *)pdev_network;
-	pcmd->cmdsz = get_wlan_bssid_ex_sz((struct wlan_bssid_ex *)pdev_network);
+	pcmd->cmdsz = get_wlan_bssid_ex_sz(pdev_network);
 	pcmd->rsp = NULL;
 	pcmd->rspsz = 0;
 	pdev_network->Length = pcmd->cmdsz;
@@ -387,7 +387,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 		}
 	}
 
-	psecnetwork = (struct wlan_bssid_ex *)&psecuritypriv->sec_bss;
+	psecnetwork = &psecuritypriv->sec_bss;
 	if (!psecnetwork) {
 		kfree(pcmd);
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 14be5a703615..9d12f92994b3 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1815,7 +1815,7 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 
 	sz = rtw_generate_ie(pregistrypriv);
 	pdev_network->ie_length = sz;
-	pdev_network->Length = get_wlan_bssid_ex_sz((struct wlan_bssid_ex  *)pdev_network);
+	pdev_network->Length = get_wlan_bssid_ex_sz(pdev_network);
 
 	/* notes: translate ie_length & Length after assign the Length to cmdsz in createbss_cmd(); */
 	/* pdev_network->ie_length = cpu_to_le32(sz); */
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 5ca8a2b158d7..b3eddcb83cd0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -1771,7 +1771,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 			plist = plist->next;
 
-			pbss_network = (struct wlan_bssid_ex *)&pnetwork->network;
+			pbss_network = &pnetwork->network;
 
 			p = rtw_get_ie(pbss_network->ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->ie_length - _FIXED_IE_LENGTH_);
 			if (!p || len == 0) { /* non-HT */
@@ -2131,7 +2131,7 @@ static u8 collect_bss_info(struct adapter *padapter,
 	bssid->Configuration.BeaconPeriod =
 		get_unaligned_le16(rtw_get_beacon_interval_from_ie(bssid->ies));
 
-	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
+	val16 = rtw_get_capability(bssid);
 
 	if (val16 & BIT(0)) {
 		bssid->InfrastructureMode = Ndis802_11Infrastructure;
@@ -2177,7 +2177,7 @@ static void start_create_ibss(struct adapter *padapter)
 	u8 join_type;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
 	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
 	pmlmeinfo->bcn_interval = get_beacon_interval(pnetwork);
@@ -2186,7 +2186,7 @@ static void start_create_ibss(struct adapter *padapter)
 	update_wireless_mode(padapter);
 
 	/* update capability */
-	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
+	caps = rtw_get_capability(pnetwork);
 	update_capinfo(padapter, caps);
 	if (caps & cap_IBSS) {/* adhoc master */
 		val8 = 0xcf;
@@ -2228,7 +2228,7 @@ static void start_clnt_join(struct adapter *padapter)
 	u8 val8;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	int beacon_timeout;
 
 	pmlmeext->cur_channel = (u8)pnetwork->Configuration.DSConfig;
@@ -2238,7 +2238,7 @@ static void start_clnt_join(struct adapter *padapter)
 	update_wireless_mode(padapter);
 
 	/* update capability */
-	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
+	caps = rtw_get_capability(pnetwork);
 	update_capinfo(padapter, caps);
 	if (caps & cap_ESS) {
 		Set_MSR(padapter, WIFI_FW_STATION_STATE);
@@ -4193,7 +4193,7 @@ void report_survey_event(struct adapter *padapter,
 
 	psurvey_evt = (struct survey_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 
-	if (collect_bss_info(padapter, precv_frame, (struct wlan_bssid_ex *)&psurvey_evt->bss) == _FAIL) {
+	if (collect_bss_info(padapter, precv_frame, &psurvey_evt->bss) == _FAIL) {
 		kfree(pcmd_obj);
 		kfree(pevtcmd);
 		return;
@@ -4851,7 +4851,7 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	struct wlan_bssid_ex *pparm = (struct wlan_bssid_ex *)pbuf;
 
 	if (pparm->InfrastructureMode == Ndis802_11APMode) {
@@ -4913,7 +4913,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	struct registry_priv *pregpriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	struct wlan_bssid_ex *pparm = (struct wlan_bssid_ex *)pbuf;
 	u32 i;
 
@@ -5024,7 +5024,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	struct disconnect_parm *param = (struct disconnect_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	u8 val8;
 
 	if (is_client_associated_to_ap(padapter))
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 8e8f1721b1a2..26f128836a5e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -906,7 +906,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	/* check encryption info */
-	val16 = rtw_get_capability((struct wlan_bssid_ex *)bssid);
+	val16 = rtw_get_capability(bssid);
 
 	if (val16 & BIT(4))
 		bssid->Privacy = 1;
@@ -1017,7 +1017,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 
-	if (rtw_get_capability((struct wlan_bssid_ex *)cur_network) & WLAN_CAPABILITY_PRIVACY) {
+	if (rtw_get_capability(cur_network) & WLAN_CAPABILITY_PRIVACY) {
 		for (i = sizeof(struct ndis_802_11_fixed_ie); i < pmlmeinfo->network.ie_length;) {
 			pIE = (struct ndis_802_11_var_ie *)(pmlmeinfo->network.ies + i);
 
-- 
2.26.2

