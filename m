Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AB12EBEDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbhAFNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbhAFNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:37:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44909C061359
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:37:09 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id dk8so4460741edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTSIWNrCdfFZGrfLRZuDMagz0Cnd73ZK/iAZinL3Hdk=;
        b=z4y0UhlLkVRbZwM3AYQ8WT/PFQO5q/ewfILqGNVWDDSMNZ3Dr694H0d6AwNfgq+ISL
         FdSNQMMAd0pT0ZKv3rBEBj9s5p1d/TBNyPHUpQe0Z73m+HSZJAq86rGi4NbhDsMJmlBf
         xt32C+2TcJPryWI7lUZBIucFO8LIuFBGBQGsRDRpm4I5kF5Z1qFOC1XFeoC/PO5SHU3E
         6M321HF23UdseRxzEJYX3DeJdDCy44rJgNUdxHrubStKupfWATezQ04igbAJekVSFdy5
         4kwsTwcjTEWkozYqZZGv4hV3qMn5BMZyqBq8+5kIEKRWq90/NIyqM91iN5MC+ZvFokk/
         CCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTSIWNrCdfFZGrfLRZuDMagz0Cnd73ZK/iAZinL3Hdk=;
        b=EA0N4qDHfuPqAtomqQ5fwBYCfnByx00Sk8zGqa9+7M7cA2kBfnGdczCe6xKTrz1c2t
         Q+E7vCGXqEiTKGJl0R3GLA+V8HIj9i3B9tSHLHNaix6SxAYG5IjjKML1KuolG5eDLhVT
         NGy1pgz+NyKp7ctJx1NOgMIchETEufxAUz3YqgeihNy5PgTFY5+beMLuEj+xi7mKUmeA
         +XC6b+ugsx0M5GNfuIwrfnBV5/egUhTf7WVBqvIYcubGgomVK9XvQNRSLvU9EIuAVV4W
         NxVSY86/EbGgucOy9KSa9W8sfzntvkYuka4wfFsuNA7jnfnNVu6o/HFmkuk50y0LUEpt
         /YJQ==
X-Gm-Message-State: AOAM533B9SscljpHir00yd6ZbbjchvCj87TR9DwkENMJw5sZd4YZr52/
        tmvY6bJk/i8IzPV8D5FQmGdl3Q==
X-Google-Smtp-Source: ABdhPJxTST/UKEVGGXaHxa8sUjQ9TOJ57dlm4hVgN3wyZhrouwJGt0HYUWmDq8U+NVaEhXraKxMb6w==
X-Received: by 2002:a50:bac4:: with SMTP id x62mr3927427ede.59.1609940228024;
        Wed, 06 Jan 2021 05:37:08 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n20sm1259275ejo.83.2021.01.06.05.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:37:07 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] usb: gadget: f_uac2: reset wMaxPacketSize
Date:   Wed,  6 Jan 2021 14:36:49 +0100
Message-Id: <20210106133652.512178-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106133652.512178-1-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 913e4a90b6f9 ("usb: gadget: f_uac2: finalize wMaxPacketSize according to bandwidth")
wMaxPacketSize is computed dynamically but the value is never reset.

Because of this, the actual maximum packet size can only decrease each time
the audio gadget is instantiated.

Reset the endpoint maximum packet size and mark wMaxPacketSize as dynamic
to solve the problem.

Fixes: 913e4a90b6f9 ("usb: gadget: f_uac2: finalize wMaxPacketSize according to bandwidth")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/gadget/function/f_uac2.c | 69 ++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 3633df6d7610..5d960b6603b6 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -271,7 +271,7 @@ static struct usb_endpoint_descriptor fs_epout_desc = {
 
 	.bEndpointAddress = USB_DIR_OUT,
 	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
-	.wMaxPacketSize = cpu_to_le16(1023),
+	/* .wMaxPacketSize = DYNAMIC */
 	.bInterval = 1,
 };
 
@@ -280,7 +280,7 @@ static struct usb_endpoint_descriptor hs_epout_desc = {
 	.bDescriptorType = USB_DT_ENDPOINT,
 
 	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
-	.wMaxPacketSize = cpu_to_le16(1024),
+	/* .wMaxPacketSize = DYNAMIC */
 	.bInterval = 4,
 };
 
@@ -348,7 +348,7 @@ static struct usb_endpoint_descriptor fs_epin_desc = {
 
 	.bEndpointAddress = USB_DIR_IN,
 	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
-	.wMaxPacketSize = cpu_to_le16(1023),
+	/* .wMaxPacketSize = DYNAMIC */
 	.bInterval = 1,
 };
 
@@ -357,7 +357,7 @@ static struct usb_endpoint_descriptor hs_epin_desc = {
 	.bDescriptorType = USB_DT_ENDPOINT,
 
 	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
-	.wMaxPacketSize = cpu_to_le16(1024),
+	/* .wMaxPacketSize = DYNAMIC */
 	.bInterval = 4,
 };
 
@@ -444,12 +444,28 @@ struct cntrl_range_lay3 {
 	__le32	dRES;
 } __packed;
 
-static void set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
+static int set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
 	struct usb_endpoint_descriptor *ep_desc,
-	unsigned int factor, bool is_playback)
+	enum usb_device_speed speed, bool is_playback)
 {
 	int chmask, srate, ssize;
-	u16 max_packet_size;
+	u16 max_size_bw, max_size_ep;
+	unsigned int factor;
+
+	switch (speed) {
+	case USB_SPEED_FULL:
+		max_size_ep = 1023;
+		factor = 1000;
+		break;
+
+	case USB_SPEED_HIGH:
+		max_size_ep = 1024;
+		factor = 8000;
+		break;
+
+	default:
+		return -EINVAL;
+	}
 
 	if (is_playback) {
 		chmask = uac2_opts->p_chmask;
@@ -461,10 +477,12 @@ static void set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
 		ssize = uac2_opts->c_ssize;
 	}
 
-	max_packet_size = num_channels(chmask) * ssize *
+	max_size_bw = num_channels(chmask) * ssize *
 		DIV_ROUND_UP(srate, factor / (1 << (ep_desc->bInterval - 1)));
-	ep_desc->wMaxPacketSize = cpu_to_le16(min_t(u16, max_packet_size,
-				le16_to_cpu(ep_desc->wMaxPacketSize)));
+	ep_desc->wMaxPacketSize = cpu_to_le16(min_t(u16, max_size_bw,
+						    max_size_ep));
+
+	return 0;
 }
 
 /* Use macro to overcome line length limitation */
@@ -670,10 +688,33 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	}
 
 	/* Calculate wMaxPacketSize according to audio bandwidth */
-	set_ep_max_packet_size(uac2_opts, &fs_epin_desc, 1000, true);
-	set_ep_max_packet_size(uac2_opts, &fs_epout_desc, 1000, false);
-	set_ep_max_packet_size(uac2_opts, &hs_epin_desc, 8000, true);
-	set_ep_max_packet_size(uac2_opts, &hs_epout_desc, 8000, false);
+	ret = set_ep_max_packet_size(uac2_opts, &fs_epin_desc, USB_SPEED_FULL,
+				     true);
+	if (ret < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = set_ep_max_packet_size(uac2_opts, &fs_epout_desc, USB_SPEED_FULL,
+				     false);
+	if (ret < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = set_ep_max_packet_size(uac2_opts, &hs_epin_desc, USB_SPEED_HIGH,
+				     true);
+	if (ret < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = set_ep_max_packet_size(uac2_opts, &hs_epout_desc, USB_SPEED_HIGH,
+				     false);
+	if (ret < 0) {
+		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
+		return ret;
+	}
 
 	if (EPOUT_EN(uac2_opts)) {
 		agdev->out_ep = usb_ep_autoconfig(gadget, &fs_epout_desc);
-- 
2.29.2

