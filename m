Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E82C045E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgKWLUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgKWLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE1C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:11 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so5262982wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++Vz68Fmu1On4IoEFcmE3A4sGOg19/cMuiuu88qyFq4=;
        b=q2K/cwXYQSgDLZTSTd16fYGp8epOrbJawkVeEFI3/Pfsv/JGDv5qaPXYej0iOxd2ph
         48gor7LDZtGHEP5ggv34K4U71CCZv9PNpVNhUskTNwtJpMYERc9plx2o33yuqougCGaK
         yh+M9Fe4ynTg2rknsoZZeLyM8Li+5AUSRduvQKHd/942b6drv28cCsPj6Zau/rquxKGQ
         F+YRrQad5JTANuegzhgxb0GJ0o76zcEYQu+iUST9WB0x+lzVqqR3ZdSgZlreFanFYD2E
         Nh+s2voMHLrEHv9VGA3bJOwwKuePJECNJP1WSvjQ5MZDdOOehYGs7KqF4AdWw00B8RsW
         0rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++Vz68Fmu1On4IoEFcmE3A4sGOg19/cMuiuu88qyFq4=;
        b=OuS6QbNCUMBmDlJ8/ZBn5cIQvObfS/29KrPZHtBNbVI8YDujZ2ziR47/N3B+JU46pI
         BoAmhGOxNWj++dPDPil6pQ2EeT63c+p21Q1Qggu7ld8w3+8y+pABpkDXXxDVPP5X60G2
         0dWGwgZvUQ5+/GKzCERjTRO+6NbQjnupa6e0ACEup9w39ihI/9MG2Q3MP6uHxKtlceLO
         4hzmoNW+VOxzyecx1YFeFtYexiISVYd2pWY6jeKUzNKEwwEDC40SccpWeyo9JtCZlbgc
         77JfWGyl2f1rvfp2lQTfpnalfU47Odv9BQbuDvAg5vdlB0Nlh3VLH4AbkLNkGUy6CPdr
         tNwA==
X-Gm-Message-State: AOAM530hfzcODly5VqQvetChEUKck8K6x7EQxwWKoml0NSQZV9vrISBG
        wYI3QEE31XzdG8n3kzDMewaU2w==
X-Google-Smtp-Source: ABdhPJw2M/yqWnzgMlKNV8eXvBuu+WRBtKXJ5jRrXE1nwLmznM70HcqS7e2cgfQC7oeumVBTkUrHgw==
X-Received: by 2002:a5d:6805:: with SMTP id w5mr5885075wru.266.1606130410214;
        Mon, 23 Nov 2020 03:20:10 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 34/40] drm/amd/amdgpu/uvd_v4_2: Add one and remove another function param description
Date:   Mon, 23 Nov 2020 11:19:13 +0000
Message-Id: <20201123111919.233376-35-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:448: warning: Function parameter or member 'flags' not described in 'uvd_v4_2_ring_emit_fence'
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:448: warning: Excess function parameter 'fence' description in 'uvd_v4_2_ring_emit_fence'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 2c8c35c3bca52..bf3d1c63739b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -439,7 +439,7 @@ static void uvd_v4_2_stop(struct amdgpu_device *adev)
  * @ring: amdgpu_ring pointer
  * @addr: address
  * @seq: sequence number
- * @fence: fence to emit
+ * @flags: fence related flags
  *
  * Write a fence and a trap command to the ring.
  */
-- 
2.25.1

