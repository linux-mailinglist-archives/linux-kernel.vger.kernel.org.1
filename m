Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5E2ADF57
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbgKJTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJTbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:19 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15934C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so4311228wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+zBR+LtvSmQF6WK85h0NeZVtoTEWkwyfZr5+ZdAWFg=;
        b=tMF+3pG5AXC3vlK8/vqtMujSz3Ljj+0p0heESDtpmL4we/th6iHGh+8nFxtYussM0a
         bMz4xEQZrR9KqTeE5hNq4bcSASyfm9uV4r+G23Av61RM+6SOH6NnB1Ynyq+Xs/TMfwpP
         WYnsHEtHkeSxZHAqsaWMDvHEkiDyYfdZD4ckndsph6cVHgRSb5Di9q3kfRjfy4Qf9qSm
         S1Z7kx0IqXLikmDSocmxhrrCXxtVPuqbtPgiLglKGcXr3YDrt1aGKXNzHSCwyzgE9ZN5
         jtMiGwewAgwbjqbxNG4AdtVdOklXLu36yfH1kB3UQxNm8ywdFzklqlvYLJttGr9JN7N6
         HQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+zBR+LtvSmQF6WK85h0NeZVtoTEWkwyfZr5+ZdAWFg=;
        b=CnWZl3W7A4jq1ST0bthSdB/Bpa6/a8Aq9ySVLabFTZ+Vs1UFpYk0Ao+v6QWkEN0tQ+
         qJaw2/idi0goIwIK+7y3umzDbov+gfs4VxF9Nw63yAxB7b/lLSh9pUe3Cp5a7ncS++Ef
         jN3spI3u3VIt//dPF1PorkuNzbOGWN1mM2kHtLG0919bwlLe4mp/C5c7ptpGWzdaVGDU
         rwhE/Hz8ZuTEy7O1dHga5FCstQaIG4GUMbFVr3BWSUsfxs9Z3qf1kYmUIPehLDKNaPUD
         JTrXXIWpEKvQlD4ZGMh0yYbKKMu8e7Ll2EcI60TBGfoqtRNCHyH2HlEeBZtoW6Dy03CV
         ZJ7Q==
X-Gm-Message-State: AOAM5331ovus0yP74BOFP/gfIF2r2yJ+cejZah8l4ek2lyQaAQi8d3bn
        EK46mX8BLIXqOHOT2C4F0OQlgw==
X-Google-Smtp-Source: ABdhPJweRmEkGhTCPihLk1lOn7tT5/NJE06idgEUjsbpo9M/smhM1lSR8C+7+QrbEbuwYgd5fw7Tgg==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr726295wmb.162.1605036677804;
        Tue, 10 Nov 2020 11:31:17 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/30] drm/radeon/evergreen: Add comment for 'evergreen_page_flip()'s 'async' param
Date:   Tue, 10 Nov 2020 19:30:43 +0000
Message-Id: <20201110193112.988999-2-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/evergreen.c: In function ‘evergreen_gpu_init’:
 drivers/gpu/drm/radeon/evergreen.c:1419: warning: Function parameter or member 'async' not described in 'evergreen_page_flip'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 4eb3f9bc8fa8b..c9a9a87959f9e 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -1412,6 +1412,7 @@ void dce4_wait_for_vblank(struct radeon_device *rdev, int crtc)
  * @rdev: radeon_device pointer
  * @crtc_id: crtc to cleanup pageflip on
  * @crtc_base: new address of the crtc (GPU MC address)
+ * @async: Set retrace
  *
  * Triggers the actual pageflip by updating the primary
  * surface base address (evergreen+).
-- 
2.25.1

