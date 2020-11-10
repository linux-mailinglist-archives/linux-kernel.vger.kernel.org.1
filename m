Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C042ADF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbgKJTbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbgKJTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:34 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02426C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:34 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so4342091wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OiQsD+EhT8Lfi4WTa7HEKxexbw01KKvzh7y2CIqIZUI=;
        b=w2cAylpRUwyxpJxnkGOH1jYHVFj+w4ZCRrbjx0+dHVK/k1SkFYcPeOrIv+gyvgruNi
         Y9pmut0MJLCqKVCoxh64xgrnCLtmBui1QC8BuC7C9/SyEufCphx7aeEWfu9jvC3U9III
         ZceExYSW02hI3ANgMEoVc/gxUujRkVafXEX36lKkxEJdphEcj+Nt4JFH1GUruisyFyb+
         29utA9JZezZormWyyDou7bDSGqHFbvgM5R5KhivIJLJ50sK25XDmyMYhwevxCu0Ro86Q
         gL5NDS6YAntMe0J1XRsZ/gdpqa72ODvsBFQ7YoDDIP0oYwu/XnoqidkCr8GBJVcGfCnd
         WUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OiQsD+EhT8Lfi4WTa7HEKxexbw01KKvzh7y2CIqIZUI=;
        b=qNJfja3EgMnZblGtiyKwSNIgtew5whwT7z0ve3An09WJB0SA2o1At0Fmu1ZCbzxQm/
         PAD/OIL5FuuPw3qXtQr4C+xgty+WN74r5fmEMcCf/HoiVIl8BH9nyMx2WUmaQy0V/Rja
         VP95z1Xgw4Dwh0X/uA6rgei7B/66WE0B4jqop2Ko+/Mn4xoyne4E0rqFDRKwcpU7vXX7
         L4phQVK+2Qi0XeGoMJcmaCLzs13jNeH+InBRr688quGLx6YXBj3wqpmryyUp3ctwhbXT
         H+hv115YcUBhbYwQvtrKRQWIPSWm1WpcMst7kN5AfArQrk+P78ODUrgfOI4U+7uHWpmq
         Bj7Q==
X-Gm-Message-State: AOAM530yi6IZck9qFWrhLPwnQeO2Z/zlPZ4qQCtLi1f5eghg4qxP4/GO
        IRw4dHeVEsrDpbqtm/oJeOoZTw==
X-Google-Smtp-Source: ABdhPJxCAbP1NBquixJByR3TRuiCtWqX8gVya2e2rBLdVzy1l0jSVoFnzm7ZOkv+OY8g7NTUfw0erw==
X-Received: by 2002:a1c:660b:: with SMTP id a11mr663260wmc.159.1605036692771;
        Tue, 10 Nov 2020 11:31:32 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/30] drm/radeon/radeon_mn: Supply description for 'cur_seq' even if it is unused
Date:   Tue, 10 Nov 2020 19:30:55 +0000
Message-Id: <20201110193112.988999-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_mn.c:51: warning: Function parameter or member 'cur_seq' not described in 'radeon_mn_invalidate'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_mn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
index 97b9b6dd6dd3b..3c4c4213a7b57 100644
--- a/drivers/gpu/drm/radeon/radeon_mn.c
+++ b/drivers/gpu/drm/radeon/radeon_mn.c
@@ -41,6 +41,7 @@
  *
  * @mn: our notifier
  * @range: the VMA under invalidation
+ * @cur_seq: unused
  *
  * We block for all BOs between start and end to be idle and
  * unmap them by move them into system domain again.
-- 
2.25.1

