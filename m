Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4172E1CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgLWNgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgLWNgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:36:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A058EC061282
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:35:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n16so1403069wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 05:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UvpyONwNGFK1cqijvX/a2/5UzH+LaYn5TNyYwWHAtHU=;
        b=STIbJo6yghNXeVFMNqXERsWmAolzLrgTDD1kYmexWRLS9wSef5T9p79CoJELIVYm7W
         0gUiMl5Uzu87MPElOS8AOal7nnlyUjHu2M3kjcTZ7aR/INuoZOc4+XrEz5hp7iZzzbsa
         GfWvgvfn9Xgj7WnA+uPvNW1e8wrj4lTRtt9RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UvpyONwNGFK1cqijvX/a2/5UzH+LaYn5TNyYwWHAtHU=;
        b=W/gVZ2T7tMcDWQTFJEYunsVvE6e+oy/H1S73XYI64BCTbZLiJ0TJJNhxAEbdunuUzy
         vWrTL2es9rLKU5wFsnp9izMOD4zM6l3umbqB8MOW39fvIgv+0ApOBxCu9sJbgF6dtItG
         qAVeFQzZsvnByLBOhno8ypSJvF6q3kfwGapM6wI6TEu6a1tXpqL5QnNfq4syq+y6ZqtS
         yDnMjYmFh+p2cCVA9wtOIHRjpGfirbfVfDYmfD0fgFYAPxdFY3lqmzyE84grf6PllO25
         yUhvZhS0Vc8yOr+x2n4s10doNpL0AMTaSJ4fIw4t29gEW3uERwtDemstriTfw81on4VR
         /u/A==
X-Gm-Message-State: AOAM5313E9M+N4mtDxqh33g7nnCSMwZDBjPcQD0U7tcDvo5hxrN8w28I
        hptsH83Q+rmBNQX+EnUyE3CUaw==
X-Google-Smtp-Source: ABdhPJxh772GgyEaVfu1ds/M+4IzjhUbWQChjzGc2/9ctIMS0PjF1dOWajGU3IqoB6OdZat6dh5p5A==
X-Received: by 2002:a1c:3d86:: with SMTP id k128mr26228187wma.66.1608730533456;
        Wed, 23 Dec 2020 05:35:33 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q143sm31572247wme.28.2020.12.23.05.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 05:35:32 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 03/12] media: uvcvideo: Allow entities with no pads
Date:   Wed, 23 Dec 2020 14:35:19 +0100
Message-Id: <20201223133528.55014-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201223133528.55014-1-ribalda@chromium.org>
References: <20201223133528.55014-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid an underflow while calculating the number of inputs for entities
with zero pads.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 82cdd1bb28dc..c0c5f75ade40 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1033,7 +1033,10 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 	unsigned int i;
 
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
-	num_inputs = (type & UVC_TERM_OUTPUT) ? num_pads : num_pads - 1;
+	if (num_pads)
+		num_inputs = type & UVC_TERM_OUTPUT ? num_pads : num_pads - 1;
+	else
+		num_inputs = 0;
 	size = sizeof(*entity) + extra_size + sizeof(*entity->pads) * num_pads
 	     + num_inputs;
 	entity = kzalloc(size, GFP_KERNEL);
@@ -1065,7 +1068,7 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 
 	for (i = 0; i < num_inputs; ++i)
 		entity->pads[i].flags = MEDIA_PAD_FL_SINK;
-	if (!UVC_ENTITY_IS_OTERM(entity))
+	if (!UVC_ENTITY_IS_OTERM(entity) && num_pads)
 		entity->pads[num_pads-1].flags = MEDIA_PAD_FL_SOURCE;
 
 	entity->bNrInPins = num_inputs;
-- 
2.29.2.729.g45daf8777d-goog

