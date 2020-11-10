Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507892ACE69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbgKJEKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 23:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbgKJEK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:10:27 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8015EC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 20:10:26 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p7so12333639ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 20:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0uJH20Y9PB94JSNsUBrDpUu5cXmjr476Na4wBZlVak=;
        b=G0dqbh2SWOkItZGekcxI4+wU+txdf2+3CqKFivXw0I/7gWkAbgW9xQtiHSZsHEW6mY
         wgiLWQkBIL6QTMDjgf0K6GPT4nw0HIIQLDb/wsL52yi/PJ3ievpt2/kDtasjibcg9yr4
         H54K1CiHE3qHpDj00CCzWPmR17a3LUYQKRljvxnJ9N5EFO5ulHEfc7++g2mZ5E0wLXIp
         PSJzLJZ7bqz4Kcr5iyE9AiXYQocIljXpjGJJU6korYt2tPBYV7JwfRpI9V019eGxpxAn
         WBSMEZYqqIr+slwwnj4HjYsNlM3QQiQaV8YBaYgSdIIZn+oH/cGfZj+7bNIwdNIYOxmy
         Vj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0uJH20Y9PB94JSNsUBrDpUu5cXmjr476Na4wBZlVak=;
        b=MEPq+Ois9UUXgzLvQasu1M6VzmODGdWiZ4LyX/YID0DATaHutchTZx61c21VKKMUTp
         U/2ZtO0FAvVO2C3/JlAUQ709+iJYIryyc/oOBH82UvZkvmolQiDfgCNmyrEn8X8EnwVI
         Xb2zDBj1oVx1ZLsIdX6m6NcApDEC46+koalxWsN/g1mvg4LyWPk/0AMhchLSBkJfihfJ
         HXDhTpl3FxD+urkg9SG4qr8OC+M+x86I4KQMk1VDEQZnGvvlMZFtsMCeHAi6yBUeURHb
         IucDOWiuy0rJzNTAQTXBrR2P1cmAY50UBRBsiGHxzfoP4tIVn7RMzjePPz6APS/5aDb9
         axFQ==
X-Gm-Message-State: AOAM533NkVM2s+qwZMMfMF1/vwI9c6HqKIX0Vuxzpj/CGEcMWBdV6fmh
        slERivNuSlAgB9b6qW6a3aM=
X-Google-Smtp-Source: ABdhPJy1jNOb/fUQKzPBckHscOzEWhJf5IzGAfno9RPj2+z0mQaKVhsLU9ZrLjx+rAJLJRQvd7r2TQ==
X-Received: by 2002:a6b:d907:: with SMTP id r7mr12849335ioc.37.1604981425945;
        Mon, 09 Nov 2020 20:10:25 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id e21sm6658842ioc.0.2020.11.09.20.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 20:10:25 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 06/10] staging: rtl8723bs: clean up switch case indentation
Date:   Mon,  9 Nov 2020 22:10:04 -0600
Message-Id: <20201110041008.15847-6-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110041008.15847-1-ross.schm.dev@gmail.com>
References: <20201110041008.15847-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move cases to align with switch indentation to fix coding style issues
and clear checkpatch errors.

ERROR: switch and case should be at the same indent

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 219 +++++++++---------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  14 +-
 2 files changed, 116 insertions(+), 117 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 783daa30f1d7..773e4816fbc4 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -664,49 +664,49 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 			pairwise_cipher = WPA_CIPHER_NONE;
 
 		switch (group_cipher) {
-			case WPA_CIPHER_NONE:
-				padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
-				break;
-			case WPA_CIPHER_WEP40:
-				padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-				break;
-			case WPA_CIPHER_TKIP:
-				padapter->securitypriv.dot118021XGrpPrivacy = _TKIP_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
-				break;
-			case WPA_CIPHER_CCMP:
-				padapter->securitypriv.dot118021XGrpPrivacy = _AES_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
-				break;
-			case WPA_CIPHER_WEP104:
-				padapter->securitypriv.dot118021XGrpPrivacy = _WEP104_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-				break;
+		case WPA_CIPHER_NONE:
+			padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
+			break;
+		case WPA_CIPHER_WEP40:
+			padapter->securitypriv.dot118021XGrpPrivacy = _WEP40_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
+			break;
+		case WPA_CIPHER_TKIP:
+			padapter->securitypriv.dot118021XGrpPrivacy = _TKIP_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
+			break;
+		case WPA_CIPHER_CCMP:
+			padapter->securitypriv.dot118021XGrpPrivacy = _AES_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
+			break;
+		case WPA_CIPHER_WEP104:
+			padapter->securitypriv.dot118021XGrpPrivacy = _WEP104_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
+			break;
 		}
 
 		switch (pairwise_cipher) {
-			case WPA_CIPHER_NONE:
-				padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
-				break;
-			case WPA_CIPHER_WEP40:
-				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-				break;
-			case WPA_CIPHER_TKIP:
-				padapter->securitypriv.dot11PrivacyAlgrthm = _TKIP_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
-				break;
-			case WPA_CIPHER_CCMP:
-				padapter->securitypriv.dot11PrivacyAlgrthm = _AES_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
-				break;
-			case WPA_CIPHER_WEP104:
-				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
-				padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
-				break;
+		case WPA_CIPHER_NONE:
+			padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
+			break;
+		case WPA_CIPHER_WEP40:
+			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
+			break;
+		case WPA_CIPHER_TKIP:
+			padapter->securitypriv.dot11PrivacyAlgrthm = _TKIP_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
+			break;
+		case WPA_CIPHER_CCMP:
+			padapter->securitypriv.dot11PrivacyAlgrthm = _AES_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
+			break;
+		case WPA_CIPHER_WEP104:
+			padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
+			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
+			break;
 		}
 
 		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
@@ -860,28 +860,27 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 	}
 
 	switch (wrqu->mode) {
-		case IW_MODE_AUTO:
-			networkType = Ndis802_11AutoUnknown;
-			DBG_871X("set_mode = IW_MODE_AUTO\n");
-			break;
-		case IW_MODE_ADHOC:
-			networkType = Ndis802_11IBSS;
-			DBG_871X("set_mode = IW_MODE_ADHOC\n");
-			break;
-		case IW_MODE_MASTER:
-			networkType = Ndis802_11APMode;
-			DBG_871X("set_mode = IW_MODE_MASTER\n");
-                        /* rtw_setopmode_cmd(padapter, networkType, true); */
-			break;
-		case IW_MODE_INFRA:
-			networkType = Ndis802_11Infrastructure;
-			DBG_871X("set_mode = IW_MODE_INFRA\n");
-			break;
-
-		default:
-			ret = -EINVAL;
-			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported \n", iw_operation_mode[wrqu->mode]));
-			goto exit;
+	case IW_MODE_AUTO:
+		networkType = Ndis802_11AutoUnknown;
+		DBG_871X("set_mode = IW_MODE_AUTO\n");
+		break;
+	case IW_MODE_ADHOC:
+		networkType = Ndis802_11IBSS;
+		DBG_871X("set_mode = IW_MODE_ADHOC\n");
+		break;
+	case IW_MODE_MASTER:
+		networkType = Ndis802_11APMode;
+		DBG_871X("set_mode = IW_MODE_MASTER\n");
+		/* rtw_setopmode_cmd(padapter, networkType, true); */
+		break;
+	case IW_MODE_INFRA:
+		networkType = Ndis802_11Infrastructure;
+		DBG_871X("set_mode = IW_MODE_INFRA\n");
+		break;
+	default:
+		ret = -EINVAL;
+		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("\n Mode: %s is not supported \n", iw_operation_mode[wrqu->mode]));
+		goto exit;
 	}
 
 /*
@@ -1342,50 +1341,50 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			section = *(pos++); len -= 1;
 
 			switch (section) {
-				case WEXT_CSCAN_SSID_SECTION:
-					/* DBG_871X("WEXT_CSCAN_SSID_SECTION\n"); */
-					if (len < 1) {
-						len = 0;
-						break;
-					}
+			case WEXT_CSCAN_SSID_SECTION:
+				/* DBG_871X("WEXT_CSCAN_SSID_SECTION\n"); */
+				if (len < 1) {
+					len = 0;
+					break;
+				}
 
-					sec_len = *(pos++); len -= 1;
+				sec_len = *(pos++); len -= 1;
 
-					if (sec_len > 0 && sec_len <= len) {
-						ssid[ssid_index].SsidLength = sec_len;
-						memcpy(ssid[ssid_index].Ssid, pos, ssid[ssid_index].SsidLength);
-						/* DBG_871X("%s COMBO_SCAN with specific ssid:%s, %d\n", __func__ */
-						/* 	, ssid[ssid_index].Ssid, ssid[ssid_index].SsidLength); */
-						ssid_index++;
-					}
+				if (sec_len > 0 && sec_len <= len) {
+					ssid[ssid_index].SsidLength = sec_len;
+					memcpy(ssid[ssid_index].Ssid, pos, ssid[ssid_index].SsidLength);
+					/* DBG_871X("%s COMBO_SCAN with specific ssid:%s, %d\n", __func__ */
+					/* 	, ssid[ssid_index].Ssid, ssid[ssid_index].SsidLength); */
+					ssid_index++;
+				}
 
-					pos += sec_len; len -= sec_len;
-					break;
+				pos += sec_len; len -= sec_len;
+				break;
 
 
-				case WEXT_CSCAN_CHANNEL_SECTION:
-					/* DBG_871X("WEXT_CSCAN_CHANNEL_SECTION\n"); */
-					pos += 1; len -= 1;
-					break;
-				case WEXT_CSCAN_ACTV_DWELL_SECTION:
-					/* DBG_871X("WEXT_CSCAN_ACTV_DWELL_SECTION\n"); */
-					pos += 2; len -= 2;
-					break;
-				case WEXT_CSCAN_PASV_DWELL_SECTION:
-					/* DBG_871X("WEXT_CSCAN_PASV_DWELL_SECTION\n"); */
-					pos += 2; len -= 2;
-					break;
-				case WEXT_CSCAN_HOME_DWELL_SECTION:
-					/* DBG_871X("WEXT_CSCAN_HOME_DWELL_SECTION\n"); */
-					pos += 2; len -= 2;
-					break;
-				case WEXT_CSCAN_TYPE_SECTION:
-					/* DBG_871X("WEXT_CSCAN_TYPE_SECTION\n"); */
-					pos += 1; len -= 1;
-					break;
-				default:
-					/* DBG_871X("Unknown CSCAN section %c\n", section); */
-					len = 0; /*  stop parsing */
+			case WEXT_CSCAN_CHANNEL_SECTION:
+				/* DBG_871X("WEXT_CSCAN_CHANNEL_SECTION\n"); */
+				pos += 1; len -= 1;
+				break;
+			case WEXT_CSCAN_ACTV_DWELL_SECTION:
+				/* DBG_871X("WEXT_CSCAN_ACTV_DWELL_SECTION\n"); */
+				pos += 2; len -= 2;
+				break;
+			case WEXT_CSCAN_PASV_DWELL_SECTION:
+				/* DBG_871X("WEXT_CSCAN_PASV_DWELL_SECTION\n"); */
+				pos += 2; len -= 2;
+				break;
+			case WEXT_CSCAN_HOME_DWELL_SECTION:
+				/* DBG_871X("WEXT_CSCAN_HOME_DWELL_SECTION\n"); */
+				pos += 2; len -= 2;
+				break;
+			case WEXT_CSCAN_TYPE_SECTION:
+				/* DBG_871X("WEXT_CSCAN_TYPE_SECTION\n"); */
+				pos += 1; len -= 1;
+				break;
+			default:
+				/* DBG_871X("Unknown CSCAN section %c\n", section); */
+				len = 0; /*  stop parsing */
 			}
 			/* DBG_871X("len:%d\n", len); */
 
@@ -1917,15 +1916,15 @@ static int rtw_wx_set_enc(struct net_device *dev,
 			DBG_871X("(keyindex_provided == 1), keyid =%d, key_len =%d\n", key, padapter->securitypriv.dot11DefKeylen[key]);
 
 			switch (padapter->securitypriv.dot11DefKeylen[key]) {
-				case 5:
-					padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
-					break;
-				case 13:
-					padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
-					break;
-				default:
-					padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
-					break;
+			case 5:
+				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
+				break;
+			case 13:
+				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
+				break;
+			default:
+				padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
+				break;
 			}
 
 			goto exit;
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index ed8212b7deb4..b62fe9238e6d 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -400,17 +400,17 @@ u16 rtw_recv_select_queue(struct sk_buff *skb)
 	memcpy(&eth_type, pdata + (ETH_ALEN << 1), 2);
 
 	switch (be16_to_cpu(eth_type)) {
-		case ETH_P_IP:
+	case ETH_P_IP:
 
-			piphdr = (struct iphdr *)(pdata + ETH_HLEN);
+		piphdr = (struct iphdr *)(pdata + ETH_HLEN);
 
-			dscp = piphdr->tos & 0xfc;
+		dscp = piphdr->tos & 0xfc;
 
-			priority = dscp >> 5;
+		priority = dscp >> 5;
 
-			break;
-		default:
-			priority = 0;
+		break;
+	default:
+		priority = 0;
 	}
 
 	return rtw_1d_to_queue[priority];
-- 
2.25.1

