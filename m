Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB32F4601
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbhAMIKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbhAMIJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983C4C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n16so3136123wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIOPy71PcWZjJKz2Zi3owNXyP9wS0eEBz4BZZ+xLt88=;
        b=DOQNpJmTzQJ07PlrsA9wD5Pn2X09SQxxyN3kHtxeodcgzi8Ykmla2cqkI/wVS1JpPJ
         3eE1eaH5MSBZsa461g25igPNwnGc6VazrF5jXh1q8WXRpRGRqVApAqCDCEReWQCZNnOW
         /BMD6FKe6mGOBpYtq0hz71X98yOqwlLCxHtovNy23y2O9VBEPBe1SY8/XF42dW9CGLS3
         AaJdGdy5ZL0DvMRo+5C3zru9wtJ4dp5galDImBX/UuzBfBM8E/CECaPgPE6gEgSfAGkt
         zSrIKYGw90wZYpZhSGt37u/SP/k9g7q4xIcS+0CnDUN/TJZ+RWdVJSBQSQ7qcNV5+N8f
         fdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIOPy71PcWZjJKz2Zi3owNXyP9wS0eEBz4BZZ+xLt88=;
        b=Ocvy+ymliCKiCy7tI98UFGS3ZUHcOtIobbjtDEex2WHJU8DHyItGl/fJLhSutQnZNT
         a09FIFS0zwxyhHjxdSLcxm5KOvEi93VNv5b0foxrk0/JPDCUn+vpRzjulAwR711wCWbT
         Bm6Fr3nJDXNsfAyWM9/DUirrw+eU1J/5YsPQkcfozzxDi9eRQlb7SdNusARNOIU30O70
         +mb5o8H0VHV9Fa2JLoi2ht8KPAF2EwmCZoIS0ThycNdv3WWDgRwhLpbANv4Dpv2AWg4z
         gmOUO4QwV3ZoGwdN2HJwFjR51W5jAHd1ZLIqaMVidFN4ukX5e3GjkHOL1/akRUOrjz5D
         staw==
X-Gm-Message-State: AOAM5334YiyS3tL6OPS6S8daFYsrZesJpvz92IrpfFSBq6tPgYKgh5W2
        VDMrB4KCv0Fn8oEj684oWn8dg2oFOHYrmP+B
X-Google-Smtp-Source: ABdhPJzvH6UUhulrt7P8a6PD9WIjQIKrsaQV3Ag8pMRM0XsjnSLnZHyD20dmavzpdbEWgdMYGBIkcg==
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr936107wmi.55.1610525310368;
        Wed, 13 Jan 2021 00:08:30 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 28/30] drm/nouveau/dispnv50/headc57d: Make local function 'headc57d_olut' static
Date:   Wed, 13 Jan 2021 08:07:50 +0000
Message-Id: <20210113080752.1003793-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous prototype for ‘headc57d_olut’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
index fd51527b56b83..bdcfd240d61c8 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -169,7 +169,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size, void __iomem *mem)
 	writew(readw(mem - 4), mem + 4);
 }
 
-bool
+static bool
 headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int size)
 {
 	if (size != 0 && size != 256 && size != 1024)
-- 
2.25.1

