Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9B72D21CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgLHEJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgLHEJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:01 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B5C06138C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:47 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id t8so15644645iov.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=od52niLdf98ylQ7QfKcp1NasP3lVbCWxBVZPG6XTlc8=;
        b=NzfFlg1q5rZmEK8aF9+AWedrrzuvSxJsEKdbVj14H+1q3HJh0eZFK6sHC0ooTZqT2p
         smHQwQKzGhbM+F5Ewp3bounB2XUYEQ1E8D6Jr7sr7KYKuid4ZM1sTbehp7LadNA9cmL+
         KGfeV1ncq4zYF4XSp1eGpk3WsZynBehMxlwGob0VkNtgZji1xcjNEZYd8LMUe7krFiqW
         Iw3sz3ZKxKI5IjnUJ9VsbHxhNwpcCAoQJpXimKmImW7LkEjK8XQPXn9gp+GWoBOYAId5
         zY5x9XiDu4vjxL7GM40KqY1nHAUx7ucSzdUbvN8Dzgu6iZ7DSXvl3C+LlS9o9wHaXsSO
         2kVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=od52niLdf98ylQ7QfKcp1NasP3lVbCWxBVZPG6XTlc8=;
        b=Y24z693EipaJ5aU7bt3HJoBKLoQBL8wMVCt1T+NJFjAacGI5/kw+NPpqoZ24Y5akpz
         Rxs7JTOXKTT0VvNXlvXG7qqBNWcTPVTn0zOCEVDOW94T3coGSzy3z83FEcVVyMAUxc+L
         ZQjyCAJJi52NOW3dYxqydVVIvr0xlj8MG0vxJFtF43Vir9bCK18+SzG103dwND5j9ohn
         IjE18/a/g6tYIyGMFfJahlnK/YiqAoeGralX3yBqIQBcQp6I/8qOpGt/TStr6j0tKpiT
         ny9C6FJTMUeaWStLZTYqKaw6U8zWI2CUzXru9reZ20FAoT/68+adsn0cNQkGB4VCYHpW
         7MMQ==
X-Gm-Message-State: AOAM533Z190EFvefMRT9R6IP081JljPNLEK5aFdhOOOzjRTjIdHGjwPz
        ZknxrgQDDGbEShhJfzxD7KC86iWqVW8=
X-Google-Smtp-Source: ABdhPJxbCz/ELnj9su7S6PGarUjBmx7qhoO6AE7R5miCdWs8h71Al74YrjrqPWqzWvfk5xYxcqcePA==
X-Received: by 2002:a02:caac:: with SMTP id e12mr24488754jap.45.1607400467135;
        Mon, 07 Dec 2020 20:07:47 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:46 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 08/21] staging: rtl8723bs: replace _DSSET_IE_
Date:   Mon,  7 Dec 2020 22:07:20 -0600
Message-Id: <20201208040733.379197-9-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _DSSET_IE_ macro with kernel provdied WLAN_EID_DS_PARAMS
from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c        |  2 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 10 +++++-----
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c   |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h       |  1 -
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 99a34c059f6d..1514975f23bc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1019,7 +1019,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	pbss_network->Configuration.Length = 0;
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
-		_DSSET_IE_, &ie_len,
+		WLAN_EID_DS_PARAMS, &ie_len,
 		(pbss_network->IELength - _BEACON_IE_OFFSET_)
 	);
 	if (p && ie_len > 0)
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e0896e128dda..58e29314c8f8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -350,7 +350,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	}
 
 	/* DS parameter set */
-	ie = rtw_set_ie(ie, _DSSET_IE_, 1, (u8 *)&(pdev_network->Configuration.DSConfig), &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_DS_PARAMS, 1, (u8 *)&(pdev_network->Configuration.DSConfig), &sz);
 
 	/* IBSS Parameter Set */
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index b9e612e1e162..1f6c1e441744 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2543,7 +2543,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pattrib->pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
 
 	/* if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) */
 	{
@@ -2747,7 +2747,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pattrib->pktlen);
 
 		/*  DS parameter set */
-		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pattrib->pktlen);
 
 		if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 			u8 erpinfo = 0;
@@ -2884,7 +2884,7 @@ static int _issue_probereq(struct adapter *padapter,
 	}
 
 	if (ch)
-		pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, &ch, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, &ch, &pattrib->pktlen);
 
 	if (append_wps) {
 		/* add wps_ie for wps2.0 */
@@ -4509,7 +4509,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		return _FAIL;
 
 	/*  Checking for DSConfig */
-	p = rtw_get_ie(bssid->IEs + ie_offset, _DSSET_IE_, &len, bssid->IELength - ie_offset);
+	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_DS_PARAMS, &len, bssid->IELength - ie_offset);
 
 	bssid->Configuration.DSConfig = 0;
 	bssid->Configuration.Length = 0;
@@ -5982,7 +5982,7 @@ static int rtw_auto_ap_start_beacon(struct adapter *adapter)
 	} else {
 		oper_channel = adapter_to_dvobj(adapter)->oper_channel;
 	}
-	ie = rtw_set_ie(ie, _DSSET_IE_, 1, &oper_channel, &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_DS_PARAMS, 1, &oper_channel, &sz);
 
 	/* ext supported rates */
 	if (rateLen > 8) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 5ad2ed6af593..ff5125b33749 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1321,7 +1321,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	/* Checking for channel */
-	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _DSSET_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_DS_PARAMS, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 	if (p) {
 			bcn_channel = *(p + 2);
 	} else {/* In 5G, some ap do not have DSSET IE checking HT info for channel */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index c98dd18c316d..ac6677212086 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -182,7 +182,7 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	pframe = rtw_set_ie(pframe, WLAN_EID_SUPP_RATES, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_DS_PARAMS, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pktlen);
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 		u32 ATIMWindow;
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 285d6f9b74b6..b29762bfb3c1 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -387,7 +387,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
-#define _DSSET_IE_				3
 #define _TIM_IE_					5
 #define _IBSS_PARA_IE_			6
 #define _COUNTRY_IE_			7
-- 
2.25.1

