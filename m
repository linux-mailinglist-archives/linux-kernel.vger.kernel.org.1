Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37C62D21D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgLHEJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgLHEJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:20 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C838C0611CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:56 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n4so15628250iow.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50gPnG7hHVVH2qSvelrRJ4nfNp6Nhs29ibByUu5SMdE=;
        b=BX17/dI3/hznW8qJMTRTwQfBBBRQ+Qg1jACfCrpDnZQ9hTiH2wSO8hmhrw6CvCVp3B
         FwSaaG/8KFToxtv4ijDBSLmLlORlkXzgVQ4fiDl+3dWogxXTDX5F9HeQJ6gznBb3NcVr
         IowgZOvHJOS8Hg/+pisGubppzUxRvA9ba9ZZ2OGbwgvtHH+2Te2X2R3Xj5jxd4hE6G+l
         w9lHhDI8wmo6Ax01k+T2snwA38LeY3XQUjnX9IG5WGUI3yOP+frsXhbKoE0P5vWWAK7i
         ppdUReNDr7iX/6oJdhGtsBhA//hhzuqNmuQHMB5fq78P3+pXP5aX8XucG8Bg1sbLtuBQ
         0OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50gPnG7hHVVH2qSvelrRJ4nfNp6Nhs29ibByUu5SMdE=;
        b=AFAhlA7izw+PIisgPZYvir3YrDMlb1/myXWWE03TBUmxft9MgDN28ESPj55W1JmnN2
         sXbEn/nsaA0ap7BcmqQbjdKElrXkfP4pqji93OtQSQBuudHdQImhmw4vwR6Akx7PV/YK
         Lv/Lu9ATUEkdRQTDrUdUDTjdLPrFPROWQm1cbf6krPZt6ZH42p7tG+HQ4aoz+fPee4f0
         SZhF08vdPZF6fF6ZFZeWTIS17BGIvOg40BpWIO4EknOZDoR3zB0mwE1QuwequQRynJU1
         U91EdHY8pZFFfp+1lS2v0/vcfENIPsm3jJY9Yrv0kYG4jxXKssGxbWHwGsGpnCfIaMvL
         PghA==
X-Gm-Message-State: AOAM530oyl2SGguvaviZ6eu0KVChJtDltyTmlZC+mU+zRUxPV0f911Xs
        NM+sls+fb0I3xo2Phw3Q4Oc=
X-Google-Smtp-Source: ABdhPJwucHn+K0UJ07C+EB1vHMlWuM8Z1Sh4hsEqUzZokgJNj6zt7lfpMPhnBWsV1mQDXRyw5OOHew==
X-Received: by 2002:a02:9469:: with SMTP id a96mr25628565jai.86.1607400476067;
        Mon, 07 Dec 2020 20:07:56 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:55 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 16/21] staging: rtl8723bs: replace _MME_IE_
Date:   Mon,  7 Dec 2020 22:07:28 -0600
Message-Id: <20201208040733.379197-17-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique _MME_IE_ macro with kernel provided WLAN_EID_MMIE from
linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 2 +-
 drivers/staging/rtl8723bs/include/wifi.h      | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 33f5d3c5ac36..a83d8f7f611c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1819,7 +1819,7 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	/* save the frame body + MME */
 	memcpy(BIP_AAD+BIP_AAD_SIZE, pframe+WLAN_HDR_A3_LEN, pattrib->pkt_len-WLAN_HDR_A3_LEN);
 	/* find MME IE pointer */
-	p = rtw_get_ie(BIP_AAD+BIP_AAD_SIZE, _MME_IE_, &len, pattrib->pkt_len-WLAN_HDR_A3_LEN);
+	p = rtw_get_ie(BIP_AAD+BIP_AAD_SIZE, WLAN_EID_MMIE, &len, pattrib->pkt_len-WLAN_HDR_A3_LEN);
 	/* Baron */
 	if (p) {
 		u16 keyid = 0;
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 187a2aa77a55..41632fa0b3c8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1292,7 +1292,7 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 		pmlmeext->mgnt_80211w_IPN++;
 
 		/* add MME IE with MIC all zero, MME string doesn't include element id and length */
-		pframe = rtw_set_ie(pframe, _MME_IE_, 16,
+		pframe = rtw_set_ie(pframe, WLAN_EID_MMIE, 16,
 				    MME, &pattrib->pktlen);
 		pattrib->last_txcmdsz = pattrib->pktlen;
 		/*  total frame length - header length */
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 29621fce6a83..82dfdafb38fc 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -395,7 +395,6 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define _SRC_IE_				59
 
 #define _RIC_Descriptor_IE_			75
-#define _MME_IE_					76 /* 802.11w Management MIC element */
 #define _LINK_ID_IE_					101
 #define _CH_SWITCH_TIMING_		104
 #define _PTI_BUFFER_STATUS_		106
-- 
2.25.1

