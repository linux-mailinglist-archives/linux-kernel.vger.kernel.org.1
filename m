Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9D2C3135
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgKXTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKXToZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:25 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E49EC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:24 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id g14so8354795wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mq7PbL6cgpxSOWqLpcSVIbGFAt/shGYJ2nDJJPb1ufM=;
        b=QAjDd7pmP9wSTKQGaUOswEXbxCamu68E+cgIDCWwIrdnY0TW1G88r+c9TTWlZxqPLu
         7zv57v0Szlbn1mpzLQt4tsC/2toJ6vwn/sSzjRXrD1qEbZT4/Wly/JbfeTn2S8Onw8mm
         wafWqtAt1WOMYWSwYeYnbnER09/6WLcU+HY/BruiZW5oXEq2u3SnvrTMAnvvloBCMAsO
         F1ZeEw24FGMFgL6LV8uNQyeg0Wj7lCIE9w3Il2U5NuAW84yje7bLFC8vlLIyg7NF63gh
         OnBw2tMVefWwP6rI4Cgnvl15GE79M3rLSQtm3G41mlKKofO+MUlFxyrET/gENNtjmohn
         7adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mq7PbL6cgpxSOWqLpcSVIbGFAt/shGYJ2nDJJPb1ufM=;
        b=VqJFiQZW59+c7+KApIQ6d/8dRQV47YOlmqq79tziPIsrgVO64okhvDhzzQJln6Op7A
         D9cD5rqR7RXfFElnStoB6zOPWCof3ZhkSP9YoPqcje4hP1rETlrtSS4RfSN4Q0ktmM4l
         tksdtiNnIwPvzrBscXhRBAMr+zhncXWuVqBE/B9hqDjXIt1xxRD3uAQ3PpeX0ydzisQ6
         Zbfx90D5vcfoOvj5GaB7nhjKsaJr2B9wDgRpwxHy3hvN39sURCkbHXyGL9ezo5A5nAh/
         kzZGCWSCdUi8PH1+c43ypVgj/DQVnbml0h6ODd4M7IPq9vbd61Q7wMWUJyks7/YEtAwQ
         bPtw==
X-Gm-Message-State: AOAM531JxEko8IdgKMpY69HTCWI2QPkE+VVA28+kPbP11mXNArOFr4ye
        bsgEwU8LUhpUsBmVJycLlVGQrw==
X-Google-Smtp-Source: ABdhPJw+kv1MDrGjFiOkLD0UZAOdz/00Mi3zE68PVR52zrFv9heQrl/sQOeaGCT/uADkZl+if9+Srw==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr77440wru.45.1606247062896;
        Tue, 24 Nov 2020 11:44:22 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 19/40] drm/amd/amdgpu/sdma_v3_0: Fix incorrect param doc-rot issue
Date:   Tue, 24 Nov 2020 19:38:03 +0000
Message-Id: <20201124193824.1118741-20-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1651: warning: Function parameter or member 'ib' not described in 'sdma_v3_0_emit_copy_buffer'
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c:1651: warning: Excess function parameter 'ring' description in 'sdma_v3_0_emit_copy_buffer'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 43410a7bccc25..8ca7fba9c035f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1633,7 +1633,7 @@ static void sdma_v3_0_set_irq_funcs(struct amdgpu_device *adev)
 /**
  * sdma_v3_0_emit_copy_buffer - copy buffer using the sDMA engine
  *
- * @ring: amdgpu_ring structure holding ring information
+ * @ib: indirect buffer to copy to
  * @src_offset: src GPU address
  * @dst_offset: dst GPU address
  * @byte_count: number of bytes to xfer
-- 
2.25.1

