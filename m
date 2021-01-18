Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AB32F9B83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbhARIsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387980AbhARIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:48:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49662C0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:47:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d26so15579661wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sr6l15TWUkoLpe2YUMRX8nPBc3XsL3PtVca29QVV2RU=;
        b=d1wWOpKtxL3bQFme34xvxo9phvPySOvA/REPdrSa14GAR33OV+e1KcU73HrjkYNyJh
         G6HARgNhlDDZ0bxFn3Oa3LfCQxoXHrdndaxkFFQnkcypuSnt6wOqThsFffQ309MC7w+u
         o7zhxp94hZ1y3B1UJq7W3cfscuT6NxIfVmuLHjfQe5hPmIbXcIvLPmozeQ/oj5L1EDcP
         GDp8a/wdSIV/iO0Mpeo07Zasw+kfL+tijj6VlxELcrcoJlTQiBWBcoO0ikSF7JfqVDsD
         mP2nUCi/361OhHiMh4fDVUYWUd8cQ0pEYBdQeMhYsiuMKHV0J9bOd/oDsQmr1JhF64f9
         xpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sr6l15TWUkoLpe2YUMRX8nPBc3XsL3PtVca29QVV2RU=;
        b=AtBfdEXNW7KTjjC6PiQU7YTyejfip74f5c8xiEh2DdPAP4bQxuUV0TiW8LuAawMQ5s
         jrS8NwmR1qBo6BGK09XHrbqPlHZ+ml4AUrn1AS8nMfpVZA4XZMuaBVBdOXDTbOzdGOcD
         oLq/2ejcwH58PRKuxb2UUe0PUuPXuByK7WkGWIb+jXssAV273APIekfpBRZXnVGbwE2L
         F2daBSBLNj0mjAmlVh1muouBlVzCXexBs+TxefjhvDj27bTXjuxFej941Jev6y7CRTq5
         Ve8Sr7sAwUK7eSzsWrVBG6eRQCKyR2rbVc4D6W+p/MzXXf1MIP0O1LnBuozOhNKbqagQ
         gpEg==
X-Gm-Message-State: AOAM530PTTX7k0wb5PmgBK9Mr1eC3b9oUZWvw1DaTey3Hzk06az3uEsU
        IkYQLs3yw4w18y3gbMKMKCVTvg==
X-Google-Smtp-Source: ABdhPJzkiDJt0vwiDk2XiiLMw04jRqJaGrGpZ/BwH3/nCtXRUkaiD6iGX0d09r7jDARG0DRWf6k6Hg==
X-Received: by 2002:adf:9e47:: with SMTP id v7mr24337382wre.185.1610959625003;
        Mon, 18 Jan 2021 00:47:05 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id y63sm26224518wmd.21.2021.01.18.00.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 00:47:04 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] usb: gadget: u_audio: remove struct uac_req
Date:   Mon, 18 Jan 2021 09:46:41 +0100
Message-Id: <20210118084642.322510-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118084642.322510-1-jbrunet@baylibre.com>
References: <20210118084642.322510-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct uac_req' purpose is to link 'struct usb_request' to the
corresponding 'struct uac_rtd_params'. However member req is never
used. Using the context of the usb request, we can keep track of the
corresponding 'struct uac_rtd_params' just as well, without allocating
extra memory.

Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/gadget/function/u_audio.c | 58 ++++++++++++---------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 27f941f71a9d..a1a1f4c8685c 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -23,11 +23,6 @@
 #define PRD_SIZE_MAX	PAGE_SIZE
 #define MIN_PERIODS	4
 
-struct uac_req {
-	struct uac_rtd_params *pp; /* parent param */
-	struct usb_request *req;
-};
-
 /* Runtime data params for one stream */
 struct uac_rtd_params {
 	struct snd_uac_chip *uac; /* parent chip */
@@ -41,7 +36,7 @@ struct uac_rtd_params {
 	void *rbuf;
 
 	unsigned int max_psize;	/* MaxPacketSize of endpoint */
-	struct uac_req *ureq;
+	struct usb_request **reqs;
 
 	spinlock_t lock;
 };
@@ -82,10 +77,9 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 	unsigned long flags, flags2;
 	unsigned int hw_ptr;
 	int status = req->status;
-	struct uac_req *ur = req->context;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
-	struct uac_rtd_params *prm = ur->pp;
+	struct uac_rtd_params *prm = req->context;
 	struct snd_uac_chip *uac = prm->uac;
 
 	/* i/f shutting down */
@@ -339,16 +333,16 @@ static inline void free_ep(struct uac_rtd_params *prm, struct usb_ep *ep)
 	params = &audio_dev->params;
 
 	for (i = 0; i < params->req_number; i++) {
-		if (prm->ureq[i].req) {
-			if (usb_ep_dequeue(ep, prm->ureq[i].req))
-				usb_ep_free_request(ep, prm->ureq[i].req);
+		if (prm->reqs[i]) {
+			if (usb_ep_dequeue(ep, prm->reqs[i]))
+				usb_ep_free_request(ep, prm->reqs[i]);
 			/*
 			 * If usb_ep_dequeue() cannot successfully dequeue the
 			 * request, the request will be freed by the completion
 			 * callback.
 			 */
 
-			prm->ureq[i].req = NULL;
+			prm->reqs[i] = NULL;
 		}
 	}
 
@@ -377,22 +371,21 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 	usb_ep_enable(ep);
 
 	for (i = 0; i < params->req_number; i++) {
-		if (!prm->ureq[i].req) {
+		if (!prm->reqs[i]) {
 			req = usb_ep_alloc_request(ep, GFP_ATOMIC);
 			if (req == NULL)
 				return -ENOMEM;
 
-			prm->ureq[i].req = req;
-			prm->ureq[i].pp = prm;
+			prm->reqs[i] = req;
 
 			req->zero = 0;
-			req->context = &prm->ureq[i];
+			req->context = prm;
 			req->length = req_len;
 			req->complete = u_audio_iso_complete;
 			req->buf = prm->rbuf + i * ep->maxpacket;
 		}
 
-		if (usb_ep_queue(ep, prm->ureq[i].req, GFP_ATOMIC))
+		if (usb_ep_queue(ep, prm->reqs[i], GFP_ATOMIC))
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 	}
 
@@ -455,22 +448,21 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	usb_ep_enable(ep);
 
 	for (i = 0; i < params->req_number; i++) {
-		if (!prm->ureq[i].req) {
+		if (!prm->reqs[i]) {
 			req = usb_ep_alloc_request(ep, GFP_ATOMIC);
 			if (req == NULL)
 				return -ENOMEM;
 
-			prm->ureq[i].req = req;
-			prm->ureq[i].pp = prm;
+			prm->reqs[i] = req;
 
 			req->zero = 0;
-			req->context = &prm->ureq[i];
+			req->context = prm;
 			req->length = req_len;
 			req->complete = u_audio_iso_complete;
 			req->buf = prm->rbuf + i * ep->maxpacket;
 		}
 
-		if (usb_ep_queue(ep, prm->ureq[i].req, GFP_ATOMIC))
+		if (usb_ep_queue(ep, prm->reqs[i], GFP_ATOMIC))
 			dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 	}
 
@@ -515,9 +507,10 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 		uac->c_prm.uac = uac;
 		prm->max_psize = g_audio->out_ep_maxpsize;
 
-		prm->ureq = kcalloc(params->req_number, sizeof(struct uac_req),
-				GFP_KERNEL);
-		if (!prm->ureq) {
+		prm->reqs = kcalloc(params->req_number,
+				    sizeof(struct usb_request *),
+				    GFP_KERNEL);
+		if (!prm->reqs) {
 			err = -ENOMEM;
 			goto fail;
 		}
@@ -537,9 +530,10 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 		uac->p_prm.uac = uac;
 		prm->max_psize = g_audio->in_ep_maxpsize;
 
-		prm->ureq = kcalloc(params->req_number, sizeof(struct uac_req),
-				GFP_KERNEL);
-		if (!prm->ureq) {
+		prm->reqs = kcalloc(params->req_number,
+				    sizeof(struct usb_request *),
+				    GFP_KERNEL);
+		if (!prm->reqs) {
 			err = -ENOMEM;
 			goto fail;
 		}
@@ -592,8 +586,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 snd_fail:
 	snd_card_free(card);
 fail:
-	kfree(uac->p_prm.ureq);
-	kfree(uac->c_prm.ureq);
+	kfree(uac->p_prm.reqs);
+	kfree(uac->c_prm.reqs);
 	kfree(uac->p_prm.rbuf);
 	kfree(uac->c_prm.rbuf);
 	kfree(uac);
@@ -615,8 +609,8 @@ void g_audio_cleanup(struct g_audio *g_audio)
 	if (card)
 		snd_card_free(card);
 
-	kfree(uac->p_prm.ureq);
-	kfree(uac->c_prm.ureq);
+	kfree(uac->p_prm.reqs);
+	kfree(uac->c_prm.reqs);
 	kfree(uac->p_prm.rbuf);
 	kfree(uac->c_prm.rbuf);
 	kfree(uac);
-- 
2.29.2

