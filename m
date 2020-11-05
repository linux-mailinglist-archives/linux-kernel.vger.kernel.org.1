Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727392A7629
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbgKEDsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388649AbgKEDsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:48:18 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E62C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 19:48:17 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id o11so374834ioo.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 19:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McHbX4RcOnMEynY3PA31njE5KEJf144e26V5mcHQkZg=;
        b=jevlTiGVv0DxIG7Gw9fKlSWD52+Q3Y1vS8ymuZ0z7D0QBRSbeRjSw5AjZkrU5XPCC2
         JSx5ZsCYw/QWxm8hia6I2oInul4K/vRUD19kKjiOv8SI1zY38W/0RGEd7gw3faUGV5Eo
         VS1GFXzbnddW1O10tQ7trhv8WmGmC0EHyc5eRdk9KlDGoUVWAZKw6drWKH4KtMbffUab
         cVnBkiRG1fIuu+ps6AhGOZSrU1zUVyvs3EF2iOGKu74bhW2xIxyPFg2F2AATNcNSTX/A
         Tsk3I3EBBv/oZDNasWmqYAN0497Igp7uLfqGL4lh17JUXYwM1DY6VDHi+0prWnG0knYK
         lh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McHbX4RcOnMEynY3PA31njE5KEJf144e26V5mcHQkZg=;
        b=ru0/4nwtd/+CUxh2aLYrCRlCmvDni5NOl2xOmNtkRGxREGh1drmsAB86FJcalUcO2h
         fCC/wCTPfyeXgoh0wjgEH1qhFkk5xrsoC4h1fnm3x8Pjel1itgFJ2smcpsdw5xj6SitB
         IC3zSMGd/rXNkr+YpSVok0D8Ymw2rnMlSm8w2K1S7dboiquBTJoe1toL6by6Eg4YdtmU
         ROGiNQ4KzFB6Ncm0FW5OiASma/RERFxpCS5l3g1U8aWSfzAd9/Xqkk+2Nrnc8j55d8dS
         6zJgiQ2ihF6Oifto4HJuH3lvqNiU+/PTBAUmwBnYpBTJ0ihX3JhXeKskXdnBujXz/8kh
         a0JA==
X-Gm-Message-State: AOAM532zIT+8V6cryRNIPuM+rC93N19cQgtJQRD2rzPOajTxDKIlJm8d
        KLY+k/xXOLlxJTG+qior/HyoLyaChkM=
X-Google-Smtp-Source: ABdhPJxiyDdaF2qEjx5X36rxU/pxoU1lzfCk9UZ7YbnbQ1Y9bCQ0u6KJ5pnlh26pyXX06P7vLRO36A==
X-Received: by 2002:a05:6638:d52:: with SMTP id d18mr561966jak.127.1604548096856;
        Wed, 04 Nov 2020 19:48:16 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id p6sm172877ilc.26.2020.11.04.19.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 19:48:16 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 9/9] staging: rtl8723bs: replace ieee80211_back_actioncode
Date:   Wed,  4 Nov 2020 21:47:54 -0600
Message-Id: <20201105034754.12383-9-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105034754.12383-1-ross.schm.dev@gmail.com>
References: <20201105034754.12383-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the unique rtw_ieee80211_back_actioncode with the standard
provided ieee80211_back_actioncode.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 16 ++++++++--------
 drivers/staging/rtl8723bs/include/ieee80211.h |  7 -------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c113902877bd..1a6cae5f9895 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1944,21 +1944,21 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 		action = frame_body[1];
 		DBG_871X("%s, action =%d\n", __func__, action);
 		switch (action) {
-		case RTW_WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
+		case WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
 
 			memcpy(&(pmlmeinfo->ADDBA_req), &(frame_body[2]), sizeof(struct ADDBA_request));
 			/* process_addba_req(padapter, (u8 *)&(pmlmeinfo->ADDBA_req), GetAddr3Ptr(pframe)); */
 			process_addba_req(padapter, (u8 *)&(pmlmeinfo->ADDBA_req), addr);
 
 			if (pmlmeinfo->accept_addba_req) {
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_ADDBA_RESP, 0);
+				issue_action_BA(padapter, addr, WLAN_ACTION_ADDBA_RESP, 0);
 			} else {
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_ADDBA_RESP, 37);/* reject ADDBA Req */
+				issue_action_BA(padapter, addr, WLAN_ACTION_ADDBA_RESP, 37);/* reject ADDBA Req */
 			}
 
 			break;
 
-		case RTW_WLAN_ACTION_ADDBA_RESP: /* ADDBA response */
+		case WLAN_ACTION_ADDBA_RESP: /* ADDBA response */
 			status = get_unaligned_le16(&frame_body[3]);
 			tid = ((frame_body[5] >> 2) & 0x7);
 
@@ -1981,7 +1981,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 			/* DBG_871X("marc: ADDBA RSP: %x\n", pmlmeinfo->agg_enable_bitmap); */
 			break;
 
-		case RTW_WLAN_ACTION_DELBA: /* DELBA */
+		case WLAN_ACTION_DELBA: /* DELBA */
 			if ((frame_body[3] & BIT(3)) == 0) {
 				psta->htpriv.agg_enable_bitmap &=
 					~BIT((frame_body[3] >> 4) & 0xf);
@@ -4199,7 +4199,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
 				DBG_871X("rx agg disable tid(%d)\n", tid);
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
+				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
 				#ifdef DBG_RX_SEQ
@@ -4213,7 +4213,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
 				DBG_871X("tx agg disable tid(%d)\n", tid);
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
+				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 
@@ -6529,7 +6529,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 		/* pmlmeinfo->ADDBA_retry_count = 0; */
 		/* pmlmeinfo->candidate_tid_bitmap |= (0x1 << pparm->tid); */
 		/* psta->htpriv.candidate_tid_bitmap |= BIT(pparm->tid); */
-		issue_action_BA(padapter, pparm->addr, RTW_WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
+		issue_action_BA(padapter, pparm->addr, WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
 		/* _set_timer(&pmlmeext->ADDBA_timer, ADDBA_TO); */
 		_set_timer(&psta->addba_retry_timer, ADDBA_TO);
 	} else {
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index cd8f6d006a38..bf53d850c370 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -913,13 +913,6 @@ enum _PUBLIC_ACTION {
 	ACT_PUBLIC_MAX
 };
 
-/* BACK action code */
-enum rtw_ieee80211_back_actioncode {
-	RTW_WLAN_ACTION_ADDBA_REQ = 0,
-	RTW_WLAN_ACTION_ADDBA_RESP = 1,
-	RTW_WLAN_ACTION_DELBA = 2,
-};
-
 /* BACK (block-ack) parties */
 enum rtw_ieee80211_back_parties {
 	RTW_WLAN_BACK_RECIPIENT = 0,
-- 
2.25.1

