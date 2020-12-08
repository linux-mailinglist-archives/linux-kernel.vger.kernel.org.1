Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F6D2D21C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgLHEI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgLHEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:08:59 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB33C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:45 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id q137so15636729iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAC5ERXQQckuc4I3XFY1gCyzk7VTIIbEvzIIzwT3tVo=;
        b=uSwBjDYcUKa2ObyL8/jwFpEiX4PA+IhKomiro2oVpROq0UbPQt7g2ji59CgLJneUuX
         XhFgC8sfxsSAPdtHu72oUjtizKVaTFypA41D+hbEbGtbAztnMmgc77CbUSuP6CrxTDjU
         M6DRt6Ui0jcYRbPCVfnaJNJc9nwlAI2mw81+wSt/mfeSyDIDJCbaKQ7wZaIuW7JIw1Ag
         k0NXX3tVCLcJCnJSMiQhcFQxcaPPibsrFl7Mvu7DLgzgPhUMobQLwjhKu6/1pdtbOOnV
         EiSu5iKF1026F/a7OnXt+sHQW95+yU6T1s2C04izjA75n6MvTcFVB0tRQ6aQGAaOUXA1
         W0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAC5ERXQQckuc4I3XFY1gCyzk7VTIIbEvzIIzwT3tVo=;
        b=UHMT/TPDBvqSJKonMRh8zyFRTQ7nmrXDyJO2SbmhZbGLNOuyepMTKyX9CrfEIg6tW5
         FRhjepVkX6Cgj+Ifist8Mh+b1EmuIsK5KyxoTdS3h0dR5+gcZlohtXvCe6BnFOvXHcFq
         +xNOLgqCGCQ+5ecMcrIbuahl5EIKdmvO2p4fjJQ6fOYo6zDhTKxrXYLA3HiJUe16Xwqg
         /c5O+cKwaUoLH+sedBCONIE0d9QauYfJRPfUZ+scGorCq1xk7hA05n20y4EngotqSVRx
         mrHKvQITInD7NMVxbbWvP83KX+LVSyLgjz+1KXiIg6AbXnykGyW0OiS60qfrjM1/N808
         L6Dw==
X-Gm-Message-State: AOAM532W4IijdbNwXo+qrBLvF+RdArg/llyBAy/ogbpdwYuZ/cL7KpWn
        Fh2l1jgPeHuwDXI9KHDHl+Q=
X-Google-Smtp-Source: ABdhPJwT6HzjHFQev+6CiHGW6CP+QPakVECR/aEkovbS5XZBg46BWOPhLmqBWr7iAZ7pt06B270DAA==
X-Received: by 2002:a02:2e52:: with SMTP id u18mr24402524jae.29.1607400464975;
        Mon, 07 Dec 2020 20:07:44 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:44 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 06/21] staging: rtl8723bs: replace _SSID_IE_
Date:   Mon,  7 Dec 2020 22:07:18 -0600
Message-Id: <20201208040733.379197-7-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _SSID_IE_ macro with kernel provided WLAN_EID_SSID from
linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  4 ++--
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 20 +++++++++----------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  6 +++---
 drivers/staging/rtl8723bs/include/wifi.h      |  1 -
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index e44c01de3b10..aaa7edbebe2c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -100,7 +100,7 @@ static void update_BCNTIM(struct adapter *padapter)
 			/* get ssid_ie len */
 			p = rtw_get_ie(
 				pie + _BEACON_IE_OFFSET_,
-				_SSID_IE_,
+				WLAN_EID_SSID,
 				&tmp_len,
 				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
 			);
@@ -1004,7 +1004,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/* SSID */
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
-		_SSID_IE_,
+		WLAN_EID_SSID,
 		&ie_len,
 		(pbss_network->IELength - _BEACON_IE_OFFSET_)
 	);
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 182cc8c0b7d3..daaa826add35 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -326,7 +326,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	ie += 2;
 
 	/* SSID */
-	ie = rtw_set_ie(ie, _SSID_IE_, pdev_network->Ssid.SsidLength, pdev_network->Ssid.Ssid, &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_SSID, pdev_network->Ssid.SsidLength, pdev_network->Ssid.Ssid, &sz);
 
 	/* supported rates */
 	if (pregistrypriv->wireless_mode == WIRELESS_11ABGN) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index b829264b8aff..983fcaae6eca 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -728,7 +728,7 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 #endif /* CONFIG_AUTO_AP_MODE */
 
-	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _PROBEREQ_IE_OFFSET_, _SSID_IE_, (int *)&ielen,
+	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _PROBEREQ_IE_OFFSET_, WLAN_EID_SSID, (int *)&ielen,
 			len - WLAN_HDR_A3_LEN - _PROBEREQ_IE_OFFSET_);
 
 
@@ -1251,7 +1251,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 	/*  now we should check all the fields... */
 	/*  checking SSID */
-	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
+	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, WLAN_EID_SSID, &ie_len,
 		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 
 	if (!p || ie_len == 0) {
@@ -2536,7 +2536,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pattrib->pktlen += 2;
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
 
 	/*  supported rates... */
 	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
@@ -2692,7 +2692,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 			u8 buf[MAX_IE_SZ];
 			u8 *ies = pmgntframe->buf_addr+TXDESC_OFFSET+sizeof(struct ieee80211_hdr_3addr);
 
-			ssid_ie = rtw_get_ie(ies+_FIXED_IE_LENGTH_, _SSID_IE_, &ssid_ielen,
+			ssid_ie = rtw_get_ie(ies+_FIXED_IE_LENGTH_, WLAN_EID_SSID, &ssid_ielen,
 				(pframe-ies)-_FIXED_IE_LENGTH_);
 
 			ssid_ielen_diff = cur_network->Ssid.SsidLength - ssid_ielen;
@@ -2740,7 +2740,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		/* below for ad-hoc mode */
 
 		/*  SSID */
-		pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
 
 		/*  supported rates... */
 		rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
@@ -2870,9 +2870,9 @@ static int _issue_probereq(struct adapter *padapter,
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if (pssid)
-		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->SsidLength, pssid->Ssid, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, pssid->SsidLength, pssid->Ssid, &(pattrib->pktlen));
 	else
-		pframe = rtw_set_ie(pframe, _SSID_IE_, 0, NULL, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, 0, NULL, &(pattrib->pktlen));
 
 	get_rate_set(padapter, bssrate, &bssrate_len);
 
@@ -3280,7 +3280,7 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen += 2;
 
 	/* SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &(pattrib->pktlen));
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &(pattrib->pktlen));
 
 	/* supported rate & extended supported rate */
 
@@ -4464,7 +4464,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	bssid->PhyInfo.SignalStrength = precv_frame->u.hdr.attrib.phy_info.SignalStrength;/* in percentage */
 
 	/*  checking SSID */
-	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_SSID, &len, bssid->IELength - ie_offset);
 	if (p == NULL) {
 		DBG_871X("marc: cannot find SSID for survey event\n");
 		return _FAIL;
@@ -5959,7 +5959,7 @@ static int rtw_auto_ap_start_beacon(struct adapter *adapter)
 	ie += 2;
 
 	/* SSID */
-	ie = rtw_set_ie(ie, _SSID_IE_, ssid_len, ssid, &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_SSID, ssid_len, ssid, &sz);
 
 	/* supported rates */
 	wireless_mode = WIRELESS_11BG_24N;
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 94e4f82610ac..a8a743cffaa8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1341,7 +1341,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 
 	/* checking SSID */
 	ssid_len = 0;
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_SSID, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 	if (p) {
 		ssid_len = *(p + 1);
 		if (ssid_len > NDIS_802_11_LENGTH_SSID)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 56fea55513ba..49cf6c2c66d3 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -175,7 +175,7 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	/* below for ad-hoc mode */
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pktlen);
 
 	/*  supported rates... */
 	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
@@ -695,7 +695,7 @@ static void ConstructProbeReq(struct adapter *padapter, u8 *pframe, u32 *pLength
 	pktlen = sizeof(struct ieee80211_hdr_3addr);
 	pframe += pktlen;
 
-	pframe = rtw_set_ie(pframe, _SSID_IE_, 0, NULL, &pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, 0, NULL, &pktlen);
 
 	get_rate_set(padapter, bssrate, &bssrate_len);
 
@@ -793,7 +793,7 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 		u8 buf[MAX_IE_SZ];
 		u8 *ies = pframe + sizeof(struct ieee80211_hdr_3addr);
 
-		ssid_ie = rtw_get_ie(ies+_FIXED_IE_LENGTH_, _SSID_IE_, &ssid_ielen,
+		ssid_ie = rtw_get_ie(ies+_FIXED_IE_LENGTH_, WLAN_EID_SSID, &ssid_ielen,
 					(pframe-ies)-_FIXED_IE_LENGTH_);
 
 		ssid_ielen_diff = cur_network->Ssid.SsidLength - ssid_ielen;
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 18325583e624..7dee4a64da8e 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -387,7 +387,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
-#define _SSID_IE_				0
 #define _SUPPORTEDRATES_IE_	1
 #define _DSSET_IE_				3
 #define _TIM_IE_					5
-- 
2.25.1

