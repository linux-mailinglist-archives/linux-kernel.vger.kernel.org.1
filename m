Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A226803B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgIMQZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIMQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:25:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607CAC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:25:40 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ay8so15218741edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJKJB6zX9XOaPugcfbZ/srCTJvZAJAvg0+wka4cvIMM=;
        b=Rqq2uW2bITTnA60MJmjJx6HRrP56zQ66+ZcWH+1uBierD6N3ddSOxA36uRPYOf4W0m
         wc04Gp3zW+4G08sb+CkpFlEYuIZbhFP9vALFM28zcCDWrmDgsyGd3azJZpaDdFY3pruu
         k5tF9/B934Ej5Qjxxh/t3ygVrP4BuezhZaYimcM+u6IPpIuxIYrMRkPtKxPkk1yp6mSF
         auPFl3YFMVMkplIFpaFWIhkJI0rcpH/V4r6uAGmJGQ/HXDQgyCAGSB843dgxD/+MY8sL
         CJ9AJmaI9qr2wgBxdGxS1dnXAIqn3A7NW8Bi97tUuflYacZoCPASlUCHKd+5gAzXb9ST
         TSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iJKJB6zX9XOaPugcfbZ/srCTJvZAJAvg0+wka4cvIMM=;
        b=HIV6afcld7Kz6p89aBbiQaSe7c6sV95foxM5DsGBPn/71hwvZ7HqsWZc9bizf3e2hp
         irTiy+IaDsAvvbi5ZTVrOjmIPCuY0ugp1zH5aYIyGZZfaGjTFhdGtMznGrb+iJzo7tYz
         dNjr3fodQ9T6Ttvr79jpWyeZrYqZ68zb5S6hFET1nZVhy4uwGW017WfrsQpFIIzV9eOE
         AEEg7sWZmr5+qtdQLc0NUiVcCgYWT4s1aVrptkBQ+CnrvlIdoYmS+Qwf93AxDgpZ6K5P
         DKoEguTot4qGUV6CHYn9bXg8xjNQ+3jzU8rIDYgWcvyqsR+SeeUQ8V7FL69g/weuFzDN
         s3Iw==
X-Gm-Message-State: AOAM533nINp6UUejH7N130TWF+VhjHz0SsV+piC2O1h/xDJRcbLzKePf
        l7gRjUOalst6v0FTNTyEKo8=
X-Google-Smtp-Source: ABdhPJxp9tV3oj6RzynqOBx3JEx7NY3drYT+vpbjf3SUFqz6QrO1OespSAjQblNz/IMLJ1xigf9Jug==
X-Received: by 2002:a05:6402:10d3:: with SMTP id p19mr13808570edu.380.1600014338977;
        Sun, 13 Sep 2020 09:25:38 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-100.092.219.pools.vodafone-ip.de. [92.219.207.100])
        by smtp.gmail.com with ESMTPSA id w19sm7163505edt.22.2020.09.13.09.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 09:25:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: remove cckrates{only}_included()
Date:   Sun, 13 Sep 2020 18:22:05 +0200
Message-Id: <20200913162206.19477-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rtw_ieee80211.c there are rtw_is_cckrates_included() and
rtw_is_cckratesonly_included() which have the same functionality as
cckrates_included() and cckrates_only_included() defined in
rtw_wlan_util.c. Remove the functions from rtw_wlan_util.c and use
those from rtw_ieee80211.c. Remove the now unused variable ratelen.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 34 ++-----------------
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 --
 2 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a5790a648a5b..6cb779bc9410 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -54,32 +54,6 @@ static u8 rtw_basic_rate_ofdm[3] = {
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-int cckrates_included(unsigned char *rate, int ratelen)
-{
-	int	i;
-
-	for (i = 0; i < ratelen; i++) {
-		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
-			return true;
-	}
-
-	return false;
-}
-
-int cckratesonly_included(unsigned char *rate, int ratelen)
-{
-	int	i;
-
-	for (i = 0; i < ratelen; i++) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
-			return false;
-	}
-
-	return true;
-}
-
 u8 networktype_to_raid_ex(struct adapter *adapter, struct sta_info *psta)
 {
 	u8 raid, cur_rf_type, rf_type = RF_1T1R;
@@ -1740,15 +1714,13 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
 
 void update_wireless_mode(struct adapter *padapter)
 {
-	int ratelen, network_type = 0;
+	int network_type = 0;
 	u32 SIFS_Timer;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
 	unsigned char 		*rate = cur_network->SupportedRates;
 
-	ratelen = rtw_get_rateset_len(cur_network->SupportedRates);
-
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable))
 		pmlmeinfo->HT_enable = 1;
 
@@ -1765,9 +1737,9 @@ void update_wireless_mode(struct adapter *padapter)
 		else if (pmlmeinfo->HT_enable)
 			network_type = WIRELESS_11_24N;
 
-		if ((cckratesonly_included(rate, ratelen)) == true)
+		if (rtw_is_cckratesonly_included(rate))
 			network_type |= WIRELESS_11B;
-		else if ((cckrates_included(rate, ratelen)) == true)
+		else if (rtw_is_cckrates_included(rate))
 			network_type |= WIRELESS_11BG;
 		else
 			network_type |= WIRELESS_11G;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 14583799039f..1567831caf91 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -716,8 +716,6 @@ void sa_query_timer_hdl(struct timer_list *t);
 		DBG_871X("%s set_sa_query_timer(%p, %d)\n", __func__, (mlmeext), (ms)); \
 		_set_timer(&(mlmeext)->sa_query_timer, (ms)); \
 	} while (0)
-extern int cckrates_included(unsigned char *rate, int ratelen);
-extern int cckratesonly_included(unsigned char *rate, int ratelen);
 
 extern void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
 
-- 
2.28.0

