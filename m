Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6C2AE04E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgKJTzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbgKJTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:49 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BC3C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:49 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n12so15595248ioc.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32QDDBy99x4tVzMXFh/xIB26US706uUEjvkcCJFWukA=;
        b=OUn248GZbW2Yw9FQ0uiDulLq/oPIjyoCPHnMNNcTk5Ng9pX4iSu8ck4tgf1o+tWRoo
         tO+P/fLxnibcqRWyPmNq1D91JTTpH2HwydJkJrrRxzjeGz/VhtSUiAj24nHaLqxn/KCv
         IZ4c9Ks772X23oqaZBGZWnkzMn732tYWBLrxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32QDDBy99x4tVzMXFh/xIB26US706uUEjvkcCJFWukA=;
        b=JiDENVxLy1xYfFR6A1zngbOghg7jmBnhDQ8FWQOQDQX/4xWt+RP1DXUMd2ZRDpWFzg
         ZFdhdHIvRINZ7K4RLv+9DQ2Yx0xtLM6ybxwIpqyvpB1ZHeh37e8Y6rVPW8MvTQfpCmJd
         E/+oDQR2HCCZYqomF1AehvZioCwtdJkGA0RY1BU+8hXhxo4gkiPO/AmzLkx8/bam6fT6
         4Vv0c1DuQYX4Ufv1MVB0zQZqDU+5c9hNSQuL7iLYBnOTrwhJwAk5npUyr6xsWWC9L2D0
         LtBclhBxnPm7O60Jvz9BQn51McnFi5X9CNtgcm00+nP6j6+kS7HaMA+iMWPYUGqnLm1l
         9ETw==
X-Gm-Message-State: AOAM533HFk8UQH+wOdwpyQsEIOtsvHFoVpgYK7ulnH6xmHKhn9dROjW8
        dkxorWyNuJYKmOTIU42zuNRgeA==
X-Google-Smtp-Source: ABdhPJySYJFIOaZ5A9UtN6T0sg9BkPUv7UQuC3GXGxvW+xX8UGhmCv0fWflm9iIJvJyyxnU6Rum5QA==
X-Received: by 2002:a05:6602:242e:: with SMTP id g14mr15689073iob.65.1605038089016;
        Tue, 10 Nov 2020 11:54:49 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:48 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, keescook@chromium.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] drivers/staging/rtl8188eu: convert stats to use seqnum_ops
Date:   Tue, 10 Nov 2020 12:53:37 -0700
Message-Id: <07ada10228dbd8d8954a30d6604fef2db762be69.1605027593.git.skhan@linuxfoundation.org>
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
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 23 ++++++++++++++-----
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |  3 ++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index b3eddcb83cd0..31dd9d31dd9a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -7,6 +7,7 @@
 #define _RTW_MLME_EXT_C_
 
 #include <linux/ieee80211.h>
+#include <linux/seqnum_ops.h>
 #include <asm/unaligned.h>
 
 #include <osdep_service.h>
@@ -3860,7 +3861,7 @@ static void init_mlme_ext_priv_value(struct adapter *padapter)
 		_12M_RATE_, _24M_RATE_, 0xff,
 	};
 
-	atomic_set(&pmlmeext->event_seq, 0);
+	seqnum32_set(&pmlmeext->event_seq, 0);
 	pmlmeext->mgnt_seq = 0;/* reset to zero when disconnect at client mode */
 
 	pmlmeext->cur_channel = padapter->registrypriv.channel;
@@ -4189,7 +4190,9 @@ void report_survey_event(struct adapter *padapter,
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct survey_event);
 	pc2h_evt_hdr->ID = _Survey_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	psurvey_evt = (struct survey_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 
@@ -4239,7 +4242,9 @@ void report_surveydone_event(struct adapter *padapter)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct surveydone_event);
 	pc2h_evt_hdr->ID = _SurveyDone_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
@@ -4283,7 +4288,9 @@ void report_join_res(struct adapter *padapter, int res)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct joinbss_event);
 	pc2h_evt_hdr->ID = _JoinBss_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	pjoinbss_evt = (struct joinbss_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	memcpy((unsigned char *)(&pjoinbss_evt->network.network), &pmlmeinfo->network, sizeof(struct wlan_bssid_ex));
@@ -4333,7 +4340,9 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct stadel_event);
 	pc2h_evt_hdr->ID = _DelSTA_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	pdel_sta_evt = (struct stadel_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	ether_addr_copy((unsigned char *)(&pdel_sta_evt->macaddr), MacAddr);
@@ -4386,7 +4395,9 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct stassoc_event);
 	pc2h_evt_hdr->ID = _AddSTA_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	seqnum32_inc(&pmlmeext->event_seq);
+	pc2h_evt_hdr->seq = seqnum32_read(&pmlmeext->event_seq);
 
 	padd_sta_evt = (struct stassoc_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	ether_addr_copy((unsigned char *)(&padd_sta_evt->macaddr), MacAddr);
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index b11a6886a083..09b7e3bb2738 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -7,6 +7,7 @@
 #ifndef __RTW_MLME_EXT_H_
 #define __RTW_MLME_EXT_H_
 
+#include <linux/seqnum_ops.h>
 #include <osdep_service.h>
 #include <drv_types.h>
 #include <wlan_bssdef.h>
@@ -393,7 +394,7 @@ struct p2p_oper_class_map {
 struct mlme_ext_priv {
 	struct adapter	*padapter;
 	u8	mlmeext_init;
-	atomic_t	event_seq;
+	struct	seqnum32 event_seq;
 	u16	mgnt_seq;
 
 	unsigned char	cur_channel;
-- 
2.27.0

