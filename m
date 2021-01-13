Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C422F45E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbhAMIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbhAMIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E3C0617A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r3so1086393wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xdwLDrcWYKJZSMYMYuV8riE8ORgcBnhB0CHa1Q/JBs=;
        b=FrwgrjKbVxt3s7pvTRS7s+XO01JRsO9XZYJHRIrzN6pluG3wMDB1Q/zF5eAgINfD5m
         RFBF7is2Nd1xdqHRGNGA/83nam7awxbCz5WzRe6K2JPtLxALiOUcqafRk5ffZ+N+EPLS
         ekCBhJvOuHkTndHv+9B7EE0zHCswpCoLDO8kZrc51wWWeWTYwmynloBfUQKEYJpQgCnp
         UEIPrnCJ0CxXXncxIGQSZPDTyg3azKpfqjcySttB1j7+C9klBZTczEAqTmBmmCsO7LN6
         pEC7tTfH8PbvCsAjD7q/AOyR6vA5aWyeIPdEiaCDsflyT1/Ry2lYfJdFst6an0ArQqYJ
         Yzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xdwLDrcWYKJZSMYMYuV8riE8ORgcBnhB0CHa1Q/JBs=;
        b=J3ASRXFjwC8vLpDWe2r1RWnMHDQzw5hGKLgmHsnGQQ2PSclMiLbiAWgqQuqTMIpmTS
         pwgvbxap9y3Z06FF8/xjRkgEMECGmkyxHvgNcQNQOzsAK1e4p3DLBk48ClzRQ0YYGUwQ
         rr0SuFJtoyHjzovKI7kuXe2Qp4rz9w6WxCl5eVIdZ2y6DUedQP7R3/i5RpsVnrroeacd
         v7TF+prtyDZaNUWa76rTdGMPOXFM3gljVPEnYxXWkkbp9vWY921NGvlZgitD0WTWIJ9/
         NR9c8r0W17AuDST9/3Y41Y9KIHCugIpgXvcoEVV+cFVwSH469HRyl/L+pqFxIWdECIAY
         dDHQ==
X-Gm-Message-State: AOAM533nrO5M/AdOKVwJqoCJ5oxnExZlkvrdBTyYkU/sJuF9lY1lb0I+
        D70xApcJobbE0Dda6pC8Yh4gRw==
X-Google-Smtp-Source: ABdhPJwkjOkvuLucehpAKBBj0JktW+lR9glrfph7izxG8rzbGe0A5bRWnqXrrWYnYK4ilSl5EQhwdA==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr1217792wrn.12.1610525285003;
        Wed, 13 Jan 2021 00:08:05 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/30] drm/amd/display/dc/core/dc_link: Remove unused variable 'status'
Date:   Wed, 13 Jan 2021 08:07:29 +0000
Message-Id: <20210113080752.1003793-8-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function ‘query_hdcp_capability’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:599:28: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f4a2088ab1792..8ccda8b9ac2eb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -596,8 +596,6 @@ static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 	dc_process_hdcp_msg(signal, link, &msg22);
 
 	if (signal == SIGNAL_TYPE_DISPLAY_PORT || signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		enum hdcp_message_status status = HDCP_MESSAGE_UNSUPPORTED;
-
 		msg14.data = &link->hdcp_caps.bcaps.raw;
 		msg14.length = sizeof(link->hdcp_caps.bcaps.raw);
 		msg14.msg_id = HDCP_MESSAGE_ID_READ_BCAPS;
@@ -605,7 +603,7 @@ static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
 		msg14.link = HDCP_LINK_PRIMARY;
 		msg14.max_retries = 5;
 
-		status = dc_process_hdcp_msg(signal, link, &msg14);
+		dc_process_hdcp_msg(signal, link, &msg14);
 	}
 
 }
-- 
2.25.1

