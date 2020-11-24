Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55A22C310B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKXTof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKXToP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:15 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86CC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:15 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so91081wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FS9YPeBS7kCrSPbUVkxYBE/KfGD+0TCEKMjrGKoj90U=;
        b=uPKMUh800nKfHaIh28pUF8SIocH8o+qrfL+QGuLUqd1kge/4Pl3XBpgRH2vT7ZMJSY
         uakHIOVbvrsrVX5vocCdEfXc4nhCqiXticos1FPTvuuwGD74+vEUTrQ77bG4krExi0Yj
         2KOTD2uvcR+0wE7EYSaX/7PE4vNy/XMZk7JBoQ3k2lzhwIXBqDY3oO1lQEHVNB8Wvi1f
         zjkWjrssK0ni8EdeoVN989g5UCWkHIWXrwwwUSka5WH7gYX5ThWerASjzmLoXGqX8QaJ
         C5CTqEy+zxMcqZWmfi/+uP+kU1QkfLIH1Cw2NQUv3dNg3u/52dC+0Jtm/hB8C6eS0Q3K
         hpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FS9YPeBS7kCrSPbUVkxYBE/KfGD+0TCEKMjrGKoj90U=;
        b=f37Gr178jd6Hb85WfKMmDVkkRFYKg17eRu5pWWfUFCsvL+KNikTjIC691xKqeh9k7b
         bmSI9BNfVWDp7xlQrc1uQnRdvrTmL+bmn1IzQbLrK03jRaDgwYyUflnNyfANRuPHFkm2
         QYE9An6wUJgikZvCP+18GOSv2+q4LjziH9PtaKMuvC9Tze9pWWu6WTaqVjK6xEzh/EJa
         baIn8+lQIUzWWEN81NAQbxBoBNRt8vIQe21qXPMNPDVr+0v03lsaA+VZaDh1ttp1Tkho
         Wqlu4fz9Xb79p+6UMmdvr9wCaC+F8c7gSSZ6He3QkimYeLJ9lFgBP9UxjNB6UNdELAVt
         N8Aw==
X-Gm-Message-State: AOAM533FVpJptD/35H7pCi3aNF6PZtHnA6p8rmQBDzwFM7Rm2wQY3krI
        eZAvD9YJD4lrPyvEUTpt8rSfQfJr2QQdQvIw
X-Google-Smtp-Source: ABdhPJzsE7Vx9UXN4W0umVdESe5TbA5OW0VFsT+YDpvTZyofmmt2DJ2JzZ4s9n8DupjG43ptWoyjKw==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr166411wmj.11.1606247053955;
        Tue, 24 Nov 2020 11:44:13 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 12/40] drm/amd/amdgpu/dce_v10_0: Supply description for function param 'async'
Date:   Tue, 24 Nov 2020 19:37:56 +0000
Message-Id: <20201124193824.1118741-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:237: warning: Function parameter or member 'async' not described in 'dce_v10_0_page_flip'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index da240f8fafcf8..7944781e1086b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -228,6 +228,7 @@ static void dce_v10_0_pageflip_interrupt_fini(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  * @crtc_id: crtc to cleanup pageflip on
  * @crtc_base: new address of the crtc (GPU MC address)
+ * @async: asynchronous flip
  *
  * Triggers the actual pageflip by updating the primary
  * surface base address.
-- 
2.25.1

