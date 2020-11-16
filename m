Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181EB2B4E55
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbgKPRof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387710AbgKPRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:39 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C03C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:37 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id m125so38566wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/knA7px3ItuZjnu7kmhshhnJxUB7qJyEjkrpKqZtiA=;
        b=k6Jv+7mHwhLKPJA/QCG06ugtxDKWpQTKy+20nzwFKSS58MARf4S8W8ACDDJb9At+kN
         Zj7BRm0cL5pJuZG03JgKNEOyxkFzKQDZEoeq6JKwur3GNW3waj1+cD/cATWqphXb/N3E
         Hwel7NdYgPQ30GBKTzLyGySsqlcZlYoScXIJf5HNpiV7Q9NiuYvKyh5I1UrBg1kr6UbV
         iCLuVTvJ0zQs9VHfs2J9H/qqPEg7slFJP5MGKs7bVItDI9ChEjoM5eM4spQGw5YLHt1S
         zBTagqyBF4NDMKbJ0sdlBYLtRa1aopP+KNyfSJbABRD/2iFY3eTiXtqFZBU8xFpxWZ8o
         d/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/knA7px3ItuZjnu7kmhshhnJxUB7qJyEjkrpKqZtiA=;
        b=Vn94jRS3dzcYH7DvNL8Q3ctA9u3R9k/UPsLNMT3KOlertR2ERJzMyDUfUDEaD6xVIT
         tKuGPhyz8KgauZF/LSk0RRr/Zc+AGEkuCyB3D6+yxpnWSDyOYF11PwoVKjFNk2xG5fQ/
         0dCMRLuR2tk1Exjr1O/W/NkUq6RL1+arvxID/+svz6jKsyj+orCrIkIjgJzSZD+xFQin
         XrT2xIJ0aAK1NC7gELv0kp9bfQqyoQRvkbTlU1gBY4dWEBU/Q6MYAMqvmYznIforkziA
         TPLD64JvwsUI+6eGkCkiLeXsvONqRAeo0aU9jxKlAVLXPnMEj/XAq6l6sSPsqfcqbFIn
         aouQ==
X-Gm-Message-State: AOAM530HA2ZvO6cfWXhpQ11mXF1eiIx6EvAn96i+yr6iIoLuCR062CBy
        GqnKuVqVp2uXqsjkX5+n9JJkzQ==
X-Google-Smtp-Source: ABdhPJzqHnsBJooc4S8laQMeNPmpnnuKV6rHd3UhDvssbsZxsM79tG8D8ZiF2nH5S1+VMw/gXxelZg==
X-Received: by 2002:a1c:5f83:: with SMTP id t125mr30364wmb.82.1605548495973;
        Mon, 16 Nov 2020 09:41:35 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:35 -0800 (PST)
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
Subject: [PATCH 12/42] drm/mediatek/mtk_drm_drv: Staticise local function invoked by reference
Date:   Mon, 16 Nov 2020 17:40:42 +0000
Message-Id: <20201116174112.1833368-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

