Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F902A762B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgKEDsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388678AbgKEDsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:48:17 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557B3C0613D1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 19:48:16 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id k1so144722ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 19:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e98j2N411UER5rHXELNTCsjcaZIK/s/RI1cj1IroP1Y=;
        b=WOatbNLcx2AVVbLrcoJVy4o4+M1ycvKb9D3fUisLOKo4NBuSClLMoUx/OSCCrkAE3H
         0+ygDMWlKlLJNNnmKNjB3i9fmLoaTHlNB0TJ/b9nXN4R694OEnuDDuWOIzBISLwg1Ar9
         lt4Yk7N9Hthvg0YFu+SFF8kicPsRvJ9NVhDo0FTx+tfuR5m8RIi1PyJkUIQguYbmurU0
         llamMd3GT7P888ltDXkbg29IvBB6W0MBaXCSMzvN4Nk71ABaI/ptxdQ1U4HPylMBcWEl
         VMxKuy5OGdfT57NmvyhuinJSeYa2rTqcEfr+3+oNMTryi1tdkhYwv5eLX7da7RqaGLAO
         j2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e98j2N411UER5rHXELNTCsjcaZIK/s/RI1cj1IroP1Y=;
        b=CKV3pjTk4oaYBY9FuFyxEB2TR9QC2VlG8888Big3HVEPc6TuWupU2tPrYl1ovPWRKe
         13VeOYkgS9rlLa+791aQ95tjTXCpBAwSfRmqSWO91vDpM284YF3/nk/MpE/cT5lb4ASi
         D1A4b1D9txFqo091wRxvnIVQPzq/DATJQ+oeBEL8xhDSgEDOv55rVgOxz3usOXd1PV/k
         Z/ivOrOUm/QqX4Y5R/LK1p0n7BymgTqvgDdkqUvqpp0zyjHWICPl0aXJZQs5Synx6gk9
         /3cwYNCLzjb2JCq6yjIwKROaFqMlPCXlEk14jxrTBwORjmEPcP68L6+2YezCNwCeRV8y
         A/jg==
X-Gm-Message-State: AOAM533WA3PShuRctz+sjz85wPPmr4jUZqQAlSdIenyZP7oDeCPpU24a
        duRb5M1NlsO9yfHLBFMdrdo=
X-Google-Smtp-Source: ABdhPJxqW3CqSvqng3aJ8NMe+iQqvTwSF8vxnSi9Amsa6lPM7aUvUl6L0i/Nn+teoRfxan1FslZTYg==
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr540599ilt.40.1604548095768;
        Wed, 04 Nov 2020 19:48:15 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id p6sm172877ilc.26.2020.11.04.19.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 19:48:15 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 8/9] staging: rtl8723bs: replace rtw_ieee80211_ht_actioncode
Date:   Wed,  4 Nov 2020 21:47:53 -0600
Message-Id: <20201105034754.12383-8-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105034754.12383-1-ross.schm.dev@gmail.com>
References: <20201105034754.12383-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the unique rtw_ieee80211_ht_actioncode enum with the provided
standard ieee80211_ht_actioncode.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index cdb1d2b06f1b..c113902877bd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2145,7 +2145,7 @@ unsigned int OnAction_ht(struct adapter *padapter, union recv_frame *precv_frame
 
 	action = frame_body[1];
 	switch (action) {
-	case RTW_WLAN_ACTION_HT_COMPRESS_BEAMFORMING:
+	case WLAN_HT_ACTION_COMPRESSED_BF:
 		break;
 	default:
 		break;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 06aacafd2340..cd8f6d006a38 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -920,18 +920,6 @@ enum rtw_ieee80211_back_actioncode {
 	RTW_WLAN_ACTION_DELBA = 2,
 };
 
-/* HT features action code */
-enum rtw_ieee80211_ht_actioncode {
-	RTW_WLAN_ACTION_HT_NOTI_CHNL_WIDTH = 0,
-       RTW_WLAN_ACTION_HT_SM_PS = 1,
-       RTW_WLAN_ACTION_HT_PSMP = 2,
-       RTW_WLAN_ACTION_HT_SET_PCO_PHASE = 3,
-       RTW_WLAN_ACTION_HT_CSI = 4,
-       RTW_WLAN_ACTION_HT_NON_COMPRESS_BEAMFORMING = 5,
-       RTW_WLAN_ACTION_HT_COMPRESS_BEAMFORMING = 6,
-       RTW_WLAN_ACTION_HT_ASEL_FEEDBACK = 7,
-};
-
 /* BACK (block-ack) parties */
 enum rtw_ieee80211_back_parties {
 	RTW_WLAN_BACK_RECIPIENT = 0,
-- 
2.25.1

