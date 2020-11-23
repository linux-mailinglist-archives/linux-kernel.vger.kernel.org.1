Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5B2C0405
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgKWLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgKWLTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:30 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF47C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:30 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so16871113wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPHwGts/M0okAx5StN5/QDa0j6ml5tJRffeJmqdhnEY=;
        b=UzyDbEtjw9EFf5YHCxgs8oF8pOLnid+3lYCSPIblTdPw6D0UjMFPSambM0pxcvoVId
         yBF6s4V7I0DZ24qAxuE+t1eTl10NX3a00BZ7ZvLaM0BYPP7yQMpXrO+z3KGbK0IyiCCQ
         zgTobsZex+ZN7sIQkC1EZVY9SOkieJDIwWXZ3h06Y6yBmTNLpqi0xGTdYF7VqGcK/Uco
         TUh+AG1KY7n3afiVLwCUjUfdO3GYkgo4iM0HXLDBmC3TmMOTjRRLFl1mgUg5F9lrpeC6
         XZVWX7JAG4VgebsWCOafOCt2rtluZltcp+0plTVJCkksuN1mscYZvfbh1aauUdFBo0x1
         pNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPHwGts/M0okAx5StN5/QDa0j6ml5tJRffeJmqdhnEY=;
        b=MYxN85pVrTpz18ld8wic4Ibr+vpvBllEXbUG7PvVEl7T/TfHEVbHJIPNwrNt2Dwy6q
         a4PaeAk5AdnzzSBvLiC1bRBTo2wD/cQnTqF0V0Nx0e0DVUX3yfgcsDOKEjogCBjkJDjr
         mc/SjENHgOhBVIcMqt8WObKPPBUhuPOL4HIZVoz6PrH64DQ558gsDAOnaSAWPqV9l/Um
         Dn5lNV5KJI7SDQM84MwQNhNry7JmKFvtsrPOCfEj4s++T292kbERGvC2PUQcP5XTLQ/B
         piVCzfrBbQX/+v62KdCJvyAwD3sqBVTzwHfA/4eryYTuHiqV0p0ksr0zuPeMsMPdlEVl
         NcIg==
X-Gm-Message-State: AOAM531x2zoV3H+xIzNEZSrXhZr/g7TYkhrcAZ2oTxP0s8izcUcGT6Yu
        23obVDFAYku5lhRacOBEC6l33g==
X-Google-Smtp-Source: ABdhPJxCCdUhjs0qi9cXiC6juGV3V7fNxFDwFrM5pEq9qjmcHBO/Y0Ddy+z2cLdiLHj8tZ/biImuuA==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr17634480wma.48.1606130369392;
        Mon, 23 Nov 2020 03:19:29 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 05/40] drm/amd/amdgpu/cik_ih: Supply description for 'ih' in 'cik_ih_{get,set}_wptr()'
Date:   Mon, 23 Nov 2020 11:18:44 +0000
Message-Id: <20201123111919.233376-6-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/cik_ih.c:189: warning: Function parameter or member 'ih' not described in 'cik_ih_get_wptr'
 drivers/gpu/drm/amd/amdgpu/cik_ih.c:274: warning: Function parameter or member 'ih' not described in 'cik_ih_set_rptr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Qinglang Miao <miaoqinglang@huawei.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/cik_ih.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index db953e95f3d27..d3745711d55f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -177,6 +177,7 @@ static void cik_ih_irq_disable(struct amdgpu_device *adev)
  * cik_ih_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to fetch wptr
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer (CIK).  Also check for
@@ -266,6 +267,7 @@ static void cik_ih_decode_iv(struct amdgpu_device *adev,
  * cik_ih_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to set wptr
  *
  * Set the IH ring buffer rptr.
  */
-- 
2.25.1

