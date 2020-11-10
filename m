Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448882ACE61
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgKJEKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 23:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbgKJEK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:10:28 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622FC0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 20:10:28 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id m9so12303633iox.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 20:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pO6HhvgMe3V0J4Q/nkktwPgnvrtVdBtv4MCewO/AMUA=;
        b=JLCDilcsaYPPmqefoU9nvexqyFiUcB9f/A3psey532ImQSDKUCQ3F9D4TqDqxamES1
         j/3c3q9eVnk0GLehC76Zd15dyNWwJtMhZQOKGWREEb6sfBdoe30vhStwJgnbtFMf0K9I
         tThaMe57ezk0k5IDirsWKkJA9MN326gbJwRMMeH+hU2VUgdVfRcIF5yWcJDZJdXlv1Jg
         aROKG2nb+Rw4dKcfLe9avE0AWL23WqigOiAXAs2JvQSrjx3kGzKgHSqsQK/jPqv5Hzj6
         jh3pndvY2phtSpMrxUlOjNxITgroMdYqIDyURT3xkq3xrrry9QC4eSCL331xjrP73zDf
         36Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pO6HhvgMe3V0J4Q/nkktwPgnvrtVdBtv4MCewO/AMUA=;
        b=kF7CguneCpRDMI1jcyPtVIOeRkG4XR7HQAWG13bZk8rCh/WXdf/4zIYu0zFd5YjX8L
         tncO/xb52arbEcN7xMWciyx18EgBMHZOKqH+H/tSrs3hL5lHLuurqqfVe3CUnWmKioeX
         x1t7kYEOxpMbw5ex4yJSTfm5wEOLMdQiSbRUGIJePVpkng98pkV8JEwSh8ZZqzjqQRPa
         +88undHF2Qv3BaHdvDlkOWYi4s8y7t3Hr3rsQyuMg8+oXTYytTzByIoJSD8UxLzeYtOX
         B1Z94XKdkLSgtC2sx+q+STuiWMpTOEEYOkteiTOXZ6r3FWftDAedF2Hjb4eM+MZhgbJ3
         UpXg==
X-Gm-Message-State: AOAM532AnRe4DLOkafd6F704hGglYqk2/H/Gkvn8pq5Jp6F5gE6Dr9XR
        I8Yp8Avi1acjAZplGVA1kRcAdY3SddY=
X-Google-Smtp-Source: ABdhPJzDgzYeS9jmWBUn4ju4koS/CU+owiehG5FeT5J71k/A/z/aQYbYdYSiWVSVc/Lju/38X8Dmnw==
X-Received: by 2002:a5d:9ec1:: with SMTP id a1mr4080995ioe.133.1604981428030;
        Mon, 09 Nov 2020 20:10:28 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id e21sm6658842ioc.0.2020.11.09.20.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 20:10:27 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 08/10] staging: rtl8723bs: clean up logical continuations
Date:   Mon,  9 Nov 2020 22:10:06 -0600
Message-Id: <20201110041008.15847-8-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110041008.15847-1-ross.schm.dev@gmail.com>
References: <20201110041008.15847-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move operators to fix coding style issues and clear checkpatch checks.

CHECK: Logical continuations should be on the previous line

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 41 +++++++------------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 27 ++++++------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  6 +--
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  6 +--
 4 files changed, 34 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 90e222a9c93b..5b05d1eaa328 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -451,9 +451,8 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 			hal_btcoex_LpsNotify(padapter, ps_mode);
 		}
 	} else {
-		if ((PS_RDY_CHECK(padapter) && check_fwstate(&padapter->mlmepriv, WIFI_ASOC_STATE))
-			|| ((hal_btcoex_IsBtControlLps(padapter))
-				&& (hal_btcoex_IsLpsOn(padapter)))
+		if ((PS_RDY_CHECK(padapter) && check_fwstate(&padapter->mlmepriv, WIFI_ASOC_STATE)) ||
+		    ((hal_btcoex_IsBtControlLps(padapter)) && (hal_btcoex_IsLpsOn(padapter)))
 			) {
 			u8 pslv;
 
@@ -472,8 +471,8 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 			if (pwrpriv->alives == 0)
 				pslv = PS_STATE_S0;
 
-			if (!(hal_btcoex_IsBtDisabled(padapter))
-				&& (hal_btcoex_IsBtControlLps(padapter))) {
+			if (!(hal_btcoex_IsBtDisabled(padapter)) &&
+			    (hal_btcoex_IsBtControlLps(padapter))) {
 				u8 val8;
 
 				val8 = hal_btcoex_LpsVal(padapter);
@@ -688,9 +687,9 @@ void LPS_Leave_check(struct adapter *padapter)
 	while (1) {
 		mutex_lock(&pwrpriv->lock);
 
-		if (padapter->bSurpriseRemoved
-			|| !(padapter->hw_init_completed)
-			|| (pwrpriv->pwr_mode == PS_MODE_ACTIVE))
+		if (padapter->bSurpriseRemoved ||
+		    !(padapter->hw_init_completed) ||
+		    (pwrpriv->pwr_mode == PS_MODE_ACTIVE))
 			bReady = true;
 
 		mutex_unlock(&pwrpriv->lock);
@@ -897,8 +896,7 @@ void rtw_unregister_task_alive(struct adapter *padapter, u32 task)
 	pwrctrl = adapter_to_pwrctl(padapter);
 	pslv = PS_STATE_S0;
 
-	if (!(hal_btcoex_IsBtDisabled(padapter))
-	    && hal_btcoex_IsBtControlLps(padapter)) {
+	if (!(hal_btcoex_IsBtDisabled(padapter)) && hal_btcoex_IsBtControlLps(padapter)) {
 		u8 val8;
 
 		val8 = hal_btcoex_LpsVal(padapter);
@@ -910,8 +908,7 @@ void rtw_unregister_task_alive(struct adapter *padapter, u32 task)
 
 	unregister_task_alive(pwrctrl, task);
 
-	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE)
-	    && pwrctrl->bFwCurrentInPSMode) {
+	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
 		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
 				 ("%s: cpwm = 0x%02x alives = 0x%08x\n",
 				  __func__, pwrctrl->cpwm, pwrctrl->alives));
@@ -1038,8 +1035,7 @@ void rtw_unregister_tx_alive(struct adapter *padapter)
 	pwrctrl = adapter_to_pwrctl(padapter);
 	pslv = PS_STATE_S0;
 
-	if (!(hal_btcoex_IsBtDisabled(padapter))
-		&& hal_btcoex_IsBtControlLps(padapter)) {
+	if (!(hal_btcoex_IsBtDisabled(padapter)) && hal_btcoex_IsBtControlLps(padapter)) {
 		u8 val8;
 
 		val8 = hal_btcoex_LpsVal(padapter);
@@ -1051,8 +1047,7 @@ void rtw_unregister_tx_alive(struct adapter *padapter)
 
 	unregister_task_alive(pwrctrl, XMIT_ALIVE);
 
-	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE)
-		&& pwrctrl->bFwCurrentInPSMode) {
+	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
 		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_notice_,
 				 ("%s: cpwm = 0x%02x alives = 0x%08x\n",
 				  __func__, pwrctrl->cpwm, pwrctrl->alives));
@@ -1080,8 +1075,7 @@ void rtw_unregister_cmd_alive(struct adapter *padapter)
 	pwrctrl = adapter_to_pwrctl(padapter);
 	pslv = PS_STATE_S0;
 
-	if (!(hal_btcoex_IsBtDisabled(padapter))
-	    && hal_btcoex_IsBtControlLps(padapter)) {
+	if (!(hal_btcoex_IsBtDisabled(padapter)) && hal_btcoex_IsBtControlLps(padapter)) {
 		u8 val8;
 
 		val8 = hal_btcoex_LpsVal(padapter);
@@ -1093,8 +1087,7 @@ void rtw_unregister_cmd_alive(struct adapter *padapter)
 
 	unregister_task_alive(pwrctrl, CMD_ALIVE);
 
-	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE)
-	    && pwrctrl->bFwCurrentInPSMode) {
+	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
 		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_info_,
 				 ("%s: cpwm = 0x%02x alives = 0x%08x\n",
 				  __func__, pwrctrl->cpwm, pwrctrl->alives));
@@ -1226,8 +1219,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 
 	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
 		DBG_871X("%s wait bInSuspend...\n", __func__);
-		while (pwrpriv->bInSuspend
-			&& jiffies_to_msecs(jiffies - start) <= 3000
+		while (pwrpriv->bInSuspend && jiffies_to_msecs(jiffies - start) <= 3000
 		) {
 			mdelay(10);
 		}
@@ -1267,10 +1259,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	}
 
 	/* TODO: the following checking need to be merged... */
-	if (padapter->bDriverStopped
-		|| !padapter->bup
-		|| !padapter->hw_init_completed
-	) {
+	if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
 		DBG_8192C("%s: bDriverStopped =%d, bup =%d, hw_init_completed =%u\n"
 			, caller
 			, padapter->bDriverStopped
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index e1528b51c17e..43e67e48d2df 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -499,9 +499,8 @@ union recv_frame *decryptor(struct adapter *padapter, union recv_frame *precv_fr
 		default:
 				break;
 		}
-	} else if (prxattrib->bdecrypted == 1
-		&& prxattrib->encrypt > 0
-		&& (psecuritypriv->busetkipkey == 1 || prxattrib->encrypt != _TKIP_)
+	} else if (prxattrib->bdecrypted == 1 && prxattrib->encrypt > 0 &&
+		   (psecuritypriv->busetkipkey == 1 || prxattrib->encrypt != _TKIP_)
 		) {
 		DBG_COUNTER(padapter->rx_logs.core_rx_post_decrypt_hw);
 
@@ -874,9 +873,9 @@ sint ap2sta_data_frame(struct adapter *adapter, union recv_frame *precv_frame,
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
 	sint bmcast = IS_MCAST(pattrib->dst);
 
-	if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true)
-		&& (check_fwstate(pmlmepriv, _FW_LINKED) == true
-			|| check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true)
+	if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) &&
+	    (check_fwstate(pmlmepriv, _FW_LINKED) == true ||
+	     check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true)
 		) {
 
 		/*  filter packets that SA is myself or multicast or broadcast */
@@ -1226,8 +1225,8 @@ sint validate_recv_mgnt_frame(struct adapter *padapter, union recv_frame *precv_
 			else if (GetFrameSubType(precv_frame->u.hdr.rx_data) == WIFI_PROBERSP) {
 				if (!memcmp(padapter->eeprompriv.mac_addr, GetAddr1Ptr(precv_frame->u.hdr.rx_data), ETH_ALEN))
 					psta->sta_stats.rx_probersp_pkts++;
-				else if (is_broadcast_mac_addr(GetAddr1Ptr(precv_frame->u.hdr.rx_data))
-					|| is_multicast_mac_addr(GetAddr1Ptr(precv_frame->u.hdr.rx_data)))
+				else if (is_broadcast_mac_addr(GetAddr1Ptr(precv_frame->u.hdr.rx_data)) ||
+					 is_multicast_mac_addr(GetAddr1Ptr(precv_frame->u.hdr.rx_data)))
 					psta->sta_stats.rx_probersp_bm_pkts++;
 				else
 					psta->sta_stats.rx_probersp_uo_pkts++;
@@ -1388,8 +1387,8 @@ static sint validate_80211w_mgmt(struct adapter *adapter, union recv_frame *prec
 	subtype = GetFrameSubType(ptr); /* bit(7)~bit(2) */
 
 	/* only support station mode */
-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) && check_fwstate(pmlmepriv, _FW_LINKED)
-		&& adapter->securitypriv.binstallBIPkey == true) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) && check_fwstate(pmlmepriv, _FW_LINKED) &&
+	    adapter->securitypriv.binstallBIPkey == true) {
 		/* unicast management frame decrypt */
 		if (pattrib->privacy && !(IS_MCAST(GetAddr1Ptr(ptr))) &&
 			(subtype == WIFI_DEAUTH || subtype == WIFI_DISASSOC || subtype == WIFI_ACTION)) {
@@ -2601,15 +2600,15 @@ static void rtw_signal_stat_timer_hdl(struct timer_list *t)
 		}
 
 		if (num_signal_strength == 0) {
-			if (rtw_get_on_cur_ch_time(adapter) == 0
-				|| jiffies_to_msecs(jiffies - rtw_get_on_cur_ch_time(adapter)) < 2 * adapter->mlmeextpriv.mlmext_info.bcn_interval
+			if (rtw_get_on_cur_ch_time(adapter) == 0 ||
+			    jiffies_to_msecs(jiffies - rtw_get_on_cur_ch_time(adapter)) < 2 * adapter->mlmeextpriv.mlmext_info.bcn_interval
 			) {
 				goto set_timer;
 			}
 		}
 
-		if (check_fwstate(&adapter->mlmepriv, _FW_UNDER_SURVEY) == true
-			|| check_fwstate(&adapter->mlmepriv, _FW_LINKED) == false
+		if (check_fwstate(&adapter->mlmepriv, _FW_UNDER_SURVEY) == true ||
+		    check_fwstate(&adapter->mlmepriv, _FW_LINKED) == false
 		) {
 			goto set_timer;
 		}
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a6176e86f370..45e5f06f0004 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1584,9 +1584,9 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 			if ((!memcmp(pIE->data, ARTHEROS_OUI1, 3)) || (!memcmp(pIE->data, ARTHEROS_OUI2, 3))) {
 				DBG_871X("link to Artheros AP\n");
 				return HT_IOT_PEER_ATHEROS;
-			} else if ((!memcmp(pIE->data, BROADCOM_OUI1, 3))
-						|| (!memcmp(pIE->data, BROADCOM_OUI2, 3))
-						|| (!memcmp(pIE->data, BROADCOM_OUI3, 3))) {
+			} else if ((!memcmp(pIE->data, BROADCOM_OUI1, 3)) ||
+				   (!memcmp(pIE->data, BROADCOM_OUI2, 3)) ||
+				   (!memcmp(pIE->data, BROADCOM_OUI3, 3))) {
 				DBG_871X("link to Broadcom AP\n");
 				return HT_IOT_PEER_BROADCOM;
 			} else if (!memcmp(pIE->data, MARVELL_OUI, 3)) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index b69998c5c07e..6582f2d7c383 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -2173,9 +2173,9 @@ inline bool xmitframe_hiq_filter(struct xmit_frame *xmitframe)
 	if (registry->hiq_filter == RTW_HIQ_FILTER_ALLOW_SPECIAL) {
 		struct pkt_attrib *attrib = &xmitframe->attrib;
 
-		if (attrib->ether_type == 0x0806
-			|| attrib->ether_type == 0x888e
-			|| attrib->dhcp_pkt
+		if (attrib->ether_type == 0x0806 ||
+		    attrib->ether_type == 0x888e ||
+		    attrib->dhcp_pkt
 		) {
 			DBG_871X(FUNC_ADPT_FMT" ether_type:0x%04x%s\n", FUNC_ADPT_ARG(xmitframe->padapter)
 				, attrib->ether_type, attrib->dhcp_pkt?" DHCP":"");
-- 
2.25.1

