Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F92AA682
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 17:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKGQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 11:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKGQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 11:01:24 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3750C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 08:01:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x7so4374170wrl.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ociINFeDE4o9/e8k6rOE8mRIF/jLl/+3MEyfMPGa20k=;
        b=Ien+CGwj6oZdQOjQCOlLyjnO2B6/a+p+ydRmdiipIi9dl2R7C+NHSYNZw3yE6dNtRB
         9Nikv0nRzfbyedcuPdxVbX6G6n2u4HIaCgj0jmosQRgC15mMQqbbfWrIQglvtUanjiHE
         IhJsnlFWqp4DAVtpRxpzAJtmJcPUvnfbpKeHfZNAiTr2aytjaQ7QXrix59kTbTnZ9fkO
         oe18CnEllTduOytiHmvCeNOoH4fyFbjuQb5skUl+wvpw1tTZpxeOJuprbPcfcKO8mVVX
         kjsuAi0xLuROjLx23Bq4ensA40S2pSnVgYifFAPMBD+NxLUf8MIb2Agl/YoOu2nrYsH9
         qo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ociINFeDE4o9/e8k6rOE8mRIF/jLl/+3MEyfMPGa20k=;
        b=FO3CQZEfTX+TDe3BoVkQfIDppAla2NuGrS+b9dfycc5G59GXrIoy5yYSXHZyDpI0it
         1nSpvqwc9YPNPmvvloG0x23wbgjTFKiawf6Fjau2Jx0ULcgcQOOLHPX0wl8E6TcTUTgj
         /xip6ogPnfOUr0d94IIKTM3reP2zEVFboHdY+3htcsCS5GsarnX/DvpS3bf0kDz4iOaH
         q49XY4jwBMqfKcCRA5zDhs5uB5bob8WUgq9mCekknVA4TREvmBdLnW8EJFSZzBM2uxHt
         JM9twxlUSsgn6RQRBxg1/WvY+iz/vFEN0LRWHR+v7b7hkoqEAJH/S9cuiieQe7qO+WNt
         Ku+w==
X-Gm-Message-State: AOAM531GdtlnkVqheF2aoo1vvRmO09+K6Sp7ZOMmkEmjvO3kTK1aCcEB
        +fJXDYTG0pRk7J0HzqciD5gbTjkoSr+Zhg==
X-Google-Smtp-Source: ABdhPJwT7O6LvMmhscfCPHAbfMLI4oNGonvHAErMcSq8TPdXuPJsJimww3dzEp+gjuo28HDZqwZtvA==
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr8937644wrv.95.1604764881565;
        Sat, 07 Nov 2020 08:01:21 -0800 (PST)
Received: from archvm.localdomain ([213.91.182.38])
        by smtp.gmail.com with ESMTPSA id m126sm7051099wmm.0.2020.11.07.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 08:01:21 -0800 (PST)
From:   Sotir Danailov <sndanailov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Sotir Danailov <sndanailov@gmail.com>
Subject: [PATCH] drivers: staging: small refactor
Date:   Sat,  7 Nov 2020 18:01:06 +0200
Message-Id: <20201107160106.5367-1-sndanailov@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small refactor of 3 files in the staging directory.

Signed-off-by: Sotir Danailov <sndanailov@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c   |  1 -
 drivers/staging/rtl8188eu/core/rtw_ap.c   |  4 +++-
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 25 +++++++++++++++--------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index f961b353c22e..94ff593508ff 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -541,7 +541,6 @@ static void mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
 
 			if (slot == 1 && tmp && !tmp->enabled)
 				phy_power_off(tmp->phy);
-
 		}
 	}
 }
diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index fa1e34a0d456..6d573648a9d9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -269,7 +269,9 @@ void expire_timeout_chk(struct adapter *padapter)
 			updated = ap_free_sta(padapter, psta, true,
 					      WLAN_REASON_DEAUTH_LEAVING);
 		} else {
-			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
+			/* TODO: Aging mechanism to digest frames in sleep_q
+			 * to avoid running out of xmitframe
+			 */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
 			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2)) {
 				DBG_88E("%s sta:%pM, sleepq_len:%u, free_xmitframe_cnt:%u, asoc_list_cnt:%u, clear sleep_q\n", __func__,
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 317355f830cb..274d93dbdb82 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -44,7 +44,9 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	u32 max_xmit_extbuf_size = MAX_XMIT_EXTBUF_SZ;
 	u32 num_xmit_extbuf = NR_XMIT_EXTBUFF;
 
-	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
+	/*  We don't need to memset padapter->XXX to zero, because adapter is
+	 *  allocated by vzalloc().
+	 */
 
 	spin_lock_init(&pxmitpriv->lock);
 
@@ -680,7 +682,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: before add mic code!!!\n", __func__));
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: pattrib->last_txcmdsz=%d!!!\n", __func__, pattrib->last_txcmdsz));
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: mic[0]=0x%.2x , mic[1]=0x%.2x , mic[2]= 0x%.2x, mic[3]=0x%.2x\n\
-  mic[4]= 0x%.2x , mic[5]= 0x%.2x , mic[6]= 0x%.2x , mic[7]= 0x%.2x !!!!\n",
+mic[4]= 0x%.2x , mic[5]= 0x%.2x , mic[6]= 0x%.2x , mic[7]= 0x%.2x !!!!\n",
 				__func__, mic[0], mic[1], mic[2], mic[3], mic[4], mic[5], mic[6], mic[7]));
 			/* add mic code  and add the mic code length in last_txcmdsz */
 
@@ -1413,8 +1415,12 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 			if (pxmitframe) {
 				phwxmit->accnt--;
 
-				/* Remove sta node when there are no pending packets. */
-				if (list_empty(&pframe_queue->queue)) /* must be done after get_next and before break */
+				/* Remove sta node when there are no
+				 * pending packets.
+				 *
+				 * must be done after get_next and before break
+				 */
+				if (list_empty(&pframe_queue->queue))
 					list_del_init(&ptxservq->tx_pending);
 				goto exit;
 			}
@@ -1660,17 +1666,19 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	if (mcast) {
 		spin_lock_bh(&psta->sleep_q.lock);
 
-		if (pstapriv->sta_dz_bitmap) {/* if any one sta is in ps mode */
+		/* if any one sta is in ps mode */
+		if (pstapriv->sta_dz_bitmap) {
 			list_del_init(&pxmitframe->list);
 
 			list_add_tail(&pxmitframe->list, get_list_head(&psta->sleep_q));
 
 			psta->sleepq_len++;
 
-			pstapriv->tim_bitmap |= BIT(0);/*  */
+			pstapriv->tim_bitmap |= BIT(0);
 			pstapriv->sta_dz_bitmap |= BIT(0);
 
-			update_beacon(padapter, WLAN_EID_TIM, NULL, false);/* tx bc/mc packets after update bcn */
+			/* tx bc/mc packets after update bcn */
+			update_beacon(padapter, WLAN_EID_TIM, NULL, false);
 
 			ret = true;
 		}
@@ -1892,7 +1900,8 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	if (!psta_bmc)
 		return;
 
-	if ((pstapriv->sta_dz_bitmap & 0xfffe) == 0x0) { /* no any sta in ps mode */
+	/* no any sta in ps mode */
+	if ((pstapriv->sta_dz_bitmap & 0xfffe) == 0x0) {
 		spin_lock_bh(&psta_bmc->sleep_q.lock);
 
 		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
-- 
2.29.2

