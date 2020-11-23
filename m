Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE02C0469
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgKWLUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgKWLTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:55 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251BEC061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g14so2998369wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNPMH7+BshXFtHvJRFR/Pz67utL4+c2zXgvOMeOYi1w=;
        b=x43XL5SjSI8fFhB+JucQYDS6mMeFgr//tbZ0jm1MCQ9P0QBt6aEmfPzxG6yD50eqQd
         NMHzrMMk4AgiHPrCgw9MpvOFhdCWMwZYGoD0lFKSesvOzp88G8aRRsbScKsdMbf9Q3p8
         QYi8NcCu1k5AzonhQ1VCH6zCT+3+AkNgrwjHiMtXMveewofVxbNK/makoLjx6W/mvQb5
         w2WODjf+b+8MZRkQF7lxK3wFyP4wZiynPH2YI42EtGDXT+d75ltrHmB4OZkczxlduGLQ
         MvIfrBqudWXGr7o2EHHoLMrgkL8mpc96BMWOhnOSnyiegEQ7PlOG2hlcT5EjOxDI35z4
         ZjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNPMH7+BshXFtHvJRFR/Pz67utL4+c2zXgvOMeOYi1w=;
        b=KRRrnY7mHfO/CUnvT7eqqJAFEO6eDtXDB1gZimF5kQWZC5fW5weAQxxxR+0rwCmne9
         5vPWHXP0J05y10gwqgSN6eHLnwIW0aaXGnE8AKciNSXbLzoSj5KkrFKcY33WcVwm3nzv
         +yFAUgxJvQijfdvPJ4ELIoYmjL4wEuQWeIrvOVAOTd+yCdMjLQU7smFUHDWXZb2KlR9H
         Gl4fZWZBRIaP2FIEcwQQ9qT5tgkGDe/HEFYXLci9PIFB+A4h6PsLdUDxA8+chJJD2CIL
         xVlmlQ4IJTOnciVlDLNqWwjjVM9/ouhKsYax2Q/GJfnd0MU3GwWeQBQsmFCe9zpsZOZf
         kJXw==
X-Gm-Message-State: AOAM533vLbJlhFLjgFc5DEZZrnfYHOyNpOkR0zryttylOo+AF/vMnb3B
        Y0ek81Eo/oNA3uDHYYq+heK8eQ==
X-Google-Smtp-Source: ABdhPJzrDah+u91N2/j3UWxTUP9JFlQRPTokZt/Vi5apdBbebjcxWKcx2wIFaChw2/Z19djyE7hbqg==
X-Received: by 2002:adf:dec3:: with SMTP id i3mr931833wrn.263.1606130392924;
        Mon, 23 Nov 2020 03:19:52 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 24/40] drm/amd/include/navi10_ip_offset: Mark top-level IP_BASE as __maybe_unused
Date:   Mon, 23 Nov 2020 11:19:03 +0000
Message-Id: <20201123111919.233376-25-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c:27:
 drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:127:29: warning: ‘UMC_BASE’ defined but not used [-Wunused-const-variable=]
 127 | static const struct IP_BASE UMC_BASE ={ { { { 0x00014000, 0, 0, 0, 0, 0 } },
 | ^~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:109:29: warning: ‘RSMU_BASE’ defined but not used [-Wunused-const-variable=]
 109 | static const struct IP_BASE RSMU_BASE = { { { { 0x00012000, 0, 0, 0, 0, 0 } },
 | ^~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi10_ip_offset.h:61:29: warning: ‘FUSE_BASE’ defined but not used [-Wunused-const-variable=]
 61 | static const struct IP_BASE FUSE_BASE ={ { { { 0x00017400, 0, 0, 0, 0, 0 } },
 | ^~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/navi10_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/navi10_ip_offset.h b/drivers/gpu/drm/amd/include/navi10_ip_offset.h
index d4a9ddc7782ff..d6824bb6139db 100644
--- a/drivers/gpu/drm/amd/include/navi10_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi10_ip_offset.h
@@ -31,7 +31,7 @@ struct IP_BASE_INSTANCE {
  
 struct IP_BASE {
 	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C00, 0, 0, 0, 0, 0 } },
-- 
2.25.1

