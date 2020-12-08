Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF202D21D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgLHEJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgLHEJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:14 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ACEC0611CD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:55 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id 2so11245646ilg.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KIyuVe6VyFOKOY1iJM9w6ygBrAwLaf1UtxyGLFKOTM=;
        b=p6cf+WlMC6WHpNSzEgHaKr2ztTGDZfHrofUktx43No4G0+K/bCKboxplQN5W4kIVfS
         6NhoH/bWfEJoCC4EnIS4OtKwr+tbHxfuXZq357iyj+g0yDzpL5QVJVHGu3+z7CyiBV+S
         ToB5OnRCtWvBVWoW1nCtMohmJPymz3Ro6b9fUIgC1ya2fiRDvd9V2iO89mFwdZIRak0y
         H6VhJKj3SQu/RI5Ctyz6nMldzbpWD/OW5R7u4OraTSCHF0bCTx98RExiNUCg97IDA7I9
         xUCGQB5m2uLv9E5l2l+ln+Rx+hw5OemBSgw9Ho8VZPPTyi50qCE/DNrcweLpOg0XKwQe
         SkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KIyuVe6VyFOKOY1iJM9w6ygBrAwLaf1UtxyGLFKOTM=;
        b=rXYZ7MJxi545PVvAJdwfW4pAYTtm6HlhFimnxWSHi4fjgfYkBTAVlYzzywHouGHb4a
         BgZheLGqKjMho27BQ7ETsXShlN9GC1ddduUftxiISR6G3qKck+xKqhiUG/Z0wi3nfgCL
         sO+m5SidqF+ZFUW++Lqs0eh0v/eq+ChiyEgsFhXcJeuTrBJUw4+79jbc0N4cRTjetJy7
         5ziT15UI2F1n0Fu0eZ9hNFcd07+95YNyTncpowHnIvqWUkkdfMN71gOa/wOZD1ij9G1p
         OA8tQzJx261Pq5I+XVVwHDFiaoCgVgfd+y5OgBKKiIj1LzBV1lRlUG4umyUG/tkLnDSw
         6VXw==
X-Gm-Message-State: AOAM530DfaNUsxw0jIV8Kts0w1YFll7362XdecV9a6oPwRmoZkgLQOzI
        UgkammQUIADqY/YYPjApbVXXLhdMSqo=
X-Google-Smtp-Source: ABdhPJzWJED/BRXZXEPedtlQiE/6DcdXLlWjW5VqOBB5lWkpt5/PWV21pYeao3W/EuIC2zaiwwH3/Q==
X-Received: by 2002:a05:6e02:19cd:: with SMTP id r13mr10385284ill.199.1607400474872;
        Mon, 07 Dec 2020 20:07:54 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:54 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 15/21] staging: rtl8723bs: replace _WAPI_IE_
Date:   Mon,  7 Dec 2020 22:07:27 -0600
Message-Id: <20201208040733.379197-16-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _WAPI_IE_ macro with kernel provided
WLAN_EID_BSS_AC_ACCESS_DELAY from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 drivers/staging/rtl8723bs/include/wifi.h       | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 28d5892d8bda..be4cffce4f5d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -623,8 +623,8 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
 
-		/* if (authmode == _WAPI_IE_) */
-		if (authmode == _WAPI_IE_ && (!memcmp(&in_ie[cnt+6], wapi_oui1, 4) ||
+		/* if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY) */
+		if (authmode == WLAN_EID_BSS_AC_ACCESS_DELAY && (!memcmp(&in_ie[cnt+6], wapi_oui1, 4) ||
 					!memcmp(&in_ie[cnt+6], wapi_oui2, 4))) {
 			if (wapi_ie) {
 				memcpy(wapi_ie, &in_ie[cnt], in_ie[cnt+1]+2);
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index e221d4574f32..29621fce6a83 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -393,7 +393,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define _FTIE_						55
 #define _TIMEOUT_ITVL_IE_			56
 #define _SRC_IE_				59
-#define _WAPI_IE_					68
 
 #define _RIC_Descriptor_IE_			75
 #define _MME_IE_					76 /* 802.11w Management MIC element */
-- 
2.25.1

