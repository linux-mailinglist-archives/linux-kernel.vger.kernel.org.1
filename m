Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AFF27BD25
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgI2Gcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgI2Gcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:32:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E5BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p15so13341082ejm.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVwxc8ndQaD/53nLnA0xKVBBpacv1lNmzl4Zof5kji8=;
        b=DNNuRhInba/4/S9uXXATHAJ81HKmabpNb3dAB3tQsn++pIFuckakqaAb1Z2PSaY2Oy
         da+8xzUwwLUR3NrZkrY63+pEkQ9aqFaoO1le645QPgqBbmolggoek/nNDvRbnpx0EP4a
         1L1VXJ2jdYujML50C+c89ExdedtZqN1F+U3MDpSjOPd9FlLl6XXUlQ4+YGbhR0lYi4dn
         D0n5si1oIfzGOspG7SGEO+SJPDeOKJDqEWwT2IrfO6fJENoOfheXTMzWSbPQ2il1updI
         ZtMShFQf6Wc33ibpoiEHNk+VKcT9uKSN9c6jzHLT/G2UvpRoDJoOmE+4CaI1BMXZ9zRQ
         8giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVwxc8ndQaD/53nLnA0xKVBBpacv1lNmzl4Zof5kji8=;
        b=M4m8oxSHcTYy8ucwjdWtqGeqwrpMRKawH+Z/oVT2cYLIv7NKhoXx8h3GW4jInd/UnI
         unEBmtFaN+e5vZq1qfz1dRdzYuPdL0FIm+/CUbsWnTU0ZXDtUX0nciQPRsEnTvNpwPfa
         7sLqntboI23uJIJWXr5FbGxg/yZQwNM/FqfuSw4ZHAiibalSnJ2YnPYrAS10v1trZNWb
         sz988GNLHmFq1FZ520QiyEPfeq7NV+fORq274f5QnVUzm4iWofOprxA5Ooxmn8D+4Z+E
         yKMCE1dHbJl0qN6XgWXAOLgJZdf+NOpCvXbtcQLY7t1epS4X1eW8j9oBK5VmS+ZSI5X+
         KXVw==
X-Gm-Message-State: AOAM53111L0fQFYJl4JxETKlBfnEXYSnGOOaVDgJPW8V6HjjmWxsAd6O
        1qnuzgKodieFjszgjTJPhQY=
X-Google-Smtp-Source: ABdhPJzvk71Z74y6T2T8jE1SL01xsyTX5syZh5fRHQC2WrdsOix3QeHWXY83uDLkJJwMB7uOishRdw==
X-Received: by 2002:a17:906:2290:: with SMTP id p16mr594848eja.104.1601361157269;
        Mon, 28 Sep 2020 23:32:37 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id r8sm4730915edy.87.2020.09.28.23.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:32:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: rtl8188eu: remove cckrates{only}_included()
Date:   Tue, 29 Sep 2020 08:28:45 +0200
Message-Id: <20200929062847.23985-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929062847.23985-1-straube.linux@gmail.com>
References: <20200929062847.23985-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rtw_ieee80211.c there are rtw_is_cckrates_included() and
rtw_is_cckratesonly_included() which have the same functionality as
cckrates_included() and cckrates_only_included() defined in
rtw_wlan_util.c. Remove the functions from rtw_wlan_util.c and use
those from rtw_ieee80211.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 34 +++----------------
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |  3 --
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index efe1f1ba7acf..bf7dd13dde03 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -53,32 +53,6 @@ static const u8 rtw_basic_rate_mix[7] = {
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-bool cckrates_included(unsigned char *rate, int ratelen)
-{
-	int i;
-
-	for (i = 0; i < ratelen; i++) {
-		u8 r = rate[i] & 0x7f;
-
-		if (r == 2 || r == 4 || r == 11 || r == 22)
-			return true;
-	}
-	return false;
-}
-
-bool cckratesonly_included(unsigned char *rate, int ratelen)
-{
-	int i;
-
-	for (i = 0; i < ratelen; i++) {
-		u8 r = rate[i] & 0x7f;
-
-		if (r != 2 && r != 4 && r != 11 && r != 22)
-			return false;
-	}
-	return true;
-}
-
 unsigned char networktype_to_raid(unsigned char network_type)
 {
 	switch (network_type) {
@@ -111,9 +85,9 @@ u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen
 	if (pmlmeinfo->HT_enable)
 		network_type = WIRELESS_11_24N;
 
-	if (cckratesonly_included(rate, ratelen))
+	if (rtw_is_cckratesonly_included(rate))
 		network_type |= WIRELESS_11B;
-	else if (cckrates_included(rate, ratelen))
+	else if (rtw_is_cckrates_included(rate))
 		network_type |= WIRELESS_11BG;
 	else
 		network_type |= WIRELESS_11G;
@@ -1362,9 +1336,9 @@ void update_wireless_mode(struct adapter *padapter)
 	if (pmlmeinfo->HT_enable)
 		network_type = WIRELESS_11_24N;
 
-	if (cckratesonly_included(rate, ratelen))
+	if (rtw_is_cckratesonly_included(rate))
 		network_type |= WIRELESS_11B;
-	else if (cckrates_included(rate, ratelen))
+	else if (rtw_is_cckrates_included(rate))
 		network_type |= WIRELESS_11BG;
 	else
 		network_type |= WIRELESS_11G;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 565bfe46256c..713e23229ef5 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -568,9 +568,6 @@ void addba_timer_hdl(struct timer_list *t);
 	mod_timer(&mlmeext->link_timer, jiffies +	\
 		  msecs_to_jiffies(ms))
 
-bool cckrates_included(unsigned char *rate, int ratelen);
-bool cckratesonly_included(unsigned char *rate, int ratelen);
-
 void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
 
 void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len);
-- 
2.28.0

