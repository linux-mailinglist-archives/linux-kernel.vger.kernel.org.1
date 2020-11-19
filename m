Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B12B9D28
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKSVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgKSVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:50:32 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE8BC061A04
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:50:31 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so8015441wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3cVaBPjEomR5EQmhK/0psT18P0AYMtS0rp6iyH/+Vc=;
        b=YIue35FxptrEnQjMqaAx1mKM8RnclPzWZi3HW5WJ5Erx0Bk/YEdcKaszK7oWl0okjj
         wscDgksUkwd4swykCGpBY3HsVyWA26VIwwVNovuwP052VMZUvG0mI3nikokpO6BV0+iP
         KAgfL+ZGUoCURPoDM+Dg6P5uO7ytrbDo7jB6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3cVaBPjEomR5EQmhK/0psT18P0AYMtS0rp6iyH/+Vc=;
        b=jUxyIKZssq33KY8BBrhdrTp+faTDsPkHUqx8snnzYP1jdVstRvUoT9qhMXh5WRegTY
         RVAohsOiRPJVUzLECvp1pjcHp5PtkpeSleWoZum3hrL1lG7TGMaWPpI51IR1N97v8USf
         1ky5ixL95gcnH3RT2RBdD8jy7Z+mm/ttibcXZ3wvU7Xfj/MaBGU+ZZFfHCDt03QB9SQC
         AM9rAHqxCjTL2MYAEDbQaHPMRkD9Rv0UXYUVSb/64AMgia6A8PqGD3DIzM7ujr+8k6En
         e1N5GOBHPwC4vpjzhmZbHdgQDlFRO3z52IH5q/D/tI109Ubm2PKcQ8drSW+Dp9BpYio5
         Qb6g==
X-Gm-Message-State: AOAM5317lbHOlWrH0fF3mcua2adltvY+lGA3qFHnWxb1jZ13xmPt7y8K
        4HbAE/RB89Y4ZHTzXEOSsz7EgQ==
X-Google-Smtp-Source: ABdhPJwBgKRbhOlgAVKd2KfVL1+4BVbNzB5/UKtTs2xA4B5FJ5PU1uHFto9QaTb3KIIgBe6Ct1BT6g==
X-Received: by 2002:adf:f347:: with SMTP id e7mr12065851wrp.183.1605822630496;
        Thu, 19 Nov 2020 13:50:30 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t136sm1818859wmt.18.2020.11.19.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 13:50:30 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 6/8] media: uvcvideo: Add Privacy control based on EXT_GPIO
Date:   Thu, 19 Nov 2020 22:50:18 +0100
Message-Id: <20201119215020.508487-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201119215020.508487-1-ribalda@chromium.org>
References: <20201119215020.508487-1-ribalda@chromium.org>
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
index 7d86ee4b4ff9..5826d06a90f5 100644
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
2.29.2.299.gdc1121823c-goog

