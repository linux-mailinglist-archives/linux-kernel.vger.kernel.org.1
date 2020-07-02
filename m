Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB48C212862
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 17:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgGBPp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGBPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:45:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26381C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:45:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so13663764pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M5epT+ZnUgKP+WCCXExIrVbl9Uf15MOmZ2N+7978elE=;
        b=DKYPBWm73CUJPwZ5vWCd5nexOuLCVv9xz7Z+H6m7w+/pjgI/1+jIO+Mm6dTdAeDkox
         rmSVdm1HuYFB3c1wisNEbkB+WQdaFb4Gm7uvcYeKasyZbx+YS1nhN4jrwT21rPLMCnwb
         pua0fKKHoJOBlwzOouwBIWN3f+lprwa0uZfi3FMoT15r+kYqn5ydb3gDQ4G0XNA/SWYf
         C3OM4i7DAZZcy5nEKryodmsrI+TtUDxMdYHO40TfKd0UnynRoA9g8IeIW8Tw0sDODAvy
         cZGHH3n8PW4EdGNYhR7Q11Z0BF0TqGN/p9QC/qWgZaqX1eeNWDMmdALVOLGfBMkK4GpO
         ZFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=M5epT+ZnUgKP+WCCXExIrVbl9Uf15MOmZ2N+7978elE=;
        b=Mw5zXnX1mpU0YC7kZthSl5IkBd5c6CSeAtUoqpLvQ4D0AFFgCuzz2crf6ZsBgJdY1M
         j0ug9xQpXFhuOrOPSRSlclQDgKj7SNDAAom3hmD/t7IhbJlsGUlQl7/5s1HQKJt2nwN6
         hS4yX/j8Bso4Iv//xhsHrfgODOmAjEeqhG+FNqJGAVxX7LYi+1BfKJRmVwDyMvguyBFI
         YNcbR5zB6rfZkmGYrB2CaTP6HhiOGp3KQZvRhyxnUE1DVgHnlY8mciarcydMNeh6Iz/6
         /OGi3A0q8omBkborg0UUWErwXJv54pFU33aTMP+zVmMo6KpvVZTk41XjXESfAnaip5qH
         N8kw==
X-Gm-Message-State: AOAM532ruLsNHQQzsELfpo+HjgO61I5hV7S+yWWOFyVquDMBZ88hWzev
        dKg5t1tdV/0R7Tuh0ilS1aA=
X-Google-Smtp-Source: ABdhPJykLlKwL2WPoDRiAMRqYEo7wDo2RE5ICzKdbcSkxAQcLiK6SiEHTdjf/LEr4/ls1rQTcN3S6w==
X-Received: by 2002:a63:8b4c:: with SMTP id j73mr24643165pge.209.1593704719681;
        Thu, 02 Jul 2020 08:45:19 -0700 (PDT)
Received: from localhost.localdomain (n11923716050.netvigator.com. [119.237.16.50])
        by smtp.gmail.com with ESMTPSA id f15sm7166804pgr.36.2020.07.02.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:45:19 -0700 (PDT)
From:   Simon Fong <simon.fodin@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     Simon Fong <simon.fodin@gmail.com>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8188eu: Fix WARNINGs of Block comments
Date:   Thu,  2 Jul 2020 23:44:20 +0800
Message-Id: <239f5c7f4761dd2ef0df8ee6966fca8ed2a13a9c.1593703689.git.simon.fodin@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593703689.git.simon.fodin@gmail.com>
References: <cover.1593703689.git.simon.fodin@gmail.com>
In-Reply-To: <cover.1593703689.git.simon.fodin@gmail.com>
References: <cover.1593703689.git.simon.fodin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed 5 WARNINGs of Block comments use * on subsequent lines.

Signed-off-by: Simon Fong <simon.fodin@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 62 +++++++++++------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 258531bc1408..9a3e5d5bade9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -49,8 +49,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	spin_lock_init(&pxmitpriv->lock);
 
 	/*
-	Please insert all the queue initializaiton using _rtw_init_queue below
-	*/
+	 * Please insert all the queue initializaiton using _rtw_init_queue below
+	 */
 
 	pxmitpriv->adapter = padapter;
 
@@ -63,10 +63,10 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	_rtw_init_queue(&pxmitpriv->free_xmit_queue);
 
 	/*
-	Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
-	and initialize free_xmit_frame below.
-	Please also apply  free_txobj to link_up all the xmit_frames...
-	*/
+	 * Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
+	 * and initialize free_xmit_frame below.
+	 * Please also apply  free_txobj to link_up all the xmit_frames...
+	 */
 
 	pxmitpriv->pallocated_frame_buf = vzalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
 
@@ -893,17 +893,17 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter, struct pkt_attrib *pat
 }
 
 /*
-
-This sub-routine will perform all the following:
-
-1. remove 802.3 header.
-2. create wlan_header, based on the info in pxmitframe
-3. append sta's iv/ext-iv
-4. append LLC
-5. move frag chunk from pframe to pxmitframe->mem
-6. apply sw-encrypt, if necessary.
-
-*/
+ *
+ * This sub-routine will perform all the following:
+ *
+ * 1. remove 802.3 header.
+ * 2. create wlan_header, based on the info in pxmitframe
+ * 3. append sta's iv/ext-iv
+ * 4. append LLC
+ * 5. move frag chunk from pframe to pxmitframe->mem
+ * 6. apply sw-encrypt, if necessary.
+ *
+ */
 s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct xmit_frame *pxmitframe)
 {
 	s32 frg_inx, frg_len, mpdu_len, llc_sz, mem_sz;
@@ -1233,25 +1233,25 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 }
 
 /*
-Calling context:
-1. OS_TXENTRY
-2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
-
-If we turn on USE_RXTHREAD, then, no need for critical section.
-Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
-
-Must be very very cautious...
-
-*/
+ * Calling context:
+ * 1. OS_TXENTRY
+ * 2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
+ *
+ * If we turn on USE_RXTHREAD, then, no need for critical section.
+ * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
+ *
+ * Must be very very cautious...
+ *
+ */
 
 struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)
 				/* _queue *pfree_xmit_queue) */
 {
 	/*
-		Please remember to use all the osdep_service api,
-		and lock/unlock or _enter/_exit critical to protect
-		pfree_xmit_queue
-	*/
+	 *	Please remember to use all the osdep_service api,
+	 *	and lock/unlock or _enter/_exit critical to protect
+	 *	pfree_xmit_queue
+	 */
 	struct xmit_frame *pxframe;
 	struct __queue *pfree_xmit_queue = &pxmitpriv->free_xmit_queue;
 
-- 
2.17.1

