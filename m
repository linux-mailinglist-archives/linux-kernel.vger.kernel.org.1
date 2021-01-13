Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C642F45E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbhAMIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbhAMIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A70C0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r3so1086599wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QtOB/mkCBg/7k2V+Yul5Q3zrw4uvSu6D+ZDw375QQ1c=;
        b=RlPHM1p/vG4SiuUwAw1bbIS+KMHFtNuIJRaOGSj+2QN2Xv9MYmpXiHybJdI3JFPrx9
         rcHTpY4z2TUTAfTT1I4Oj+dYy1Hoq9VB4U7/nMWz8M3OeGbsigW+GAcdlv43iq+PGUqc
         N/cHJxQw7WOtopw0GWdLqfI59hhkzZnOcSo7/WDLBGdj/umo2fYaYvciEXE+O4JwVn7J
         7nL1q7H638KJMQx/i6LfIKD5pmJ7JhBscMqHmPRL/AUL5ZZQHYmHOg0fVC6TrZFE2wX5
         RiRcZAQbYaxDh/JmbM+g5OXeOQUIqAjF2kPGe8QidqmB+v8VvhcXal041dC+f32wFYfy
         OUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QtOB/mkCBg/7k2V+Yul5Q3zrw4uvSu6D+ZDw375QQ1c=;
        b=qf/1zU+4CWT4zEC7ri+dzoFrTnk/kjZNED967dS89Jk2wbimeiBrv6TxoLuhaFhv6A
         Uy4OtZExUkH2XrjAnd1dW+aokXfgsnT9p+pZiS7A3F4Vm+ph7NsX3n81SXMXuyJLNkUC
         6DgQVRY3WhdUX1J2ExeOyzwl8eyxBXo7ZBpfX4SuSeZ8++Kj5G6xVvcpyCTsLkWMfuS+
         cZXP+/MELL6o1x4/ECvFTErO0llsMWd6vJ6MQGW5hmPwkghU+5stEOWcdOAlyFtDZntI
         gmRPAdu1oJgYkM5OcJ2UzyYntRJn+Cf+mp4MP41S+9CG1meWAspgzUT020LHDIO6C5s/
         vVJQ==
X-Gm-Message-State: AOAM533cjeE57kkkEt6sr3bBS71uzvIPcTHlIsbZc6jv+VdJ5FqVR76h
        KEqKV6EVg32ruzdGUiDY0InNrITZJUzQ9aFj
X-Google-Smtp-Source: ABdhPJywG3pcXtpKgqZEPCytcOe3O9Nzdu7Pq9pYz665OvcE3oeucdt1OjBpXy9CDZfBHI6bFQh8Pw==
X-Received: by 2002:a5d:4112:: with SMTP id l18mr1191436wrp.116.1610525288602;
        Wed, 13 Jan 2021 00:08:08 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:07 -0800 (PST)
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
Subject: [PATCH 10/30] drm/amd/display/dc/core/dc: Staticise local function 'apply_ctx_interdependent_lock'
Date:   Wed, 13 Jan 2021 08:07:32 +0000
Message-Id: <20210113080752.1003793-11-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:806:6: warning: no previous prototype for ‘apply_ctx_interdependent_lock’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8f1cadb823c71..0a07e608485ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -803,7 +803,8 @@ static void disable_all_writeback_pipes_for_stream(
 		stream->writeback_info[i].wb_enabled = false;
 }
 
-void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *context, struct dc_stream_state *stream, bool lock)
+static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *context,
+					  struct dc_stream_state *stream, bool lock)
 {
 	int i = 0;
 
-- 
2.25.1

