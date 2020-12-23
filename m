Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263F52E1C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgLWNgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgLWNgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:36:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6EAC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:35:33 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v14so5396766wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u758tc6qPeylpt3SsVLMdt+s9OHLjZNVgsX5L88s2r0=;
        b=Q0erJBz9hqoU0oD9aLjCvmVU/bI2+F5SMwPkvpY74SU1tcoH70Y42Yd/eDOGArUPkJ
         Z65XOrGr/mdJja7UDE9DWusMG+ymQy7jOFXAU/8eQpS1VPf6t85xBuVOZ8aEQPEdmGf3
         JlcPpqsqvZ/BLRWiQlzvgHyyKC+X3PUQhDfRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u758tc6qPeylpt3SsVLMdt+s9OHLjZNVgsX5L88s2r0=;
        b=nuv6cqAfIdN+h85MJocnxRgZTyl1pGsjkW2hLaERyY1EWLiRiga9iI7KNGG3wr7LUa
         /HJb9SdelljdK3oJvhQEGaT0MR8q0VjeECPHIyt+4rWYsjcQhyENYRdiuNCbL10T49P4
         MzCT8oej5aVwV5VxNXyTg3u5QwYNqThOvr8bCXd7Fkw2HfnXoO7qIqGRQAKmp0S5lu0q
         VJ3k7XpdSCZKjfnoOdNYGNnOc66iZCSypn8GhAWapsSVvtOvkU1JCMfzBKNaIbfdyVEY
         ePATnUPxA53bMp4vMlYA1z6TgjDczPu+86zbstJhhmoRX+ejCKRtd2CDjkMV9qd051Zp
         z26g==
X-Gm-Message-State: AOAM531Bm2tVui2aOzxylE3FERsOAdImDFisXgXGCtVnNcHtKrB+m1+o
        sBKovmALCclvc1YcwDTzmk/J99Xd8mc69ETAcHY=
X-Google-Smtp-Source: ABdhPJz8winmAgCoMmDxTaaGOOK1awTyCxupK+2oMN7iwvjZPJ7/d+008qZp+DukJfSj1R8ZD/AC1Q==
X-Received: by 2002:a1c:67c5:: with SMTP id b188mr27091865wmc.147.1608730532583;
        Wed, 23 Dec 2020 05:35:32 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q143sm31572247wme.28.2020.12.23.05.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 05:35:32 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 02/12] media: uvcvideo: Allow extra entities
Date:   Wed, 23 Dec 2020 14:35:18 +0100
Message-Id: <20201223133528.55014-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201223133528.55014-1-ribalda@chromium.org>
References: <20201223133528.55014-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the size of the id, to avoid collisions with entities
implemented by the driver that are not part of the UVC device.

Entities exposed by the UVC device use IDs 0-255, extra entities
implemented by the driver (such as the GPIO entity) use IDs 256 and
up.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 drivers/media/usb/uvc/uvcvideo.h   | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index bfbc5a4d4ca6..82cdd1bb28dc 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1024,7 +1024,7 @@ static const u8 uvc_media_transport_input_guid[16] =
 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
 static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
 
-static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
+static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 		unsigned int num_pads, unsigned int extra_size)
 {
 	struct uvc_entity *entity;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df7bf2d104a3..c50b0546901f 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -301,7 +301,12 @@ struct uvc_entity {
 					 * chain. */
 	unsigned int flags;
 
-	u8 id;
+	/*
+	 * Entities exposed by the UVC device use IDs 0-255, extra entities
+	 * implemented by the driver (such as the GPIO entity) use IDs 256 and
+	 * up.
+	 */
+	u16 id;
 	u16 type;
 	char name[64];
 	u8 guid[16];
-- 
2.29.2.729.g45daf8777d-goog

