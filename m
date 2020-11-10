Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23C72ACE62
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbgKJEKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 23:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbgKJEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:10:31 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7471C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 20:10:30 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y9so3425259ilb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 20:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URaf68lAYo+ZaDEToPZX/uqKN/VjHuBVv8pd0QncFx0=;
        b=QHuq7z+R+XpgCJRof0KVttEN08LdNP15vn/AVFyIphfe6+NEKDLyvVHLnBmqLTmYSk
         deGXaidC6argTUT/iCWH/0KjJJ0wRn5VNUUfd3h66FsQkXDJ9DjinqiBoiA4T9jEG2+3
         ABZ5uSXVJzSwlgkaYzvMxjEmjLoysv059aBAR31yoFHdTaTfQ6trc2E+TQMgKqxHOEwx
         lnQdy/jiSr7z7yVKKaUUoPBrWOuRdQXOZaWD/qVMEvLrvxpOocXlJDv1XRJcAj8xCcE5
         sSF58uF3ZpOFVZjOrbY5RIUjS5t29si4kfTD9AXuWnyyAeGq9VrDNKxXqdnQuJg+/tRu
         Qkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URaf68lAYo+ZaDEToPZX/uqKN/VjHuBVv8pd0QncFx0=;
        b=WRWM3vAOxz99Qo7jZsfz/aQDdOLvl/PrQ/uCdB3Y86tY4POJuMQFpnp5k3qYHzgCtE
         r5K74e0BJDJlco+Ub5ayjR1WVGDfaCqUt+qgP2fsGqbl0l69gUe9yrsQ/Sn0ODekDLLx
         tePVSAb6PJCNX3t/z1yEKRBgpMWrbYn10DgRQ5k/R/sIvwrhnSECKfhjzAstJDh6FV/M
         UUTbO0ya15EaX2xZBt76IZlfyH0U1apdODC4rKm5qjSIkr6FSqXnd99zPWp5mU8phrUW
         vNSUM/OhvQe7SfVAL0Y8B3nGJtSi2cilJ+4Kau6webRTXXbIH3hVY62uR+Ud0b3dgQF6
         UAcQ==
X-Gm-Message-State: AOAM530TjyNWg5VaWEa/nmYYSS6TGcC2caHk1b9H1F26ejwtF2muzakp
        siUqMZkUBxk8phOYOvfjrG3Kcw9+ekI=
X-Google-Smtp-Source: ABdhPJylhnYKcukqRX+wuTikJC6+MBuNQUURgrDwertAeIKcw0iDCcXibzmNWV2hXtnz/YVglR8VFg==
X-Received: by 2002:a92:1f8d:: with SMTP id f13mr13512381ilf.77.1604981430333;
        Mon, 09 Nov 2020 20:10:30 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id e21sm6658842ioc.0.2020.11.09.20.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 20:10:29 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 10/10] staging: rtl8723bs: clean up leading space
Date:   Mon,  9 Nov 2020 22:10:08 -0600
Message-Id: <20201110041008.15847-10-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110041008.15847-1-ross.schm.dev@gmail.com>
References: <20201110041008.15847-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert spaces to tabs to fix coding style issues and clear checkpatch
warnings.

WARNING: please, no spaces at the start of a line

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 80 +++++++++----------
 .../staging/rtl8723bs/os_dep/osdep_service.c  |  2 +-
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 294c4f406fcc..6c38eb239381 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -985,23 +985,23 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 		    if (psecuritypriv->PMKIDIndex == 16)
 		        psecuritypriv->PMKIDIndex = 0;
 		}
-        } else if (pPMK->cmd == IW_PMKSA_REMOVE) {
-                DBG_871X("[rtw_wx_set_pmkid] IW_PMKSA_REMOVE!\n");
-                intReturn = true;
+	} else if (pPMK->cmd == IW_PMKSA_REMOVE) {
+		DBG_871X("[rtw_wx_set_pmkid] IW_PMKSA_REMOVE!\n");
+		intReturn = true;
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
 				/*  BSSID is matched, the same AP => Remove this PMKID information and reset it. */
-                                eth_zero_addr(psecuritypriv->PMKIDList[j].Bssid);
-                                psecuritypriv->PMKIDList[j].bUsed = false;
+				eth_zero_addr(psecuritypriv->PMKIDList[j].Bssid);
+				psecuritypriv->PMKIDList[j].bUsed = false;
 				break;
 			}
 	        }
-        } else if (pPMK->cmd == IW_PMKSA_FLUSH) {
-            DBG_871X("[rtw_wx_set_pmkid] IW_PMKSA_FLUSH!\n");
-            memset(&psecuritypriv->PMKIDList[0], 0x00, sizeof(RT_PMKID_LIST) * NUM_PMKID_CACHE);
-            psecuritypriv->PMKIDIndex = 0;
-            intReturn = true;
-        }
+	} else if (pPMK->cmd == IW_PMKSA_FLUSH) {
+		DBG_871X("[rtw_wx_set_pmkid] IW_PMKSA_FLUSH!\n");
+		memset(&psecuritypriv->PMKIDList[0], 0x00, sizeof(RT_PMKID_LIST) * NUM_PMKID_CACHE);
+		psecuritypriv->PMKIDIndex = 0;
+		intReturn = true;
+	}
 	return intReturn;
 }
 
@@ -2222,8 +2222,8 @@ static int rtw_wx_get_nick(struct net_device *dev,
 }
 
 static int rtw_wx_read32(struct net_device *dev,
-                            struct iw_request_info *info,
-                            union iwreq_data *wrqu, char *extra)
+			 struct iw_request_info *info,
+			 union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter;
 	struct iw_point *p;
@@ -2282,8 +2282,8 @@ static int rtw_wx_read32(struct net_device *dev,
 }
 
 static int rtw_wx_write32(struct net_device *dev,
-                            struct iw_request_info *info,
-                            union iwreq_data *wrqu, char *extra)
+			  struct iw_request_info *info,
+			  union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
@@ -2319,8 +2319,8 @@ static int rtw_wx_write32(struct net_device *dev,
 }
 
 static int rtw_wx_read_rf(struct net_device *dev,
-                            struct iw_request_info *info,
-                            union iwreq_data *wrqu, char *extra)
+			  struct iw_request_info *info,
+			  union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	u32 path, addr, data32;
@@ -2340,8 +2340,8 @@ static int rtw_wx_read_rf(struct net_device *dev,
 }
 
 static int rtw_wx_write_rf(struct net_device *dev,
-                            struct iw_request_info *info,
-                            union iwreq_data *wrqu, char *extra)
+			   struct iw_request_info *info,
+			   union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	u32 path, addr, data32;
@@ -2375,8 +2375,8 @@ static int dummy(struct net_device *dev, struct iw_request_info *a,
 }
 
 static int rtw_wx_set_channel_plan(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+				   struct iw_request_info *info,
+				   union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	u8 channel_plan_req = (u8)(*((int *)wrqu));
@@ -2425,8 +2425,8 @@ static  int rtw_drvext_hdl(struct net_device *dev, struct iw_request_info *info,
 }
 
 static int rtw_get_ap_info(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+			   struct iw_request_info *info,
+			   union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
 	int wpa_ielen;
@@ -2523,8 +2523,8 @@ static int rtw_get_ap_info(struct net_device *dev,
 }
 
 static int rtw_set_pid(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+		       struct iw_request_info *info,
+		       union iwreq_data *wrqu, char *extra)
 {
 
 	int ret = 0;
@@ -2552,8 +2552,8 @@ static int rtw_set_pid(struct net_device *dev,
 }
 
 static int rtw_wps_start(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+			 struct iw_request_info *info,
+			 union iwreq_data *wrqu, char *extra)
 {
 
 	int ret = 0;
@@ -2582,8 +2582,8 @@ static int rtw_wps_start(struct net_device *dev,
 }
 
 static int rtw_p2p_set(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+		       struct iw_request_info *info,
+		       union iwreq_data *wrqu, char *extra)
 {
 
 	return 0;
@@ -2591,8 +2591,8 @@ static int rtw_p2p_set(struct net_device *dev,
 }
 
 static int rtw_p2p_get(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+		       struct iw_request_info *info,
+		       union iwreq_data *wrqu, char *extra)
 {
 
 	return 0;
@@ -2609,8 +2609,8 @@ static int rtw_p2p_get2(struct net_device *dev,
 }
 
 static int rtw_rereg_nd_name(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(dev);
@@ -2658,8 +2658,8 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 }
 
 static int rtw_dbg_port(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+			struct iw_request_info *info,
+			union iwreq_data *wrqu, char *extra)
 {
 	u8 major_cmd, minor_cmd;
 	u16 arg;
@@ -3014,7 +3014,7 @@ static int rtw_dbg_port(struct net_device *dev,
 							pregistrypriv->ldpc_cap = (u8)(extra_arg&0x33);
 						}
 					}
-                                        break;
+					break;
 				case 0x1a:
 					{
 						struct registry_priv *pregistrypriv = &padapter->registrypriv;
@@ -3029,7 +3029,7 @@ static int rtw_dbg_port(struct net_device *dev,
 							pregistrypriv->stbc_cap = (u8)(extra_arg&0x33);
 						}
 					}
-                                        break;
+					break;
 				case 0x1b:
 					{
 						struct registry_priv *pregistrypriv = &padapter->registrypriv;
@@ -3065,7 +3065,7 @@ static int rtw_dbg_port(struct net_device *dev,
 							}
 						}
 					}
-                                        break;
+					break;
 				case 0x1c: /* enable/disable driver control AMPDU Density for peer sta's rx */
 					{
 						if (arg == 0) {
@@ -4409,8 +4409,8 @@ static int rtw_wx_set_priv(struct net_device *dev,
 }
 
 static int rtw_pm_set(struct net_device *dev,
-                               struct iw_request_info *info,
-                               union iwreq_data *wrqu, char *extra)
+		      struct iw_request_info *info,
+		      union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
 	unsigned	mode = 0;
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index f61ad9200960..3c71d2fafabf 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -272,7 +272,7 @@ void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 	if (rtw_cbuf_empty(cbuf))
 		return NULL;
 
-        DBG_871X("%s on %u\n", __func__, cbuf->read);
+	DBG_871X("%s on %u\n", __func__, cbuf->read);
 	buf = cbuf->bufs[cbuf->read];
 	cbuf->read = (cbuf->read + 1) % cbuf->size;
 
-- 
2.25.1

