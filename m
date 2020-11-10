Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0D2AE042
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgKJTyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbgKJTyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:47 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22483C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:47 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p10so13354283ile.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=784hYvPZE9Kj7QTtRo1zol/rRngB0cVM6VmZ2jBAeR8=;
        b=QDSV/fLjN4nL8wEf8kaOtK3f+amOWKam4Tgzz+WrUsS5kMTinUVhMuOFKDeYwjj2fk
         QtO5lelWzk4ZXCpkFBEL+GA+Yl4aIfwwwgUgV3UprarfYrz0+huxieAsGFdJulfWsFPV
         ywsjSrWMhDg9Ns+4b7IXQDduZjNNXoenpzhIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=784hYvPZE9Kj7QTtRo1zol/rRngB0cVM6VmZ2jBAeR8=;
        b=rcqXW0DOvKm2ybcp4TvAnWiuy59N9LlqQzG+OkL/knUKSraLEaA0fqGOYEVOjsBopm
         V3DLgqcxeCFBaM8182cN/YWBiuxFGwI5tG/+oR72lNKKyKnxVnlkW29tf19wJBrr9ig3
         4+yvMhXnltGLHQ05tfoXqYqEgZjhva7YXyVD9WurwNKmV7Q1m/jlrQHfoXhvVdO2sI2t
         Gw/897iSryChWC23fotSzx9uv2qus101pSEaGnTn4qaht37LYmRX3Ay4w6Ffpmfafp5G
         uwmoyCWFMUBLCRAyD/P5Ck+p1wb9O+e1nV8aF37s1LAs9NhSMc8WWRvmyYJtdl8ogLjX
         c08g==
X-Gm-Message-State: AOAM530MLXC/YJAElWrirm40htLClBZ6+nQPPPkcsaOKQmwv8+K3O7Ct
        XVr179W1tXOBAytOdJg3aPZjTA==
X-Google-Smtp-Source: ABdhPJxw4BEcLVk9f41wkm0Xyp9uehcK69ARUG5kJ31PYy8ogZQxIKS5U9/CCdLxCB5u+1wsU8w7nA==
X-Received: by 2002:a05:6e02:f0e:: with SMTP id x14mr14670137ilj.307.1605038086404;
        Tue, 10 Nov 2020 11:54:46 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:45 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, keescook@chromium.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] drivers/staging/rtl8723bs: convert stats to use seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:35 -0700
Message-Id: <500cc03f4fdea0237576913cfc739ae26d8a0b58.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seqnum_ops api is introduced to be used when a variable is used as
a sequence/stat counter and doesn't guard object lifetimes. This
clearly differentiates atomic_t usages that guard object lifetimes.

seqnum32 variables wrap around to INT_MIN when it overflows and
should not be used to guard resource lifetimes, device usage and
open counts that control state changes, and pm states.

atomic_t variables used for stats are atomic counters. Overflow will
wrap around and reset the stats and no change with the conversion.

Convert them to use seqnum_ops. This conversion replaces inc_return()
with _inc() followed by _read().

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 33 +++++++++++++------
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |  3 +-
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  3 +-
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 2abe205e3453..c3350f97816d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -10,6 +10,7 @@
 #include <rtw_debug.h>
 #include <hal_btcoex.h>
 #include <linux/jiffies.h>
+#include <linux/seqnum_ops.h>
 
 static struct _cmd_callback rtw_cmd_callback[] = {
 	{GEN_CMD_CODE(_Read_MACREG), NULL}, /*0*/
@@ -207,7 +208,7 @@ static void c2h_wk_callback(_workitem * work);
 int rtw_init_evt_priv(struct evt_priv *pevtpriv)
 {
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
-	atomic_set(&pevtpriv->event_seq, 0);
+	seqnum32_set(&pevtpriv->event_seq, 0);
 	pevtpriv->evt_done_cnt = 0;
 
 	_init_workitem(&pevtpriv->c2h_wk, c2h_wk_callback, NULL);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index b912ad2f4b72..addcd11b153b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -11,6 +11,7 @@
 #include <rtw_wifi_regd.h>
 #include <hal_btcoex.h>
 #include <linux/kernel.h>
+#include <linux/seqnum_ops.h>
 #include <asm/unaligned.h>
 
 static struct mlme_handler mlme_sta_tbl[] = {
@@ -281,7 +282,7 @@ static void init_mlme_ext_priv_value(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	atomic_set(&pmlmeext->event_seq, 0);
+	seqnum32_set(&pmlmeext->event_seq, 0);
 	pmlmeext->mgnt_seq = 0;/* reset to zero when disconnect at client mode */
 	pmlmeext->sa_query_seq = 0;
 	pmlmeext->mgnt_80211w_IPN = 0;
@@ -5051,7 +5052,9 @@ void report_survey_event(struct adapter *padapter, union recv_frame *precv_frame
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct survey_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_Survey);
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	psurvey_evt = (struct survey_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 
@@ -5104,7 +5107,9 @@ void report_surveydone_event(struct adapter *padapter)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct surveydone_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_SurveyDone);
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
@@ -5151,7 +5156,9 @@ void report_join_res(struct adapter *padapter, int res)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct joinbss_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_JoinBss);
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	pjoinbss_evt = (struct joinbss_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	memcpy((unsigned char *)(&(pjoinbss_evt->network.network)), &(pmlmeinfo->network), sizeof(struct wlan_bssid_ex));
@@ -5202,7 +5209,9 @@ void report_wmm_edca_update(struct adapter *padapter)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct wmm_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_WMM);
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	pwmm_event = (struct wmm_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	pwmm_event->wmm = 0;
@@ -5249,7 +5258,9 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct stadel_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_DelSTA);
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	pdel_sta_evt = (struct stadel_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	memcpy((unsigned char *)(&(pdel_sta_evt->macaddr)), MacAddr, ETH_ALEN);
@@ -5302,7 +5313,9 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct stassoc_event);
 	pc2h_evt_hdr->ID = GEN_EVT_CODE(_AddSTA);
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	padd_sta_evt = (struct stassoc_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	memcpy((unsigned char *)(&(padd_sta_evt->macaddr)), MacAddr, ETH_ALEN);
@@ -6620,10 +6633,10 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	#ifdef CHECK_EVENT_SEQ
 	/*  checking event sequence... */
-	if (evt_seq != (atomic_read(&pevt_priv->event_seq) & 0x7f)) {
+	if (evt_seq != (seqnum32_read(&pevt_priv->event_seq) & 0x7f)) {
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
 			 ("Event Seq Error! %d vs %d\n", (evt_seq & 0x7f),
-			  (atomic_read(&pevt_priv->event_seq) & 0x7f)));
+			  (seqnum32_read(&pevt_priv->event_seq) & 0x7f)));
 
 		pevt_priv->event_seq = (evt_seq+1)&0x7f;
 
@@ -6647,7 +6660,7 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	}
 
-	atomic_inc(&pevt_priv->event_seq);
+	seqnum32_inc(&pevt_priv->event_seq);
 
 	peventbuf += 2;
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 56c77bc7ca81..cc0ea649388b 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -8,6 +8,7 @@
 #define __RTW_CMD_H_
 
 #include <linux/completion.h>
+#include <linux/seqnum_ops.h>
 
 #define C2H_MEM_SZ (16*1024)
 
@@ -62,7 +63,7 @@
 		struct rtw_cbuf *c2h_queue;
 		#define C2H_QUEUE_MAX_LEN 10
 
-		atomic_t event_seq;
+		struct seqnum32 event_seq;
 		u8 *evt_buf;	/* shall be non-paged, and 4 bytes aligned */
 		u8 *evt_allocated_buf;
 		u32 evt_done_cnt;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 1567831caf91..ebb050253bcf 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -7,6 +7,7 @@
 #ifndef __RTW_MLME_EXT_H_
 #define __RTW_MLME_EXT_H_
 
+#include <linux/seqnum_ops.h>
 
 /* 	Commented by Albert 20101105 */
 /* 	Increase the SURVEY_TO value from 100 to 150  (100ms to 150ms) */
@@ -461,7 +462,7 @@ struct p2p_oper_class_map {
 struct mlme_ext_priv {
 	struct adapter	*padapter;
 	u8 mlmeext_init;
-	atomic_t		event_seq;
+	struct seqnum32		event_seq;
 	u16 mgnt_seq;
 	u16 sa_query_seq;
 	u64 mgnt_80211w_IPN;
-- 
2.27.0

