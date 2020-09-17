Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F2226D469
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIQHRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgIQHRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:17:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EAC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:17:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so859795wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Frt12MGwM2wJlYqdoMwjpS7JA8q4wN3zpMFf+klm1TI=;
        b=qZAvO5Od2Z4LRC6lHbZTOfUoRle9XOrGpbml4bP3kv6RkD04jKfKWoAXGys3P8r9u5
         D2eBfQlQWqUwrrhvHbEsAjmSH5+bmpFE2Bu1ooWW454CvCiEmktLrfgF5plYZ2dAYCqK
         A/4Vn1jKAylBumCCHxQsOavnjX70sJ1BmlkEiocnAzMbwQpLzCzvh1m+FnaxvrJMx4+s
         e4GJhrn0P1ZnzU8q4NpB5IOUIMaxXAfX2bwWCj9rsQqJ2UAbD90RQKGoc0Q3WrlbUDrj
         SdyWT9LV0hwJT5AqzbYGN2aduUH5e9bdwaeiCZDCVCJ0ZtNtwbuU+t2+1IPVyQidxzs/
         SWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Frt12MGwM2wJlYqdoMwjpS7JA8q4wN3zpMFf+klm1TI=;
        b=CemMYVWe/bcPLZ0ubOXRk0dOwARP/+3MHWqQrIGfsB743jHfs9KvHJ+mJw8fEa8F4J
         Uo/NMH1zLNPmOoSKhQEShc7iW27O0scI7GSYSR0Q0eSWn0S4FQmGXdWRTbnON4GSykqh
         1hcl2NaGnuTDCmL6oKjr9q0jnao+lyK5R1gsWUjLOCUJpIWUBLAeotT5V7GRHtfOb07I
         VKVI6NLdjlvR78c/aNSVk1oFTjIuj4BXcW9PdjC2y5xvFy+VC8r/Cy/RuWXLWnXFYWZw
         gfpHSotyekzKROKexJwZaVO9Yplw83iMIG5YYGEWWm7VrQRov4CIxTkDKSZuFvqide5E
         XoMw==
X-Gm-Message-State: AOAM532KIgQOhSbuzNUEOB0uJaH5opDRDPO5p/G4zmXo63SixFqkQsH+
        7d8KYJ49Ep3YnCSWjNVm6XE=
X-Google-Smtp-Source: ABdhPJy1ARQlddKUhi5Istu9l/DMdP6x363TMJojzDTKQ765QAcP/PcW8d1laGaBC+kWwye2IdzTZQ==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr30308433wrx.3.1600327032042;
        Thu, 17 Sep 2020 00:17:12 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-070-028-140.088.070.pools.vodafone-ip.de. [88.70.28.140])
        by smtp.gmail.com with ESMTPSA id t6sm41696271wre.30.2020.09.17.00.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:17:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: clean up comparsion style issues
Date:   Thu, 17 Sep 2020 09:13:30 +0200
Message-Id: <20200917071330.31740-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917071330.31740-1-straube.linux@gmail.com>
References: <20200917071330.31740-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move constants to the right side of comparsions to follow kernel
coding style and clear checkpatch warnings. In case of comparsion
to _FAIL we can use '!' since _FAIL is defined as '0'.

WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c     |  6 +++---
 drivers/staging/rtl8188eu/hal/odm.c               |  4 ++--
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c |  2 +-
 drivers/staging/rtl8188eu/include/rtw_mlme.h      |  4 ++--
 drivers/staging/rtl8188eu/include/wifi.h          |  2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c    | 10 +++++-----
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index dad007f78d8c..4df790c83d9f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2981,7 +2981,7 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 			status = _STATS_FAILURE_;
 	}
 
-	if (_STATS_SUCCESSFUL_ != status)
+	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
 	/*  check if the supported rate is ok */
@@ -3072,7 +3072,7 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 		wpa_ie_len = 0;
 	}
 
-	if (_STATS_SUCCESSFUL_ != status)
+	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
@@ -3282,7 +3282,7 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 
 	/*  now the station is qualified to join our BSS... */
-	if ((pstat->state & WIFI_FW_ASSOC_SUCCESS) && (_STATS_SUCCESSFUL_ == status)) {
+	if ((pstat->state & WIFI_FW_ASSOC_SUCCESS) && (status == _STATS_SUCCESSFUL_)) {
 		/* 1 bss_cap_update & sta_info_update */
 		bss_cap_update_on_sta_join(padapter, pstat);
 		sta_info_update(padapter, pstat);
diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index d6c4c7d023d1..4d659a812aed 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -829,9 +829,9 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 	}
 
 	/*  Decide RATRState by RSSI. */
-	if (RSSI > HighRSSIThreshForRA)
+	if (HighRSSIThreshForRA < RSSI)
 		RATRState = DM_RATR_STA_HIGH;
-	else if (RSSI > LowRSSIThreshForRA)
+	else if (LowRSSIThreshForRA < RSSI)
 		RATRState = DM_RATR_STA_MIDDLE;
 	else
 		RATRState = DM_RATR_STA_LOW;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index e640c2256ab9..6e131202fde5 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -187,7 +187,7 @@ static s32 _LLTWrite(struct adapter *padapter, u32 address, u32 data)
 	/* polling */
 	do {
 		value = usb_read32(padapter, LLTReg);
-		if (_LLT_NO_ACTIVE == _LLT_OP_VALUE(value))
+		if (_LLT_OP_VALUE(value) == _LLT_NO_ACTIVE)
 			break;
 
 		if (count > POLLING_LLT_THRESHOLD) {
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index 010f0c42368a..1b74b32b8a81 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -266,7 +266,7 @@ static inline void set_fwstate(struct mlme_priv *pmlmepriv, int state)
 {
 	pmlmepriv->fw_state |= state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY == state)
+	if (state == _FW_UNDER_SURVEY)
 		pmlmepriv->bScanInProcess = true;
 }
 
@@ -274,7 +274,7 @@ static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, int state)
 {
 	pmlmepriv->fw_state &= ~state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY == state)
+	if (state == _FW_UNDER_SURVEY)
 		pmlmepriv->bScanInProcess = false;
 }
 
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 118e215dd6b1..a549b6d0159a 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -326,7 +326,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 
 static inline int IsFrameTypeCtrl(unsigned char *pframe)
 {
-	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
+	if (GetFrameType(pframe) == WIFI_CTRL_TYPE)
 		return true;
 	else
 		return false;
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index d10a078c5b49..ba6356e0825a 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -694,7 +694,7 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 	enum ndis_802_11_network_infra networkType;
 	int ret = 0;
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
+	if (!rtw_pwr_wakeup(padapter)) {
 		ret = -EPERM;
 		goto exit;
 	}
@@ -946,7 +946,7 @@ static int rtw_wx_set_wap(struct net_device *dev,
 	struct	wlan_network	*pnetwork = NULL;
 	enum ndis_802_11_auth_mode	authmode;
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
+	if (!rtw_pwr_wakeup(padapter)) {
 		ret = -1;
 		goto exit;
 	}
@@ -1065,7 +1065,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s\n", __func__));
 
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
+	if (!rtw_pwr_wakeup(padapter)) {
 		ret = -1;
 		goto exit;
 	}
@@ -1269,7 +1269,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
 		 ("+%s: fw_state = 0x%08x\n", __func__, get_fwstate(pmlmepriv)));
-	if (_FAIL == rtw_pwr_wakeup(padapter)) {
+	if (!rtw_pwr_wakeup(padapter)) {
 		ret = -1;
 		goto exit;
 	}
@@ -2878,7 +2878,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 		int probereq_wpsie_len = len;
 		u8 wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 
-		if ((_VENDOR_SPECIFIC_IE_ == probereq_wpsie[0]) &&
+		if ((probereq_wpsie[0] == _VENDOR_SPECIFIC_IE_) &&
 		    (!memcmp(&probereq_wpsie[2], wps_oui, 4))) {
 			cp_sz = min(probereq_wpsie_len, MAX_WPS_IE_LEN);
 
-- 
2.28.0

