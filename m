Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A4D27F6B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgJAA2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbgJAA2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:28:48 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D75DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 17:28:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w12so3593698qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfbeZ1InQAwZth4mJ7971yKIR8SQx6BQ7+DGpeWilgg=;
        b=X2OaIXnpxWi1p8YsjA3OZDjXABig1sqic6dMuCMEdOXQinJRdlMgH5OIsMXjc7k4GF
         6XzFdIZSUOvzN40OsADAZKOHsev3QLew1RHkhw3EjdGyefyecLaXTtmHgeIIZ15XZ593
         YmNIHkyK2hF683R11QO0PLgqIXWZ7UbPZuoru916rGemu5wboNogkzooFKN5wnInPWzL
         3Wb008S1DiaEFNcTpPKTL+STdrTbka9M49qPFxH334BbmoU7wdSpBvOhqPQ4mz/SkkCC
         1hU3XT8nI+FT8A/3xhCq7yCjLoqRoItLMCKwc/f/tBcmJpaA2bpnKdh+497yWohkJgvN
         HjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfbeZ1InQAwZth4mJ7971yKIR8SQx6BQ7+DGpeWilgg=;
        b=NXCTzgH7u7VvtHyo0simUPZ4dv/0PWEkqZsFDAlnO1I/nsNobzmjcYBsdRDS9pOg2L
         +amLRuWPiExqcNznaRHYpZjnRHsOaq1Nnpp4kMz4Eiogu9QzsuoDpDVX1PZjF2+ojtqO
         pOlouZXRU5acax0utwogaqxJA8ERdaqiID2wbgcFCe9QWwayrnuwanmTZbuG/JsgZ4c+
         EBXf3J0vQY6PS8lM40uRNq0E0e01+TID3jpGojIOG82VvtWSdQorJqlzULqEkavhDyrf
         Xe5RYjK5qBKO4zpzX1bh9J36C7d7Nq41LJVl5tQwdCYMxINtrlg+lRFCODZ60rmpMRXN
         3AKw==
X-Gm-Message-State: AOAM532Mjy4BwcOVW/J9N7oNzzyi636uJln+3Qv+HUww1rnyWIAnT2UH
        sRk7QlqESIYhIbHJ6X59Ft/R8h23RbARKjDb
X-Google-Smtp-Source: ABdhPJwINBo5uh42Mio6f1rg+sxf+yJ7Ja4lfnT3Lsq25qym0EpvD2ez7RBLEDNX7+D+OdzeZGP8Cw==
X-Received: by 2002:a05:620a:90c:: with SMTP id v12mr5187417qkv.16.1601512127320;
        Wed, 30 Sep 2020 17:28:47 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 205sm3850908qki.118.2020.09.30.17.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 17:28:46 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] drm/msm: support for host-cached BOs
Date:   Wed, 30 Sep 2020 20:27:03 -0400
Message-Id: <20201001002709.21361-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to support cached and cached-coherent memory types in vulkan.

I made a corresponding WIP merge request [1] which shows usage of this.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/6949

Jonathan Marek (3):
  drm/msm: add MSM_BO_CACHED_COHERENT
  drm/msm: add DRM_MSM_GEM_SYNC_CACHE for non-coherent cache maintenance
  drm/msm: bump up the uapi version

 drivers/gpu/drm/msm/adreno/adreno_device.c |  1 +
 drivers/gpu/drm/msm/msm_drv.c              | 24 ++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_drv.h              |  3 +++
 drivers/gpu/drm/msm/msm_gem.c              | 23 ++++++++++++++++++++
 include/uapi/drm/msm_drm.h                 | 25 +++++++++++++++++++---
 5 files changed, 72 insertions(+), 4 deletions(-)

-- 
2.26.1

