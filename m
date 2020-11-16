Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF852B4E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbgKPRnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387797AbgKPRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:00 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E482BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:59 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b6so19669485wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbt6Bt9xb+nEOL+sC88FIyMMDCRwxeU6Sb1wX9bISpg=;
        b=jjlCCiNIxsXpA+Jb25gKyWLrqTzlSWECuVTeXlKwqjUFgAiMxr2Kg1XsOu2FBDybwM
         wlRkZCxOJb/RWj0i6Uh14Z8mZESJ4jsc5a5m97NFCFK10sB7oe7LWCpmkBLNACoAEDGT
         XsH/kfY8Xy6dWH0+U1ERkrX4+wT77JWiLWRTDYONESCjRkl7SpP+eTUmq5S69un0s8x8
         tZlttEn9Mofc1vKl82qQa3htdJRCyrK6jakgRDCgIgeVn8u/bxzK6iGrPvoyWYFXKCOY
         U/LNolmUxpjXqFf14X66y15Q1pU0Ul51bCFk/mWMfRsyW4W+haj5BpTbHXJOfr3btsFP
         p8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbt6Bt9xb+nEOL+sC88FIyMMDCRwxeU6Sb1wX9bISpg=;
        b=lb9Kazi5jOIzKIpy679bQuquc35LFE13v1LtWh3CBTI8BDvzIX4UFQ9fBjU2SSEEHc
         BtE6xA3LLq6kgU8Rng3SknauBTTSyIsOzbt3Za6bmgfwBv9NFlDyprjx1FCly1rIK1Rx
         +XjDlY6zyKC5SnuTNuakBnCe1Q9P5a9H3xhfR+rHWHLcPGt/J+uaNZjW/ITWg3KsvYja
         i14WkfkUSOYvNM2zC3RavIs8lrdJZJE0hjTyrUq0g4OvvL3Ps6t1lSwghyxfdxOlH/VT
         kZLftfEmo649VbXOezLjCbdDM0EVVHG2z1nvSoDfUwrs0qUVDgdaozJ+h1oBoPy815OP
         9TAg==
X-Gm-Message-State: AOAM533kUzwCnptxAppHF2yJXjqkOcqA7jySjSMhImOGgwCkSx0PWWZp
        ZOcfxW1RwZrGCwcQD71yTHQ4TQ==
X-Google-Smtp-Source: ABdhPJxixVTfoinJ+pbMo9gBUuK0pz4maqlEmMuGBMn7mSWL5CMNmdd/xIpmu0aAD8lk+4XYjkVVsw==
X-Received: by 2002:adf:8521:: with SMTP id 30mr20985238wrh.265.1605548518655;
        Mon, 16 Nov 2020 09:41:58 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/42] drm/selftests/test-drm_mm: Mark 'hole_end' as always_unused
Date:   Mon, 16 Nov 2020 17:40:57 +0000
Message-Id: <20201116174112.1833368-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the macro drm_mm_for_each_hole() 'hole_end' is provided as a
container for 'hole_start + pos->hole_size', but is not utilised in
this use-case.  We cannot simply delete the variable, so here we tell
the compiler that we're intentionally discarding the read value.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/selftests/test-drm_mm.c: In function ‘assert_no_holes’:
 drivers/gpu/drm/selftests/test-drm_mm.c:57:18: warning: variable ‘hole_end’ set but not used [-Wunused-but-set-variable]

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/selftests/test-drm_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index 95e212a9a74d2..b768b53c4aee3 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -54,7 +54,7 @@ static int igt_sanitycheck(void *ignored)
 static bool assert_no_holes(const struct drm_mm *mm)
 {
 	struct drm_mm_node *hole;
-	u64 hole_start, hole_end;
+	u64 hole_start, __always_unused hole_end;
 	unsigned long count;
 
 	count = 0;
-- 
2.25.1

