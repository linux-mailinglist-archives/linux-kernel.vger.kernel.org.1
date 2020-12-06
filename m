Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF02D0078
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 05:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgLFEQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 23:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgLFEPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:15:36 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E27C061A51
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 20:14:44 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id f9so6097427pfc.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 20:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vYQwjmo0RTRT78a4pJ/wKxPikM9y2nIdsWBhPX3Z88=;
        b=jbg7pLtMeYiCs+bKFoOZcjwRyXxII1M3wVnpoVihT9MF3IokrPDg4zgR+iKPZEBTEz
         1WAd0iogK7iMt5pmvpKn9M1q+FdJd3sPPX+CW54EaFatF9cZOH/45DRQ4FPo/xy0Amif
         +UXAMZvy/psutpJDEcEHw97VoV12wjKZJG39LitkuktxoshGslKK3S+EclbpffjuMUv1
         KE5gtwxVWPtGOpHrfF7yxEc4RNHLXZoNgzgI0Xfx8r3n0eG2mIgHH2z4j89sZTYMvptG
         b6ybXMNF0QNlL3D9InR44XjNhqynBMG1TClIJphlodct1BXr9OwVlGkkZbbS/685ZkGm
         S6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vYQwjmo0RTRT78a4pJ/wKxPikM9y2nIdsWBhPX3Z88=;
        b=pfGnW0pgJVhcymjHiVkMKSjDIIFnUAthGxGM+Zc5YpXQGJYIW0afs8vhDiFMZMAmsU
         PIZodmd84szAV9U7vDPDZNVNVswxXamPvcMmwqKPoFw0kg8/J7M9jkpjf5ZpmfTkPsJN
         c7VQWm+6B+N9eAFK9R3yYWHhwGgQRNXHlOoTUl3fwNrmGaQXSdYTXK47bOJ3HPN8p5nR
         Kn5PKhBfqeyFETZBWPVbdLlb06hsDtjcRdcTio9g+0Z/xCWJsdcbOM0LCN6BliiIjCun
         c558qYf6zfFQc8kyYvRDUEdv31UnsfBWksjW7KeosiR4ZdNxf2hTOSgF0THfQxb80WqA
         AX1w==
X-Gm-Message-State: AOAM53342ebomHk3qDsmH33dwKxT/V+BIU2DmXs2m4wiFhzbhEkHHopb
        o5lals/UYf6sD5rpRD9ZuMAU57Gc3gM=
X-Google-Smtp-Source: ABdhPJxG7mu2POITYhGeN4b3UZFo3fY+KkVYcBdpf8apj+UYhilzDlSvhkcX2PHuYFAdrxZ6vGxueQ==
X-Received: by 2002:a92:d350:: with SMTP id a16mr13030547ilh.291.1607226326989;
        Sat, 05 Dec 2020 19:45:26 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id v63sm3908553ioe.52.2020.12.05.19.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 19:45:26 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 04/10] staging: rtl8723bs: replace HT_CAP_AMPDU_FACTOR
Date:   Sat,  5 Dec 2020 21:45:11 -0600
Message-Id: <20201206034517.4276-4-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201206034517.4276-1-ross.schm.dev@gmail.com>
References: <20201206034517.4276-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique HT_CAP_AMPDU_FACTOR enum with kernel provided
ieee80211_max_ampdu_length_exp enum.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c         |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     | 12 ++++++------
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c |  2 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h          |  7 -------
 5 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 001cce312f05..e20e0ce4a2c5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2580,7 +2580,7 @@ void rtw_build_wmm_ie_ht(struct adapter *padapter, u8 *out_ie, uint *pout_len)
 unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_ie, uint in_len, uint *pout_len, u8 channel)
 {
 	u32 ielen, out_len;
-	enum HT_CAP_AMPDU_FACTOR max_rx_ampdu_factor;
+	enum ieee80211_max_ampdu_length_exp max_rx_ampdu_factor;
 	unsigned char *p, *pframe;
 	struct ieee80211_ht_cap ht_capie;
 	u8 cbw40_enable = 0, stbc_rx_enable = 0, rf_type = 0, operation_bw = 0;
@@ -2698,7 +2698,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	if (padapter->driver_rx_ampdu_factor != 0xFF)
 		max_rx_ampdu_factor =
-		  (enum HT_CAP_AMPDU_FACTOR)padapter->driver_rx_ampdu_factor;
+		  (enum ieee80211_max_ampdu_length_exp)padapter->driver_rx_ampdu_factor;
 	else
 		rtw_hal_get_def_var(padapter, HW_VAR_MAX_RX_AMPDU_FACTOR,
 				    &max_rx_ampdu_factor);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 239c89ce7dc9..0743e56582ba 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3880,7 +3880,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	u16 reason_code;
 	u16 BA_timeout_value;
 	u16 BA_starting_seqctrl = 0;
-	enum HT_CAP_AMPDU_FACTOR max_rx_ampdu_factor;
+	enum ieee80211_max_ampdu_length_exp max_rx_ampdu_factor;
 	struct xmit_frame		*pmgntframe;
 	struct pkt_attrib		*pattrib;
 	u8 			*pframe;
@@ -3975,18 +3975,18 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&status), &(pattrib->pktlen));
 			if (padapter->driver_rx_ampdu_factor != 0xFF)
 				max_rx_ampdu_factor =
-				  (enum HT_CAP_AMPDU_FACTOR)padapter->driver_rx_ampdu_factor;
+				  (enum ieee80211_max_ampdu_length_exp)padapter->driver_rx_ampdu_factor;
 			else
 				rtw_hal_get_def_var(padapter,
 						    HW_VAR_MAX_RX_AMPDU_FACTOR, &max_rx_ampdu_factor);
 
-			if (MAX_AMPDU_FACTOR_64K == max_rx_ampdu_factor)
+			if (IEEE80211_HT_MAX_AMPDU_64K == max_rx_ampdu_factor)
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x1000); /* 64 buffer size */
-			else if (MAX_AMPDU_FACTOR_32K == max_rx_ampdu_factor)
+			else if (IEEE80211_HT_MAX_AMPDU_32K == max_rx_ampdu_factor)
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x0800); /* 32 buffer size */
-			else if (MAX_AMPDU_FACTOR_16K == max_rx_ampdu_factor)
+			else if (IEEE80211_HT_MAX_AMPDU_16K == max_rx_ampdu_factor)
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x0400); /* 16 buffer size */
-			else if (MAX_AMPDU_FACTOR_8K == max_rx_ampdu_factor)
+			else if (IEEE80211_HT_MAX_AMPDU_8K == max_rx_ampdu_factor)
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x0200); /* 8 buffer size */
 			else
 				BA_para_set = ((le16_to_cpu(pmlmeinfo->ADDBA_req.BA_para_set) & 0x3f) | 0x1000); /* 64 buffer size */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index de8caa6cd418..84e963909283 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -4373,7 +4373,7 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum HAL_DEF_VARIABLE variable, v
 		/*  Stanley@BB.SD3 suggests 16K can get stable performance */
 		/*  The experiment was done on SDIO interface */
 		/*  coding by Lucas@20130730 */
-		*(u32 *)pval = MAX_AMPDU_FACTOR_16K;
+		*(u32 *)pval = IEEE80211_HT_MAX_AMPDU_16K;
 		break;
 	case HAL_DEF_TX_LDPC:
 	case HAL_DEF_RX_LDPC:
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 08abfb8ec4c7..718ee9eee87c 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1802,7 +1802,7 @@ static u8 GetHalDefVar8723BSDIO(
 	case HW_VAR_MAX_RX_AMPDU_FACTOR:
 		/*  Stanley@BB.SD3 suggests 16K can get stable performance */
 		/*  coding by Lucas@20130730 */
-		*(u32 *)pValue = MAX_AMPDU_FACTOR_16K;
+		*(u32 *)pValue = IEEE80211_HT_MAX_AMPDU_16K;
 		break;
 	default:
 		bResult = GetHalDefVar8723B(Adapter, eVariable, pValue);
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 181c29b73617..9c92b5020fbc 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -612,13 +612,6 @@ struct ADDBA_request {
 	__le16	BA_starting_seqctrl;
 }  __attribute__ ((packed));
 
-enum HT_CAP_AMPDU_FACTOR {
-	MAX_AMPDU_FACTOR_8K		= 0,
-	MAX_AMPDU_FACTOR_16K	= 1,
-	MAX_AMPDU_FACTOR_32K	= 2,
-	MAX_AMPDU_FACTOR_64K	= 3,
-};
-
 /* 802.11n HT capabilities masks */
 #define IEEE80211_HT_CAP_LDPC_CODING		0x0001
 #define IEEE80211_HT_CAP_SUP_WIDTH		0x0002
-- 
2.25.1

