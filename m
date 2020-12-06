Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A642D0077
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 05:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLFEP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 23:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgLFEPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:15:13 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1AC0613D1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 20:14:27 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 19so1983605qkm.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 20:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n2vbuSsWUEhStVURfBEd2z7J0jw1E1fuEExHKYsUcSA=;
        b=UPJqbOPfBpqNMS86b3EJ3lb4aWlc9NZ0000ieUf36AFdheFoYEXZ5xBnELg43Euy93
         /ZlS/nC03PX4Po1VNUuhu0JQEo8PIASKDAgE2TSwAFQf78R9O9Mdl3UvVd2ZbhEHM0EL
         w4WfMgSXpwIYqKt1ArwaO5axgUMLVk4+HT9yw018wK5IvfG4DWzCCjmoQIRnIFhPBYeb
         yv6p6r/D+OFAHI36ax5SpWIqE/KE8EOPug40Xz96q6H8Xax8y6+mDjXFtlPjpWC+6QL6
         UOC8qPe5KYTiBdiKdrq8xtSOQ3IfBxl89mxdV6NfydNcf9ch82MkO3fcq7b2xHzzlNVB
         WRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2vbuSsWUEhStVURfBEd2z7J0jw1E1fuEExHKYsUcSA=;
        b=WJplGPEG57esMepKRFy/piArMeZv+JDWpoBpBTKmQNB8+PFaJcgXKzUaA4yAvcOF+4
         SjCMMwBKQLkKGxA1isE/4JB5KW6W87vT5i8SpQCLXAvDoL78dPlOWAfjmQg7LECvvxee
         jgtjmblbn+szTCqz+MTigGPxeN2YQD7Qj452b8ZhZTgnPfTtfNemH//dWlGi94nEjyvO
         /fVIjgQU2OfStaWJ1Drp2pcCs90YEZOwDlVTZFfAvwB2EZzC8Zk0sowfuW4/ijg9Ectg
         XkGt7W+I/zdCreYpIpxEql/ke149OuQnW2kHJmf00hK1/BYfPgqey1vh28417aXeFj3x
         WDWA==
X-Gm-Message-State: AOAM531eVmGrLJSpz74gziBQTS/sEELWaqrEs8Ibds/w56f8D7FfLltn
        /TfFiGI44DPfPX5nl+sy5ZMKTLSX350=
X-Google-Smtp-Source: ABdhPJxVira4gNXnvMwMdYDd5zPRnbBNl91c95g8skS1DXo17mbu03rJW4chwHgkhkk+xCoNw1Y/ow==
X-Received: by 2002:a02:856d:: with SMTP id g100mr277534jai.10.1607226325931;
        Sat, 05 Dec 2020 19:45:25 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id v63sm3908553ioe.52.2020.12.05.19.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 19:45:25 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 03/10] staging: rtl8723bs: replace cap_* macros
Date:   Sat,  5 Dec 2020 21:45:10 -0600
Message-Id: <20201206034517.4276-3-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201206034517.4276-1-ross.schm.dev@gmail.com>
References: <20201206034517.4276-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique cap_* macros with kernel provided WLAN_CAPABILITY_*
macros.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c        |  2 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |  6 +++---
 drivers/staging/rtl8723bs/core/rtw_mlme.c      |  4 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  | 12 ++++++------
 drivers/staging/rtl8723bs/include/ieee80211.h  |  4 ----
 drivers/staging/rtl8723bs/include/wifi.h       | 12 ------------
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c |  4 ++--
 7 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index a2b39ae56d89..984b9f5a83ac 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1980,7 +1980,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 		}
 	}
 
-	if (!(psta->capability & WLAN_CAPABILITY_SHORT_SLOT)) {
+	if (!(psta->capability & WLAN_CAPABILITY_SHORT_SLOT_TIME)) {
 		if (!psta->no_short_slot_time_set) {
 			psta->no_short_slot_time_set = 1;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 8d61be5bd250..e80b957f947f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -314,13 +314,13 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	/* capability info */
 	*(u16 *)ie = 0;
 
-	*(__le16 *)ie |= cpu_to_le16(cap_IBSS);
+	*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_IBSS);
 
 	if (pregistrypriv->preamble == PREAMBLE_SHORT)
-		*(__le16 *)ie |= cpu_to_le16(cap_ShortPremble);
+		*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE);
 
 	if (pdev_network->Privacy)
-		*(__le16 *)ie |= cpu_to_le16(cap_Privacy);
+		*(__le16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
 	sz += 2;
 	ie += 2;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 351178ab78c5..001cce312f05 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -424,8 +424,8 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 			((!memcmp(src->Ssid.Ssid, dst->Ssid.Ssid, src->Ssid.SsidLength))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
-			((s_cap & WLAN_CAPABILITY_BSS) ==
-			(d_cap & WLAN_CAPABILITY_BSS));
+			((s_cap & WLAN_CAPABILITY_ESS) ==
+			(d_cap & WLAN_CAPABILITY_ESS));
 
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 6dab68033941..239c89ce7dc9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4600,7 +4600,7 @@ void start_create_ibss(struct adapter *padapter)
 	/* update capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
-	if (caps&cap_IBSS) {/* adhoc master */
+	if (caps&WLAN_CAPABILITY_IBSS) {/* adhoc master */
 		val8 = 0xcf;
 		rtw_hal_set_hwreg(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
 
@@ -4655,7 +4655,7 @@ void start_clnt_join(struct adapter *padapter)
 	/* update capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
-	if (caps&cap_ESS) {
+	if (caps&WLAN_CAPABILITY_ESS) {
 		Set_MSR(padapter, WIFI_FW_STATION_STATE);
 
 		val8 = (pmlmeinfo->auth_algo == dot11AuthAlgrthm_8021X) ? 0xcc : 0xcf;
@@ -4681,7 +4681,7 @@ void start_clnt_join(struct adapter *padapter)
 			(REAUTH_TO * REAUTH_LIMIT) + (REASSOC_TO*REASSOC_LIMIT) + beacon_timeout);
 
 		pmlmeinfo->state = WIFI_FW_AUTH_NULL | WIFI_FW_STATION_STATE;
-	} else if (caps&cap_IBSS) { /* adhoc client */
+	} else if (caps&WLAN_CAPABILITY_IBSS) { /* adhoc client */
 		Set_MSR(padapter, WIFI_FW_ADHOC_STATE);
 
 		val8 = 0xcf;
@@ -5952,9 +5952,9 @@ static int rtw_auto_ap_start_beacon(struct adapter *adapter)
 
 	/* capability info */
 	*(u16 *)ie = 0;
-	*(u16 *)ie |= cpu_to_le16(cap_ESS);
-	*(u16 *)ie |= cpu_to_le16(cap_ShortPremble);
-	/* u16*)ie |= cpu_to_le16(cap_Privacy); */
+	*(u16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_ESS);
+	*(u16 *)ie |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE);
+	/* u16*)ie |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY); */
 	sz += 2;
 	ie += 2;
 
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index c095ffba0f27..79c410cfadba 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -343,10 +343,6 @@ struct ieee80211_snap_hdr {
 #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTW_IEEE80211_SCTL_FRAG)
 #define WLAN_GET_SEQ_SEQ(seq)  ((seq) & RTW_IEEE80211_SCTL_SEQ)
 
-/* Authentication algorithms */
-#define WLAN_CAPABILITY_BSS (1<<0)
-#define WLAN_CAPABILITY_SHORT_SLOT (1<<10)
-
 /* Reason codes */
 #define WLAN_REASON_ACTIVE_ROAM 65533
 #define WLAN_REASON_JOIN_WRONG_CHANNEL       65534
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index fe9c3a4ffe7f..181c29b73617 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -516,18 +516,6 @@ enum ELEMENT_ID {
 #define WLAN_ETHCONV_RFC1042	2
 #define WLAN_ETHCONV_8021h		3
 
-#define cap_ESS BIT(0)
-#define cap_IBSS BIT(1)
-#define cap_CFPollable BIT(2)
-#define cap_CFRequest BIT(3)
-#define cap_Privacy BIT(4)
-#define cap_ShortPremble BIT(5)
-#define cap_PBCC	BIT(6)
-#define cap_ChAgility	BIT(7)
-#define cap_SpecMgmt	BIT(8)
-#define cap_QoS	BIT(9)
-#define cap_ShortSlot	BIT(10)
-
 /*-----------------------------------------------------------------------------
 				Below is the definition for 802.11i / 802.1x
 ------------------------------------------------------------------------------*/
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 6c38eb239381..51cf3f4c046f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -163,8 +163,8 @@ static char *translate_scan(struct adapter *padapter,
 		cap = le16_to_cpu(le_tmp);
 	}
 
-	if (cap & (WLAN_CAPABILITY_IBSS | WLAN_CAPABILITY_BSS)) {
-		if (cap & WLAN_CAPABILITY_BSS)
+	if (cap & (WLAN_CAPABILITY_IBSS | WLAN_CAPABILITY_ESS)) {
+		if (cap & WLAN_CAPABILITY_ESS)
 			iwe.u.mode = IW_MODE_MASTER;
 		else
 			iwe.u.mode = IW_MODE_ADHOC;
-- 
2.25.1

