Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E42D21D5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgLHEJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgLHEJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:22 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F5C0619D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:08:01 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 81so15603736ioc.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dsWJ3wrdvClaf8NoUeAOfEEb2bR+T2eO/cQV3hJDJhA=;
        b=O3SsdqoptsHL+5djAONfMBEO4xq7WCTiejUCI/p/Nmi6OEizNdKX5jH2UatTU6nxSz
         kYXX/BH9jGXLcj341NUUje8zDnWt0U9ZsNIn1igZFVytaV13cgxVAzyC1vSz0x+Vgkwd
         MlliFr/LKBxzOD12uqhAYZRB1FziXfvMILEqLJVM5VuhrEaqd2TA8/OgkqIc1xPMTlD0
         MLvVDR00+LQliL77qZ3x+akhodwsl1eKA2W22McXhDDOilivK87oYVydz8nbKUirwbid
         efrP8A+EaFjK5fP1oW8m/FaglBCXI+kpI7+h1cHG4kzJRHoQW9uOO5zZHe7M8EuDVqI8
         1Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dsWJ3wrdvClaf8NoUeAOfEEb2bR+T2eO/cQV3hJDJhA=;
        b=hTyEg6SO/e5jaeY5FOr5452OdhGkcYVrgRY095LawG7xpvI0IA3wWDzNxXA2v3NV8Z
         6ZltnXwqL/VSlKVFJJJ0aQbXZTaYPaC9g97Pexh/it9S8d/0gPwpBba1UeN0nz8j31+B
         Ywhl5HvemcXcxty8JoFBlx9zRZFZhVG9dVTRSZphP4HKfrDypjWJer8d4BQM0IzwFbi5
         t5L2IUz8SOEHjgx5FUCiGXbWoxLaiT8trvhTzTLbRU0EzSZXhSb/rBVa2HrhnHrnDMEt
         lbw6HhUERTfe3+Xs3CbKm/6/QZtaCKE2iwgjeBVm87UImaUN/IG3ZfAeWLflvPZ5rnLR
         Ug4g==
X-Gm-Message-State: AOAM532egtwuduvxPbKTBHshVCdSCYYy48jZqMkSFccKAknKbC0x2KZf
        0ayqaJvJ3IGooUswJSV1Azo=
X-Google-Smtp-Source: ABdhPJxK9xuXLbplaY1A0R0SwyrpRl4q1MJSZx1rOm8fC1aw+oP6FpIfRiS27FtfmeE65QMnwhgQpw==
X-Received: by 2002:a02:b607:: with SMTP id h7mr25285486jam.120.1607400480332;
        Mon, 07 Dec 2020 20:08:00 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:59 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 20/21] staging: rtl8723bs: remove unused macros
Date:   Mon,  7 Dec 2020 22:07:32 -0600
Message-Id: <20201208040733.379197-21-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove many macros from wifi.h and ieee80211.h because they are unused.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h |  5 -----
 drivers/staging/rtl8723bs/include/wifi.h      | 15 ---------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 20c53c290aa1..d9ff8c8e7f36 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -348,11 +348,6 @@ struct ieee80211_snap_hdr {
 #define WLAN_REASON_JOIN_WRONG_CHANNEL       65534
 #define WLAN_REASON_EXPIRATION_CHK 65535
 
-/* EIDs defined by IEEE 802.11h - END */
-#define WLAN_EID_20_40_BSS_COEXISTENCE 72
-#define WLAN_EID_20_40_BSS_INTOLERANT 73
-#define WLAN_EID_OVERLAPPING_BSS_SCAN_PARAMS 74
-
 #define IEEE80211_MGMT_HDR_LEN 24
 #define IEEE80211_DATA_HDR3_LEN 24
 #define IEEE80211_DATA_HDR4_LEN 30
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 82dfdafb38fc..7f482a45705b 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -387,21 +387,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
-#define _SUPPORTED_CH_IE_		36
-#define _CH_SWTICH_ANNOUNCE_	37	/* Secondary Channel Offset */
-
-#define _FTIE_						55
-#define _TIMEOUT_ITVL_IE_			56
-#define _SRC_IE_				59
-
-#define _RIC_Descriptor_IE_			75
-#define _LINK_ID_IE_					101
-#define _CH_SWITCH_TIMING_		104
-#define _PTI_BUFFER_STATUS_		106
-#define _EXT_CAP_IE_				127
-
-#define	_RESERVED47_				47
-
 enum ELEMENT_ID {
 	EID_SsId					= 0, /* service set identifier (0:32) */
 	EID_SupRates				= 1, /* supported rates (1:8) */
-- 
2.25.1

