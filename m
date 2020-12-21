Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D02DFF28
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgLUSDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgLUSDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:03:17 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BAC061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:02:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y24so9765581edt.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wsch7K/Hnn/3Wb4xvUK2cOpHQ53+sfVj7evWMdQyT98=;
        b=aGhyvuaPGOshy+8ymjZ9e8lnLphr2xwunbCdHxbj/jpEqkyvDj2GCcvQOZTqvdmN34
         irF2+k1CW0+yZFna3nfQkfGX1HpCw20fc8gado+okBZDLs2J+0COsc5d5n/gyCQZCgVT
         aXuHHseKJAZkrKsITJkLbSjPtJ8sExFc7rFZ3zD9tiqg5Eony51rk1/fSIf66chYUvb4
         6PQRBH74scYOFrEfY1yoRHREH1K6Ib+Pzh5qZNtdOet+w8F59+VJjfakp9LdDtam9lj2
         B4rQtNUsIxVpisd94050zPUeqMML6RqINs5GuCvp+igA9aD7EvDVwIQ/oHrb+ldSMo49
         FT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wsch7K/Hnn/3Wb4xvUK2cOpHQ53+sfVj7evWMdQyT98=;
        b=kVoiRj+AjlwuIqiixeRUfbbBpRyCIfbo6w8gP395D8kRcpQKUzdAQ51I1tRZairCkv
         Y1Xx0iq3htFtCVXZ94FDLGHfDEnFGotM3+Ok4s6H215Ajya6Ite6ftE4G0atF3X0tUMw
         q1eK+g8eMqjs9hcBrjqTFIVHdQF+TCeJsvRegm8md2kRETGbyAzbMomxHF/t4LY+phCi
         /oRpIUhQ4n0dNu3Diyod0qz/p2UnyteCoHlfk3ZqakRJKMgnmVRamZX5C0FcXdHYujYQ
         dE174pMZbf28FhDzwkRKY7ayxm9gltopzjuwJjG85eJ5SlFnngKDrrq80qrN3/spR0d9
         xqAQ==
X-Gm-Message-State: AOAM530H92evCRdjrk1+6iLM0QqB/X0k3LPEKJkRaLDFUSVB4Zd0aiTy
        yNKQZRVuml3/BBLpJy+gBSxLnIysQhvsMYUe
X-Google-Smtp-Source: ABdhPJzIlZnvli6+KqTXUyoX/4v9FqCRmPeqaIabPev0Z/qKPK0Sl412YN/NVBfHgzgpahGNana/Qw==
X-Received: by 2002:a50:ce13:: with SMTP id y19mr16994613edi.241.1608572143950;
        Mon, 21 Dec 2020 09:35:43 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id dd18sm9338408ejb.53.2020.12.21.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 09:35:43 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] usb: gadget: u_audio: remove struct uac_req
Date:   Mon, 21 Dec 2020 18:35:30 +0100
Message-Id: <20201221173531.215169-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221173531.215169-1-jbrunet@baylibre.com>
References: <20201221173531.215169-1-jbrunet@baylibre.com>
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

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/gadget/function/u_audio.c | 58 ++++++++++++---------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 2f69bd572ed7..3eba31b8ebcb 100644
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
@@ -339,11 +333,11 @@ static inline void free_ep(struct uac_rtd_params *prm, struct usb_ep *ep)
 	params = &audio_dev->params;
 
 	for (i = 0; i < params->req_number; i++) {
-		if (prm->ureq[i].req) {
-			if (usb_ep_dequeue(ep, prm->ureq[i].req))
-				usb_ep_free_request(ep, prm->ureq[i].req);
+		if (prm->reqs[i]) {
+			if (usb_ep_dequeue(ep, prm->reqs[i]))
+				usb_ep_free_request(ep, prm->reqs[i]);
 			/* else will be freed in u_audio_iso_complete() */
-			prm->ureq[i].req = NULL;
+			prm->reqs[i] = NULL;
 		}
 	}
 
@@ -372,22 +366,21 @@ int u_audio_start_capture(struct g_audio *audio_dev)
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
 
@@ -450,22 +443,21 @@ int u_audio_start_playback(struct g_audio *audio_dev)
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
 
@@ -510,9 +502,10 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
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
@@ -532,9 +525,10 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
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
@@ -587,8 +581,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
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
@@ -610,8 +604,8 @@ void g_audio_cleanup(struct g_audio *g_audio)
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

