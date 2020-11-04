Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFFB2A5E51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgKDGsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgKDGsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:48:07 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00CC061A4D;
        Tue,  3 Nov 2020 22:48:07 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o3so15722924pgr.11;
        Tue, 03 Nov 2020 22:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UZc9qlgFs8CbchOrOL+r6fXR+9YC4L2N3YMq7bhJ0+0=;
        b=rdS5MU5L79qRpQTiXpdQThWirVZOcLRFimad1oO/csh5TOxT5lXTLaOvUbMGHrEa86
         ab8w6iGGzfk4onE5Gy482ldjBhqdEgPQ9NKbtnkuzxqHkb2MCRJ4+M9FwuXD+ORRdCGx
         gbZEP3TAX4uCrjWdpnSMmOxeOMd13gUSgN2DpyPjCzCsnYQqo/5Eyi3nGUp8dvnUIN0O
         QKdnsTUJnW02HNyreYJw2ZvEtDV/49ayJqMiWt4cRtx7fMuasv5dfMlVRbkhrAZaqBts
         MDV60SWeUdBGNSg70uw8g08QTs9Z79NjWncRGlMnOcDwtRtxQJcYUt/No1+sou/8kpWb
         LFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UZc9qlgFs8CbchOrOL+r6fXR+9YC4L2N3YMq7bhJ0+0=;
        b=r7IYTsU0e2NZXWBqOcTZvmp+9zLQZd8V8o3xTzU4Bt+h385KJnhtq9ftCePgHWv2Nx
         4CNuqEZOPLPatuR5rLUMBneRMZryNc2nwV+IoO0FE4dH9853eQ57B3tDs8LcDZeAro6l
         XpHUYWpVoz7OgiUa4J+RqlWPtT0iFE4OyvwgSI3gPQh2VvOJcXfpYqhrJe91dkoZi5te
         TcQ0uZsiFsl5rSII3uboQ9Xt/yZ1g1EOFjtpgzd0RgwGSXLJHc4cM93a4Cx8JNg9tIld
         oqOVv3a6Bw3tqf63K1fmp1P9nd3NK/mdK2K1BE76+UP6TK7k3cBBwN3gMxNv43cUCGWV
         YR2w==
X-Gm-Message-State: AOAM531H84w6pSnTata6Xrens1rDOQZmkqZjIB16qc586udKQr1HVXnu
        52nLW2lMqwchBsoJ6Mh4+RI=
X-Google-Smtp-Source: ABdhPJyaj/FbrDzFn4tjPMhDjKG6aLzqGg8DFGOw9jnUBvDEGU4Tt0LkYY74y0xtSktHQrE/aDWn5w==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr3087081pja.36.1604472487174;
        Tue, 03 Nov 2020 22:48:07 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:48:06 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 10/15] usb: serial: io_ti: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:58 +0530
Message-Id: <20201104064703.15123-11-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
usb_control_msg() with proper error check. Hence use the wrappers
instead of calling usb_control_msg() directly

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
 drivers/usb/serial/io_ti.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index c327d4cf7928..ab2370b80b3c 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -260,16 +260,12 @@ static int ti_vread_sync(struct usb_device *dev, __u8 request,
 {
 	int status;
 
-	status = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
-			(USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN),
-			value, index, data, size, 1000);
-	if (status < 0)
+	status = usb_control_msg_recv(dev, 0, request, USB_TYPE_VENDOR |
+				      USB_RECIP_DEVICE | USB_DIR_IN, value,
+				      index, data, size, 1000, GFP_KERNEL);
+	if (status)
 		return status;
-	if (status != size) {
-		dev_dbg(&dev->dev, "%s - wanted to write %d, but only wrote %d\n",
-			__func__, size, status);
-		return -ECOMM;
-	}
+
 	return 0;
 }
 
@@ -278,16 +274,12 @@ static int ti_vsend_sync(struct usb_device *dev, u8 request, u16 value,
 {
 	int status;
 
-	status = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
-			(USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT),
-			value, index, data, size, timeout);
-	if (status < 0)
+	status = usb_control_msg_send(dev, 0, request, USB_TYPE_VENDOR |
+				      USB_RECIP_DEVICE | USB_DIR_OUT, value,
+				      index, data, size, timeout, GFP_KERNEL);
+	if (status)
 		return status;
-	if (status != size) {
-		dev_dbg(&dev->dev, "%s - wanted to write %d, but only wrote %d\n",
-			__func__, size, status);
-		return -ECOMM;
-	}
+
 	return 0;
 }
 
-- 
2.17.1

