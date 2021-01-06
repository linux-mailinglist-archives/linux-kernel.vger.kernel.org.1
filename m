Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE32EBEE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbhAFNik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbhAFNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:38:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843EEC06135D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:37:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id x16so5038120ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9smjvmBrXS956ZqDnNmJ0jm4AV+owA3S3+oE2oCsDc=;
        b=mVLKEpdBbpPhnWhJ1Fg67spUEXzH9vbPYksVD5A9g/p8rNULEVaFO8Nsmntljq9aQ6
         +UtH/0mz0Agr7If7rd4x5F/3hgGeuKqM5sYwE2OCWTX3FICeUSaN280NDpgsdt06Xg/G
         C3pO3I7QdP4S7HjdvbxwhkYEPo5Z07OL6Wflm4UEM1rS+Tiz9IPlB4LT4ztr6VhBxQmi
         7JZHZzuh4etylydOc9R8DKvM6A3Rz6yYNTek8QxoHWqD9ee9PGTxpWgK+nUDHanleGHh
         Hwq+ieSkR7hBh61a6VxDzDr4RQBGGvTQNa0Ua2CDKlypGbSxCY92LdzrumcyyCUdUfuG
         de4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9smjvmBrXS956ZqDnNmJ0jm4AV+owA3S3+oE2oCsDc=;
        b=oMjr0l4w65J9FBuBlPkiEsLneDM2qAsugZC6QXqZ/do5In12iv7cf34IQkqm83hIgO
         I5qI9Y1tlU1gS9V9GoX5XRNQoa2WSo44jKjcpV4zZI+7m4Q8PWkKKkbLxVrolTjlOaiq
         InO0Ww/oOj2CYvHA//Cqzxw6k5T5nx19keL7LJ+/98yLyGv2JR9ico6dfQ3sSsgqq18J
         Wyo7TBNaCn+4aa8YnDHuhPl3tYuxK8Iaxdnku5IXexiTAaMXIHr+Zi4C1Ap4+nGdeeRK
         qIu446gYLP4r9Nqo2fk+K7Ccsdm+MGpRLlihU20E9kk0eZuSq6LdODVF0nbw02+Tni9v
         Xm9w==
X-Gm-Message-State: AOAM533R4gM2rDBuj9/E5oy3JucvGQuXeHsYNUke4JnSYkXBSpoLOv1c
        L6g7zm3tVtXlRQDwWT+8Kkc6Ow==
X-Google-Smtp-Source: ABdhPJwUM8ViGRlmjo3b0dkpWRCB0Qwg1XcWV/GSMOF6D4xI9X2ewpG8JuLaLBPqMjUL6Ji4CLKJ8g==
X-Received: by 2002:a17:906:3b55:: with SMTP id h21mr2939265ejf.184.1609940230302;
        Wed, 06 Jan 2021 05:37:10 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n20sm1259275ejo.83.2021.01.06.05.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:37:09 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] usb: gadget: u_audio: remove struct uac_req
Date:   Wed,  6 Jan 2021 14:36:51 +0100
Message-Id: <20210106133652.512178-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106133652.512178-1-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
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
index 045f237472a7..1d12657b3b73 100644
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

