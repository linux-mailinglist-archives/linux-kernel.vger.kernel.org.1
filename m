Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD3296020
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900230AbgJVNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900202AbgJVNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:37:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA8EC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:37:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c16so2287903wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZZV4ffF4t+t01RKSJGPFAOGdVaSv3k/nLSd6l7lD08=;
        b=D0Ao1njOzjQ6IdZQAHxd1A84huIlTvUCJTXCAQhNoKuSjqoOsQF2f/oIMP2oHwGuUA
         aDTklkY3ju3qD/eM011me8bMYM2usafIifdwMqnqMbq5DcL/M8wKA++WpkYmJW87nuY6
         eADppQQcJCeX+tzLYzbtrQ05sjeTG2S4SBWKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZZV4ffF4t+t01RKSJGPFAOGdVaSv3k/nLSd6l7lD08=;
        b=pYCM5224EkI59+96lwbGKOYCJu7T2O4PNHRK8+hLJmT8vMmPAMxMFOWVFIxtIpgDul
         t1nZVc+F8k+EFy8U9Y/BvD6rOTETY6Th5ND8SmYri6N2d8sChvYOvgko2oYYCR+pdHZC
         zv21+hPAaK3so0y062OyvJsq4DX9ItzDzY/6d2LAWSkWCnH2nk0cO0Aq8US0CM65guCX
         kfH4EkmOgMOOzpDTMrKTSzcebcwv2IxZGh3s+WbQ/lUrFL2/PQIt3GjTJRJwfg0mGUPL
         X6wHCKhoFGGLVJviKSIoFWQQySUKAJ0XdbnYI/eXwkoOnivXmzr7X2vER+35ImUpmVZc
         7nsQ==
X-Gm-Message-State: AOAM531gX17+KjbQx0EW1TVrpBExxpGO8RmidcR+8SAnGwRu3Zskqs1d
        5QI2igXV/PhpIN8Nqxte7W0COg==
X-Google-Smtp-Source: ABdhPJyj3CtaDwRNr3rjY7qm50rCEtFan9QRCWUmj128pucNzLwWUz5ZYLrfXEI1xi+6UeaA+I7HJQ==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr2589725wmf.0.1603373878059;
        Thu, 22 Oct 2020 06:37:58 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q10sm4094031wrp.83.2020.10.22.06.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:37:57 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tfiga@chromium.org, Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 2/6] media: uvcvideo: Add UVC_CTRL_FLAG_ENTITY_GET_CUR
Date:   Thu, 22 Oct 2020 15:37:49 +0200
Message-Id: <20201022133753.310506-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201022133753.310506-1-ribalda@chromium.org>
References: <20201022133753.310506-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag allows controls to get their current value from an entity
defined function instead of via a query to the USB device.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 17 +++++++++++++----
 include/uapi/linux/uvcvideo.h    |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 7acdc055613b..0a8835742d49 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1001,10 +1001,19 @@ static int __uvc_ctrl_get(struct uvc_video_chain *chain,
 		return -EACCES;
 
 	if (!ctrl->loaded) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
-				chain->dev->intfnum, ctrl->info.selector,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
-				ctrl->info.size);
+		if (ctrl->info.flags & UVC_CTRL_FLAG_ENTITY_GET_CUR) {
+			if (!ctrl->entity->get_cur)
+				return -EINVAL;
+			ret = ctrl->entity->get_cur(ctrl->entity,
+					ctrl->info.selector,
+					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+					ctrl->info.size);
+		} else {
+			ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
+					     chain->dev->intfnum, ctrl->info.selector,
+					     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
+					     ctrl->info.size);
+		}
 		if (ret < 0)
 			return ret;
 
diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
index 69b636290c31..cb91797d2a09 100644
--- a/include/uapi/linux/uvcvideo.h
+++ b/include/uapi/linux/uvcvideo.h
@@ -32,6 +32,7 @@
 #define UVC_CTRL_FLAG_ASYNCHRONOUS	(1 << 8)
 /* Entity queries */
 #define UVC_CTRL_FLAG_ENTITY_GET_INFO	(1 << 9)
+#define UVC_CTRL_FLAG_ENTITY_GET_CUR	(1 << 10)
 
 #define UVC_CTRL_FLAG_GET_RANGE \
 	(UVC_CTRL_FLAG_GET_CUR | UVC_CTRL_FLAG_GET_MIN | \
-- 
2.29.0.rc1.297.gfa9743e501-goog

