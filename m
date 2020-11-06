Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D322A9F69
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgKFVuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgKFVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:08 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B195C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:08 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c16so2656015wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Egmlgv9H3fW37Nl0/DO7Y7+0OQCWufEB+r7yIAqkua0=;
        b=eYaXK275kZ6tl5bZ2mLwFa4Hvd2EKmC0/VME8B9G/DISC2ffhyEptBOVG0KMjuNOLC
         XsEsCBmAoM7RHtAu3Qlc9CDxH+LWQ1uBALNxpw6HcSXEq0Pwu0m95yHxCdsAjrL12ceV
         KKvpLWrKJWTh5XU+PgrRW9YhQWWPAJMptrUEfAahqFedytbPfoYgCfYmvN5loU/6Lx/p
         jUyrunnT1AJH5g9RK08Qcpg1guaWrUBsccPIJSv44/qAOHunj6+eiN42lzj/+reg9vaX
         FXAGldEVoHjpHPVRlk78/1fsZaFkU/N2gn3wWzFRiBhdyL1xxlo9jkwAjDu4MIG2RFV2
         2N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Egmlgv9H3fW37Nl0/DO7Y7+0OQCWufEB+r7yIAqkua0=;
        b=I2vGu3yDjL5Cxn0xZGjSVxm3+2Dk+N64Wcyxna2gfd+h509ucl8maTkg3Le3MDZ9/M
         bEighccwLRWsgrdm+zMH1WY/rtTACkXssMX3kexN3WqNtcadwCVOMdEq2HipiUzbTQp6
         hv0LIljCeBF75N8BG2Zaw+tfPo1qAViAzkcWACU4bAjjygVdjF9u/duGGa+HQq4FsUCZ
         QtH/71bpMn3LC6PGiowIMhBAiW46tIvuGhHpz67xOvrl//Y6tFhq8V/H38wiYTEOy+nb
         nlOG+yd1FjMjB+4hZacn+hErRrvxIS7dVwDjRTr1vueMR8CLF33XHRhejmFCF+mInVGZ
         wTGg==
X-Gm-Message-State: AOAM530QorF5EXK89ov47YiZ2CwMaHYcFnjqPGaDnMPikbP4CKqr73HB
        QkSi7JtRQ7NBrZ/jPNN/X8HfPmEQ6JPXzY4r
X-Google-Smtp-Source: ABdhPJy2bIjiZLuZODIqlT1CvO+CLjkrEG+vzynMbmZJqKxhgkUCFDhXVQmJzX4wCSLbFC2K6m9Glg==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr1515842wmb.141.1604699407208;
        Fri, 06 Nov 2020 13:50:07 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/19] drm/radeon/radeon_drv: Source file headers are not good candidates for kernel-doc
Date:   Fri,  6 Nov 2020 21:49:41 +0000
Message-Id: <20201106214949.2042120-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_drv.c:2: warning: Cannot understand  * file radeon_drv.c

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 560267cc25892..bb7b33e535f81 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -1,4 +1,4 @@
-/**
+/*
  * \file radeon_drv.c
  * ATI Radeon driver
  *
-- 
2.25.1

