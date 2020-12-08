Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133332D21D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgLHEJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgLHEJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:03 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E0C0611CA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:52 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id q137so15636917iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JOKh3pIHcLV6hwl3hlWvC1AlmNEfQsVeH0itWK9SLyo=;
        b=P77/YpIBjnMJhnXe+tUjkJioKMu/B+nUL+sICUo7K/dReW/izbDrd1WnY34jQUB6LE
         j9GF6RHxlVXR9vdfHtCkunz+EKcGkjneL17TdYp3HHlynHpqqQuQEabsxwPktVRZ/eVk
         Zu8G2v29UZ6Y/KPKgrSrCR2aCZmwUweH7le9RQfmSLStKrx+zR2/lwx/lrmlSKYw5m48
         WenafGOrlKO/koSE0kdFiaSukw/FaTmatsjvowBIyuMlZc4oCtgsBBbtZQspEBlcQwWi
         facn2gjvYayhSKwi9eWD0/pobCIrnO5rnALUjwlxD0YXkTvLy94QKvKb6aSN1Y3Abctu
         DVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOKh3pIHcLV6hwl3hlWvC1AlmNEfQsVeH0itWK9SLyo=;
        b=ATUjvSc5UnLUHT9h0vQt2Akj9rGHHo3y+FSuaj9BgURn55s3VfSNvbEzbfsNHcOzWu
         8QmAWvfGTH2SwaZVdPhZAis44qsMTxN/nDH/Xcf3j4lUdSGT38AOevtFVVj7GyDmpmA1
         RqeWM5qLeCRBKpJcE/EfhoIfJZqfEfsbDZVrN26g9ayUTfmtVIGK8dexzkwbF8Ub8+0e
         SFHnZMHvcoGcMlv1gQoBwMP5Hi4UUveJKXV/jL0OKm179qGqTGvLTDP3/iOyeU5vyzIP
         LBqAcHem6UXdUd+C42maz9gS4rkgH4HEx7pTP8NuAFAvXTir6lHBwjz7RC0xHwOPxUhs
         pj3g==
X-Gm-Message-State: AOAM532cva94oRqlsa0vtkenkA8QT4B7DMfj8WkaRFr/QxKzWZMwaEJY
        hrktg9mKQb6MslHITJ8PE0E=
X-Google-Smtp-Source: ABdhPJw/qy4MC90H5v9Y7veDNjf1LTCTV5jZOBdIFvzDmSSzHsFO2ZpvcGDpDu98Ij4Qe+MZvF5N0g==
X-Received: by 2002:a05:6602:2c48:: with SMTP id x8mr22739836iov.24.1607400471511;
        Mon, 07 Dec 2020 20:07:51 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:50 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 12/21] staging: rtl8723bs: replace _CHLGETXT_IE_
Date:   Mon,  7 Dec 2020 22:07:24 -0600
Message-Id: <20201208040733.379197-13-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _CHLGETXT_IE_ macro with kernel provided WLAN_EID_CHALLENGE
from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++++----
 drivers/staging/rtl8723bs/include/wifi.h      | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 319a99833a49..93380493e8dc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1028,7 +1028,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			/* checking for challenging txt... */
 			DBG_871X("checking for challenging txt...\n");
 
-			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&ie_len,
+			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
 			if ((p == NULL) || (ie_len <= 0)) {
@@ -1124,7 +1124,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	if (seq == 2) {
 		if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared) {
 			 /*  legendary shared system */
-			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&len,
+			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
 			if (p == NULL) {
@@ -3026,7 +3026,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 
 		/*  added challenging text... */
 		if ((psta->auth_seq == 2) && (psta->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1))
-			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, psta->chg_txt, &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, WLAN_EID_CHALLENGE, 128, psta->chg_txt, &(pattrib->pktlen));
 
 	} else {
 		memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
@@ -3066,7 +3066,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 
 		/*  then checking to see if sending challenging text... */
 		if ((pmlmeinfo->auth_seq == 3) && (pmlmeinfo->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1)) {
-			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, pmlmeinfo->chg_txt, &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, WLAN_EID_CHALLENGE, 128, pmlmeinfo->chg_txt, &(pattrib->pktlen));
 
 			SetPrivacy(fctrl);
 
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 6df50468200e..2f13bbe38f74 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -387,7 +387,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
-#define _CHLGETXT_IE_			16
 #define _SUPPORTED_CH_IE_		36
 #define _CH_SWTICH_ANNOUNCE_	37	/* Secondary Channel Offset */
 #define _ERPINFO_IE_			42
-- 
2.25.1

