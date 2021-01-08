Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6DF2EF8DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbhAHUR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbhAHURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF4C0612EA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:47 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v14so8751000wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEfovM2NKT8ag9TvqZ5TvTpEztKPhuBS/BnjHfStf3g=;
        b=qrFDHa6UMrCuOW/PtBirv0Ncr1vLCDJC57MzIwvydzI8tYtfDhmCZvdRcq+JEaYKFj
         j7lHElH8pycb5tVBNhvAACygNyfntQryXRiD4cAGiUtrML6OGIBkIDaIUyn/bH1pT3Nk
         mbEUKAeUZDcLk7U/O4lCYCQ20NPOfui8QBFwVFHzmaRu0QeeN2Og9A741HgBzdhG8grL
         0Fa4ls1CABD03p++A9w9y1DX1LB3k/YCpqruWCGpbWMhT8gYBlG0FkPBdY7CY2TJ6Rv7
         zdjgfbCO6oeuAuaxBG8OZL7CZTm5vMaWRgC+QgxY4dNb3Qyr3OJHAc71TYnJp9bl2noX
         xv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEfovM2NKT8ag9TvqZ5TvTpEztKPhuBS/BnjHfStf3g=;
        b=UM3PvFBXhlhraPaj6gkj40i0oHHaxnoB+FduMemeVbdegLuKD3veT+z5/PwvwU7Ldx
         /Mpxlwko0e0hNahNV3cJAYGfe3XaWeJJLzuf/gghRUo2Ovixp5dQJTadGKkItFIkAN47
         xkPzWCsHiIc2/zx5bFxBnFBqQLg4gXI2pj/Tz47izWTOBvgftQiqhwhV1igtrdh3Y0sF
         b7BuSUVBArueP9x5b7fhrpRopk17DAfa0Mr22Vj0N7JzBPZEkPyFKlQi99nblsyZbGIT
         pJI/2RMtTidr04rafVAuZfGhyDK/4AUmy7ywijLebJtKSsx2/IPpYajWai/lavSbNAs1
         3UIg==
X-Gm-Message-State: AOAM532yBE5b/uu6efnk59L0Lyk3uCHz8m2/eJI70j8SCajG8wASJ7MO
        shrJGhzOmcZV8VSzFfxHDwSPLtBpp8AJwq8q
X-Google-Smtp-Source: ABdhPJyWNXAZMb17ssH50iSdT8H27rJjcQnuXfCL2ZQMggBqNfo6pnT2c08Z3ljkQNjZ2fHs49c11w==
X-Received: by 2002:a1c:87:: with SMTP id 129mr4460111wma.183.1610136946590;
        Fri, 08 Jan 2021 12:15:46 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 29/40] drm/amd/display/dc/dce/dce_dmcu: Staticify local function call 'dce_dmcu_load_iram'
Date:   Fri,  8 Jan 2021 20:14:46 +0000
Message-Id: <20210108201457.3078600-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.c:74:6: warning: no previous prototype for ‘dce_dmcu_load_iram’ [-Wmissing-prototypes]
 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_dmcu.c:31:

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index f3ed8b619cafd..fa2b47d41ee2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -71,7 +71,7 @@ static bool dce_dmcu_init(struct dmcu *dmcu)
 	return true;
 }
 
-bool dce_dmcu_load_iram(struct dmcu *dmcu,
+static bool dce_dmcu_load_iram(struct dmcu *dmcu,
 		unsigned int start_offset,
 		const char *src,
 		unsigned int bytes)
-- 
2.25.1

