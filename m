Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF762E0038
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgLUSnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgLUSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:43:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAD8C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:42:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v14so10809296wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kP8yYt31i5ONWl1LfXGzW6cFigEjf/TbpTOooi2m/ec=;
        b=kE8Vb5B4Zev9IefCltuuQwNxOVTpBzcStyZwon/c/qNBWWargTnjd8ekd9XjkCUlcu
         /NaM5J8fkc06TjZDglePQ5DgUKbFw2YWUsidoliiRexnyED37+0Dg7w7hO7uyrikyE+y
         gIoRIk0EwqZyWaxEc5dpfUjOgHbqQtJVq66uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kP8yYt31i5ONWl1LfXGzW6cFigEjf/TbpTOooi2m/ec=;
        b=I+vab966GijM87kYRTvaAiDjzYbzDVOZBdc+JWaATAiUVUTbwiO/blo11vx/F25LyV
         F6eczmBJCjrTaUKie/dBjrzGxKbUoeJl5H94hsarLmjjNm0VSSVom/ZxWhyAkWOgClwK
         UDt443FtvvfLsjwHPJee0JC5j//7NeuW7npwrXNQQ0LapBYSUONaRgOJWfNPjvHRh45g
         aUG1JRp7DlVmjAWyCN1pt9lD68/PbNPcMZZ1LdqKHZyy5D5W3XYH+vmatuV/VwdQxnAo
         9CJh9PMiw9yr85Tgq5/Im6y2pv7yPMqegulDXjbKqB+E1Tt5FTus8mENRDg1OO3Rsj6h
         H0Fg==
X-Gm-Message-State: AOAM532pEBBCEVGcYqI/si7jPRpenGwwcdIqXpQref8U/soUMkog+JJJ
        x6AwWJhovNzIVN9wMbHz4jliC0qmkDWkkgghw/w=
X-Google-Smtp-Source: ABdhPJxslxLVGEOuROyEdv8KQAorJoPoMR/GHeNPyPsE7RYTrpRJIouIyPUS4mCv1DvbUKXJUzcmUw==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr16820996wma.17.1608569302884;
        Mon, 21 Dec 2020 08:48:22 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o125sm24581109wmo.30.2020.12.21.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:48:22 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 01/12] media: uvcvideo: Fix race condition handling events
Date:   Mon, 21 Dec 2020 17:48:08 +0100
Message-Id: <20201221164819.792019-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201221164819.792019-1-ribalda@chromium.org>
References: <20201221164819.792019-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The control and its data needs to be copied to the workqueue at the same
time to avoid half-updates of the events.
This is, events reported to userspace were the control id does not match
its value.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
 drivers/media/usb/uvc/uvcvideo.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 011e69427b7c..aa18dcdf8165 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1332,7 +1332,7 @@ bool uvc_ctrl_status_event(struct urb *urb, struct uvc_video_chain *chain,
 		return false;
 	}
 
-	w->data = data;
+	memcpy(w->data, data, ctrl->info.size);
 	w->urb = urb;
 	w->chain = chain;
 	w->ctrl = ctrl;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a3dfacf069c4..0db6c2e0bd98 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -678,7 +678,7 @@ struct uvc_device {
 		struct urb *urb;
 		struct uvc_video_chain *chain;
 		struct uvc_control *ctrl;
-		const void *data;
+		u8 data[UVC_MAX_STATUS_SIZE];
 	} async_ctrl;
 };
 
-- 
2.29.2.684.gfbc64c5ab5-goog

