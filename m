Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DBF2E1CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgLWNhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgLWNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:36:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EBC0611C5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:35:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q75so6178092wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjkonHU1mJHkCtQzMYm5le5K7SMq0C21OXHdjoRdyJA=;
        b=bwy/OyDbVBKU+FY6mqGoGVwkzRHrKwaPPSEhcS3bH8ZvOGB26B7VscG7UoFW/e1RmY
         XnVphzlqXtqWQnZue6q0OJPG0eohnCtYG8y5hwRmM5tC7h+PvnPeHC1FD5c0/I8ZZa5A
         bN0Z2sBq3cV4NDa/jb9uWpuCIxufh9AgmGANQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjkonHU1mJHkCtQzMYm5le5K7SMq0C21OXHdjoRdyJA=;
        b=NuwQM2livhDpdpf+RFsCM/fkgI9HjgMQK5s8dhmJMo8Lh46IJ8L+HrkiMaoFxLk8Yo
         uND5ecDZVKXekJv/wtsPOUS+0E/SQwQhr/C3q9AYuL12k4Xk1ZsYSOMs6g7tU4jsO4Fv
         D4Et/S3lWmcWsE+3VwO5JIUu1nuiRQidY4kSkFMLwSU240BI7o4rLQbwBVU5cAPFu1Sk
         Hjlba7pCmMuu9Nih3zkFC+N91gXISky/wpZ2PCRmLk6ZF0cBM8Fojx+LGIhFyTRw6ehB
         DBEID3A5uRuwyARHvUKA8f+INm+ZN0o7Rrv4BRvmrjIeZ1BvEK9VqLtJaNPBewHzPFY+
         gRww==
X-Gm-Message-State: AOAM530kVoHe47byUeb8gNsuex74VhK+kRGrh/iuYqTP6QIox9xwd4qv
        lEAfBkgFo2gan3r7Mepn8sDIKg==
X-Google-Smtp-Source: ABdhPJwGVmakMrvyjQ2wuiqiw8JumQHQnfLr3yJPDeUUlFxIeRqvY8FbRQoZkIWtuhkLlD6aXL2aKA==
X-Received: by 2002:a1c:81d5:: with SMTP id c204mr26219998wmd.156.1608730534769;
        Wed, 23 Dec 2020 05:35:34 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q143sm31572247wme.28.2020.12.23.05.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 05:35:34 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 05/12] media: uvcvideo: Allow entity-defined get_info and get_cur
Date:   Wed, 23 Dec 2020 14:35:21 +0100
Message-Id: <20201223133528.55014-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201223133528.55014-1-ribalda@chromium.org>
References: <20201223133528.55014-1-ribalda@chromium.org>
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
index 4d43f4c3e349..1a5e85368af4 100644
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
 
@@ -1692,8 +1702,12 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
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
index be784ed8354d..6465711fe5bb 100644
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
2.29.2.729.g45daf8777d-goog

