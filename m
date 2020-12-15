Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8B2DB08F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgLOPw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbgLOPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:46:19 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57817C061285
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:44:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t30so2285302wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6yh43wBSayz1RW70OomVDoFDUWCsjdlRC2vPld/5C8=;
        b=hBIfqPgIO7rEee56qP09oVOX7LhbWzFwfzTLL289foRvFUBpDgqOiezjntF58Tz5Yr
         bSzR68xNiN/W9MynJBUUALwTX/JHCygIZ4wtRfqEhFib6zr6cWH3MWrvD54yxlk3axBe
         N10OAV4CVsACcup22ZjevQVmaRK6dZ0Xj/Jcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6yh43wBSayz1RW70OomVDoFDUWCsjdlRC2vPld/5C8=;
        b=Bh/uecxEFfZ4zuV5c4MJ6h5CljuwUOF3VAn9gud349Rz6OptBD1vnoNJvm49TTysKl
         JOe9sJaitiTbXh7I0qUraMqsMEY6obdUhSl2fhwVFiP7NveH9lINsJ6p5Vl1Ilci+dz6
         EoVmS00zEYIDkKXMKjhnksNM+mftD+RtXCwspCIP92aAnlvbLkZ2DBWt20ZMjEqhWOpo
         2outSiP4IIfwiLgfHfYJXwNLA3NHPPgkmH3altz7ucYdBfYI7jRDT4JnR/ROZWlSLySm
         x6wbpiAjo9t/reYO67HhZyqCwnM+vKNvb/OHdbRGs907HD4Gte6ws6qEXAUgvQu2aXUJ
         GQNA==
X-Gm-Message-State: AOAM5317Snwo0j0VtSBiNXHLQiKG5JucpKyujQzAIx1zcRYSzdjRKc76
        8VKB9xf1HWbNBK4uPqfgsZELn5+5iwBqojzu
X-Google-Smtp-Source: ABdhPJwZ4lAvOVTFnDeTGHn5MC5oFMZlTY0FjV23Eh952wQldzd/26a1X0TS1f3wl822I9tY0Pf3Bg==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr16932197wrt.15.1608047096071;
        Tue, 15 Dec 2020 07:44:56 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id 125sm38204141wmc.27.2020.12.15.07.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 07:44:55 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 3/9] media: uvcvideo: Allow entities with no pads
Date:   Tue, 15 Dec 2020 16:44:33 +0100
Message-Id: <20201215154439.69062-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201215154439.69062-1-ribalda@chromium.org>
References: <20201215154439.69062-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid an underflow while calculating the number of inputs for entities
with zero pads.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9f4451a2e0a6..534629ecd60d 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1033,7 +1033,11 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 	unsigned int i;
 
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
-	num_inputs = (type & UVC_TERM_OUTPUT) ? num_pads : num_pads - 1;
+	if (num_pads)
+		num_inputs = (type & UVC_TERM_OUTPUT) ? num_pads :
+								num_pads - 1;
+	else
+		num_inputs = 0;
 	size = sizeof(*entity) + extra_size + sizeof(*entity->pads) * num_pads
 	     + num_inputs;
 	entity = kzalloc(size, GFP_KERNEL);
@@ -1066,7 +1070,7 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
 
 	for (i = 0; i < num_inputs; ++i)
 		entity->pads[i].flags = MEDIA_PAD_FL_SINK;
-	if (!UVC_ENTITY_IS_OTERM(entity))
+	if (!UVC_ENTITY_IS_OTERM(entity) && num_pads)
 		entity->pads[num_pads-1].flags = MEDIA_PAD_FL_SOURCE;
 
 	entity->bNrInPins = num_inputs;
-- 
2.29.2.684.gfbc64c5ab5-goog

