Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F322B1C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgKMNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgKMNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:01 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC1C061A49
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:55 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so8200572wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/knA7px3ItuZjnu7kmhshhnJxUB7qJyEjkrpKqZtiA=;
        b=Yv+njuEXEnBreJ8gLTiSi7E/xj85s7S1U0w/6zQmiPZ1aSp7ZCFuVeOXtQ700dVUZY
         9cYICnqGX8VqTm9uswhkeCOG1WtAgHPlSd0c5esIEBrxnfKNGIGJ7N8p3mHPOWhQfTc1
         nC3wfYKKdObN0Tc9WdhW5lnWd2XE2C8FVH/YwzSsMK/FEI4Sr8lWCjkLc40a3q/X6SyT
         UgKx9M745DJvAIjlEINmUn1V9VoRLqlMR+Mzj+ZgD/IZxefVR1P/a0fFZ2ta9U0SnQuq
         SE8cIQ/hFaUu8KdY84nozKy8eDIdoFOTixMUC5F5T/SUqdfdqRWs1tIjHdgcknmYQkwG
         RpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/knA7px3ItuZjnu7kmhshhnJxUB7qJyEjkrpKqZtiA=;
        b=q09sPkZdX+5C24cfwYX9YKpuvB9upEzPYyXuPclJM3K+OLggOvY7Qbnvr6LnUw7fYf
         3xmT6amKjik26DqCMLww1Hrst9PZTp55WNaGhTUWr5qqDpz9/hGXGxqfQmrQEgsz07Hg
         dThLkWlKShHBs3ZbSbi95f6rCc6/lUcOw03JKaU7VzCCyGIli33O56HJ+m2AS3+UfQd4
         C4UW/tLOs5knrcDEopuMb4U6Krz/7ko4RgzHq4kJZ2gw22G0xXiJhCH6bGyFGAhHMs2O
         a+fuIVLbYiK2XUlMKayRbmohBVyIPaTzx40TQnlRrQ/cBZEuIibaztubdJU9A4zXL8sJ
         WrHQ==
X-Gm-Message-State: AOAM533NfkwjXYCIc6nRoflNmjP6cVE/nHZSLcIp8NJBa48C1ijyMVZx
        fkOvQD8x9lZgHMWJRySx5DILLg==
X-Google-Smtp-Source: ABdhPJwR/sJKpEHbFTNMAquVWfrvJqacpk5fI57RXqCKzBoxehBUK0EZ5Dy/sI0mHknNbdzfm98Okg==
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr2624009wme.171.1605275394497;
        Fri, 13 Nov 2020 05:49:54 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        YT SHEN <yt.shen@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 10/40] drm/mediatek/mtk_drm_drv: Staticise local function invoked by reference
Date:   Fri, 13 Nov 2020 13:49:08 +0000
Message-Id: <20201113134938.4004947-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_drm_drv.c:316:24: warning: no previous prototype for ‘mtk_drm_gem_prime_import’ [-Wmissing-prototypes]

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: YT SHEN <yt.shen@mediatek.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 2e8065b1e2bbc..401311453e7d0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -313,8 +313,8 @@ static const struct file_operations mtk_drm_fops = {
  * We need to override this because the device used to import the memory is
  * not dev->dev, as drm_gem_prime_import() expects.
  */
-struct drm_gem_object *mtk_drm_gem_prime_import(struct drm_device *dev,
-						struct dma_buf *dma_buf)
+static struct drm_gem_object *mtk_drm_gem_prime_import(struct drm_device *dev,
+						       struct dma_buf *dma_buf)
 {
 	struct mtk_drm_private *private = dev->dev_private;
 
-- 
2.25.1

