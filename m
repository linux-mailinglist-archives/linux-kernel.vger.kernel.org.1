Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5052D007E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 05:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgLFERd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 23:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLFERc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 23:17:32 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47DC0613D1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 20:16:52 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id p4so817684pfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 20:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xozfEtcjgJFJI3Lfdsh6l2B4qBozB67SYu7OaS1aMj8=;
        b=WPDQ971HnD3G3d2c90QjQ6tkM+4oUIUwXBKoAO37zdTFeSwlOi6T9mpdWIWee69+ag
         NBG2SoAI6sJ7nTKEmeISBZdxcCP2hws8zr64A9Yb2DeQ+BjYR483TrXrXljRmF3TAY95
         xrKc0NM1Ty+k1XtX4Uwuxz6XduDk/DT8N9J7I95RbFEOwsrexRVUWhJDDPsizFMMxnQp
         qSQS1MIOtH60ad+5flljT8UeFGb0wnsbjksLE9VsPrkX0TllFeaou326msok2ygar45y
         ANxraMaLnKVoAxg1nNHIXlBV1HDxCYZwnwjKbYrLGY5Q++z6mkfOHbyrr/Pf7fsQUrKF
         Jm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xozfEtcjgJFJI3Lfdsh6l2B4qBozB67SYu7OaS1aMj8=;
        b=j466m6KkyiTgx/0N3JcdqiG+S3072AmGrdECYJP+ZlrV6cYwhETMlYMTE0X2xlu1ED
         IO3IVmhYa32XSM0eVNMV4dSu1YRAm43+akCL58rF/8H7LWQU1ND2ZJQUW4LY9uB7C/+f
         BqF2NZGuTsvoQ3Ep39ng2a9DWQY7GulwiaEKQaAxVX5ZCuAfz1sIeIDV0UXfZTwaSKMK
         yZRfj2yKwdJ13NZyzowCOgVVCDQpiAnsTCUNfdsOHJDErfnos9QDMF1g9xKAa61WA+1B
         SqfxW/HzaOypIgZuc3zg5gTBT7CtSkwpxamxh35lnaP+/o4NXhVpbk3/9FeCu6pzK2d/
         3IRA==
X-Gm-Message-State: AOAM5302RC4ma1mI8Xvw4bLpdtlCJXHFIj4q/1ueNJhPhTKG416snvZD
        tLIOt1xOekFvw9dIFuOdS+YgM2zVn9U=
X-Google-Smtp-Source: ABdhPJy8Yh9LYFtX77yTPdq/GqAkN7LOhq1p1msgGNctPUh4XyTK7eE3x1qyyaTh29gzf6Ez6Q7WZQ==
X-Received: by 2002:a92:c052:: with SMTP id o18mr13075881ilf.245.1607226330528;
        Sat, 05 Dec 2020 19:45:30 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id v63sm3908553ioe.52.2020.12.05.19.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 19:45:29 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 07/10] staging: rtl8723bs: replace RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK
Date:   Sat,  5 Dec 2020 21:45:14 -0600
Message-Id: <20201206034517.4276-7-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201206034517.4276-1-ross.schm.dev@gmail.com>
References: <20201206034517.4276-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique macro RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK with kernel
provided IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK.  The other
IEEE80211_ADDBA_* and IEEE_DELBA_* macros are duplicates already defined
in linux/ieee80211.h, remove them.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 +++---
 drivers/staging/rtl8723bs/include/wifi.h      | 7 -------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 0743e56582ba..166b5369b003 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3943,7 +3943,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 				/*  TID */
 				BA_para_set |= (status << 2) & IEEE80211_ADDBA_PARAM_TID_MASK;
 				/*  max buffer size is 8 MSDU */
-				BA_para_set |= (8 << 6) & RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK;
+				BA_para_set |= (8 << 6) & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK;
 			} else {
 				BA_para_set = (0x1002 | ((status & 0xf) << 2)); /* immediate ack & 64 buffer size */
 			}
@@ -3994,8 +3994,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			if (hal_btcoex_IsBTCoexCtrlAMPDUSize(padapter) &&
 			    padapter->driver_rx_ampdu_factor == 0xFF) {
 				/*  max buffer size is 8 MSDU */
-				BA_para_set &= ~RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK;
-				BA_para_set |= (8 << 6) & RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK;
+				BA_para_set &= ~IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK;
+				BA_para_set |= (8 << 6) & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK;
 			}
 
 			if (pregpriv->ampdu_amsdu == 0)/* disabled */
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 2e8ca191c608..c3a4a0bad0d7 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -653,13 +653,6 @@ struct ADDBA_request {
 #define IEEE80211_HT_IE_NON_GF_STA_PRSNT	0x0004
 #define IEEE80211_HT_IE_NON_HT_STA_PRSNT	0x0010
 
-/* block-ack parameters */
-#define IEEE80211_ADDBA_PARAM_POLICY_MASK 0x0002
-#define IEEE80211_ADDBA_PARAM_TID_MASK 0x003C
-#define RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFC0
-#define IEEE80211_DELBA_PARAM_TID_MASK 0xF000
-#define IEEE80211_DELBA_PARAM_INITIATOR_MASK 0x0800
-
 /*
  * A-PMDU buffer sizes
  * According to IEEE802.11n spec size varies from 8K to 64K (in powers of 2)
-- 
2.25.1

