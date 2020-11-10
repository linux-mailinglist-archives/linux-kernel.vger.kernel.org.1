Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA602ACE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbgKJEKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 23:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731969AbgKJEKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:10:23 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 20:10:23 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id t8so7829288iov.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 20:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXAxrNz1Dc12d9SAAQ35NbJvI+L3WcaSLevuULZjXUM=;
        b=u4ax+2DQUAYiYjBz79FPTkX0v3vQUcQe8r8VHzf9+10ajCcKRl/XXqEd91lYeiOxWf
         5H+SXpsi/Kh5ubD5vGaCGxoQJAmI5H0fcAYyAfxkxboyCoApZ16f3ywG7qXARtxz4M2y
         3ehsxtmZ0i/b2/eGu9KSYub17su0dsz5a1oAfQhMxQPHUmINk0YPQpHoBjCBlLGXLymi
         dBYn+sD/dAaQYB7udjBSHcrPQOoj8DlNw2XqDgaUUu1MwsYkkAgHx++W6tBdevrXbCCF
         3hAlSJKqGdk2VHWZ2jpUTvh41v04HJHe/49xO9lP/Mc+axoRJdAnDDK1yRo6/0E6Ns+k
         i/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXAxrNz1Dc12d9SAAQ35NbJvI+L3WcaSLevuULZjXUM=;
        b=Kjp2FhqwyW/nB+ed6GkGRdgqCsyCIIE4373xo7h4kIkTqOMZPmXubRJWpik3VvPIq0
         0UJZqqtTVWrmUylCbzRFnOp+i80HxK+5GC8fjOfXxvUtExo9jwP3JxaGMvBSZHjbsgUy
         VD4ZChxAqMN6AliJh+Ms4BsDu4LYL3dmWTUPMReYj1iptL5+qnMCl/VR+jEHq3vJ7dOo
         RuSCgH8jXSE/3H97oiCXJ+k8AXdYfpgNg1ue48tuFDm8KPIodlt8HlmbNJ9siuIONSLg
         WBUcIYWmVvtsQxdCDnaR9nrfObTAi2K8ITpht9IGXikvGU6IQRHQtq036B2LnJXoNmGT
         O5Wg==
X-Gm-Message-State: AOAM5324BbnVEJAQUtjN/joANjzt8sQ8jn5uDh3PK21W/OcTS8UJkXDF
        o3DN6fqM3X+9zwoMWku19KbKAiNhIyA=
X-Google-Smtp-Source: ABdhPJwNkVDZExYWTb3kXLXdbxuV5TEeAirLJvIGwGfo9RM+cRNibQ1Rg7DGLPld6TxXGtI3MBmGRg==
X-Received: by 2002:a6b:ef11:: with SMTP id k17mr12524107ioh.210.1604981422427;
        Mon, 09 Nov 2020 20:10:22 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id e21sm6658842ioc.0.2020.11.09.20.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 20:10:21 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 03/10] staging: rtl8723bs: clean up space before tabs
Date:   Mon,  9 Nov 2020 22:10:01 -0600
Message-Id: <20201110041008.15847-3-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110041008.15847-1-ross.schm.dev@gmail.com>
References: <20201110041008.15847-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spaces before tabs to fix coding style issues and clear
checkpatch warnings.

WARNING: please, no space before tabs

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 16 +++----
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 42 +++++++++---------
 drivers/staging/rtl8723bs/core/rtw_security.c | 44 +++++++++----------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 34 +++++++-------
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 20 ++++-----
 5 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 0d8aa7a2469e..8fe1d7429760 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -1340,8 +1340,8 @@ void rtw_ps_deny(struct adapter *padapter, enum PS_DENY_REASON reason)
 {
 	struct pwrctrl_priv *pwrpriv;
 
-/* 	DBG_871X("+" FUNC_ADPT_FMT ": Request PS deny for %d (0x%08X)\n", */
-/* 		FUNC_ADPT_ARG(padapter), reason, BIT(reason)); */
+	/* DBG_871X("+" FUNC_ADPT_FMT ": Request PS deny for %d (0x%08X)\n", */
+	/* FUNC_ADPT_ARG(padapter), reason, BIT(reason)); */
 
 	pwrpriv = adapter_to_pwrctl(padapter);
 
@@ -1353,8 +1353,8 @@ void rtw_ps_deny(struct adapter *padapter, enum PS_DENY_REASON reason)
 	pwrpriv->ps_deny |= BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
 
-/* 	DBG_871X("-" FUNC_ADPT_FMT ": Now PS deny for 0x%08X\n", */
-/* 		FUNC_ADPT_ARG(padapter), pwrpriv->ps_deny); */
+	/* DBG_871X("-" FUNC_ADPT_FMT ": Now PS deny for 0x%08X\n", */
+	/* FUNC_ADPT_ARG(padapter), pwrpriv->ps_deny); */
 }
 
 /*
@@ -1366,8 +1366,8 @@ void rtw_ps_deny_cancel(struct adapter *padapter, enum PS_DENY_REASON reason)
 	struct pwrctrl_priv *pwrpriv;
 
 
-/* 	DBG_871X("+" FUNC_ADPT_FMT ": Cancel PS deny for %d(0x%08X)\n", */
-/* 		FUNC_ADPT_ARG(padapter), reason, BIT(reason)); */
+	/* DBG_871X("+" FUNC_ADPT_FMT ": Cancel PS deny for %d(0x%08X)\n", */
+	/* FUNC_ADPT_ARG(padapter), reason, BIT(reason)); */
 
 	pwrpriv = adapter_to_pwrctl(padapter);
 
@@ -1379,8 +1379,8 @@ void rtw_ps_deny_cancel(struct adapter *padapter, enum PS_DENY_REASON reason)
 	pwrpriv->ps_deny &= ~BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
 
-/* 	DBG_871X("-" FUNC_ADPT_FMT ": Now PS deny for 0x%08X\n", */
-/* 		FUNC_ADPT_ARG(padapter), pwrpriv->ps_deny); */
+	/* DBG_871X("-" FUNC_ADPT_FMT ": Now PS deny for 0x%08X\n", */
+	/* FUNC_ADPT_ARG(padapter), pwrpriv->ps_deny); */
 }
 
 /*
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 26e72decb07e..c854aa3ff992 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -25,7 +25,7 @@ void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 	spin_lock_init(&psta_recvpriv->lock);
 
 	/* for (i = 0; i<MAX_RX_NUMBLKS; i++) */
-	/* 	_rtw_init_queue(&psta_recvpriv->blk_strms[i]); */
+	/* _rtw_init_queue(&psta_recvpriv->blk_strms[i]); */
 
 	_rtw_init_queue(&psta_recvpriv->defrag_q);
 }
@@ -55,7 +55,7 @@ sint _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 	precvpriv->precv_frame_buf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(precvpriv->pallocated_frame_buf), RXFRAME_ALIGN_SZ);
 	/* precvpriv->precv_frame_buf = precvpriv->pallocated_frame_buf + RXFRAME_ALIGN_SZ - */
-	/* 						((SIZE_PTR) (precvpriv->pallocated_frame_buf) &(RXFRAME_ALIGN_SZ-1)); */
+	/* ((SIZE_PTR) (precvpriv->pallocated_frame_buf) &(RXFRAME_ALIGN_SZ-1)); */
 
 	precvframe = (union recv_frame *) precvpriv->precv_frame_buf;
 
@@ -316,9 +316,9 @@ sint recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvframe)
 	u8 *pframe, *payload, *pframemic;
 	u8 *mickey;
 	/* u8 *iv, rxdata_key_idx = 0; */
-	struct	sta_info 	*stainfo;
-	struct	rx_pkt_attrib	*prxattrib = &precvframe->u.hdr.attrib;
-	struct	security_priv *psecuritypriv = &adapter->securitypriv;
+	struct sta_info *stainfo;
+	struct rx_pkt_attrib *prxattrib = &precvframe->u.hdr.attrib;
+	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
@@ -340,7 +340,7 @@ sint recvframe_chkmic(struct adapter *adapter,  union recv_frame *precvframe)
 
 				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic: bcmc key\n"));
 				/* DBG_871X("\n recvframe_chkmic: bcmc key psecuritypriv->dot118021XGrpKeyid(%d), pmlmeinfo->key_index(%d) , recv key_id(%d)\n", */
-				/* 								psecuritypriv->dot118021XGrpKeyid, pmlmeinfo->key_index, rxdata_key_idx); */
+				/* psecuritypriv->dot118021XGrpKeyid, pmlmeinfo->key_index, rxdata_key_idx); */
 
 				if (psecuritypriv->binstallGrpkey == false) {
 					res = _FAIL;
@@ -600,13 +600,13 @@ union recv_frame *portctrl(struct adapter *adapter, union recv_frame *precv_fram
 			prtnframe = precv_frame;
 			/* check is the EAPOL frame or not (Rekey) */
 			/* if (ether_type == eapol_type) { */
-			/* 	RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("########portctrl:ether_type == 0x888e\n")); */
+			/* RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("########portctrl:ether_type == 0x888e\n")); */
 				/* check Rekey */
 
-			/* 	prtnframe =precv_frame; */
+			/* prtnframe =precv_frame; */
 			/*  */
 			/* else { */
-			/* 	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:ether_type = 0x%04x\n", ether_type)); */
+			/* RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:ether_type = 0x%04x\n", ether_type)); */
 			/*  */
 		}
 	} else
@@ -735,11 +735,11 @@ void process_wmmps_data(struct adapter *padapter, union recv_frame *precv_frame)
 void count_rx_stats(struct adapter *padapter, union recv_frame *prframe, struct sta_info *sta);
 void count_rx_stats(struct adapter *padapter, union recv_frame *prframe, struct sta_info *sta)
 {
-	int	sz;
-	struct sta_info 	*psta = NULL;
-	struct stainfo_stats	*pstats = NULL;
-	struct rx_pkt_attrib	*pattrib = &prframe->u.hdr.attrib;
-	struct recv_priv 	*precvpriv = &padapter->recvpriv;
+	int sz;
+	struct sta_info *psta = NULL;
+	struct stainfo_stats *pstats = NULL;
+	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
+	struct recv_priv *precvpriv = &padapter->recvpriv;
 
 	sz = get_recvframe_len(prframe);
 	precvpriv->rx_bytes += sz;
@@ -779,8 +779,8 @@ sint sta2sta_data_frame(
 	u8 *ptr = precv_frame->u.hdr.rx_data;
 	sint ret = _SUCCESS;
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
-	struct	sta_priv 	*pstapriv = &adapter->stapriv;
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	u8 *mybssid  = get_bssid(pmlmepriv);
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
 	u8 *sta_addr = NULL;
@@ -878,8 +878,8 @@ sint ap2sta_data_frame(
 	u8 *ptr = precv_frame->u.hdr.rx_data;
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
 	sint ret = _SUCCESS;
-	struct	sta_priv 	*pstapriv = &adapter->stapriv;
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	u8 *mybssid  = get_bssid(pmlmepriv);
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
 	sint bmcast = IS_MCAST(pattrib->dst);
@@ -1026,8 +1026,8 @@ sint sta2ap_data_frame(
 {
 	u8 *ptr = precv_frame->u.hdr.rx_data;
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
-	struct	sta_priv 	*pstapriv = &adapter->stapriv;
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	unsigned char *mybssid  = get_bssid(pmlmepriv);
 	sint ret = _SUCCESS;
 
@@ -2557,7 +2557,7 @@ s32 rtw_recv_entry(union recv_frame *precvframe)
 	struct recv_priv *precvpriv;
 	s32 ret = _SUCCESS;
 
-/* 	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+rtw_recv_entry\n")); */
+	/* RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+rtw_recv_entry\n")); */
 
 	padapter = precvframe->u.hdr.adapter;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 85f1164f7960..41b80e433cc2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -221,10 +221,10 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	u8 *pframe, *payload, *iv;    /* wepkey */
 	u8 wepkey[16];
-	u8   hw_hdr_offset = 0;
-	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
-	struct	xmit_priv 	*pxmitpriv = &padapter->xmitpriv;
+	u8 hw_hdr_offset = 0;
+	struct pkt_attrib *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
 		return;
@@ -664,9 +664,9 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 	u8 *pframe, *payload, *iv, *prwskey;
 	union pn48 dot11txpn;
-	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
-	struct	xmit_priv 	*pxmitpriv = &padapter->xmitpriv;
+	struct pkt_attrib *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	u32 res = _SUCCESS;
 
 	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
@@ -740,10 +740,10 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 	u8 *pframe, *payload, *iv, *prwskey;
 	union pn48 dot11txpn;
-	struct	sta_info 	*stainfo;
-	struct	rx_pkt_attrib	 *prxattrib = &((union recv_frame *)precvframe)->u.hdr.attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
-	u32 	res = _SUCCESS;
+	struct sta_info *stainfo;
+	struct rx_pkt_attrib *prxattrib = &((union recv_frame *)precvframe)->u.hdr.attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	u32 res = _SUCCESS;
 
 	pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
 
@@ -1477,15 +1477,15 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {	/*  exclude ICV */
 
 	/*static*/
-/* 	unsigned char message[MAX_MSG_SIZE]; */
+	/* unsigned char message[MAX_MSG_SIZE]; */
 
 	/* Intermediate Buffers */
-	sint	curfragnum, length;
+	sint curfragnum, length;
 	u8 *pframe, *prwskey;	/*  *payload,*iv */
-	u8   hw_hdr_offset = 0;
-	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
-	struct	xmit_priv 	*pxmitpriv = &padapter->xmitpriv;
+	u8 hw_hdr_offset = 0;
+	struct pkt_attrib *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	u32 res = _SUCCESS;
 
@@ -1793,15 +1793,15 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 {	/*  exclude ICV */
 
 	/*static*/
-/* 	unsigned char message[MAX_MSG_SIZE]; */
+	/* unsigned char message[MAX_MSG_SIZE]; */
 
 	/* Intermediate Buffers */
 
-	sint		length;
+	sint length;
 	u8 *pframe, *prwskey;	/*  *payload,*iv */
-	struct	sta_info 	*stainfo;
-	struct	rx_pkt_attrib	 *prxattrib = &((union recv_frame *)precvframe)->u.hdr.attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
+	struct sta_info *stainfo;
+	struct rx_pkt_attrib *prxattrib = &((union recv_frame *)precvframe)->u.hdr.attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	u32 res = _SUCCESS;
 
 	pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 2fedaa1b4870..a6176e86f370 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -802,7 +802,7 @@ void WMMOnAssocRsp(struct adapter *padapter)
 	u32 edca[4], inx[4];
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct xmit_priv 	*pxmitpriv = &padapter->xmitpriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct registry_priv *pregpriv = &padapter->registrypriv;
 
 	acm_mask = 0;
@@ -937,7 +937,7 @@ static void bwmode_update_check(struct adapter *padapter, struct ndis_80211_var_
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u8 cbw40_enable = 0;
 
 	if (!pIE)
@@ -1030,8 +1030,8 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 	u8 cur_ldpc_cap = 0, cur_stbc_cap = 0;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	if (!pIE)
 		return;
@@ -1043,8 +1043,8 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	for (i = 0; i < (pIE->Length); i++) {
 		if (i != 2) {
-			/* 	Commented by Albert 2010/07/12 */
-			/* 	Got the endian issue here. */
+			/* Commented by Albert 2010/07/12 */
+			/* Got the endian issue here. */
 			pmlmeinfo->HT_caps.u.HT_cap[i] &= (pIE->data[i]);
 		} else {
 			/* modify from  fw by Thomas 2010/11/17 */
@@ -1113,8 +1113,8 @@ void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	if (!pIE)
 		return;
@@ -1131,8 +1131,8 @@ void HT_info_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 void HTOnAssocRsp(struct adapter *padapter)
 {
-	unsigned char 	max_AMPDU_len;
-	unsigned char 	min_MPDU_spacing;
+	unsigned char max_AMPDU_len;
+	unsigned char min_MPDU_spacing;
 	/* struct registry_priv  *pregpriv = &padapter->registrypriv; */
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
@@ -1229,8 +1229,8 @@ void update_ldpc_stbc_cap(struct sta_info *psta)
 
 int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 {
-	unsigned int		len;
-	unsigned char 	*p;
+	unsigned int len;
+	unsigned char *p;
 	unsigned short	val16, subtype;
 	struct wlan_network *cur_network = &(Adapter->mlmepriv.cur_network);
 	/* u8 wpa_ie[255], rsn_ie[255]; */
@@ -1530,7 +1530,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 
 int support_short_GI(struct adapter *padapter, struct HT_caps_element *pHT_caps, u8 bwmode)
 {
-	unsigned char 				bit_offset;
+	unsigned char bit_offset;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
@@ -1604,7 +1604,7 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 				if (pIE->Length >= 5) {
 					if (pIE->data[4] == 1)
 						/* if (pIE->data[5] & RT_HT_CAP_USE_LONG_PREAMBLE) */
-						/* 	bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
+						/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_LONG_PREAMBLE; */
 						if (pIE->data[5] & RT_HT_CAP_USE_92SE)
 							/* bssDesc->BssHT.RT2RT_HT_Mode |= RT_HT_CAP_USE_92SE; */
 							Vender = HT_IOT_PEER_REALTEK_92SE;
@@ -1730,8 +1730,8 @@ void update_wireless_mode(struct adapter *padapter)
 	u32 SIFS_Timer;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
-	unsigned char 		*rate = cur_network->SupportedRates;
+	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
+	unsigned char *rate = cur_network->SupportedRates;
 
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable))
 		pmlmeinfo->HT_enable = 1;
@@ -2141,7 +2141,7 @@ void rtw_get_current_ip_address(struct adapter *padapter, u8 *pcurrentip)
 #ifdef CONFIG_WOWLAN
 void rtw_get_sec_iv(struct adapter *padapter, u8 *pcur_dot11txpn, u8 *StaAddr)
 {
-	struct sta_info 	*psta;
+	struct sta_info *psta;
 	struct security_priv *psecpriv = &padapter->securitypriv;
 
 	memset(pcur_dot11txpn, 0, 8);
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index af23c649a870..391bc666f7a6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -363,8 +363,8 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
 
 	/*  (1) RTS_Threshold is compared to the MPDU, not MSDU. */
 	/*  (2) If there are more than one frag in  this MSDU, only the first frag uses protection frame. */
-	/* 		Other fragments are protected by previous fragment. */
-	/* 		So we only need to check the length of first fragment. */
+	/* Other fragments are protected by previous fragment. */
+	/* So we only need to check the length of first fragment. */
 	if (pmlmeext->cur_wireless_mode < WIRELESS_11_24N  || padapter->registrypriv.wifi_spec) {
 		if (sz > padapter->registrypriv.rts_thresh) {
 			pattrib->vcs_mode = RTS_CTS;
@@ -648,9 +648,9 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 	struct ethhdr etherhdr;
 
 	sint bmcast;
-	struct sta_priv 	*pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct qos_priv 	*pqospriv = &pmlmepriv->qospriv;
+	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
 	sint res = _SUCCESS;
 
 	DBG_COUNTER(padapter->tx_logs.core_tx_upd_attrib);
@@ -812,10 +812,10 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 {
 	sint			curfragnum, length;
 	u8 *pframe, *payload, mic[8];
-	struct	mic_data		micdata;
-	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
-	struct	xmit_priv 	*pxmitpriv = &padapter->xmitpriv;
+	struct mic_data micdata;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
 	u8 hw_hdr_offset = 0;
 	sint bmcst = IS_MCAST(pattrib->ra);
@@ -1237,8 +1237,8 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, _pkt *pkt, struct xmit
 {
 	u8 *pframe, *mem_start = NULL, *tmp_buf = NULL;
 	u8 subtype;
-	struct sta_info 	*psta = NULL;
-	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
+	struct sta_info *psta = NULL;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 	s32 bmcst = IS_MCAST(pattrib->ra);
 	u8 *BIP_AAD = NULL;
 	u8 *MGMT_body = NULL;
-- 
2.25.1

