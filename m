Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA692B9D21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKSVud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgKSVub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:50:31 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE91C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:50:30 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so8553747wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55kTCi5y+XICNGDL7/0eGjMXC1xD8wNQoc79/T3mLfc=;
        b=JjYyZQ4S7vK8vC8Y7IimnwmKCaXDRkK6YetwVCQyP+Kp1TP3VmRgkRoVh2+1T3ZuPZ
         spU2DMO4uYH+89dwK76VqHR0Lh/gweJX8DhzxTm28C2NGdO0+S/hI2NbGKKo6NMwLrc2
         oeRifcizLjIdoFIcH3u+DnFE/uaPZMoSW83gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55kTCi5y+XICNGDL7/0eGjMXC1xD8wNQoc79/T3mLfc=;
        b=PVVWnhqO79uO7ZcHOz+3/tyFV3U1INlOu02uio8zEVd83uYwiIGCm+d/7Y0Bv5jC+s
         pijl/cuJgi5ukZjZ/hHTtg/xflH/va40UGUMT2x79gocPbDwbBOOMRBb3DziDWBbymZK
         XBuLbgsZia4fNqUxBQ6+5II9ojLmlDeskr272eWmTvyhvGwMhAimhMqwEGnZLf1dFPP5
         l7awMasA7QXU/mL6kVcopxtK5GH1RO+5iXm26j5nWvSoUiUhpVZJ4WPvjnNKfDk+dOfV
         ONjizlrpYXB53Ha9kmOSdvYIf57JSFT4iJWeC2zr/ViKR/KLW9/WBA2DaUr8Hu9sgACJ
         ZYtA==
X-Gm-Message-State: AOAM531VndtHsuy3+Dbm/RKoIYt1sDD1EyOu8ZPGVXMtVXDL2VdZzUIO
        7ORw2HKvJqOcH5i4rBdsjnsopA==
X-Google-Smtp-Source: ABdhPJwGQXcAztFA2b5IjTVFDNRZaQUoXGZkkBNAAEzQVQrwKt6Xuian7/zxpYixdFsBSdopVXiAhg==
X-Received: by 2002:a1c:1fcc:: with SMTP id f195mr6560456wmf.121.1605822629231;
        Thu, 19 Nov 2020 13:50:29 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t136sm1818859wmt.18.2020.11.19.13.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 13:50:28 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 4/8] media: uvcvideo: Entity defined get_info and get_cur
Date:   Thu, 19 Nov 2020 22:50:16 +0100
Message-Id: <20201119215020.508487-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201119215020.508487-1-ribalda@chromium.org>
References: <20201119215020.508487-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows controls to get their properties and current value
from an entity-defined function instead of via a query to the USB
device.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 22 ++++++++++++++++++----
 drivers/media/usb/uvc/uvcvideo.h |  5 +++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0e480b75e724..492328cb470e 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -980,10 +980,20 @@ static int __uvc_ctrl_get(struct uvc_video_chain *chain,
 		return -EACCES;
 
 	if (!ctrl->loaded) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
-				chain->dev->intfnum, ctrl->info.selector,
+		if (ctrl->entity->get_cur) {
+			ret = ctrl->entity->get_cur(chain->dev,
+				ctrl->entity,
+				ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
+		} else {
+			ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
+				ctrl->entity->id,
+				chain->dev->intfnum,
+				ctrl->info.selector,
+				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+				ctrl->info.size);
+		}
 		if (ret < 0)
 			return ret;
 
@@ -1687,8 +1697,12 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 	if (data == NULL)
 		return -ENOMEM;
 
-	ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
-			     info->selector, data, 1);
+	if (ctrl->entity->get_info)
+		ret = ctrl->entity->get_info(dev, ctrl->entity,
+					     ctrl->info.selector, data);
+	else
+		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
+				     dev->intfnum, info->selector, data, 1);
 	if (!ret)
 		info->flags |= (data[0] & UVC_CONTROL_CAP_GET ?
 				UVC_CTRL_FLAG_GET_CUR : 0)
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 00f985001c1d..ae464ba83f4f 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -353,6 +353,11 @@ struct uvc_entity {
 	u8 bNrInPins;
 	u8 *baSourceID;
 
+	int (*get_info)(struct uvc_device *dev, struct uvc_entity *entity,
+			u8 cs, u8 *caps);
+	int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
+		       u8 cs, void *data, u16 size);
+
 	unsigned int ncontrols;
 	struct uvc_control *controls;
 };
-- 
2.29.2.299.gdc1121823c-goog

