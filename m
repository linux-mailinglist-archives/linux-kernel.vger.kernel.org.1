Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032EB2C0455
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgKWLUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbgKWLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:58 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:57 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so16859593wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BSX8iGmFlpNBkCwyYHsXehrutNO54wnnUYTt1a8UO4=;
        b=kq+yTUs0Z36Ahw7u+PzIXO7sgObe2HM66BxwQRS4z8siLlP0bqTJ1E4ekPh8ZzB2xV
         KrPXoI5LzXiWCUU6gv/h+Ac5AkvBrXCtGIdXzqiD3E6fzjlaykwmpnp0ncc9mpMPXwpF
         7ZO7x5sszZgxTW0UZBhGM+nZPJNMfDadL033J9dDknwd0n71CmxAJxEfiOSfp9ZWRYzT
         VjWz7KhkCFs8qGvbkbLv6YhVXaOHIHxX+gga4D1/GLSvPxglfwfHNhszl9lcqHMNlukf
         3bU5zyK0fgnAlzHDZ9nRCXu6URdAznRm6+l/O3LsPeBn+y817mC4us+NHZemgltRJsTy
         MAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BSX8iGmFlpNBkCwyYHsXehrutNO54wnnUYTt1a8UO4=;
        b=umaacC4uYvU2Y3o0xAo6PC0XKhUMtbKH/jBpu1khGhH35RUEJZ84l+JRDSrzAvjsHW
         X1pFaWlPHZE9ipwVqkXVKpVmIRfA+Nu3FoUoqvxWMANjrq+joAYcifBRM3xIGEH+t8uk
         7w/e9rXfmYE878pQa29Ikq8tLRq0LPbSXof8FYBXbgN9xzqwAVvaE+jYnNOgzf062byN
         0tMdq2F7m1ips77TWWLVQBXYOAS1L5iKU0PrTv0JaVsI/5kVMh86hL3JSJ0G2HNGae8C
         ZCqjFu/Tp2fk9akBmEVXgZLfWwuo2R8UpywIuTzeoRHZRKBXz8LMiwyx9ksKjgVsHX5X
         cm5w==
X-Gm-Message-State: AOAM5303VCFIC6lV4tbPec3DWlpSGGe9pKnUvh71tqA7K9C1csppgUig
        ycbcLBYYGKbra5ntPgv/GPpdIg==
X-Google-Smtp-Source: ABdhPJyN4OEr/YOxNYffIUn5qCnDBtG2DeSQZgaAWBIDjmJjXk/O+zQ0IJfMgrsLJnio9vIdj85SYw==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr22882338wme.23.1606130396662;
        Mon, 23 Nov 2020 03:19:56 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/40] drm/amd/include/navi12_ip_offset: Mark top-level IP_BASE as __maybe_unused
Date:   Mon, 23 Nov 2020 11:19:06 +0000
Message-Id: <20201123111919.233376-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c:27:
 drivers/gpu/drm/amd/amdgpu/../include/navi12_ip_offset.h:179:29: warning: ‘USB0_BASE’ defined but not used [-Wunused-const-variable=]
 179 | static const struct IP_BASE USB0_BASE ={ { { { 0x0242A800, 0x05B00000, 0, 0, 0 } },
 | ^~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi12_ip_offset.h:172:29: warning: ‘UMC_BASE’ defined but not used [-Wunused-const-variable=]
 172 | static const struct IP_BASE UMC_BASE ={ { { { 0x00014000, 0x02425800, 0, 0, 0 } },
 | ^~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi12_ip_offset.h:151:29: warning: ‘SDMA_BASE’ defined but not used [-Wunused-const-variable=]
 151 | static const struct IP_BASE SDMA_BASE ={ { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0 } },
 | ^~~~~~~~~

NB: Snipped a few of these

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/navi12_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
index 6c2cc6296c061..d8fc00478b6a0 100644
--- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
@@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ATHUB_BASE ={ { { { 0x00000C00, 0x02408C00, 0, 0, 0 } },
-- 
2.25.1

