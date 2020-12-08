Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79F2D21CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgLHEJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgLHEJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:06 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55354C0611CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:54 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id t9so10031420ilf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2qDl9bmsnlpud25xHCJIjGIHhs2jrlzxUTwUHc0aqI=;
        b=HMknenx5Yar6F1t3hONTq4SIcRBH35p/RkK5yY+fwfGC4MyxEmCrpXHznNjQX1kHdZ
         bkpesMVFskHva/6VaedjqKchqew6cGWNHbmNRc2T/u5SOmnAnnfEo+/CI8MBwXKXKtS/
         U7Iy6Asxlw6fKh7wTm82QCdlhCi1/i73dpXWL7pjYxbYaaK5r1E30J7AsfS3dV0KIv5v
         /G1bswIfriuF69cB/udr7Rg+dIcXTwFl5orBElKNrX+8tvyE+WmS+niBFV+Fv99Bg7jF
         +NZ0lbGzSxw5QXWcJ3tadmiQGrMefiloulG6dzpqctHVk/KkcFZMJPIQgXfJ+R64DkYc
         dS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2qDl9bmsnlpud25xHCJIjGIHhs2jrlzxUTwUHc0aqI=;
        b=H2WlPVY150MwX7izDNi9dwoqKA/9V+I2rjOfC+GGOZuaIGY1LfBoBRG01RejOXo9sH
         IBZmIHBcWeEou2By73IfhOwkT6ps6cxMbnNnBRIDDo0r5x3+lAiRN2fOecSt5vWqwIQH
         CGn2piefpdBDLyA7GoAk4ZRWXZMM6ZgTSVb+G9UL+nCf8rFmGRrc7cyKFtSeBmCYe9F4
         mE2XZuYUoA06Vwo4nllUIcJ79AcegfnqjJi6Z5Z8QbYtp/K7KBOzFcKrPPGfK0EYxhog
         ssGjZunTX3ziGOVVG2QbghZLzo1UjjSGIN/02STRFbHefvcTlyJuKvXSvYuV5RptYsP3
         Ufug==
X-Gm-Message-State: AOAM533BcBdoqfMdjNVaNwgPxQWGtUpDeAAsH+zj4fE+jbiLo0EbzNmG
        Y9DacIpXIDPVuznun8OfjKfyPXptEKc=
X-Google-Smtp-Source: ABdhPJxS2vu0iBpftzjUtjhCb/FxWAtguxXh+lBbJiEczkGrjESkFMyLDcJDnOLC/ms+UmQSJsti7w==
X-Received: by 2002:a05:6e02:926:: with SMTP id o6mr24113558ilt.65.1607400473775;
        Mon, 07 Dec 2020 20:07:53 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:53 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 14/21] staging: rtl8723bs: replace _EXT_SUPPORTEDRATES_IE_
Date:   Mon,  7 Dec 2020 22:07:26 -0600
Message-Id: <20201208040733.379197-15-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _EXT_SUPPORTEDRATES_IE_ macro with kernel provided
WLAN_EID_EXT_SUPP_RATES from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c        |  2 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 18 +++++++++---------
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c   |  4 ++--
 drivers/staging/rtl8723bs/include/wifi.h       |  1 -
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 5e93a85cb6ce..b6f944b37b08 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1043,7 +1043,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/* get ext_supported rates */
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
-		_EXT_SUPPORTEDRATES_IE_,
+		WLAN_EID_EXT_SUPP_RATES,
 		&ie_len,
 		pbss_network->IELength - _BEACON_IE_OFFSET_
 	);
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index b899f511ff9f..28d5892d8bda 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -344,7 +344,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 
 	if (rateLen > 8) {
 		ie = rtw_set_ie(ie, WLAN_EID_SUPP_RATES, 8, pdev_network->SupportedRates, &sz);
-		/* ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz); */
+		/* ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz); */
 	} else {
 		ie = rtw_set_ie(ie, WLAN_EID_SUPP_RATES, rateLen, pdev_network->SupportedRates, &sz);
 	}
@@ -357,7 +357,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	ie = rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->Configuration.ATIMWindow), &sz);
 
 	if (rateLen > 8) {
-		ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz);
+		ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz);
 	}
 
 	/* HT Cap. */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5d56fbf0c1fe..e9b14fc8b10f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -783,7 +783,7 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 	u8 *p = NULL;
 	u32 ielen = 0;
 
-	p = rtw_get_ie(pframe + sizeof(struct ieee80211_hdr_3addr) + _BEACON_IE_OFFSET_, _EXT_SUPPORTEDRATES_IE_, &ielen, precv_frame->u.hdr.len - sizeof(struct ieee80211_hdr_3addr) - _BEACON_IE_OFFSET_);
+	p = rtw_get_ie(pframe + sizeof(struct ieee80211_hdr_3addr) + _BEACON_IE_OFFSET_, WLAN_EID_EXT_SUPP_RATES, &ielen, precv_frame->u.hdr.len - sizeof(struct ieee80211_hdr_3addr) - _BEACON_IE_OFFSET_);
 	if (p && ielen > 0) {
 		if ((*(p + 1 + ielen) == 0x2D) && (*(p + 2 + ielen) != 0x2D)) {
 			/* Invalid value 0x2D is detected in Extended Supported Rates (ESR) IE. Try to fix the IE length to avoid failed Beacon parsing. */
@@ -1284,7 +1284,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		memcpy(supportRate, p+2, ie_len);
 		supportRateNum = ie_len;
 
-		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _EXT_SUPPORTEDRATES_IE_, &ie_len,
+		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, WLAN_EID_EXT_SUPP_RATES, &ie_len,
 				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 		if (p !=  NULL) {
 
@@ -2561,7 +2561,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	/*  EXTERNDED SUPPORTED RATE */
 	if (rate_len > 8) {
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->SupportedRates + 8), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->SupportedRates + 8), &pattrib->pktlen);
 	}
 
 
@@ -2764,7 +2764,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 		/*  EXTERNDED SUPPORTED RATE */
 		if (rate_len > 8) {
-			pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->SupportedRates + 8), &pattrib->pktlen);
+			pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->SupportedRates + 8), &pattrib->pktlen);
 		}
 
 
@@ -2878,7 +2878,7 @@ static int _issue_probereq(struct adapter *padapter,
 
 	if (bssrate_len > 8) {
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, 8, bssrate, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
 	} else {
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, bssrate_len, bssrate, &(pattrib->pktlen));
 	}
@@ -3156,7 +3156,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, pstat->bssratelen, pstat->bssrateset, &(pattrib->pktlen));
 	} else {
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, 8, pstat->bssrateset, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (pstat->bssratelen-8), pstat->bssrateset+8, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (pstat->bssratelen-8), pstat->bssrateset+8, &(pattrib->pktlen));
 	}
 
 	if ((pstat->flags & WLAN_STA_HT) && (pmlmepriv->htpriv.ht_option)) {
@@ -3341,7 +3341,7 @@ void issue_assocreq(struct adapter *padapter)
 
 	if (bssrate_len > 8) {
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, 8, bssrate, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
 	} else
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, bssrate_len, bssrate, &(pattrib->pktlen));
 
@@ -4494,7 +4494,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		i = len;
 	}
 
-	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_EXT_SUPP_RATES, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > (NDIS_802_11_LENGTH_RATES_EX-i)) {
 			DBG_871X("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
@@ -5986,7 +5986,7 @@ static int rtw_auto_ap_start_beacon(struct adapter *adapter)
 
 	/* ext supported rates */
 	if (rateLen > 8) {
-		ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (supportRate + 8), &sz);
+		ie = rtw_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rateLen - 8), (supportRate + 8), &sz);
 	}
 
 	DBG_871X("%s, start auto ap beacon sz =%d\n", __func__, sz);
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index e8e91e24c04d..975f2830e29e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1793,7 +1793,7 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
 	memcpy(pmlmeinfo->FW_sta_info[cam_idx].SupportedRates, pIE->data, ie_len);
 	supportRateNum = ie_len;
 
-	pIE = (struct ndis_80211_var_ie *)rtw_get_ie(pvar_ie, _EXT_SUPPORTEDRATES_IE_, &ie_len, var_ie_len);
+	pIE = (struct ndis_80211_var_ie *)rtw_get_ie(pvar_ie, WLAN_EID_EXT_SUPP_RATES, &ie_len, var_ie_len);
 	if (pIE && (ie_len <= sizeof(pmlmeinfo->FW_sta_info[cam_idx].SupportedRates) - supportRateNum))
 		memcpy((pmlmeinfo->FW_sta_info[cam_idx].SupportedRates + supportRateNum), pIE->data, ie_len);
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index f6073ecef2e2..86f31d98349a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -198,7 +198,7 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 
 	/*  EXTERNDED SUPPORTED RATE */
 	if (rate_len > 8)
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->SupportedRates + 8), &pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8), (cur_network->SupportedRates + 8), &pktlen);
 
 
 	/* todo:HT for adhoc */
@@ -701,7 +701,7 @@ static void ConstructProbeReq(struct adapter *padapter, u8 *pframe, u32 *pLength
 
 	if (bssrate_len > 8) {
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, 8, bssrate, &pktlen);
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_EXT_SUPP_RATES, (bssrate_len - 8), (bssrate + 8), &pktlen);
 	} else
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, bssrate_len, bssrate, &pktlen);
 
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index ff8865d1d846..e221d4574f32 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -389,7 +389,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _SUPPORTED_CH_IE_		36
 #define _CH_SWTICH_ANNOUNCE_	37	/* Secondary Channel Offset */
-#define _EXT_SUPPORTEDRATES_IE_	50
 
 #define _FTIE_						55
 #define _TIMEOUT_ITVL_IE_			56
-- 
2.25.1

