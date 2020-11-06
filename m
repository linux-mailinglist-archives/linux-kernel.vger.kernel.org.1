Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B822A9F61
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgKFVuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgKFVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:01 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DFAC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:01 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so2848099wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yTQMc6a66cwUFoQYWGGyiO2EU4ADWxZkG+2OvZt+WM=;
        b=uu5CGwOhSh+kpjSSd4FX+GvasU7eWip8CDp0IRaYQIF5N1TIYgU5kTexPHmzjkcK5D
         rTMLSCA6JSbeVTgKQKc0amCA0raDfgjYOkfCwhHq6PPFHEqV2O2FThee1nR93MVA41DF
         vznj0gRfU91Nt7HHqrhb1lHlpEqH573c8ytllAEtmVkmRqGXc7tF+34xrKGJQ+2DtLBi
         q4Qgut7OuPIbGSw2oNfsoZxevt2fuKfP00Wn4+I3MglnWzYYBwbbhQxF2x/EzvEfJ29K
         m1x3flrkiiysoh9NkBkFMCBloyKb7FbsxskEnnXG//znSHi7DxDSXACWic4J5SZHaJrg
         kTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yTQMc6a66cwUFoQYWGGyiO2EU4ADWxZkG+2OvZt+WM=;
        b=tZWAaee7JRBTDKfAJpuHX+AvVXo3cShneN/0d8xd96xsODBVvMDJs0tuHrvXfulhca
         fzNMf2AYzee4hHlk0CY3l2W1NGkcDg/3ZDaW5Z00wh6sOFprUHeIw99i/y0myolyGVOe
         +wVWGiGQfCqMXC91cIwddKZ8/sdLTmWF9rZmLOkqJBPDrU/ofkXksj7VeWc6XB2A5Ttv
         h3Z2s/e/m+SYXfvbPsJyWMu648lNLScpcFkF2sKj/e1Syl560Oof8kDulhI7hyFQTSql
         6BozZ7rlj4sA4dprF7EMfrSB5AHCSPcQD6mGcx6fMlVWqhCCZlKRde442tihvqXx3tf5
         k69g==
X-Gm-Message-State: AOAM531uR8YwkzawIgXYgf8zedRdChoGmDuFQGIRAaP+VDQIYI20G+hu
        BTl8rRZk0PggR/6yhzEyD503cA==
X-Google-Smtp-Source: ABdhPJy5LKzmQoSeaJUeYWgN9CpdYgSjweaktI1+rR7Bn53iyx1LEhARhzIXTJr0ekOvGwY9RdRdFg==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr1656632wmd.10.1604699399772;
        Fri, 06 Nov 2020 13:49:59 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:49:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        by <jhartmann@precisioninsight.com>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Keith Whitwell <keith@tungstengraphics.com>,
        Gareth Hughes <gareth@valinux.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/19] drm/mga/mga_state: Remove unused variable 'buf_priv'
Date:   Fri,  6 Nov 2020 21:49:35 +0000
Message-Id: <20201106214949.2042120-6-lee.jones@linaro.org>
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

 drivers/gpu/drm/mga/mga_state.c: In function ‘mga_dma_iload’:
 drivers/gpu/drm/mga/mga_state.c:945:22: warning: variable ‘buf_priv’ set but not used [-Wunused-but-set-variable]

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: by <jhartmann@precisioninsight.com>
Cc: Jeff Hartmann <jhartmann@valinux.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mga/mga_state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/mga/mga_state.c b/drivers/gpu/drm/mga/mga_state.c
index 77a0b006f0669..0dec4062e5a2f 100644
--- a/drivers/gpu/drm/mga/mga_state.c
+++ b/drivers/gpu/drm/mga/mga_state.c
@@ -942,7 +942,6 @@ static int mga_dma_iload(struct drm_device *dev, void *data, struct drm_file *fi
 	struct drm_device_dma *dma = dev->dma;
 	drm_mga_private_t *dev_priv = dev->dev_private;
 	struct drm_buf *buf;
-	drm_mga_buf_priv_t *buf_priv;
 	drm_mga_iload_t *iload = data;
 	DRM_DEBUG("\n");
 
@@ -959,7 +958,6 @@ static int mga_dma_iload(struct drm_device *dev, void *data, struct drm_file *fi
 		return -EINVAL;
 
 	buf = dma->buflist[iload->idx];
-	buf_priv = buf->dev_private;
 
 	if (mga_verify_iload(dev_priv, iload->dstorg, iload->length)) {
 		mga_freelist_put(dev, buf);
-- 
2.25.1

