Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41522B4E59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbgKPRos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733294AbgKPRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:23 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C405FC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so19670787wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wySX8cNvv9NUCsmEXsR0JBc7XJM0MHUH49ItqBshbVE=;
        b=hy+U4SAx16PrqlnuxVW5U1xQBAKZb2kMB+JBT6jHCWWzrxWoYMTf/gpOSUnZWvRMBJ
         AV+gpm5PS/9qVYSDg82yYZi5O9uwFTk2UVpOOUA9Q4MvdxOld2ijiYRGuvNm5GalEDxs
         H1hQ4gnyxx6Zs2PHS9F7KXqSpGHsvqpezLeVqbrX7w7HPqWJrC6g6I8U9OhtKkHHHTNk
         cOjr9HODR3ivsTKLy9slgduBPEMGw2/z1aGzX4m9gECM8l81Ti37Trf+2hA7dZT2Qof5
         NdJl4WjDbuuwMbqraBU2i1ZcGYRv6BvOUBLindgX0mkRR8iLqZ6+d2hsFvh9ewzYucNv
         wZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wySX8cNvv9NUCsmEXsR0JBc7XJM0MHUH49ItqBshbVE=;
        b=F6fXgITHm0IMvbS5ow5YUwsTlSsTuq0BDEwg36E5Ns+Ld9DdFBip5b8u7tig9V3vGN
         t4WyQu6nIR54i1NUJbKtgBwVH/xBC0ee7aNaZUb+Cld9AZz13jooz4A233jOKRcEbW/3
         hjqKwQICEgyMLvPwkw+qRuMYgYAPinMs6I428bHIHdVqVYN/WFRvXchfCOqsvDpkQ0di
         r6Jnzuyg4fR8SduLTABq/gEtLfvDYnr0BDK06DWeKIDD30YZy2SPIc9xQjdZRKffygt+
         qs3EP/hv7HSh1+Ef27Yh9xITx3kmUsI7lvLzkNov4ZiIwXnamafjxY9OTuq9GIDvzyDC
         9G8w==
X-Gm-Message-State: AOAM532HDiJcHeCv4HEsZ7Om+JHQQXSDIoriIgjrNjNXOzzd+SvwMvcx
        Dj4mrrjUvvQ70ZXHhdpx9Z5q1x6g92/RbuDU
X-Google-Smtp-Source: ABdhPJz2NVpodSO80ODErNsO8Nnc8xpQNlSxjZjIgamuTY2aDdtYen+IQPe6zyftuY2DtfotFd1Ybw==
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr19723606wrn.146.1605548481587;
        Mon, 16 Nov 2020 09:41:21 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/42] drm/armada/armada_overlay: Staticify local function 'armada_overlay_duplicate_state'
Date:   Mon, 16 Nov 2020 17:40:32 +0000
Message-Id: <20201116174112.1833368-3-lee.jones@linaro.org>
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

 drivers/gpu/drm/armada/armada_overlay.c:329:1: warning: no previous prototype for ‘armada_overlay_duplicate_state’ [-Wmissing-prototypes]

Cc: Russell King <linux@armlinux.org.uk>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/armada/armada_overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index 30e01101f59ed..6346b890279a0 100644
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -325,7 +325,7 @@ static void armada_overlay_reset(struct drm_plane *plane)
 	}
 }
 
-struct drm_plane_state *
+static struct drm_plane_state *
 armada_overlay_duplicate_state(struct drm_plane *plane)
 {
 	struct armada_overlay_state *state;
-- 
2.25.1

