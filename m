Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB662710A1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 23:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgISVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgISVUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 17:20:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A93C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 14:20:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so7906176ljg.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARYlD+mbtcJAUH0Veuj81wsIo6yFsSRfm6bQdfgH0jc=;
        b=YfYk65gx6U4cr7K3Jyg7OTAqSb/FcTmclUnYa4H69kyaQ/89g5oKLanVsBij0Vvn50
         2EhsrQVUog2LZNagcuzCRHoUZN/ebm+Ido4InV05OAtV0/UrxfUPtgJ8bHKiNeFdqLzG
         TbleKHpY/e3ZIUG+OJenas6rV5XagljnSjMpiPu6AAAS5Z2OzTYG944EFfmHoHnZg//F
         2u7mx9DjPaQ5zwUAUHbgIziLIM/4rIfEAK2j4M+a4RfHA8jlnLAtHHoEcNVP0e6PnKiB
         u/5B/BjCN0UUJ5sN9fXd3ZGGGwflaoc59b4ZgHNZF4vIk21/Ip16ut9FrNv8iu4AOR0E
         h9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARYlD+mbtcJAUH0Veuj81wsIo6yFsSRfm6bQdfgH0jc=;
        b=Ed9tn/77atKltR9N7Q3xfDDcrFYbK/uey1AKqdTtfyDU7ALCX+SYLr+7OjX1IvWHvN
         Xv7TsGMMcP2QbTBth+6uhAWIyY1+yrUQU2fg5OQNWqZmFqgB4HWc487cBzZ0L2LPrDby
         nrEyAZ9WWYgMuVQAt4/Iz/mdUlCAIz4zEjDmVWmf5PvK8fsE/JVY50T2yeJsH1x1Qlkx
         asLW2VAiKoe9VAotGzYneZ+MMY9CQ4PL4TRtzdLe+goC+NVpV85/T9yxZjGD1v+CJoUE
         FuAmuzKpTcHRN2YQqPspbEhz/9BBewLy+w9APDZRbl9gktUejcGrAoJOudemvwpJuTBt
         4jAA==
X-Gm-Message-State: AOAM532f9LSOfW+p4A5pVKnrqXXPoUdnWeoV+vGvxIdmahSRx8AE3UTL
        EwbFMlDJT5eR4PwY3vaSPXk=
X-Google-Smtp-Source: ABdhPJw1Dq47vNEGO0cw9E1XsEihuvszqtiO9a5+k35+2M7WHqbnaVY4e/EqMGIWXdsA39BeiCbHDQ==
X-Received: by 2002:a05:651c:1064:: with SMTP id y4mr12694418ljm.107.1600550413566;
        Sat, 19 Sep 2020 14:20:13 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id 18sm1447752lfz.141.2020.09.19.14.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 14:20:12 -0700 (PDT)
Received: (nullmailer pid 264177 invoked by uid 1000);
        Sat, 19 Sep 2020 21:25:23 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andre Pinto <andrealmeidap1996@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:r8188eu: replace WIFI_REASON_CODE enum with native ieee80211_reasoncode
Date:   Sun, 20 Sep 2020 00:24:44 +0300
Message-Id: <20200919212443.264126-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WIFI_REASON_CODE is duplication of enum ieee80211_reasoncode.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  4 +--
 drivers/staging/rtl8188eu/include/wifi.h      | 31 -------------------
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 4df790c83d9f..cef15cb937d2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2929,7 +2929,7 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 
 	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 	if (!pstat) {
-		status = _RSON_CLS2_;
+		status = WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA;
 		goto asoc_class2_error;
 	}
 
@@ -2943,7 +2943,7 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	/*  check if this stat has been successfully authenticated/assocated */
 	if (!((pstat->state) & WIFI_FW_AUTH_SUCCESS)) {
 		if (!((pstat->state) & WIFI_FW_ASSOC_SUCCESS)) {
-			status = _RSON_CLS2_;
+			status = WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA;
 			goto asoc_class2_error;
 		} else {
 			pstat->state &= (~WIFI_FW_ASSOC_SUCCESS);
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index a549b6d0159a..757c582ba4d9 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -74,37 +74,6 @@ enum WIFI_FRAME_SUBTYPE {
 	WIFI_QOS_DATA_NULL	= (BIT(6) | WIFI_QOS_DATA_TYPE),
 };
 
-enum WIFI_REASON_CODE	{
-	_RSON_RESERVED_			= 0,
-	_RSON_UNSPECIFIED_		= 1,
-	_RSON_AUTH_NO_LONGER_VALID_	= 2,
-	_RSON_DEAUTH_STA_LEAVING_	= 3,
-	_RSON_INACTIVITY_		= 4,
-	_RSON_UNABLE_HANDLE_		= 5,
-	_RSON_CLS2_			= 6,
-	_RSON_CLS3_			= 7,
-	_RSON_DISAOC_STA_LEAVING_	= 8,
-	_RSON_ASOC_NOT_AUTH_		= 9,
-
-	/*  WPA reason */
-	_RSON_INVALID_IE_		= 13,
-	_RSON_MIC_FAILURE_		= 14,
-	_RSON_4WAY_HNDSHK_TIMEOUT_	= 15,
-	_RSON_GROUP_KEY_UPDATE_TIMEOUT_	= 16,
-	_RSON_DIFF_IE_			= 17,
-	_RSON_MLTCST_CIPHER_NOT_VALID_	= 18,
-	_RSON_UNICST_CIPHER_NOT_VALID_	= 19,
-	_RSON_AKMP_NOT_VALID_		= 20,
-	_RSON_UNSUPPORT_RSNE_VER_	= 21,
-	_RSON_INVALID_RSNE_CAP_		= 22,
-	_RSON_IEEE_802DOT1X_AUTH_FAIL_	= 23,
-
-	/* belowing are Realtek definition */
-	_RSON_PMK_NOT_AVAILABLE_	= 24,
-	_RSON_TDLS_TEAR_TOOFAR_		= 25,
-	_RSON_TDLS_TEAR_UN_RSN_		= 26,
-};
-
 enum WIFI_STATUS_CODE {
 	_STATS_SUCCESSFUL_		= 0,
 	_STATS_FAILURE_			= 1,
-- 
2.26.2

