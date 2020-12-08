Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2650A2D21C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgLHEIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLHEIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:08:22 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFE0C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:42 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id g1so14363343ilk.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugAwhz6W8+KF2bxtnuIZAtS6zbuaPVOvGIK6GBD/fKM=;
        b=DrlhSvApor9uM97cD6iRnv3+xaHVZ95Pmo9QWksj0HF4CYVr0uHIo2mKbSc62lp4px
         R92NFlpQ8q1Kp8mt1/1+Ew5dIY1LvJS81jLqTUyz+VgcUlsPjM3Hpn/L8oLTrSMX/dgX
         cn3AAcmzdaCqYiXhMWi41iOtw1Yv2WC+3dbTQJh2Nxk/VusVXbaW1nEokN8Kqh/9c/AK
         IXq/EpY2Zf+3m/wGTa2fxufLU1Z493jvbms7OdS2RE+P+nt4UASHlCer4urmYXfd5BYi
         xA9OJJauabe82dLr/wmEHCEi5227aBqmbROeBss0qz87+SHkW+H5QePqgECmZwRvflzw
         3V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugAwhz6W8+KF2bxtnuIZAtS6zbuaPVOvGIK6GBD/fKM=;
        b=oGIa8/jCJ1KSH9u7XEJQ3qM1hFzYsFqIQuO/vyhh+ThhTNCZfkNseE74Qu5sOWtnJ1
         DbZKRh5Yk7nictMxW4HbzkRFMuXPJi5Ja9FjQjN2CLnB/HhVBcea8EQrncx+G4ftYfW9
         sPDoDI/onHhmBiDnyHtBiwuphPTN77/CPoFKtqFTin48L3g0o89tugzenOFvxMq29eu+
         ALOwhj8ny8fzeyAmqYS292xErz1/nQUjMGKaxmcYOw+hJ98b2iifB18xUvvoZnNiE6SO
         8/HLwxN68fo+4qJIErN6y3B8gntTO12rtCwfDB+KVhDTYXmTgAueu/5Hwane41agaB3L
         Ho4A==
X-Gm-Message-State: AOAM5310MZxKlvRkzfuEZG46BXEDqt66RbOHeyR5i5RGYLaJO3eothim
        LI/Z6XDipnrmQKW+IBvi4I8=
X-Google-Smtp-Source: ABdhPJxSRYXyi7FNxJP6qytezFuH70G3dHIfxi5GvWbmfZZle7FVj2L0wSoTcw3cJ3DHZSYQY1MgYg==
X-Received: by 2002:a92:c5a7:: with SMTP id r7mr25098915ilt.219.1607400461750;
        Mon, 07 Dec 2020 20:07:41 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:40 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 03/21] staging: rtl8723bs: use WLAN_EID_RSN
Date:   Mon,  7 Dec 2020 22:07:15 -0600
Message-Id: <20201208040733.379197-4-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _WPA2_IE_ID_, EID_WPA2, and _RSN_IE_2_ with kernel provided
WLAN_EID_RSN from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c          | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c   | 6 +++---
 drivers/staging/rtl8723bs/core/rtw_mlme.c        | 8 ++++----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 2 +-
 drivers/staging/rtl8723bs/include/rtw_security.h | 2 --
 drivers/staging/rtl8723bs/include/wifi.h         | 1 -
 7 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index c8953b442734..7cab9889140e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1080,7 +1080,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psecuritypriv->wpa2_pairwise_cipher = _NO_PRIVACY_;
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
-		_RSN_IE_2_,
+		WLAN_EID_RSN,
 		&ie_len,
 		(pbss_network->IELength - _BEACON_IE_OFFSET_)
 	);
@@ -1780,7 +1780,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 		break;
 
-	case _RSN_IE_2_:
+	case WLAN_EID_RSN:
 
 		update_bcn_rsn_ie(padapter);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 86a5114d1241..4ab34d71b09b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -424,7 +424,7 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 
 unsigned char *rtw_get_wpa2_ie(unsigned char *pie, int *rsn_ie_len, int limit)
 {
-	return rtw_get_ie(pie, _WPA2_IE_ID_, rsn_ie_len, limit);
+	return rtw_get_ie(pie, WLAN_EID_RSN, rsn_ie_len, limit);
 }
 
 int rtw_get_wpa_cipher_suite(u8 *s)
@@ -544,7 +544,7 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 		return _FAIL;
 	}
 
-	if ((*rsn_ie != _WPA2_IE_ID_) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2))) {
+	if ((*rsn_ie != WLAN_EID_RSN) || (*(rsn_ie+1) != (u8)(rsn_ie_len - 2))) {
 		return _FAIL;
 	}
 
@@ -683,7 +683,7 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 				*wpa_len = in_ie[cnt+1]+2;
 				cnt += in_ie[cnt+1]+2;  /* get next */
 		} else {
-			if (authmode == _WPA2_IE_ID_) {
+			if (authmode == WLAN_EID_RSN) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("\n get_rsn_ie: sec_idx =%d in_ie[cnt+1]+2 =%d\n", sec_idx, in_ie[cnt+1]+2));
 
 				if (rsn_ie) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 50129a3e67e0..1d4e565a314b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -736,7 +736,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	    bselected = false;
 
 		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
-			p = rtw_get_ie(pnetwork->network.IEs + _BEACON_IE_OFFSET_, _RSN_IE_2_, &ie_len, (pnetwork->network.IELength - _BEACON_IE_OFFSET_));
+			p = rtw_get_ie(pnetwork->network.IEs + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.IELength - _BEACON_IE_OFFSET_));
 			if (p && ie_len > 0)
 				bselected = true;
 			else
@@ -2361,13 +2361,13 @@ sint rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in
 	if ((ndisauthmode == Ndis802_11AuthModeWPA) || (ndisauthmode == Ndis802_11AuthModeWPAPSK))
 			authmode = WLAN_EID_VENDOR_SPECIFIC;
 	if ((ndisauthmode == Ndis802_11AuthModeWPA2) || (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
-			authmode = _WPA2_IE_ID_;
+			authmode = WLAN_EID_RSN;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
 		memcpy(out_ie+ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
 
 		ielength += psecuritypriv->wps_ie_len;
-	} else if ((authmode == WLAN_EID_VENDOR_SPECIFIC) || (authmode == _WPA2_IE_ID_)) {
+	} else if ((authmode == WLAN_EID_VENDOR_SPECIFIC) || (authmode == WLAN_EID_RSN)) {
 		/* copy RSN or SSN */
 		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1]+2);
 		/* debug for CONFIG_IEEE80211W
@@ -2386,7 +2386,7 @@ sint rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in
 	if (iEntry < 0) {
 		return ielength;
 	} else {
-		if (authmode == _WPA2_IE_ID_)
+		if (authmode == WLAN_EID_RSN)
 			ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
 	}
 	return ielength;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 11e176f29b4b..1fa0be4dbfd5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3369,8 +3369,8 @@ void issue_assocreq(struct adapter *padapter)
 			}
 			break;
 
-		case EID_WPA2:
-			pframe = rtw_set_ie(pframe, EID_WPA2, pIE->Length, pIE->data, &(pattrib->pktlen));
+		case WLAN_EID_RSN:
+			pframe = rtw_set_ie(pframe, WLAN_EID_RSN, pIE->Length, pIE->data, &(pattrib->pktlen));
 			break;
 		case WLAN_EID_HT_CAPABILITY:
 			if (padapter->mlmepriv.htpriv.ht_option) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 92c4ef01b070..c0e435ba2730 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1511,7 +1511,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 
 				break;
 
-			case _RSN_IE_2_:
+			case WLAN_EID_RSN:
 				if (!memcmp((pIE->data + 8), RSN_TKIP_CIPHER, 4))
 					return true;
 				break;
diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 67ba62b54b10..85ffd4ec4ce5 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -21,8 +21,6 @@
 
 const char *security_type_str(u8 value);
 
-#define _WPA2_IE_ID_	0x30
-
 #define SHA256_MAC_LEN 32
 #define AES_BLOCK_SIZE 16
 #define AES_PRIV_SIZE (4 * 44)
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index f7d8d0ec827c..5a8c594008aa 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -396,7 +396,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define _CHLGETXT_IE_			16
 #define _SUPPORTED_CH_IE_		36
 #define _CH_SWTICH_ANNOUNCE_	37	/* Secondary Channel Offset */
-#define _RSN_IE_2_				48
 #define _ERPINFO_IE_			42
 #define _EXT_SUPPORTEDRATES_IE_	50
 
-- 
2.25.1

