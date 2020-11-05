Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D232A7628
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbgKEDsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388649AbgKEDsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:48:15 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FFC0613D1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 19:48:15 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id p2so171600ilg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 19:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afX1gGZlyZvcJQpwCTCtKlmr5LCYW7s+SwuRxa2BoFo=;
        b=BG3eeq4r6Z8Kh0wYQ06zL1tykRFdu1W1fSvCWAgbAyJApSf/rC7fyg/voUzPHkTTbg
         4OZ8q57rqWaB34vQje4YdKSQTwleBc/wkm6SUHmwzJ01G/nBIPSc2OxOjeFfymi5BgxO
         RkpLMIBOHuBLe1Xky30R3yhD2NDjERgf7uTEExDX2w+xDCUMcnDxtNzqUcjkkFNeS7tn
         zkK0af7DLvlaKvYkIPltfDSwOkcEl4mIWd/VMTJPBLABYi8pm0N0nXpQHucOSRhzWhbf
         UPF82vy5j8C31H/sDZWq80CtHcjzdn/giDeyR1NvRsgBEKiHQvalEkOI5iEFiDdOvAkW
         9SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afX1gGZlyZvcJQpwCTCtKlmr5LCYW7s+SwuRxa2BoFo=;
        b=FJMsQ+LqVq0rYUXuGcXV4D/LjntUD/RwC7ZVndxgd3lUJQ6yH/XWr+dOVtt0Wms1G4
         CNL5gdZ5lDQDGNZNl5zAzg2N7JlqUivSrFzoVCEMyGt794Ts/9c1bS1I4w3aOmrZPPyr
         sywuskUXYV2/sMNPGCa0R7Hf6sIRs5NfK0SFZZdWeQFr+pDqIsj/MFKptpq6ngD9jFQU
         3bssbyjdkqX8aYypjkO9jk+vIcsumjQLbszAKV5JhGgd18qqLTJPamPElt1ugn265D8L
         kIGZo6l5QTAU4IhNMY/+OdZ9SPIrZve0/eadf7mWP64xmogLESzLT2a2tiY/0BCI4EUN
         ul1w==
X-Gm-Message-State: AOAM532y5Ev/o4s4ppi1+uRzRGkb22LFYQD3HfqR8DmdxNkJ8wpddoQJ
        sEPr+pEs6kq8lAf9G4B7zrM=
X-Google-Smtp-Source: ABdhPJzuXf//vRPEu+jW4RqKsyrxs8pItZv3g/5mkiU01qXNOSWDGVBOno+YlYnm+0/TCLlq7ujCWA==
X-Received: by 2002:a92:c0c9:: with SMTP id t9mr524682ilf.56.1604548094684;
        Wed, 04 Nov 2020 19:48:14 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id p6sm172877ilc.26.2020.11.04.19.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 19:48:13 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 7/9] staging: rtl8723bs: replace rtw_ieee80211_spectrum_mgmt_actioncode
Date:   Wed,  4 Nov 2020 21:47:52 -0600
Message-Id: <20201105034754.12383-7-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105034754.12383-1-ross.schm.dev@gmail.com>
References: <20201105034754.12383-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the unique rtw_ieee80211_mgmt_actioncode enum with the provided
standard ieee80211_spectrum_mgmt_actioncode.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 10 +++++-----
 drivers/staging/rtl8723bs/include/ieee80211.h | 10 ----------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 3bb80db51562..cdb1d2b06f1b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1891,11 +1891,11 @@ unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_fr
 
 	action = frame_body[1];
 	switch (action) {
-	case RTW_WLAN_ACTION_SPCT_MSR_REQ:
-	case RTW_WLAN_ACTION_SPCT_MSR_RPRT:
-	case RTW_WLAN_ACTION_SPCT_TPC_REQ:
-	case RTW_WLAN_ACTION_SPCT_TPC_RPRT:
-	case RTW_WLAN_ACTION_SPCT_CHL_SWITCH:
+	case WLAN_ACTION_SPCT_MSR_REQ:
+	case WLAN_ACTION_SPCT_MSR_RPRT:
+	case WLAN_ACTION_SPCT_TPC_REQ:
+	case WLAN_ACTION_SPCT_TPC_RPRT:
+	case WLAN_ACTION_SPCT_CHL_SWITCH:
 		break;
 	default:
 		break;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index e2a6b92ba3ba..06aacafd2340 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -893,16 +893,6 @@ enum rtw_ieee80211_category {
 	RTW_WLAN_CATEGORY_P2P = 0x7f,/* P2P action frames */
 };
 
-/* SPECTRUM_MGMT action code */
-enum rtw_ieee80211_spectrum_mgmt_actioncode {
-	RTW_WLAN_ACTION_SPCT_MSR_REQ = 0,
-	RTW_WLAN_ACTION_SPCT_MSR_RPRT = 1,
-	RTW_WLAN_ACTION_SPCT_TPC_REQ = 2,
-	RTW_WLAN_ACTION_SPCT_TPC_RPRT = 3,
-	RTW_WLAN_ACTION_SPCT_CHL_SWITCH = 4,
-	RTW_WLAN_ACTION_SPCT_EXT_CHL_SWITCH = 5,
-};
-
 enum _PUBLIC_ACTION {
 	ACT_PUBLIC_BSSCOEXIST = 0, /*  20/40 BSS Coexistence */
 	ACT_PUBLIC_DSE_ENABLE = 1,
-- 
2.25.1

