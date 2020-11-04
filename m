Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82522A6C68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgKDSHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732230AbgKDSHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:07:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A32FC0401C2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:07:51 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so3267172wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTfpViGp/YAR6eiRBzwI3JOg4O3Heq9bwynk1bWiaJc=;
        b=XQy+ahFQF4UaoqmnsYHhsBvX6grINJ8mOqmb4n3whQ2VJAH53HkpDJ+t7dS4NjvG65
         dwFnIlBMu3R0Ze6S6qDLXK2EZAux7WO/B1/F4Z6ByveOBpDvRT3Myadt9+lc+Eup1K6q
         szK3NmINoG4MX7QNVVbqHOVGDew8/s8D+sShg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTfpViGp/YAR6eiRBzwI3JOg4O3Heq9bwynk1bWiaJc=;
        b=JXrcOeMErhTSpb5P8BtKY5nucvGKFLf2vDEodSOkd+NqUg+oidygSjOWvEhYjv+4vr
         82fcDxubrabTWPbmEdUY64noFoTr3Kb+6a3ggDyPRtaKW7HqKUKafSO4GogmmqvVlOTD
         U1YBCWgzz30Ykil4ZFVVc49RlC44FpqkUtWN6CO3A9TxBNhaqgEZu1Qkk1S6BhsBo+ZM
         ehP0TZ6RscG4IK9/bs3WrpzXR1HPAr68H9ZvaSwxx2TH+foT6IyYA1DOfZ65fDV17CzQ
         CnZm90APREoGcBdtJi3EOmjlhjXB7JgeXOr5xP0XLDNp80KAaIfYPSCf/98niThEYiHR
         8C/w==
X-Gm-Message-State: AOAM533GOsUCNeXQzgJj9Iq0NEjiAffkWp53jNu2oZpHHwlCUtP+Zij/
        LtHYxGXAwcDgkunCAiYvz2cg9Q==
X-Google-Smtp-Source: ABdhPJw6gti+ZBgjhBtFsUallZansd5igSs/VbMB/P6MMiDr5Df+oTbk5CEoHdkq4s9PnLcfQ8ynWw==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr5908044wme.8.1604513270005;
        Wed, 04 Nov 2020 10:07:50 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id y10sm3801841wru.94.2020.11.04.10.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:07:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 5/7] media: uvcvideo: Entity defined get_info and get_cur
Date:   Wed,  4 Nov 2020 19:07:32 +0100
Message-Id: <20201104180734.286789-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201104180734.286789-1-ribalda@chromium.org>
References: <20201104180734.286789-1-ribalda@chromium.org>
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
 drivers/media/usb/uvc/uvc_ctrl.c | 21 +++++++++++++++++----
 drivers/media/usb/uvc/uvcvideo.h |  3 +++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0e480b75e724..076f63af1031 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -980,10 +980,19 @@ static int __uvc_ctrl_get(struct uvc_video_chain *chain,
 		return -EACCES;
 
 	if (!ctrl->loaded) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
-				chain->dev->intfnum, ctrl->info.selector,
+		if (ctrl->entity->get_cur) {
+			ret = ctrl->entity->get_cur(ctrl->entity,
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
 
@@ -1687,8 +1696,12 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 	if (data == NULL)
 		return -ENOMEM;
 
-	ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
-			     info->selector, data, 1);
+	if (ctrl->entity->get_info)
+		ret = ctrl->entity->get_info(ctrl->entity, ctrl->info.selector,
+					     data);
+	else
+		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
+				     dev->intfnum, info->selector, data, 1);
 	if (!ret)
 		info->flags |= (data[0] & UVC_CONTROL_CAP_GET ?
 				UVC_CTRL_FLAG_GET_CUR : 0)
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 00f985001c1d..776b083ed466 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -353,6 +353,9 @@ struct uvc_entity {
 	u8 bNrInPins;
 	u8 *baSourceID;
 
+	int (*get_info)(struct uvc_entity *entity, u8 cs, u8 *caps);
+	int (*get_cur)(struct uvc_entity *entity, u8 cs, void *data, u16 size);
+
 	unsigned int ncontrols;
 	struct uvc_control *controls;
 };
-- 
2.29.1.341.ge80a0c044ae-goog

