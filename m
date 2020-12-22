Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894FB2E107F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 00:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgLVXGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 18:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgLVXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 18:06:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AA0C061285
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:04:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m5so16619635wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UvpyONwNGFK1cqijvX/a2/5UzH+LaYn5TNyYwWHAtHU=;
        b=PfQsqWri/hKgNl0nF1hq5MvL9I4M8x+jpaWzsXDrHWHdnwxMlSc1a9K2+IirTsCI6P
         QTalWNKVslAkaSv2t/Wd3RFMhMTXc69ox9W00Ft4l2+yUqXt03IdaXBnBEjcsKkWsynT
         DJWLxKUtWk0jq829P9coHpWV95N050r+4Gus0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UvpyONwNGFK1cqijvX/a2/5UzH+LaYn5TNyYwWHAtHU=;
        b=VYw280RZFpOtK0v6CarLXrWp9waDeaTr6Tc1W4hE7YVd27l8JD0z/b8wL6yJkN1/Wp
         sGXNCRk7PM/Xm9MQtsPgXAyuTcK1dMoUpmGF0G8TnqRPqCx6Eos6EykieZsK+/VaRCMb
         1BipqFQGgu3t5Jynyd9Vw6dYxHVk5bPXB/m7hzeZ28Xpbfv6UY4BPkVO+lpcgCpCNVTC
         Ro4Hnow+tMghWLiZMU/jRBG7819StBTdUx8PT5WXmppMKc9ct3FmpAAxBk4+0TgQVxw0
         A8B+m7L/CHluKN0lKvRLfAUbtbYSb8LHQdNg1bo80nFvJmily6V2EDHB4OY3Vw0+SVts
         NV8w==
X-Gm-Message-State: AOAM531biyLG1zx2SDDc411559tjxsBWBRHU6cP4C+J51mVny5vUVRuD
        7jCQvXHGjxCYDUOZ+5IdHGh24A==
X-Google-Smtp-Source: ABdhPJzAMjgZKZ5YBCR64KDyR43RuN7gKzJmCyrynQQv81rVO5TYtW9pt+bF0SFcpFEr3F0xt6xO6Q==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr27092842wrt.242.1608678291064;
        Tue, 22 Dec 2020 15:04:51 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r16sm34463401wrx.36.2020.12.22.15.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 15:04:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 03/11] media: uvcvideo: Allow entities with no pads
Date:   Wed, 23 Dec 2020 00:04:38 +0100
Message-Id: <20201222230446.1027916-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201222230446.1027916-1-ribalda@chromium.org>
References: <20201222230446.1027916-1-ribalda@chromium.org>
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

