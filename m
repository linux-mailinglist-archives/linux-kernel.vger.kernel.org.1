Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903082D007A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 05:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgLFEQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 23:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgLFEPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:15:39 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDCFC061A52
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 20:14:59 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n14so9981989iom.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 20:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qkNKRbDcUUBwj4iE09P22MAxUjsp1i2IjCK22JBaNw=;
        b=K3Xacm+ALpMCMgLd5dMXNV8jpgof/q3XY2HvxGHwzrNT1SmLVlp3/LNUWcOvqkA+Sv
         ovZ+A/iurKJTuKx1ZBNW7p2THk9BHHNnxLQu3BsyfXNg1pdutZ2Xmi+/gqstIdrNdSpF
         8fXSwlbNbU2ILmN5GqpIx7fHUztsVBWeC1Y/54HEn5sXrURFm7CSB3PEoJblnemqvFxa
         RhUPiTNKgioorD7cScsBPUL5xxiDIfCS/8loWjM6/1y0gmzQ+2XZIMANJYxYQz/Kwu1F
         tJcnXEjHBtKXdqa/BituwyKrBh85qy5hr75FDZhXxQVSremHY4cyfUpKN503SgKwNTIL
         j6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qkNKRbDcUUBwj4iE09P22MAxUjsp1i2IjCK22JBaNw=;
        b=c23+gI/uNlJZPhGQ3WdBzST2wx6AfxrKH3Vwwjyn6o7grCw+UlZHWUfq8iniOtRq7f
         O/jKJeMi17QYZhlrFcr6s2jClScCn2tFkC0YH4PQL5a78QV1YAfDN5XQXlKbesVixqQk
         ANt04Ab4sY2MlWPs+KIC6rVih650I6PmFSHKExr3NPnh3O8XTNebjCz6MnyvqQOPJiUA
         62KciFxGjsdzyGNhTfw4vkdHFY8PMBU0d/KVnHsfbQwE7UFtT4vXz/WGtj2UG3Hk0rPa
         M2kmk57s7AIJKnE68D5OxlcWHRScy/Eh49KJ8ePiuEkZMFKK2ygPRLHTfD2EQoKiOZTG
         AaKA==
X-Gm-Message-State: AOAM530lfQO+9HEa233Q/7+bT+4H0IqbhgYF1Q2Ra32mgZIsDCEavhoW
        s9nBFWHZDW0bFSPOP4HgIWFcqXCGG6o=
X-Google-Smtp-Source: ABdhPJw6HHjZb88oT7T9qa/YCnyOZP41p8Jpoi72+tH03BXkNWpB2VnFGehobFpmjC36s0ezpu0dbQ==
X-Received: by 2002:a02:6c50:: with SMTP id w77mr13359501jab.68.1607226331614;
        Sat, 05 Dec 2020 19:45:31 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id v63sm3908553ioe.52.2020.12.05.19.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 19:45:31 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 08/10] staging: rtl8723bs: remove unused macros
Date:   Sat,  5 Dec 2020 21:45:15 -0600
Message-Id: <20201206034517.4276-8-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201206034517.4276-1-ross.schm.dev@gmail.com>
References: <20201206034517.4276-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove many macros from wifi.h because they are unused.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/include/wifi.h | 33 ------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index c3a4a0bad0d7..41de2605c517 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -643,39 +643,6 @@ struct ADDBA_request {
 #define IEEE80211_HT_CAP_TXBF_TX_NDP		0x00000010
 #define IEEE80211_HT_CAP_TXBF_EXPLICIT_COMP_STEERING_CAP	0x00000400
 
-/* 802.11n HT IE masks */
-#define IEEE80211_HT_IE_CHA_SEC_OFFSET		0x03
-#define IEEE80211_HT_IE_CHA_SEC_NONE		0x00
-#define IEEE80211_HT_IE_CHA_SEC_ABOVE		0x01
-#define IEEE80211_HT_IE_CHA_SEC_BELOW		0x03
-#define IEEE80211_HT_IE_CHA_WIDTH		0x04
-#define IEEE80211_HT_IE_HT_PROTECTION		0x0003
-#define IEEE80211_HT_IE_NON_GF_STA_PRSNT	0x0004
-#define IEEE80211_HT_IE_NON_HT_STA_PRSNT	0x0010
-
-/*
- * A-PMDU buffer sizes
- * According to IEEE802.11n spec size varies from 8K to 64K (in powers of 2)
- */
-#define IEEE80211_MIN_AMPDU_BUF 0x8
-
-#define HT_INFO_HT_PARAM_SECONDARY_CHNL_OFF_MASK	((u8) BIT(0) | BIT(1))
-#define HT_INFO_HT_PARAM_SECONDARY_CHNL_ABOVE		((u8) BIT(0))
-#define HT_INFO_HT_PARAM_SECONDARY_CHNL_BELOW		((u8) BIT(0) | BIT(1))
-#define HT_INFO_HT_PARAM_REC_TRANS_CHNL_WIDTH		((u8) BIT(2))
-#define HT_INFO_HT_PARAM_RIFS_MODE			((u8) BIT(3))
-#define HT_INFO_HT_PARAM_CTRL_ACCESS_ONLY		((u8) BIT(4))
-#define HT_INFO_HT_PARAM_SRV_INTERVAL_GRANULARITY	((u8) BIT(5))
-
-#define HT_INFO_STBC_PARAM_DUAL_BEACON			((u16) BIT(6))
-#define HT_INFO_STBC_PARAM_DUAL_STBC_PROTECT		((u16) BIT(7))
-#define HT_INFO_STBC_PARAM_SECONDARY_BCN		((u16) BIT(8))
-#define HT_INFO_STBC_PARAM_LSIG_TXOP_PROTECT_ALLOWED	((u16) BIT(9))
-#define HT_INFO_STBC_PARAM_PCO_ACTIVE			((u16) BIT(10))
-#define HT_INFO_STBC_PARAM_PCO_PHASE			((u16) BIT(11))
-
-
-
 /* endif */
 
 /* 	===============WPS Section =============== */
-- 
2.25.1

