Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EDC2D21CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgLHEJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgLHEJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:03 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD16C061257
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:49 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z136so15648959iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JST98VZPaX2qnxCjv/Wu6UJKvxVQ8ZfkpQ0u1A/qWnQ=;
        b=PSBY/Cj73fWmbvypFpatUNUYlRwtvtP+dlMvWeZLEs+BSfu23hScw9KqmGbITUhGPs
         e4u/naCzZzSg0rIiEJgbjkK1Qvi2PefI94n8NLWEfVuFxbiCOop1af/qI/oC9qUBzv7h
         478xW7GTCuF+h2jMhWKTGEBUnot90PiQYfFva2dWT4WzLnjTAMe9KHOmWmDqlKdIN9je
         5q11XmXtweJvQ3zYfiD9omzY4pHeWb2IzFxBrlGFHDL4H1lRYIXysfYM7aKKL3N5J289
         dOu6lzqTGqP31Wh7x3pGDIPacPAMDgCjr6+kn90TQEjTxnXNCWAtwtlAXXz8WPnegJdd
         7zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JST98VZPaX2qnxCjv/Wu6UJKvxVQ8ZfkpQ0u1A/qWnQ=;
        b=DfF+lKDxqhCawEGrp3OxqeNMs8tgg3yi35w7cu9gH49Rx0xk56X6lowM0+/MixF5eQ
         aUXG3060BJ36LHfBUgEVNLd+UOJo6Cwda3EPVmUwfvw0H94yIZhkLuzKW/e5ItcVNGP5
         KP2A99TsncBsxBpt4IkzIIk0/xYMW6iHyC+mfbYPmxHqdry/h1AVjgEVOR1RvK8OI5cu
         haOofqFFqXwRHY0blLBi6uFFcAygaH63cjsD0BgAi2wO822qz6TrqKm8GDb4/NUa9GkN
         F8vPRqsHWO+506gEv5qB+Og7e08X17h/XsMatNa6D2pu4P+oxubE6DQQ8/Hn8dbBIt0V
         k8jw==
X-Gm-Message-State: AOAM531jBPR4lUIqcRp6I4n4L/02u7jwWGi/vWi0tkDexnGsdmyjQ5jJ
        7jSgkGng4XiAtFCJGTr6GKo=
X-Google-Smtp-Source: ABdhPJxXGPFenswYiMPKdpPyxS/1QjD/CEYgAxlvcpk9uYWEqy2eTP8d3NoJRHfEEJFE1PDvcD9Ldw==
X-Received: by 2002:a6b:441a:: with SMTP id r26mr22951251ioa.105.1607400469242;
        Mon, 07 Dec 2020 20:07:49 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:48 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 10/21] staging: rtl8723bs: replace _IBSS_PARA_IE_
Date:   Mon,  7 Dec 2020 22:07:22 -0600
Message-Id: <20201208040733.379197-11-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _IBSS_PARA_IE_ macro with kernel provided
WLAN_EID_IBSS_PARAMS from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 4 ++--
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c   | 2 +-
 drivers/staging/rtl8723bs/include/wifi.h       | 1 -
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 58e29314c8f8..b899f511ff9f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -354,7 +354,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 
 	/* IBSS Parameter Set */
 
-	ie = rtw_set_ie(ie, _IBSS_PARA_IE_, 2, (u8 *)&(pdev_network->Configuration.ATIMWindow), &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2, (u8 *)&(pdev_network->Configuration.ATIMWindow), &sz);
 
 	if (rateLen > 8) {
 		ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1f6c1e441744..546e4a31142b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2552,7 +2552,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 		/*  IBSS Parameter Set... */
 		/* ATIMWindow = cur->Configuration.ATIMWindow; */
 		ATIMWindow = 0;
-		pframe = rtw_set_ie(pframe, _IBSS_PARA_IE_, 2, (unsigned char *)(&ATIMWindow), &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_IBSS_PARAMS, 2, (unsigned char *)(&ATIMWindow), &pattrib->pktlen);
 
 		/* ERP IE */
 		pframe = rtw_set_ie(pframe, _ERPINFO_IE_, 1, &erpinfo, &pattrib->pktlen);
@@ -2755,7 +2755,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 			/*  IBSS Parameter Set... */
 			/* ATIMWindow = cur->Configuration.ATIMWindow; */
 			ATIMWindow = 0;
-			pframe = rtw_set_ie(pframe, _IBSS_PARA_IE_, 2, (unsigned char *)(&ATIMWindow), &pattrib->pktlen);
+			pframe = rtw_set_ie(pframe, WLAN_EID_IBSS_PARAMS, 2, (unsigned char *)(&ATIMWindow), &pattrib->pktlen);
 
 			/* ERP IE */
 			pframe = rtw_set_ie(pframe, _ERPINFO_IE_, 1, &erpinfo, &pattrib->pktlen);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index ac6677212086..f6073ecef2e2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -189,7 +189,7 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 		/*  IBSS Parameter Set... */
 		/* ATIMWindow = cur->Configuration.ATIMWindow; */
 		ATIMWindow = 0;
-		pframe = rtw_set_ie(pframe, _IBSS_PARA_IE_, 2, (unsigned char *)(&ATIMWindow), &pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_IBSS_PARAMS, 2, (unsigned char *)(&ATIMWindow), &pktlen);
 	}
 
 
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index dc11ba28d469..3adeb3c23a3c 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -387,7 +387,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
-#define _IBSS_PARA_IE_			6
 #define _COUNTRY_IE_			7
 #define _CHLGETXT_IE_			16
 #define _SUPPORTED_CH_IE_		36
-- 
2.25.1

