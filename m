Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA582F838F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbhAOSOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbhAOSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD04CC0617A0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v15so6541463wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ja/1FFTGOv6AaggbEFEZcUW2YjyBuvrOQaBJpOOoCfs=;
        b=ghF0kG8rNEQVOXAUreNjXGcJ48KjNg9l5Ypq/mQHTLuOAZzim1Tgi51UYfBff6o/5k
         SqJZsUxrQ2OQ2MC4A/in2xeKuyglvlerxtbegG8LeZMZWP5cxJRHQK0X354kmcGB6Ran
         s9B8lpGNLa3wdOJvkz7ETmHhR9fgPWpeJ6rsQF3l8L7MsEelRNXwQqZqKso6zKDgNR8C
         e6DcT9hKAhYY+8mR7q/15hXGU0+6zlJjE1MoYm4ZEF8FQkcJxX1KOEhVNUBsIhSjt7kf
         cN1gw5k2GbmPbroZiq6Hv+zvbSvAQBcsJ4nrPDlKUVifSUUV8B8dCoQokTHyAQm3r3wt
         Qzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ja/1FFTGOv6AaggbEFEZcUW2YjyBuvrOQaBJpOOoCfs=;
        b=gw2REoiNLRSii3xF8ixzOIBDts3utfvnM9g2hhSABfUsO0DUc4LUoFc2j5OHDp6FYB
         zVt3Hm7JoXEdnnksacoAzrUKnnLsD5dlaMLeelEBaM6gY4hYC/fuYyf7y1eczwp0y8Sn
         jAZFi1NV+sp8j52gbH9FuiYPz7d1MuCT81hLCCuVi9n1lbQ0LvlWop7nbY7MIlIE0Pxg
         SSmBfwmeukRW/QhhDh8aeqneKuG/ooPwlvfMheWAueYlU45PL74s4MFptMpj9JME/EXQ
         QBt1FXO9i+pfLJJv2rXVvWCOBPP3J2eYy9hMN14BnQheVa3V05HGF/SbAsqKjPWc8kY1
         1pYA==
X-Gm-Message-State: AOAM530La7K/jqf7Yoy3cbPqfBxW5XzgHOW+lxxv0yHjbC8knStrMQBs
        xnAFiUlb+OHcThwsCv1bJbkUb8NHsW8bZYvL
X-Google-Smtp-Source: ABdhPJxs93jdlE+R+l0+00KbInYFz0hyGWh21RRCg+gQ2ikl2wjRWfhBWoZr6RR9J0t/xrD1VNYXrg==
X-Received: by 2002:adf:ab5b:: with SMTP id r27mr14285129wrc.282.1610734411548;
        Fri, 15 Jan 2021 10:13:31 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/40] drm/vmwgfx/vmwgfx_ttm_buffer: Supply some missing parameter descriptions
Date:   Fri, 15 Jan 2021 18:12:44 +0000
Message-Id: <20210115181313.3431493-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:275: warning: Function parameter or member 'p_offset' not described in 'vmw_piter_start'
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:676: warning: Function parameter or member 'evict' not described in 'vmw_move_notify'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index dbb068830d800..6a44567e4ba52 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -265,6 +265,7 @@ static dma_addr_t __vmw_piter_sg_addr(struct vmw_piter *viter)
  *
  * @viter: Pointer to the iterator to initialize
  * @vsgt: Pointer to a struct vmw_sg_table to initialize from
+ * @p_offset: Pointer offset used to update current array position
  *
  * Note that we're following the convention of __sg_page_iter_start, so that
  * the iterator doesn't point to a valid page after initialization; it has
@@ -664,6 +665,7 @@ static int vmw_ttm_io_mem_reserve(struct ttm_bo_device *bdev, struct ttm_resourc
  * vmw_move_notify - TTM move_notify_callback
  *
  * @bo: The TTM buffer object about to move.
+ * @evict: Unused
  * @mem: The struct ttm_resource indicating to what memory
  *       region the move is taking place.
  *
-- 
2.25.1

