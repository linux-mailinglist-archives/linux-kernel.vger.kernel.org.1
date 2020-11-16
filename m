Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762442B4E15
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgKPRmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387779AbgKPRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:56 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67BBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so19688910wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ly2vy0YXlYaSPJSVrw6dCp9MyYzaUlBE3q9eSYRtTE=;
        b=pPumeK8MjgTP68BQSG7hK5qh97k6m6M3fw6z+lcvLPzvg8BTWkTZHzzkXpU7QxOXHo
         BNjpaSAzOgDBRdrPBcrtCR8DySCYkQDX4/MZVG76DaCUlEmmI49870pkv1EZV4xCG+RW
         xUkjKMIcPpgrpkYhscE9yITsWMpQmuW/CKacZfUBLt/FmxAD6478E6Bi15qz8SGIpYuX
         /HCT/SjC04O9zWBTy/dqDc5YderwRLjQdaOVsRKO4MH6wC7olydW+2wepE2s4TjzZQU4
         2tSuihOsK2IWwV376TXT9CQEMTFzOTWhYx5vOCjVCZcjRFvbRIzFn8H2bFZdysPo46RF
         prWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ly2vy0YXlYaSPJSVrw6dCp9MyYzaUlBE3q9eSYRtTE=;
        b=EH04HMS2bnrr3S/K9fPBjlHqFOV2SRR8FLH9n+AScjEDR/McMS/hYRxjEW0XHMCHnT
         hRBizQiaetUNidIC1VgChHRpjadtwxmd4/BFq2HPFRdWrONEkp5Efl7dhTbRfLTOZ4OQ
         cxWV/xyKM/eW+Uw7cwqTtRSosgu12PKdyZAaF61bpkmtM/7zwyyrtHAjmXLQHrf2ojpy
         rFr8ygYB8rsg8VptTPJ/Icej6AfdZ84nNj8T1IZIi0HxjllvtKlLo22b6aeMZ8FNQOnj
         aX8bE8WLyKh8oXqwskWmLWeDNb/ED+4HAiSVOKqWKe3d4ODsIMO6E46fE6J0BB2dKNKc
         2/Xg==
X-Gm-Message-State: AOAM532BdNBUsBwhOOiPGLmaNxbt+n8ATrk3Sx1O/8Ii6GwZLuKCF1bx
        Aq4PrU+BXgB56wy9v5ZCu/y/lw==
X-Google-Smtp-Source: ABdhPJxfPlHBGHo5OFZg60I7eHKyQ/Wgn1YzLYFclvP3QpESJC/x7/DqF1YwB7WHfVgKpSGF4/ZOmg==
X-Received: by 2002:a5d:410c:: with SMTP id l12mr20517364wrp.173.1605548513635;
        Mon, 16 Nov 2020 09:41:53 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 23/42] drm/pl111/pl111_debugfs: Make local function 'pl111_debugfs_regs()' static
Date:   Mon, 16 Nov 2020 17:40:53 +0000
Message-Id: <20201116174112.1833368-24-lee.jones@linaro.org>
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

 drivers/gpu/drm/pl111/pl111_debugfs.c:33:5: warning: no previous prototype for ‘pl111_debugfs_regs’ [-Wmissing-prototypes]

Cc: Eric Anholt <eric@anholt.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_debugfs.c b/drivers/gpu/drm/pl111/pl111_debugfs.c
index 317f68abf18b0..6744fa16f4644 100644
--- a/drivers/gpu/drm/pl111/pl111_debugfs.c
+++ b/drivers/gpu/drm/pl111/pl111_debugfs.c
@@ -30,7 +30,7 @@ static const struct {
 	REGDEF(CLCD_PL111_LCUR),
 };
 
-int pl111_debugfs_regs(struct seq_file *m, void *unused)
+static int pl111_debugfs_regs(struct seq_file *m, void *unused)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
-- 
2.25.1

