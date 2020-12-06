Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2772D006E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 05:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgLFEKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 23:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLFEKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:10:16 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97346C061A4F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 20:09:30 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id j12so1884503ilk.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 20:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEzO8bX1wjn8Nr1hxe30D5feSFhsaVt2TREt7C5KgWA=;
        b=H/FLhaoH6kmS9i3Q5lwtEQ2TDHxvGifGGAp8AveXgPBRYEqeCGwApULlnHoZiCcOdU
         qxvH1ShuKhhvQpO5lrs4I7XTvmR6I+39jIECfhzTmt33KwG/M0//rbaxTU2R0KBaGxWM
         tHHIGtSuQY3dDbFwV9C1hBUu51zDMKeXn0FMwbQuDKL8jMD+zE8XlOUjQPFrFSw9shTU
         ngLMxDMob5d2pIdCzBv0sutPltQZhhzMPL2tHKq8FHtmQMRscC2UTnqFHLYpy/opNCo/
         7HPulT9IVsJ5PXF+LXDvCxRy3aMl4AYsK5oGVXRMIwmW7RPCZaz41boiCo4OHRaDJNTD
         1Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEzO8bX1wjn8Nr1hxe30D5feSFhsaVt2TREt7C5KgWA=;
        b=NCLSF88MqW8rhz9wdfJpKganfpUUN4viHZNV/Yz3zbfjILX1/qTmX66fmfw0wYKywm
         jY+k28FrQLQ/GyS/UxVwMqcAd6txx2KYwJomLIq1gbKLZO7lcdDpxejJEs9QiwNrzyLU
         kaDC7nUJnChQNo/YX4tuxyrsREEmtGekEHUhhmMNkDI3S4h3gd1/bsMAxqsQ9UPjADHy
         6IkwYbMEafvyJ6QHwkBRAzRIlfHF6jdPCtUdxABH6V8tyRYBC2X1x7XF25d8CJGpQTjq
         vfkZ3rt8011XAAJi8iYy6Q2620oD3VUa12PsYtA9owhTZC5N8Ndz0SXml/GqIK2ZT9ko
         g82A==
X-Gm-Message-State: AOAM5325ROfDvjTCdVb0pX4iWdyLuEBQCNRBfNBfMxQMIuUEdt/vNxPF
        pcI1E79R1tSSRYH6X0yXpC9xkiWVDrw=
X-Google-Smtp-Source: ABdhPJyttt0Bw3VlgTY3BYsQzx5ForBuQOjPh10mA9YLFpY9LCCTMH9wPfmaZRhfJUBOihOXDC9O8w==
X-Received: by 2002:a92:3407:: with SMTP id b7mr1761134ila.298.1607226328186;
        Sat, 05 Dec 2020 19:45:28 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id v63sm3908553ioe.52.2020.12.05.19.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 19:45:27 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 05/10] staging: rtl8723bs: replace OP_MODE_* and HT_INFO_OPERATION_MODE_* macros
Date:   Sat,  5 Dec 2020 21:45:12 -0600
Message-Id: <20201206034517.4276-5-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201206034517.4276-1-ross.schm.dev@gmail.com>
References: <20201206034517.4276-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique OP_MODE_* and HT_INFO_OPERATION_MODE_* macro families
with kernel provided IEEE80211_HT_OP_MODE_* macros.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c  | 30 ++++++++++++------------
 drivers/staging/rtl8723bs/include/wifi.h | 13 ----------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 984b9f5a83ac..27446156ed34 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1842,28 +1842,28 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	DBG_871X("%s current operation mode = 0x%X\n",
 		   __func__, pmlmepriv->ht_op_mode);
 
-	if (!(pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT)
+	if (!(pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT)
 	    && pmlmepriv->num_sta_ht_no_gf) {
 		pmlmepriv->ht_op_mode |=
-			HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT;
+			IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT;
 		op_mode_changes++;
 	} else if ((pmlmepriv->ht_op_mode &
-		    HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT) &&
+		    IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT) &&
 		   pmlmepriv->num_sta_ht_no_gf == 0) {
 		pmlmepriv->ht_op_mode &=
-			~HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT;
+			~IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT;
 		op_mode_changes++;
 	}
 
-	if (!(pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_HT_STA_PRESENT) &&
+	if (!(pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT) &&
 	    (pmlmepriv->num_sta_no_ht || pmlmepriv->olbc_ht)) {
-		pmlmepriv->ht_op_mode |= HT_INFO_OPERATION_MODE_NON_HT_STA_PRESENT;
+		pmlmepriv->ht_op_mode |= IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT;
 		op_mode_changes++;
 	} else if ((pmlmepriv->ht_op_mode &
-		    HT_INFO_OPERATION_MODE_NON_HT_STA_PRESENT) &&
+		    IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT) &&
 		   (pmlmepriv->num_sta_no_ht == 0 && !pmlmepriv->olbc_ht)) {
 		pmlmepriv->ht_op_mode &=
-			~HT_INFO_OPERATION_MODE_NON_HT_STA_PRESENT;
+			~IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT;
 		op_mode_changes++;
 	}
 
@@ -1873,20 +1873,20 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	 */
 	new_op_mode = 0;
 	if (pmlmepriv->num_sta_no_ht ||
-	    (pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT))
-		new_op_mode = OP_MODE_MIXED;
+	    (pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT))
+		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED;
 	else if (
 		(le16_to_cpu(phtpriv_ap->ht_cap.cap_info) & IEEE80211_HT_CAP_SUP_WIDTH)
 		&& pmlmepriv->num_sta_ht_20mhz)
-		new_op_mode = OP_MODE_20MHZ_HT_STA_ASSOCED;
+		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_20MHZ;
 	else if (pmlmepriv->olbc_ht)
-		new_op_mode = OP_MODE_MAY_BE_LEGACY_STAS;
+		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONMEMBER;
 	else
-		new_op_mode = OP_MODE_PURE;
+		new_op_mode = IEEE80211_HT_OP_MODE_PROTECTION_NONE;
 
-	cur_op_mode = pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_OP_MODE_MASK;
+	cur_op_mode = pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_PROTECTION;
 	if (cur_op_mode != new_op_mode) {
-		pmlmepriv->ht_op_mode &= ~HT_INFO_OPERATION_MODE_OP_MODE_MASK;
+		pmlmepriv->ht_op_mode &= ~IEEE80211_HT_OP_MODE_PROTECTION;
 		pmlmepriv->ht_op_mode |= new_op_mode;
 		op_mode_changes++;
 	}
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 9c92b5020fbc..2fb1687ecabf 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -673,12 +673,6 @@ struct ADDBA_request {
 #define WLAN_HT_CAP_SM_PS_INVALID	2
 #define WLAN_HT_CAP_SM_PS_DISABLED	3
 
-
-#define OP_MODE_PURE                    0
-#define OP_MODE_MAY_BE_LEGACY_STAS      1
-#define OP_MODE_20MHZ_HT_STA_ASSOCED    2
-#define OP_MODE_MIXED                   3
-
 #define HT_INFO_HT_PARAM_SECONDARY_CHNL_OFF_MASK	((u8) BIT(0) | BIT(1))
 #define HT_INFO_HT_PARAM_SECONDARY_CHNL_ABOVE		((u8) BIT(0))
 #define HT_INFO_HT_PARAM_SECONDARY_CHNL_BELOW		((u8) BIT(0) | BIT(1))
@@ -687,13 +681,6 @@ struct ADDBA_request {
 #define HT_INFO_HT_PARAM_CTRL_ACCESS_ONLY		((u8) BIT(4))
 #define HT_INFO_HT_PARAM_SRV_INTERVAL_GRANULARITY	((u8) BIT(5))
 
-#define HT_INFO_OPERATION_MODE_OP_MODE_MASK	\
-		((u16) (0x0001 | 0x0002))
-#define HT_INFO_OPERATION_MODE_OP_MODE_OFFSET		0
-#define HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT	((u8) BIT(2))
-#define HT_INFO_OPERATION_MODE_TRANSMIT_BURST_LIMIT	((u8) BIT(3))
-#define HT_INFO_OPERATION_MODE_NON_HT_STA_PRESENT	((u8) BIT(4))
-
 #define HT_INFO_STBC_PARAM_DUAL_BEACON			((u16) BIT(6))
 #define HT_INFO_STBC_PARAM_DUAL_STBC_PROTECT		((u16) BIT(7))
 #define HT_INFO_STBC_PARAM_SECONDARY_BCN		((u16) BIT(8))
-- 
2.25.1

