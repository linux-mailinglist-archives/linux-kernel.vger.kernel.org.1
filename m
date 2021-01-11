Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2232F1F32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403796AbhAKTUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403769AbhAKTUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34BC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:40 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t16so948900wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYAUvWYhLSY+y3POXwzPmF8UOJaTJ9mXjk2V2XniJm0=;
        b=AvjJHTIgB9FSFfzuhd2/xZddg8dZhEgKX/CNFOHHQ7b9yZsOPZNXR49nJuu2Y3EZf6
         nUy0bQnAI1boEBFBEoLLzNZNtykXnh6Nep+/FljRN06bxsfy9XrWoASbuW4gRpXFmeHq
         uw87V0KY+HzEFkFreB0xHPov/rSoFGqymGVJCJKOd5Xj7nLXfnnwmP4Rxeev8YCd/XzN
         eoNsw5lmZJrz9wKkkiTSm9obVvLZuTZuyD09jCcXNJMvvm/FUZRXFn8GSmGRi1njKqMW
         gFM8rEm3OsjmjtxdT9TdiLV56tLbw67SeScy7kFp2Og0E2rZzMC32vhYy9IZbztGz2XX
         y1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYAUvWYhLSY+y3POXwzPmF8UOJaTJ9mXjk2V2XniJm0=;
        b=lMEUWh+6hhD+65QbXhdgNWo5gJIo7MIr3tLZ/HwtuO36JvacYFPyN+Zz0e/jq+1vj7
         dmCXdzLM4TNOaue5NAMmlcLUUjsDlb80gNszApq1/ZuoXO0jkZfc30tvL/yfrmSvO7vR
         PRSZSz6ewQcfwCV+3GwVo3nqtn+x7qPyoxCrgBGIO0eAKR8XUfMiJ33Jkfjj4wFk992h
         XFhkRVBPGCexaFTBV0B5YuUmNPdKlaHNPH8vqThveGP3EF6OvNreAKnpPqmOwVaovEt+
         wbUZf5fWR9ys/wvXdBi7NP8oE6ylzazC9vg0JF9W0kAItIxYwmKjhpGwcmHq44f0ldho
         ABKA==
X-Gm-Message-State: AOAM530KgEK9f6gsxU8HCzHd/vq4K2DDldxFuiGfm4hICPc5Euty+If3
        cgnzSM70vKgEyy6/p37tkQ6Gm5LUSjsS3REu
X-Google-Smtp-Source: ABdhPJx4yFMdBRMlt7UNZ0+TK6A3eCANJ4OL+8R9h9mxZjmvYAxD+wT/31ZR77V8KnbfZmyjH+EZVQ==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr613515wrs.284.1610392779552;
        Mon, 11 Jan 2021 11:19:39 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 07/40] drm/amd/display/dc/irq/irq_service: Make local function static
Date:   Mon, 11 Jan 2021 19:18:53 +0000
Message-Id: <20210111191926.3688443-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/irq/irq_service.c:82:31: warning: no previous prototype for ‘find_irq_source_info’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index 6bf27bde87240..5f245bde54ff7 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -79,7 +79,7 @@ void dal_irq_service_destroy(struct irq_service **irq_service)
 	*irq_service = NULL;
 }
 
-const struct irq_source_info *find_irq_source_info(
+static const struct irq_source_info *find_irq_source_info(
 	struct irq_service *irq_service,
 	enum dc_irq_source source)
 {
-- 
2.25.1

