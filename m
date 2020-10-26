Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6F298CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774897AbgJZMOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:14:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39398 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774890AbgJZMOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:14:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id y12so12177972wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9XiXFBGQEoweypTgUIFL5kZ+Amj93MlM0t0ZCMvklW0=;
        b=iTKZFezCsqq2n2F4JPAbKdXTaWRh9kTrhFstv9NgLlaNfbTkeeLpyWOp95hc3X1SrX
         E8SD4Ww212pal2CIkC6EB9bc0oNGUIojxrZuo2fLQBvicj3LxX4HiRTGyky+vi7WTYwr
         mYq4X1mZZb82+f6KykkQ0c+hSxkBbh1kexNLcdT8oKLLk2Q2TI1wnYWYQpw1ca4RBNB2
         /zSBtSneE9LOw5+KEu7fn6Rh6SE2ZWxHjlTrzmdmLIfcE1kfePIH2PtNAIGeikfSV9pg
         oE+r2G6b0ahFd53hpM64HeKlEwhpShrtizhpkZgqRB2MZ3pTNloT3+PNYJWmr+uoeQJL
         kd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9XiXFBGQEoweypTgUIFL5kZ+Amj93MlM0t0ZCMvklW0=;
        b=RYqUU2YRkZ68FRjPqExSBTlJ+bTBcA2bZsS+5yFq5mo033H4uG4JeXjm9DzqD0rzi7
         +3S7rFlnD7lAok+qP0v8QJ/DaFR1Pcx58JYFh3Hfwj8FP0eCgtOzfMqAXVdn+B4MsjlG
         rmP0wF2HCEV2QO/l3fyCbGjkTB7+o6H3HB7eOSpIdholXtC5wxgnhKWaoTsZFJCryIZg
         euAVjpWsB1mZqMA0R4pM0HQtxD9NYUlD2orGBWd+EpANK9jj7wqNjXduGLWJD01PbGQa
         o+7lomgSIrPXC6DaTWn4bNly2gb5WrNlkS+t1apLLxXsARYIfMdZy0suzTGlbudyKQW6
         Dihg==
X-Gm-Message-State: AOAM531RV7oKvsuL7Tvl30qIvvE6J0gM2WVP1qNYoUZeLQtaPuE21eP1
        SuLEAF1A6mfOkjPHbeSI1Nw=
X-Google-Smtp-Source: ABdhPJwPpJyXIs3pUGwvBR+/ENMixM97/4OI0vdyYuXXn8soG6754hhxDYQq9ez/zErVZ5L/5ABVdQ==
X-Received: by 2002:a5d:40c3:: with SMTP id b3mr19024728wrq.157.1603714481408;
        Mon, 26 Oct 2020 05:14:41 -0700 (PDT)
Received: from LEGION ([103.150.154.170])
        by smtp.gmail.com with ESMTPSA id v189sm20241764wmg.14.2020.10.26.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:14:40 -0700 (PDT)
Date:   Mon, 26 Oct 2020 17:14:35 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        musamaanjum@gmail.com
Subject: [PATCH] staging: rtl8192e, rtl8192u: use correct notation to define
 pointer
Message-ID: <20201026121435.GA782465@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pointer notation instead of using array notation as info_element is
a pointer not array.

Warnings from sparse:
drivers/staging/rtl8192u/ieee80211/ieee80211.h:1013:51: warning: array of flexible structures
drivers/staging/rtl8192u/ieee80211/ieee80211.h:985:51: warning: array of flexible structures
drivers/staging/rtl8192u/ieee80211/ieee80211.h:963:51: warning: array of flexible structures
drivers/staging/rtl8192u/ieee80211/ieee80211.h:996:51: warning: array of flexible structures
drivers/staging/rtl8192u/ieee80211/ieee80211.h:974:51: warning: array of flexible structures

drivers/staging/rtl8192e/rtllib.h:832:48: warning: array of flexible structures
drivers/staging/rtl8192e/rtllib.h:851:48: warning: array of flexible structures
drivers/staging/rtl8192e/rtllib.h:805:48: warning: array of flexible structures
drivers/staging/rtl8192e/rtllib.h:843:48: warning: array of flexible structures
drivers/staging/rtl8192e/rtllib.h:821:48: warning: array of flexible structures

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h              | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/ieee80211.h | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b84f00b8d18b..1dab9c3d08a8 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -802,7 +802,7 @@ struct rtllib_authentication {
 	__le16 transaction;
 	__le16 status;
 	/*challenge*/
-	struct rtllib_info_element info_element[];
+	struct rtllib_info_element *info_element;
 } __packed;
 
 struct rtllib_disauth {
@@ -818,7 +818,7 @@ struct rtllib_disassoc {
 struct rtllib_probe_request {
 	struct rtllib_hdr_3addr header;
 	/* SSID, supported rates */
-	struct rtllib_info_element info_element[];
+	struct rtllib_info_element *info_element;
 } __packed;
 
 struct rtllib_probe_response {
@@ -829,7 +829,7 @@ struct rtllib_probe_response {
 	/* SSID, supported rates, FH params, DS params,
 	 * CF params, IBSS params, TIM (if beacon), RSN
 	 */
-	struct rtllib_info_element info_element[];
+	struct rtllib_info_element *info_element;
 } __packed;
 
 /* Alias beacon for probe_response */
@@ -840,7 +840,7 @@ struct rtllib_assoc_request_frame {
 	__le16 capability;
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
-	struct rtllib_info_element info_element[];
+	struct rtllib_info_element *info_element;
 } __packed;
 
 struct rtllib_assoc_response_frame {
@@ -848,7 +848,7 @@ struct rtllib_assoc_response_frame {
 	__le16 capability;
 	__le16 status;
 	__le16 aid;
-	struct rtllib_info_element info_element[]; /* supported rates */
+	struct rtllib_info_element *info_element; /* supported rates */
 } __packed;
 
 struct rtllib_txb {
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 39f4ddd86796..37b240dd0b1f 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -960,7 +960,7 @@ struct ieee80211_authentication {
 	__le16 transaction;
 	__le16 status;
 	/*challenge*/
-	struct ieee80211_info_element info_element[];
+	struct ieee80211_info_element *info_element;
 } __packed;
 
 struct ieee80211_disassoc {
@@ -971,7 +971,7 @@ struct ieee80211_disassoc {
 struct ieee80211_probe_request {
 	struct rtl_80211_hdr_3addr header;
 	/* SSID, supported rates */
-	struct ieee80211_info_element info_element[];
+	struct ieee80211_info_element *info_element;
 } __packed;
 
 struct ieee80211_probe_response {
@@ -982,7 +982,7 @@ struct ieee80211_probe_response {
 	/* SSID, supported rates, FH params, DS params,
 	 * CF params, IBSS params, TIM (if beacon), RSN
 	 */
-	struct ieee80211_info_element info_element[];
+	struct ieee80211_info_element *info_element;
 } __packed;
 
 /* Alias beacon for probe_response */
@@ -993,7 +993,7 @@ struct ieee80211_assoc_request_frame {
 	__le16 capability;
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
-	struct ieee80211_info_element info_element[];
+	struct ieee80211_info_element *info_element;
 } __packed;
 
 struct ieee80211_reassoc_request_frame {
@@ -1002,7 +1002,7 @@ struct ieee80211_reassoc_request_frame {
 	__le16 listen_interval;
 	u8 current_ap[ETH_ALEN];
 	/* SSID, supported rates, RSN */
-	struct ieee80211_info_element info_element[];
+	struct ieee80211_info_element *info_element;
 } __packed;
 
 struct ieee80211_assoc_response_frame {
@@ -1010,7 +1010,7 @@ struct ieee80211_assoc_response_frame {
 	__le16 capability;
 	__le16 status;
 	__le16 aid;
-	struct ieee80211_info_element info_element[]; /* supported rates */
+	struct ieee80211_info_element *info_element; /* supported rates */
 } __packed;
 
 struct ieee80211_txb {
-- 
2.25.1

