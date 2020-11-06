Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB52A998D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgKFQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:38:38 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2BCC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:38:38 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id n63so1168996qte.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l//k+DSsx34Nc1jx/NivWPrPdB1Y2U4G87NDV4sY8fM=;
        b=J+dH50Ir6c9uH6K2wDO7IcS4bmFe8lOV8q7+I16iVL9sjS3ctqlKrze3+q9Dn3fH/p
         RpMwzXUMrzNbJyPmx+TInGqyYah2NJUHYeomnGj+eemuaR379i/7d8r5X8giuFbGhR7y
         wrM6ajU8PG6oJDbIPQ9ERXxj/66peBmKJWpqMXvriAry6Z3WSgCMRWZe9tfZ3T9X9y9j
         QTQwPL+nomvaHWeZlEFoV04dF9gYsCCXTk8CeYNMv10M/BfwBV6pZXPdNV9t7LDRtRoO
         6lEJFo7vdOQFlmWWaJ8vZA+GtzvCwj4m3nO1x+NSb0nhaMaTJE3zVpMpDnJ4erK0/xQF
         ZzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l//k+DSsx34Nc1jx/NivWPrPdB1Y2U4G87NDV4sY8fM=;
        b=X8g2zjBdCOECCFqlrelHJwFWY1wQ04GOb6JAbtkNiKgMta1g2gSGofgn+RNzlNdREt
         8jdf7ObTqg809X8DTsQSJbWQ1KJxTJsn9kClas7Y6Y1de1r25B35l2da7+ydGrswxmPA
         JlBCo5GBNToQm09Al8FF59L6Z6wbER8VxtU8hiNonXx6neWFrBj9gYNonAUurVENKsUz
         OrH+PO2jFLcM2yJK+VcprImhmhodgnJKVnPKKihqFUIaDDTDReZuv7feDNMbgxHrKcZS
         zqyLZgBi7yndjlBp+rxmHTLS7kS6uLhuPWCt/knKhhMIGAZnZrr7Lg60pY53c1VSpvp2
         cDTg==
X-Gm-Message-State: AOAM533oPisoJ3JxB/54JEsDIlBxrYRJ5IJJt9fx3pJJeTJXQSXlZFnH
        R7J1aLrmDFrI6Hc8eNGtVmShIw==
X-Google-Smtp-Source: ABdhPJxHUWgYZ4frcBST4WltJsrhWPJrimgJHKRjTXKm4KGGNoJ82BuMMEXhzlmb3W3E9MA/bng0Qg==
X-Received: by 2002:ac8:5748:: with SMTP id 8mr2284612qtx.114.1604680717401;
        Fri, 06 Nov 2020 08:38:37 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id s3sm860000qkj.27.2020.11.06.08.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:38:36 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS),
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/5] drm/msm: support for host-cached BOs
Date:   Fri,  6 Nov 2020 11:34:29 -0500
Message-Id: <20201106163437.30836-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to support cached and cached-coherent memory types in vulkan.

v2:
 - added patches 2/3 to enable using dma_ops_bypass
 - changed DRM_MSM_GEM_SYNC_CACHE patch to use dma_sync_sg_for_device()
   and dma_sync_sg_for_cpu(), and renamed sync flags.

Not sure I did the right thing with for the dma_ops_bypass part,
this is what I came up with reading the emails.

Jonathan Marek (5):
  drm/msm: add MSM_BO_CACHED_COHERENT
  dma-direct: add dma_direct_bypass() to force direct ops
  drm/msm: call dma_direct_bypass()
  drm/msm: add DRM_MSM_GEM_SYNC_CACHE for non-coherent cache maintenance
  drm/msm: bump up the uapi version

 drivers/gpu/drm/msm/Kconfig                |  1 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |  1 +
 drivers/gpu/drm/msm/msm_drv.c              | 32 +++++++++++++++++++---
 drivers/gpu/drm/msm/msm_drv.h              |  3 ++
 drivers/gpu/drm/msm/msm_gem.c              | 31 +++++++++++++++++++++
 include/linux/dma-direct.h                 |  9 ++++++
 include/uapi/drm/msm_drm.h                 | 25 +++++++++++++++--
 kernel/dma/direct.c                        | 23 ++++++++++++++++
 8 files changed, 118 insertions(+), 7 deletions(-)

-- 
2.26.1

