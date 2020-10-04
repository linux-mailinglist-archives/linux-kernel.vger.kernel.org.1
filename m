Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE1C2827C4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgJDBSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgJDBSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:18:02 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E6C061787
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 18:18:02 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so5664728ioo.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vWv7cPa16PRp5GbfQ30XwWuZ9bZoQepsEfFV+tBy7A=;
        b=rrttXhXqJcwVCIafWohQ9XbVxf7PlVCHiwgH3hvThDqBR6bAhWcAvHb8YMDf8ia5zf
         1o8Cn9g0yqr7xgDKb46G41fxmWD/IhkXmKUPWUdTZL4Y9D9B3htRUYXLj68N+AYohmQq
         MVxLRhsdmsAv2LB8PHEG80O7FM40rWTWn6GUyviYSwPnDOXQcBJgFsHAfisOW6fG6ZC+
         UV8GaOU8TmMDW0821cv+DrTCiULMKgbJayqyYprCtkchfbcuP7RHPksqSg96vWyik5Fs
         31/1+RA47dX4Ab/woOLUivMQlHbEvXjZYupAv0dtXuEfclzySU1y8MjqMpdMFuTsrPDo
         N7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vWv7cPa16PRp5GbfQ30XwWuZ9bZoQepsEfFV+tBy7A=;
        b=uaLM8u5e00pjOxaihNUId9uuKBCc/G3DcI3mvdBIVWxWtlvZHRUeP0N/nK23f5EKfq
         7cknmyW3vPZC6NogWmaVTJ8Gb1zAH5AN7r6kQ9vd99SCcz+jB0Ku3RFrVr9VWE4fZp0r
         JeKMCDyGDPuwAyTQHZ3eYnvVVgTMXr+ACXjUHyoC/vpfVTwpTGXSnl0R4fpDkayjFbcv
         /09B5XoILeHlNRC5KZBWVwttwCvpoNtsWQG8C2aEvSoZ5L7fuICiliAZMcK9Z+5uNAKp
         UjYKjkVCSKI4zo1s2Yd5DJcPZGzX2GmgiaM2U4ahomN9sNG5J7kFhOZXD8789FirLVLT
         X24w==
X-Gm-Message-State: AOAM532ObLbmaTdCnkTidj3jukzzl2ti0sCtw8ReSNmirUmm+zosQSy4
        n9jCbFcucsTUDyl6/sPx2XY=
X-Google-Smtp-Source: ABdhPJwRrwJ2IZ1GuU0zkARWhVP2JQrDsKfNDnrlRRyF/ifkdc7cEZ+lPJoiCn9m6X+yMLrcpDo+QA==
X-Received: by 2002:a6b:6118:: with SMTP id v24mr5344603iob.61.1601774281383;
        Sat, 03 Oct 2020 18:18:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id t64sm3575194ild.10.2020.10.03.18.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 18:18:01 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 7/8] staging: rtl8723bs: replace RTW_GET_BE16 with get_unaligned_be16
Date:   Sat,  3 Oct 2020 20:17:42 -0500
Message-Id: <20201004011743.10750-7-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004011743.10750-1-ross.schm.dev@gmail.com>
References: <20201004011743.10750-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace RTW_GET_BE16 macro with get_unlaligned_be16.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c    | 4 ++--
 drivers/staging/rtl8723bs/core/rtw_recv.c         | 3 ++-
 drivers/staging/rtl8723bs/include/osdep_service.h | 2 --
 drivers/staging/rtl8723bs/os_dep/recv_linux.c     | 3 ++-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 3b7a3c220032..c43cca4a3828 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -801,8 +801,8 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 
 	while (attr_ptr - wps_ie < wps_ielen) {
 		/*  4 = 2(Attribute ID) + 2(Length) */
-		u16 attr_id = RTW_GET_BE16(attr_ptr);
-		u16 attr_data_len = RTW_GET_BE16(attr_ptr + 2);
+		u16 attr_id = get_unaligned_be16(attr_ptr);
+		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
 
 		/* DBG_871X("%s attr_ptr:%p, id:%u, length:%u\n", __func__, attr_ptr, attr_id, attr_data_len); */
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 7e1da0e35812..6979f8dbccb8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -11,6 +11,7 @@
 #include <linux/jiffies.h>
 #include <rtw_recv.h>
 #include <net/cfg80211.h>
+#include <asm/unaligned.h>
 
 static u8 SNAP_ETH_TYPE_IPX[2] = {0x81, 0x37};
 static u8 SNAP_ETH_TYPE_APPLETALK_AARP[2] = {0x80, 0xf3};
@@ -1906,7 +1907,7 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 	while (a_len > ETH_HLEN) {
 
 		/* Offset 12 denote 2 mac address */
-		nSubframe_Length = RTW_GET_BE16(pdata + 12);
+		nSubframe_Length = get_unaligned_be16(pdata + 12);
 
 		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
 			DBG_871X("nRemain_Length is %d and nSubframe_Length is : %d\n", a_len, nSubframe_Length);
diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index 2f7e1665b6b1..a94b72397ce7 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -150,8 +150,6 @@ extern void rtw_free_netdev(struct net_device * netdev);
 
 /* Macros for handling unaligned memory accesses */
 
-#define RTW_GET_BE16(a) ((u16) (((a)[0] << 8) | (a)[1]))
-
 void rtw_buf_free(u8 **buf, u32 *buf_len);
 void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index b2a1bbb30df6..900ff3a3b014 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -10,6 +10,7 @@
 #include <rtw_debug.h>
 #include <linux/jiffies.h>
 #include <net/cfg80211.h>
+#include <asm/unaligned.h>
 
 void rtw_os_free_recvframe(union recv_frame *precvframe)
 {
@@ -69,7 +70,7 @@ _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8
 	skb_reserve(sub_skb, 12);
 	skb_put_data(sub_skb, (pdata + ETH_HLEN), nSubframe_Length);
 
-	eth_type = RTW_GET_BE16(&sub_skb->data[6]);
+	eth_type = get_unaligned_be16(&sub_skb->data[6]);
 
 	if (sub_skb->len >= 8 &&
 		((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
-- 
2.26.2

