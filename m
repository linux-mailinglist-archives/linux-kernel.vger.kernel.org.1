Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B142E1076
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 00:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgLVXFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 18:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgLVXFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 18:05:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E07C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:04:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d26so16616858wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbfPTNs2EDdwgiQnP1q1i2BiY/ttWxmdXwJUUJfLhFk=;
        b=SCIohTf7jLC7iAueYZRYzlKyRilEWCsCFpVyq70KwPdQdgUQZnWT15gKS3ZiSrDsQ7
         k31Ey0WFtDMyV1aV3f99hokqRqnhsJsHc7WnbcyjsG72ZeeVvKv0CFVYGTjXXAZZCn+V
         YqYQMZUVo5VIzrhe5HW/RvYZHmLXO8qOHYvTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbfPTNs2EDdwgiQnP1q1i2BiY/ttWxmdXwJUUJfLhFk=;
        b=j9zyaktTYcAVU4eQBmJVrhJerZBNHel8cJTfS3fN1e/rphZ4rFVVhHkW+4p3bdwlte
         yvNl+Y05F5feQDCYEyFwmf2//BfszmPdY2Wp3z9tBNkC/Jlsky5MBhUgrtc1IgJoeRfE
         RQRiTqTX/SqCMP0+Sgr+zn31iW+kyQmaGVpo+feBG/WNJ5wlAREeFmwZJddjYOYZylh+
         82am1NMV/fXIycTeWV/srl8Qu1KH2qs75E8lNpLdyhvG6h8JYNMfN9anpqbcrdrVCPKt
         l8cS+ko08OkXoE9yh7/5AED6IZr1l5ReN6P3mEfhsuu4RLZCbHDtb9ChKFI/C2oR8tUz
         JhZA==
X-Gm-Message-State: AOAM530p5nbyoFJoPJ1bjj/YtsRu4q8zoPNZJnrQcKGWNT6324w6UeLD
        jSNaw5rr+cvTgnjIxv029VJCMA==
X-Google-Smtp-Source: ABdhPJzTGEDzwUFVnNgupnLuAUVbSGognbs178LBbWsHhLMki3aKG5sMvhLUSDvdH/FokX+9oWxYQA==
X-Received: by 2002:a5d:5049:: with SMTP id h9mr27452936wrt.404.1608678289461;
        Tue, 22 Dec 2020 15:04:49 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r16sm34463401wrx.36.2020.12.22.15.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 15:04:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 01/11] media: uvcvideo: Move guid to entity
Date:   Wed, 23 Dec 2020 00:04:36 +0100
Message-Id: <20201222230446.1027916-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201222230446.1027916-1-ribalda@chromium.org>
References: <20201222230446.1027916-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having multiple copies of the entity guid on the code, move
it to the entity structure.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 30 ++++--------------------------
 drivers/media/usb/uvc/uvc_driver.c | 25 +++++++++++++++++++++++--
 drivers/media/usb/uvc/uvcvideo.h   |  2 +-
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 011e69427b7c..9f6174a10e73 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -826,31 +826,10 @@ static void uvc_set_le_value(struct uvc_control_mapping *mapping,
  * Terminal and unit management
  */
 
-static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
-static const u8 uvc_camera_guid[16] = UVC_GUID_UVC_CAMERA;
-static const u8 uvc_media_transport_input_guid[16] =
-	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
-
 static int uvc_entity_match_guid(const struct uvc_entity *entity,
-	const u8 guid[16])
+				 const u8 guid[16])
 {
-	switch (UVC_ENTITY_TYPE(entity)) {
-	case UVC_ITT_CAMERA:
-		return memcmp(uvc_camera_guid, guid, 16) == 0;
-
-	case UVC_ITT_MEDIA_TRANSPORT_INPUT:
-		return memcmp(uvc_media_transport_input_guid, guid, 16) == 0;
-
-	case UVC_VC_PROCESSING_UNIT:
-		return memcmp(uvc_processing_guid, guid, 16) == 0;
-
-	case UVC_VC_EXTENSION_UNIT:
-		return memcmp(entity->extension.guidExtensionCode,
-			      guid, 16) == 0;
-
-	default:
-		return 0;
-	}
+	return memcmp(entity->guid, guid, sizeof(entity->guid)) == 0;
 }
 
 /* ------------------------------------------------------------------------
@@ -1776,8 +1755,7 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
 	if (data == NULL)
 		return -ENOMEM;
 
-	memcpy(info->entity, ctrl->entity->extension.guidExtensionCode,
-	       sizeof(info->entity));
+	memcpy(info->entity, ctrl->entity->guid, sizeof(info->entity));
 	info->index = ctrl->index;
 	info->selector = ctrl->index + 1;
 
@@ -1883,7 +1861,7 @@ int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 
 	if (!found) {
 		uvc_trace(UVC_TRACE_CONTROL, "Control %pUl/%u not found.\n",
-			entity->extension.guidExtensionCode, xqry->selector);
+			entity->guid, xqry->selector);
 		return -ENOENT;
 	}
 
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index ddb9eaa11be7..bfbc5a4d4ca6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1019,6 +1019,11 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 	return ret;
 }
 
+static const u8 uvc_camera_guid[16] = UVC_GUID_UVC_CAMERA;
+static const u8 uvc_media_transport_input_guid[16] =
+	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
+static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
+
 static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
 		unsigned int num_pads, unsigned int extra_size)
 {
@@ -1038,6 +1043,22 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
 	entity->id = id;
 	entity->type = type;
 
+	/*
+	 * Set the GUID for standard entity types. For extension units, the GUID
+	 * is initialized by the caller.
+	 */
+	switch (type) {
+	case UVC_ITT_CAMERA:
+		memcpy(entity->guid, uvc_camera_guid, 16);
+		break;
+	case UVC_ITT_MEDIA_TRANSPORT_INPUT:
+		memcpy(entity->guid, uvc_media_transport_input_guid, 16);
+		break;
+	case UVC_VC_PROCESSING_UNIT:
+		memcpy(entity->guid, uvc_processing_guid, 16);
+		break;
+	}
+
 	entity->num_links = 0;
 	entity->num_pads = num_pads;
 	entity->pads = ((void *)(entity + 1)) + extra_size;
@@ -1109,7 +1130,7 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
 		if (unit == NULL)
 			return -ENOMEM;
 
-		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
+		memcpy(unit->guid, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
 		memcpy(unit->baSourceID, &buffer[22], p);
 		unit->extension.bControlSize = buffer[22+p];
@@ -1368,7 +1389,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 		if (unit == NULL)
 			return -ENOMEM;
 
-		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
+		memcpy(unit->guid, &buffer[4], 16);
 		unit->extension.bNumControls = buffer[20];
 		memcpy(unit->baSourceID, &buffer[22], p);
 		unit->extension.bControlSize = buffer[22+p];
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a3dfacf069c4..df7bf2d104a3 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -304,6 +304,7 @@ struct uvc_entity {
 	u8 id;
 	u16 type;
 	char name[64];
+	u8 guid[16];
 
 	/* Media controller-related fields. */
 	struct video_device *vdev;
@@ -342,7 +343,6 @@ struct uvc_entity {
 		} selector;
 
 		struct {
-			u8  guidExtensionCode[16];
 			u8  bNumControls;
 			u8  bControlSize;
 			u8  *bmControls;
-- 
2.29.2.729.g45daf8777d-goog

