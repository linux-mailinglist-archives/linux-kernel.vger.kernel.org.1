Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7729602B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900269AbgJVNiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900194AbgJVNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:37:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACC0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:37:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d3so2282867wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdKYKANqyDji6M6kylMPVeVh8pZvdLMVlAzAT/a7CSQ=;
        b=KIYVlz1dtTEMD20BXN2L33ew12vdB/3MM+nyziXAQ5KVCWgQeSNpbBYv0glYIYcLpN
         Wkgw7dc5YZPCpHX+38jXnfz3cEbPzF6e9aCQB/bfddTz6/dRTWdtIHHPJCbrZ6rIcATi
         xSFatDUf+2nkuYIVkL2svMcBCA8E38UBFcvzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdKYKANqyDji6M6kylMPVeVh8pZvdLMVlAzAT/a7CSQ=;
        b=nvPd70/xG8DNT6kq2qT+LvR/Wgom74TeniNx1jk8QeLKHklWDa70+UCLhgfAutbAM3
         OOUtzzW8frgBWPOzfUAHydeJgK67/Vwprkl7Wyli6CdiVgS3PflFvSw/ESSoIuPEANW8
         CrGkKukCmeR5kLV7oNQCoYE/22ikBYL+/7C5IQiOr3BRwAI+v9pwXrq96nqCHAOAZVU0
         PhZxGA1NF+KtHiZ00wwaFbLCgaXQuv37bht+ZMwqrrLL6xbpSYAjwb8nkch2DMzGQM2j
         mwM2DF3JC4xgI6fE+E5iNaKaXWrj/8H7kyg5ZJYuNFoXInTu/NKfWj2hf5oQLakrSG33
         NsyA==
X-Gm-Message-State: AOAM530UH31q/h/nTIiLTE/dGLzkgX+dU+m1OWPxSoPCLHZ9KySlxYDY
        lrEpyamkSRVwSVK9Bj10G9HVe9jhURjY6luU
X-Google-Smtp-Source: ABdhPJxtG87peUAj9nUcOJZ6kJ3GfgLcVifZfsIilxdCmYeKjXrDcFn72DSZZaOVqn63oI0RNI6EWA==
X-Received: by 2002:a1c:7707:: with SMTP id t7mr2777097wmi.54.1603373876961;
        Thu, 22 Oct 2020 06:37:56 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q10sm4094031wrp.83.2020.10.22.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:37:56 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tfiga@chromium.org, Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 1/6] media: uvcvideo: Add UVC_CTRL_FLAG_ENTITY_GET_INFO
Date:   Thu, 22 Oct 2020 15:37:48 +0200
Message-Id: <20201022133753.310506-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201022133753.310506-1-ribalda@chromium.org>
References: <20201022133753.310506-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag allows controls to get their properties from an entity defined
function instead of via a query to the USB device.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 9 +++++++--
 drivers/media/usb/uvc/uvcvideo.h | 3 +++
 include/uapi/linux/uvcvideo.h    | 2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index f479d8971dfb..7acdc055613b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1708,8 +1708,13 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 	if (data == NULL)
 		return -ENOMEM;
 
-	ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
-			     info->selector, data, 1);
+	if (ctrl->info.flags & UVC_CTRL_FLAG_ENTITY_GET_INFO)
+		ret = ctrl->entity->get_info ?
+			ctrl->entity->get_info(ctrl->entity, ctrl->info.selector, data) :
+			-EINVAL;
+	else
+		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
+				     info->selector, data, 1);
 	if (!ret)
 		info->flags |= (data[0] & UVC_CONTROL_CAP_GET ?
 				UVC_CTRL_FLAG_GET_CUR : 0)
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a3dfacf069c4..08922d889bb6 100644
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
diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
index f80f05b3c423..69b636290c31 100644
--- a/include/uapi/linux/uvcvideo.h
+++ b/include/uapi/linux/uvcvideo.h
@@ -30,6 +30,8 @@
 #define UVC_CTRL_FLAG_AUTO_UPDATE	(1 << 7)
 /* Control supports asynchronous reporting */
 #define UVC_CTRL_FLAG_ASYNCHRONOUS	(1 << 8)
+/* Entity queries */
+#define UVC_CTRL_FLAG_ENTITY_GET_INFO	(1 << 9)
 
 #define UVC_CTRL_FLAG_GET_RANGE \
 	(UVC_CTRL_FLAG_GET_CUR | UVC_CTRL_FLAG_GET_MIN | \
-- 
2.29.0.rc1.297.gfa9743e501-goog

