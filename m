Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838432E0008
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgLUSjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgLUSjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:39:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4BCC061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:39:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q75so11938128wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80KPby0xcz+iK59YkSpKMwmYMBDDjMUhltAQvUYuGYI=;
        b=PBUhAqFugSrK7CSnPkt/nRSA79ntpcvblfiGq0PCFSBHK4jYX9ZYrQjD2tDDQM+hK4
         vRXmKb5Vtzz6ervNwhcR6anPJGRNeJSRyB00KlORr2rUhygnNSh+nujwQde6jcoeAhPd
         ymmQpV1YZFOh+qGkiFbpAbe9QybGw763WvKv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80KPby0xcz+iK59YkSpKMwmYMBDDjMUhltAQvUYuGYI=;
        b=At885QZVWNVqInah2OnSgb471W+zxT/baOeVV3jfJ7hgN9arMxK/sj5eswDryYK1uH
         /jNBDiiLAsmF1TCaoiUdcpfc62M0fcU17sMuMXVp32GBGaTPwYOo/fLuHFxABxIcqD0C
         H21iSurzt+VO0x9+in7ZroumDzu2lHGF1NWzwjpGxf/JWbTrpVS6rrTZcj8ISDsSLq15
         QA8fCsEOp+9HYWs2ViwzbTm7j6FyStetVXbb+d/F+A0KC1SErCYeZTthmxPiE7EfK1W4
         npGvczntLt0JT8Bf/XSPKGgCd6e7aFzbTn1Y+zdGnnxuakyDBkakb+UD6pTSZaZ6ekss
         jASA==
X-Gm-Message-State: AOAM531gAi0W5lZQ+D5htf/5spiMan31nAcHSgZldZGohhMrlk9madlW
        Ustc+dOBkIJ/5diKVszQuI+R4KTfdcMrEO+/zPk=
X-Google-Smtp-Source: ABdhPJyTadWVI5YU5Jq8O4Budepa0tJFPD1wnTSdIcik689xVi5MtgGunTRsHnBgB4BEI8pFrC/8xw==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr17324701wmh.88.1608569305892;
        Mon, 21 Dec 2020 08:48:25 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o125sm24581109wmo.30.2020.12.21.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:48:25 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 05/12] media: uvcvideo: Allow entities with no pads
Date:   Mon, 21 Dec 2020 17:48:12 +0100
Message-Id: <20201221164819.792019-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201221164819.792019-1-ribalda@chromium.org>
References: <20201221164819.792019-1-ribalda@chromium.org>
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
2.29.2.684.gfbc64c5ab5-goog

