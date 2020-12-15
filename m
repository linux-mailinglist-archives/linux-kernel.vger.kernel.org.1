Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1155C2DB094
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgLOPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbgLOPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:46:19 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B543C061282
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:44:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d13so2067868wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QcJmNeaUOwN3Wix2WmoXCV3cAVx0ZDDOGTBDar8mqQ=;
        b=NSCnv5CjE5mL/htpsDuZ0cFHkbw9+5eMvpcr3xRCxA8MD6DM0DOpTDTn90PH6aldJQ
         DlA9I55SzMX9Vcp/xwd4u5JYmajfIy8dUmb1mxQAZ11N/zpVKNugTarg0ufnE/Ic0H/h
         eK9GtbcraVNTWm52pQZPVOJlpxK+9OY44ULYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QcJmNeaUOwN3Wix2WmoXCV3cAVx0ZDDOGTBDar8mqQ=;
        b=ZmzzdpUmFh2Ky93nj9pAlcG5Y1q7p7WzvPwCMiluB//fvDxjRo03GTftLci0aE1NQZ
         dRFIXDThl9kwpxC65FjeHb4BeJ+dKAwwKx5KemFK2stcW9oaN7YNKnJI3aKw8f07xBos
         yaGT8eocg+X/VixJpbv/wBku1li5YzGwKQqIT2zu0hADGrxGBvVCUpzDVMUTrTVnnuV7
         Saj2k4OXOENuaScat6V6Yr8MdWkIguWkalfpIYl8+msaibL8Ruoju9sqe1T7eDq7kYb6
         KeQZ7elr8zfowJCgI5wPdzRcmAAcuEeGK9UPRPNYa/V7IubOqElpYMgyubY69tj1W65+
         wlYw==
X-Gm-Message-State: AOAM530+sTjmJmkTLUR1kp+6vap0WYSHjloT4IkdhaYqE75lRck8Ddsf
        VnxR0HsRSZz7MAVMjPDgPb0IErioNeLmXUTT
X-Google-Smtp-Source: ABdhPJzq3amJoFPTUqs7d4HxdPWwkXDFF9fwLcAftuW38ATYEg/vKIn18tvI9ZTIln2IAduptodCtw==
X-Received: by 2002:adf:ce84:: with SMTP id r4mr34193271wrn.91.1608047095167;
        Tue, 15 Dec 2020 07:44:55 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id 125sm38204141wmc.27.2020.12.15.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 07:44:54 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 2/9] media: uvcvideo: Allow external entities
Date:   Tue, 15 Dec 2020 16:44:32 +0100
Message-Id: <20201215154439.69062-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201215154439.69062-1-ribalda@chromium.org>
References: <20201215154439.69062-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the size of the id, to avoid collisions with external entities.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 drivers/media/usb/uvc/uvcvideo.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 4cdd65d252d9..9f4451a2e0a6 100644
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
index df7bf2d104a3..00f985001c1d 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -301,7 +301,7 @@ struct uvc_entity {
 					 * chain. */
 	unsigned int flags;
 
-	u8 id;
+	u16 id; /* 0-255: usb entity. 256-65535: external entities */
 	u16 type;
 	char name[64];
 	u8 guid[16];
-- 
2.29.2.684.gfbc64c5ab5-goog

