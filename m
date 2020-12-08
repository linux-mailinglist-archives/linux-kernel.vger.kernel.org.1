Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB392D21D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgLHEJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgLHEJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:03 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1EFC0611C5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:50 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id j12so7196918ilk.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1AJFYjdsVXmhfoTYzC+8zbX17r0CL2qIE6XsavrcP8=;
        b=iE52eEJ57XPMICXUHrlBOAr0VIRcLo6RwUiTVYKrvgLt/eiPIx9dCX5fJFgll7K7a5
         aDM0HFUSFZbA5vP48wezuVPZvX7gcg/ToN/63/buFCL9hxNKujWRAXHtNiusJ6EQFbaa
         JzhXIJJRkRGTg1uSMzqSJKAK5JGUWPptkEtq/d1K3mwCp4A2SzmPhNGtFxCeMsHOLKzV
         YMcZ+3NlUPHeb1vjCpLgjczUUDDOoCiRePMGlsqqZBjNw30PViZNabfHIznYaSmFc9l8
         mtp70VRhYxfaECW0lFfc++fc8dYHVv13cZu506q3bOr9HkuyYkDrwhJeFVnUAOD5czgc
         E/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1AJFYjdsVXmhfoTYzC+8zbX17r0CL2qIE6XsavrcP8=;
        b=BKdVGZr9nqZC/EDbVXw+2UdJqG3cC7YJ1VSOYyolys/xLWJDQ+ZVqvASm+rhwRESEX
         NOPXIfWXAfH15auGvKnp3mAkRy/PM/GKgxCMlidnu7J3+G3AtcVKm+eW2RbWnHwVweAy
         kuZWJFz7qr2BF4nM41AX5/hXxeyWymhYvY3pxc826UBzbpEMUd+Um6CHWWDDALeQpWtS
         ytzB81S0lGivsKaUeI+xDOq4QmE904RT7IO65H20KNOpAMtAQZUqBc4cIemEMXmFlbHV
         oyXGeNCdeywhgyoi2PvGfakxgg00Yh2mkYeTtuwN5FGx4Ivg2d6rSjvRk77z7Ui0ShTi
         MErQ==
X-Gm-Message-State: AOAM531dHrMdpaEyVWkhrmmXD8szgLwOt9ii/WH5LU32b50ngVXRmIUu
        yngskIgEfRjU5iDAfQxj3IQdySwgffo=
X-Google-Smtp-Source: ABdhPJy+03nV7mpJPbBx4SaEIUyRyLg0+vRVU3GrF1b+YHM7GqvcWN56iW0x7fr8m6yxlb5zVr5v5Q==
X-Received: by 2002:a92:6410:: with SMTP id y16mr24431243ilb.126.1607400470407;
        Mon, 07 Dec 2020 20:07:50 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:49 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 11/21] staging: rtl8723bs: replace _COUNTRY_IE_
Date:   Mon,  7 Dec 2020 22:07:23 -0600
Message-Id: <20201208040733.379197-12-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _COUNTRY_IE_ macro with kernel provided WLAN_EID_COUNTRY
from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/rtl8723bs/include/wifi.h      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 546e4a31142b..319a99833a49 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4788,7 +4788,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		u8 noc; /*  number of channel */
 		u8 j, k;
 
-		ie = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _COUNTRY_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
+		ie = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, WLAN_EID_COUNTRY, &len, bssid->IELength - _FIXED_IE_LENGTH_);
 		if (!ie)
 			return;
 		if (len < 6)
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 3adeb3c23a3c..6df50468200e 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -387,7 +387,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
-#define _COUNTRY_IE_			7
 #define _CHLGETXT_IE_			16
 #define _SUPPORTED_CH_IE_		36
 #define _CH_SWTICH_ANNOUNCE_	37	/* Secondary Channel Offset */
-- 
2.25.1

