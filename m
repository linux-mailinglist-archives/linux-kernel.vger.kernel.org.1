Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B426C2D21CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgLHEJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgLHEJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:02 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1600C061285
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:48 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n4so15628009iow.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=998/RAMpBFAw+nXnsxaqoKJ9xKsScbi5lvuf7EPxM+Q=;
        b=Jn/vMcOZQn+CXLXoYxtlNWmEoAMNYX0WoEoVQWn/UrizI3hcJc836lc38WIJl/x6Bp
         IFUuwcTj8dyYqvoNN74dA/UNUFXKH8pFIKaaYJMsKicCL/2b59DkhSVzS9y2Zjef+c3e
         aB+8IzkVmmDvJoxAQbe2tDI0H4qizkskDJkdr2gzbFjAYd+nn2HFvxbQarbnKPLs9iiD
         kFZiYaKMIcCVT4SWHZ82Jlnd/xgtuPquitUY/lxr+GE2isBv59vP9RA2tgDcuZhkboHh
         TYNKbIoqGtRt+wupm1CtHUlOGozypXW1HU1kH9M72P2jaejpoMPPdrPCJEAQfyKOJgKR
         74Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=998/RAMpBFAw+nXnsxaqoKJ9xKsScbi5lvuf7EPxM+Q=;
        b=GLH9K5BA3xA4AHXCRsohp1xzm+MBJQKrcGGYl1q5OWbnRZfqcd2oE9PjMxoXLUrDmK
         whCKAdIOcp/U+AOvQ1oektU63ZwmGZQPauxrenSRkIp6tNhnuHReYHmEpnOO1DJaYYei
         zVhxvqdUnmGkYWpA0hya19rAWwWdJQRpYVeUZQDqtl1VvebvDXF19tSPH2/LMx+d5EOc
         WmcYyfydIHoO1SGZAe+WMKZXVVudqWOoDAsHqT5eYmsyQwH3aE5D+IIYtiLH7BiDmrxH
         4UYKkd4JrC2E869HOr11LosCuzroK427/zlv0GElIqLHznS2p1BFx/l6MKfBysCTLPpP
         H+Iw==
X-Gm-Message-State: AOAM5336pSEsMw3kIz7qOKM/xCq9FAvlrX3a0iXjhCgqPU96MfjU/wc3
        hUWD/2ulre478lrPfaWQZZs=
X-Google-Smtp-Source: ABdhPJyNpUHQSu9mb5ve1RkmxOJlflCJAi93SkPMC7qbKkrLnkKrH3xq/SeNSjV+I7zAcJ3CHL7ZJw==
X-Received: by 2002:a02:969a:: with SMTP id w26mr24834336jai.96.1607400468204;
        Mon, 07 Dec 2020 20:07:48 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:47 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 09/21] staging: rtl8723bs: replace _TIM_IE_
Date:   Mon,  7 Dec 2020 22:07:21 -0600
Message-Id: <20201208040733.379197-10-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _TIM_IE_ macro with kernel provided WLAN_EID_DS_PARAMS
from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c   | 10 +++++-----
 drivers/staging/rtl8723bs/core/rtw_cmd.c  |  2 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_xmit.c |  8 ++++----
 drivers/staging/rtl8723bs/include/wifi.h  |  1 -
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 1514975f23bc..139350288d1b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -76,7 +76,7 @@ static void update_BCNTIM(struct adapter *padapter)
 
 		p = rtw_get_ie(
 			pie + _FIXED_IE_LENGTH_,
-			_TIM_IE_,
+			WLAN_EID_TIM,
 			&tim_ielen,
 			pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
 		);
@@ -133,7 +133,7 @@ static void update_BCNTIM(struct adapter *padapter)
 				memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 		}
 
-		*dst_ie++ = _TIM_IE_;
+		*dst_ie++ = WLAN_EID_TIM;
 
 		if ((pstapriv->tim_bitmap & 0xff00) && (pstapriv->tim_bitmap & 0x00fe))
 			tim_ielen = 5;
@@ -301,7 +301,7 @@ void expire_timeout_chk(struct adapter *padapter)
 
 					/* to update bcn with tim_bitmap for this station */
 					pstapriv->tim_bitmap |= BIT(psta->aid);
-					update_beacon(padapter, _TIM_IE_, NULL, true);
+					update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 
 					if (!pmlmeext->active_keep_alive_check)
 						continue;
@@ -922,7 +922,7 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	);
 
 	if (pmlmeext->bstart_bss) {
-		update_beacon(padapter, _TIM_IE_, NULL, true);
+		update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 
 #ifndef CONFIG_INTERRUPT_BASED_TXBCN /* other case will  tx beacon when bcn interrupt coming in. */
 		/* issue beacon frame */
@@ -1762,7 +1762,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 		break;
 
-	case _TIM_IE_:
+	case WLAN_EID_TIM:
 
 		update_BCNTIM(padapter);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 1d0a7690acde..3fe79169a811 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1703,7 +1703,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 			pstapriv->sta_dz_bitmap &= ~BIT(0);
 
 			if (update_tim)
-				update_beacon(padapter, _TIM_IE_, NULL, true);
+				update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 		} else {/* re check again */
 			rtw_chk_hi_queue_cmd(padapter);
 		}
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 2bb501f2113c..3c9dbd7443d9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1158,7 +1158,7 @@ sint validate_recv_ctrl_frame(struct adapter *padapter, union recv_frame *precv_
 
 					/* update BCN for TIM IE */
 					/* update_BCNTIM(padapter); */
-					update_beacon(padapter, _TIM_IE_, NULL, true);
+					update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 				}
 
 				/* spin_unlock_bh(&psta->sleep_q.lock); */
@@ -1184,7 +1184,7 @@ sint validate_recv_ctrl_frame(struct adapter *padapter, union recv_frame *precv_
 
 					/* update BCN for TIM IE */
 					/* update_BCNTIM(padapter); */
-					update_beacon(padapter, _TIM_IE_, NULL, true);
+					update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 				}
 			}
 		}
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index f9ef7dc84e55..1d62ce501e80 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -2251,7 +2251,7 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 			pstapriv->sta_dz_bitmap |= BIT(0);
 
 			if (update_tim)
-				update_beacon(padapter, _TIM_IE_, NULL, true);
+				update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 			else
 				chk_bmc_sleepq_cmd(padapter);
 
@@ -2308,7 +2308,7 @@ sint xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fr
 
 				if (update_tim)
 					/* update BCN for TIM IE */
-					update_beacon(padapter, _TIM_IE_, NULL, true);
+					update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 			}
 
 			ret = true;
@@ -2516,7 +2516,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	if (update_mask)
-		update_beacon(padapter, _TIM_IE_, NULL, true);
+		update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 }
 
 void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *psta)
@@ -2579,7 +2579,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
 			pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-			update_beacon(padapter, _TIM_IE_, NULL, true);
+			update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 		}
 	}
 
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index b29762bfb3c1..dc11ba28d469 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -387,7 +387,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
-#define _TIM_IE_					5
 #define _IBSS_PARA_IE_			6
 #define _COUNTRY_IE_			7
 #define _CHLGETXT_IE_			16
-- 
2.25.1

