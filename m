Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8972DFFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgLUSbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgLUSbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:31:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F4C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:30:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a6so10774193wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kcgi01wgItQpOubw2spttIDcP8vTsmoc49nzk/8qIw=;
        b=KZzkZ/gSDYYvjeSZ/JCelI18eU6zzJY3dZqIlxQ5JpDcCA4sfRdV7vaFIyDoNmTxrw
         xlBVxAvq9XxYTDO60TXU+oUJ45QbAWCGX3CRiODJMWt/sEXR63VeaAnWGO+G4Su7jgQU
         mKbUKa7Tda+ydjgHi4M6mOP2YX7Jrrd5dEcz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kcgi01wgItQpOubw2spttIDcP8vTsmoc49nzk/8qIw=;
        b=dq54xKq28sdxKDlHSqT33cTOtNEVcks2tQldbB2pshXrXmx27zDLjmh+LlzYqBi0Td
         c20aDe9fPm4KyPHXkBkRbWa3G9Sk/56SURTEOYGLkEnqhOdJkcAzLXLh+4wX0qWYCPyy
         k0X3ca26RFAXxaAfjJY4jmtMwsFjkKf9YtwVXoIY+Vc6qUHnr89rLP9C/+OGGIqyb0Ai
         023D69jSMeBezRLFHo52JEUww78BoYkaVY31AtisypZYhSL2VLokmyueh4LnGFJopkTM
         +5WBpOCnKQryR2BV0JBLWbC7+v6lFEnn3Ch8fVfcNeW4fKv7l4O28BGVIN1sXR8inZm7
         AFCQ==
X-Gm-Message-State: AOAM533DXlLkD7pAEqTD8f/DkdgUb/hM/x93G2nLdJuNZJev6aBUbsqq
        gxxZ3vXt6uG3LIjHo10GcgKY1eZr0GG+x1uG728=
X-Google-Smtp-Source: ABdhPJy+SvXsvllykpmarIUJ6j7nFLIP4ZJYvTdam3Fhnv5/RGxuN5yLbb/mGzynU+kUI+jLdwrwJg==
X-Received: by 2002:a1c:8115:: with SMTP id c21mr17439949wmd.1.1608569306568;
        Mon, 21 Dec 2020 08:48:26 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o125sm24581109wmo.30.2020.12.21.08.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:48:26 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 06/12] media: uvcvideo: Allow entity-defined get_info and get_cur
Date:   Mon, 21 Dec 2020 17:48:13 +0100
Message-Id: <20201221164819.792019-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201221164819.792019-1-ribalda@chromium.org>
References: <20201221164819.792019-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows controls to get their properties and current value
from an entity-defined function instead of via a query to the USB
device.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 22 ++++++++++++++++++----
 drivers/media/usb/uvc/uvcvideo.h |  5 +++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index d7ccd0fcd88d..528254230535 100644
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
 
@@ -1716,8 +1726,12 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
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
index 5d4da54dfd13..6edbf79b2ff1 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -358,6 +358,11 @@ struct uvc_entity {
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
2.29.2.684.gfbc64c5ab5-goog

