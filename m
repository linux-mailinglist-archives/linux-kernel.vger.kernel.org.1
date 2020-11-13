Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D642B1C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKMNuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKMNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E838C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so9972691wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsA84tchu/fVBD8BOW0vRm+o6+cq+5iG+jRvtUiphpA=;
        b=ljkhqYySRrWFIwFjkjtJqAOVwEjQpjcXz+P0dCfR06bxVDX+TFbuC9nUsXJd/9wlJl
         Dn174tiIjfzxErd2027y8/GR6KJZsMnqluLTnVaSVT393O7ablFJhKZThhKDvfLsmEO4
         CDkKcSiRsOKOxRicNS8l2wW80We25vptVDk0vs1ahrW9ONB/bAIAmPheEhWa2xIo7oFy
         uZ+2r2cCKWJQNJyiG26Cfe7MJIr6Uc9P2iNZwu80ma2/ckIYZYH7RGmBpLh+rjph00z/
         adlERjv3mnMt4UrG0hHN9Qd1dznr+yVA0DL1oJ6cK1B+ZPBVNwSAGH7Y7GIpWVIhDbsu
         CDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsA84tchu/fVBD8BOW0vRm+o6+cq+5iG+jRvtUiphpA=;
        b=FkrYsDoVme+S/zHFKhR6ZOqdOgVemJoWOeuuroVa4nr9+PLZDjUgM7TR6Rg7ZWz+7v
         xdPNkcqy6pmtevX6kLRZCGvPlwrQwSAsy8u4wmqrXxig0GGB1/1q+jSbjiXvKsqSbahy
         M44zHTVSxRE6ksoP/zxkxLlN+gBfZ9zmle5G5bJiFbV9CDEesKKFU2ydbrqjsaNf15gV
         RRtJ2XZt1JJzxj3GQvVWjnj1X++ZmZpdyZPtMs7pTzqKrWefx6bUcVGu6wKPFGlTV4TQ
         dMHNUOB3XgehmvDzNI8BdcZz9dZg+6OvqiYpOgFwZ+TCbVTF97oCO8N5oDh2k3uySpL5
         9sTw==
X-Gm-Message-State: AOAM533wl+mFnubX5NOBW555/CbhBM9AN5Au1gGSM+nYqgL3IdUfN4Fr
        OB5iU0AuxAabgBk9yBNWGykRHQ==
X-Google-Smtp-Source: ABdhPJw0ubF+ddCYt/IdqzNmhTYlMrII1PRfSKp1xN+rqZtEc0LeJm/oKMgfrtivtLV7J47M+qK2Tw==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr3517443wre.282.1605275400292;
        Fri, 13 Nov 2020 05:50:00 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Qiang Yu <yuq825@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org
Subject: [PATCH 15/40] drm/lima/lima_drv: Demote kernel-doc formatting abuse
Date:   Fri, 13 Nov 2020 13:49:13 +0000
Message-Id: <20201113134938.4004947-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/lima/lima_drv.c:264: warning: cannot understand function prototype: 'const struct drm_driver lima_drm_driver = '

Cc: Qiang Yu <yuq825@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: lima@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/lima/lima_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index d497af91d8505..7b8d7178d09aa 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -255,7 +255,7 @@ static const struct drm_ioctl_desc lima_drm_driver_ioctls[] = {
 
 DEFINE_DRM_GEM_FOPS(lima_drm_driver_fops);
 
-/**
+/*
  * Changelog:
  *
  * - 1.1.0 - add heap buffer support
-- 
2.25.1

