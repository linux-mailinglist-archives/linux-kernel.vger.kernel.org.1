Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D572D21C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgLHEI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgLHEIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:08:23 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE13C06179C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:43 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n4so15627875iow.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFH8ssOq8taBSz7WJiVHZ0gOaA547gg/JRA7CYsBNQo=;
        b=eYl4p0U+uCnuwsBnn7aUOPI7p86u9Vmut+7OQhqcjsL4c0J416j1MRWLtvGXi9r1Ps
         AxY7CKJqLrs/Z27ckR2bl4VDNSpm6BjE1kLur2T21eCAKHPfojGveR1ARemY8TtGueli
         Y5AOhGZogka+Jc8nFTe3mehCfeKJSUxoZngW3PDFloMrMr2shGRLqsA8iirBtnpH7Rph
         0inYhkh+HD08gREdr4XyytQavDKba/FBSi3XH/ygdK1BKQwLBVNUB4SA+U18fq/d2T90
         0Pum3Ovh9XMZtbw0COMIoSkPC2maywJEPA78IuINbnPpWJDpYyQ885PoIW78QEtNYmzO
         +2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFH8ssOq8taBSz7WJiVHZ0gOaA547gg/JRA7CYsBNQo=;
        b=r33hdRbv+ngWEdf7A5+YsK9XOI+AXD550j9ofqsffOzfpA2Ny/nTwvs+vtTNQ4ZjAN
         VNKLOxhPgTY6CJB6QMWDiGC6hbAIgVCdMrunQDpaQvFoFRtcKLCQmQAb9yr67S+oV3Jj
         MNQoYqbBq55EViYwoN61OJCQTi+Me8Cl0+bZsUqn3GSu68SfcNfqaNqHut7c+Jn7d5Cc
         /+kC6br+JxVmYpZhXQC97sjfhuDfkJ1DWGeF6oSaACUmBAvM8hzWXug5rmmC33teSDnn
         EUfMd4cr0tiYz1FI7yCpTUUzzSz0tcdVvxDy9EsIC20qa85xro1OStj67JuT3ruZzDs1
         LwHA==
X-Gm-Message-State: AOAM532MAMPHbokTz8xr1kHFUW+c2VpiAL/QYZkt1awI4Qrt7MLQuejt
        oYDH2oRQfQyhGobSZa4fN6N+JLzAFbE=
X-Google-Smtp-Source: ABdhPJzrh4U6kYniW7IDxjsNAN3RAY3SEDPwZDidzDQlADVBT/2OtVEIBfkjH9AVZQu7r9OoU1i+0g==
X-Received: by 2002:a02:b011:: with SMTP id p17mr24979592jah.55.1607400462735;
        Mon, 07 Dec 2020 20:07:42 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:42 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 04/21] staging: rtl8723bs: use WLAN_EID_HT_OPERATION
Date:   Mon,  7 Dec 2020 22:07:16 -0600
Message-Id: <20201208040733.379197-5-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _HT_EXTRA_INFO_IE_ and _HT_ADD_INFO_IE_ macros with kernel
provided WLAN_EID_HT_OPERATION from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c        | 10 +++++-----
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c      |  8 ++++----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  |  8 ++++----
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c |  6 +++---
 drivers/staging/rtl8723bs/include/wifi.h       |  2 --
 6 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 7cab9889140e..e44c01de3b10 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -855,7 +855,7 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	/* set channel, bwmode */
 	p = rtw_get_ie(
 		(pnetwork->IEs + sizeof(struct ndis_802_11_fix_ie)),
-		_HT_ADD_INFO_IE_,
+		WLAN_EID_HT_OPERATION,
 		&ie_len,
 		(pnetwork->IELength - sizeof(struct ndis_802_11_fix_ie))
 	);
@@ -1235,7 +1235,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/* parsing HT_INFO_IE */
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
-		_HT_ADD_INFO_IE_,
+		WLAN_EID_HT_OPERATION,
 		&ie_len,
 		(pbss_network->IELength - _BEACON_IE_OFFSET_)
 	);
@@ -1786,7 +1786,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 		break;
 
-	case _HT_ADD_INFO_IE_:
+	case WLAN_EID_HT_OPERATION:
 
 		update_bcn_htinfo_ie(padapter);
 
@@ -2053,7 +2053,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 	if (rtw_ht_operation_update(padapter) > 0) {
 		update_beacon(padapter, WLAN_EID_HT_CAPABILITY, NULL, false);
-		update_beacon(padapter, _HT_ADD_INFO_IE_, NULL, true);
+		update_beacon(padapter, WLAN_EID_HT_OPERATION, NULL, true);
 	}
 
 	/* update associated stations cap. */
@@ -2117,7 +2117,7 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 
 	if (rtw_ht_operation_update(padapter) > 0) {
 		update_beacon(padapter, WLAN_EID_HT_CAPABILITY, NULL, false);
-		update_beacon(padapter, _HT_ADD_INFO_IE_, NULL, true);
+		update_beacon(padapter, WLAN_EID_HT_OPERATION, NULL, true);
 	}
 
 	/* update associated stations cap. */
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 4ab34d71b09b..ff4f493e8dcd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1217,7 +1217,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 			pnetwork->BcnInfo.ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(pnetwork->network.IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, pnetwork->network.IELength - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
 			pnetwork->BcnInfo.ht_info_infos_0 = pht_info->infos[0];
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 1d4e565a314b..d05338015744 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2616,7 +2616,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 			/* TDLS: TODO 40? */
 			operation_bw = CHANNEL_WIDTH_40;
 	} else {
-		p = rtw_get_ie(in_ie, _HT_ADD_INFO_IE_, &ielen, in_len);
+		p = rtw_get_ie(in_ie, WLAN_EID_HT_OPERATION, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			struct HT_info_element *pht_info = (struct HT_info_element *)(p+2);
 
@@ -2724,10 +2724,10 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	phtpriv->ht_option = true;
 
 	if (in_ie) {
-		p = rtw_get_ie(in_ie, _HT_ADD_INFO_IE_, &ielen, in_len);
+		p = rtw_get_ie(in_ie, WLAN_EID_HT_OPERATION, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			out_len = *pout_len;
-			pframe = rtw_set_ie(out_ie+out_len, _HT_ADD_INFO_IE_, ielen, p+2, pout_len);
+			pframe = rtw_set_ie(out_ie+out_len, WLAN_EID_HT_OPERATION, ielen, p+2, pout_len);
 		}
 	}
 
@@ -2780,7 +2780,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	}
 
 	len = 0;
-	p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fix_ie), _HT_ADD_INFO_IE_, &len, ie_len-sizeof(struct ndis_802_11_fix_ie));
+	p = rtw_get_ie(pie+sizeof(struct ndis_802_11_fix_ie), WLAN_EID_HT_OPERATION, &len, ie_len-sizeof(struct ndis_802_11_fix_ie));
 	if (p && len > 0) {
 		pht_addtinfo = (struct ieee80211_ht_addt_info *)(p+2);
 		/* todo: */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1fa0be4dbfd5..b829264b8aff 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1701,7 +1701,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 			HT_caps_handler(padapter, pIE);
 			break;
 
-		case _HT_EXTRA_INFO_IE_:	/* HT info */
+		case WLAN_EID_HT_OPERATION:	/* HT info */
 			HT_info_handler(padapter, pIE);
 			break;
 
@@ -3173,7 +3173,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 
 		/* FILL HT ADD INFO IE */
 		/* p = hostapd_eid_ht_operation(hapd, p); */
-		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _HT_ADD_INFO_IE_, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_));
+		pbuf = rtw_get_ie(ie + _BEACON_IE_OFFSET_, WLAN_EID_HT_OPERATION, &ie_len, (pnetwork->IELength - _BEACON_IE_OFFSET_));
 		if (pbuf && ie_len > 0) {
 			memcpy(pframe, pbuf, ie_len+2);
 			pframe += (ie_len+2);
@@ -4519,7 +4519,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	} else {
 		/*  In 5G, some ap do not have DSSET IE */
 		/*  checking HT info for channel */
-		p = rtw_get_ie(bssid->IEs + ie_offset, _HT_ADD_INFO_IE_, &len, bssid->IELength - ie_offset);
+		p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_HT_OPERATION, &len, bssid->IELength - ie_offset);
 		if (p) {
 			struct HT_info_element *HT_info = (struct HT_info_element *)(p + 2);
 
@@ -6182,7 +6182,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 			pmlmeinfo->HT_caps_enable = 1;
 			break;
 
-		case _HT_EXTRA_INFO_IE_:	/* Get HT Info IE. */
+		case WLAN_EID_HT_OPERATION:	/* Get HT Info IE. */
 			pmlmeinfo->HT_info_enable = 1;
 
 			/* spec case only for cisco's ap because cisco's ap issue assoc rsp using mcs rate @40MHz or @20MHz */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index c0e435ba2730..94e4f82610ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1297,7 +1297,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 			ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
 			ht_info_infos_0 = pht_info->infos[0];
@@ -1325,7 +1325,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (p) {
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
-			rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _HT_ADD_INFO_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+			rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 			if (pht_info) {
 					bcn_channel = pht_info->primary_channel;
 			} else { /* we don't find channel IE, so don't check it */
@@ -1474,7 +1474,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 
 			break;
 
-		case _HT_EXTRA_INFO_IE_:	/* HT info */
+		case WLAN_EID_HT_OPERATION:	/* HT info */
 			/* HT_info_handler(padapter, pIE); */
 			bwmode_update_check(padapter, pIE);
 			break;
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 5a8c594008aa..18325583e624 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -402,8 +402,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define _FTIE_						55
 #define _TIMEOUT_ITVL_IE_			56
 #define _SRC_IE_				59
-#define _HT_EXTRA_INFO_IE_			61
-#define _HT_ADD_INFO_IE_			61 /* _HT_EXTRA_INFO_IE_ */
 #define _WAPI_IE_					68
 
 #define _RIC_Descriptor_IE_			75
-- 
2.25.1

