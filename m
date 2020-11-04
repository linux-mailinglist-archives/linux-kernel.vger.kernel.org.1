Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285C12A6C69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgKDSH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbgKDSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:07:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445AC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:07:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w14so23035604wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nmto78jsH6BP6EX0aLno4Xjo3zNTYMaOPlWvmD+y/wA=;
        b=IBYm2Gr8EXSUOYL6JJZjaMkyyFYG6BPmGFxxSeNIp9Nf5XEOxreKOMsN0y2MlluiND
         nnGl5AoNkXTonVo+vPsF9HBVvcCFU/TLq4qK+FyvMQNX9rEcjciurjcaIP5cW6vFJLg/
         yJ52SUEbHyyO1YelKxpa/piYskUD+jI35yF0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nmto78jsH6BP6EX0aLno4Xjo3zNTYMaOPlWvmD+y/wA=;
        b=Px0i6tGoJF3ZUngmvEpz40GvlqklGvlmawhvo4yhiSXx6SqyoU4nUEjFCLyc3jvz5N
         0fapqj1e0YZ5vrpaegpgX9UmjUXlnSi8yGX/FixXLUdFjTPElPPkwg7XWYtNeSAEG0to
         65riHg6py73Iw5HzOExAeHbGI+NQHxHxJRDzvFebvQLQGxxgq02E72KExC7LYZICf8tA
         ql/FjMwEQxjYFf1N9SHTv5L7pdrmAxC07FrPjaHY0u9GLaj+vqxqV2Xf1S44dyV0yqM6
         W+jRW/+M4ycFo1139rPryEG+0sjq+KC537tYZEcB/y5Ji6w6daD29jhgmSgsk4laFbnY
         lhAg==
X-Gm-Message-State: AOAM530n53XCba/Y19YtsyOSR736IqEOLk5P1A9dbDZACya89rvZoksq
        rSl4NX8JCIkkQxO9os2AgUcKJMk+9A19be6tFAk=
X-Google-Smtp-Source: ABdhPJzuXIR9p1qoOh6D+1lieXOhk8pgGbPZS4owSlNy7AgFeX0GWLwWa8ZjCqRdgD0pzH57cb0j9g==
X-Received: by 2002:a5d:6ac6:: with SMTP id u6mr24341534wrw.145.1604513271613;
        Wed, 04 Nov 2020 10:07:51 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id y10sm3801841wru.94.2020.11.04.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:07:51 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 7/7] media: uvcvideo: Add Privacy control based on EXT_GPIO
Date:   Wed,  4 Nov 2020 19:07:34 +0100
Message-Id: <20201104180734.286789-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201104180734.286789-1-ribalda@chromium.org>
References: <20201104180734.286789-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new control and mapping for Privacy controls connected to
UVC_GUID_EXT_GPIO_CONTROLLERs.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index f9382f8c10a8..285a7a5e15d2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -347,6 +347,14 @@ static const struct uvc_control_info uvc_ctrls[] = {
 				| UVC_CTRL_FLAG_RESTORE
 				| UVC_CTRL_FLAG_AUTO_UPDATE,
 	},
+	{
+		.entity		= UVC_GUID_EXT_GPIO_CONTROLLER,
+		.selector	= UVC_CT_PRIVACY_CONTROL,
+		.index		= 0,
+		.size		= 1,
+		.flags		= UVC_CTRL_FLAG_GET_CUR
+				| UVC_CTRL_FLAG_AUTO_UPDATE,
+	},
 };
 
 static const struct uvc_menu_info power_line_frequency_controls[] = {
@@ -735,6 +743,16 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
 		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
 	},
+	{
+		.id		= V4L2_CID_PRIVACY,
+		.name		= "Privacy",
+		.entity		= UVC_GUID_EXT_GPIO_CONTROLLER,
+		.selector	= UVC_CT_PRIVACY_CONTROL,
+		.size		= 1,
+		.offset		= 0,
+		.v4l2_type	= V4L2_CTRL_TYPE_BOOLEAN,
+		.data_type	= UVC_CTRL_DATA_TYPE_BOOLEAN,
+	},
 };
 
 /* ------------------------------------------------------------------------
-- 
2.29.1.341.ge80a0c044ae-goog

