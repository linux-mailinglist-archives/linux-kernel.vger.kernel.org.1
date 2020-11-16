Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70912B4E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbgKPRnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbgKPRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:18 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E518C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:18 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so19676393wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwAPsdpVMxl/zDOaEKrvh3eBbThND3Sgn5s6wfB0Uyk=;
        b=DKTVoYhLDkbUjmiKBiSxqN0EkzBLYyzyrkoqtuN6VulUimxRpI6QLv0OIHxkKaQQgU
         KYLrGD874Ber7KTt6OJaUpi2vEOqawPyVBFY0niR1SkoQpbH0FGG2WodY9fl8grPOC7q
         RqSW3DTkKBPSp1/YLd9RcWADeSJl8AGqcerHF/73w3pZyGN4NPmJ0ha5qJWTublG4eVP
         FvWuTMIgTQVlzi1mJLNQgc+aO/NoIPqjaxzq3VlsC2bSDchoZBkqoBcDmPKQ3X5z4eXv
         XWJrBqmGzKAQIh2YZjXrnie9qVgHj6SkltfZVcvXgBg7Cmg7I8oXBfuMB0NnR4ltofjK
         +9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwAPsdpVMxl/zDOaEKrvh3eBbThND3Sgn5s6wfB0Uyk=;
        b=T8Ljl/D2ydSCudk+6G+eN4j/Zzj+29+idwoFgpmaU+xbWV5ufQbmTLa2d9eDwGjM5W
         DrqeoSheSQBr71ah3LxXJ3m4FEXYU8lj7lEzVY2cQn0z3Nz0xVgSmgNCaqyPCKn7pQnp
         WC7fiN9OQAzzI9BAD2YutIhKCVM7qDi0BBccTYePc+Is07V4H1XKnamOERn1p505WMtC
         IW3golQj7w7IO5ZdIIeL1RGxgVHa4wcGoqsK2rqN6gxZzVYcxiCnH6HBOi0Ioms4gdnz
         ECLZMJv9xzsa0FAufOPrkaWnIyKlq7OsXwAQp5bRPt6x3qKESmnKD/TxmsXuNLhR9TUe
         eEuQ==
X-Gm-Message-State: AOAM532a1Nua1wjHSZyUEFiRSs1WzBqjWcgDOfbNiCFZpILIA38ILYCN
        h8x08A+nXeWtPAoNyffogk/WlQ==
X-Google-Smtp-Source: ABdhPJxBcXflNnhznga0qA/1qGlXLsbwa73sxSXQZeI2NdqkAJACA5ixV1bOC5dXLeCi3pwSiE6mqA==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr19918921wrq.424.1605548536828;
        Mon, 16 Nov 2020 09:42:16 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 40/42] drm/vc4/vc4_debugfs: Demote non-conformant kernel-doc headers
Date:   Mon, 16 Nov 2020 17:41:10 +0000
Message-Id: <20201116174112.1833368-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vc4/vc4_debugfs.c:25: warning: Function parameter or member 'minor' not described in 'vc4_debugfs_init'
 drivers/gpu/drm/vc4/vc4_debugfs.c:62: warning: Function parameter or member 'dev' not described in 'vc4_debugfs_add_file'
 drivers/gpu/drm/vc4/vc4_debugfs.c:62: warning: Function parameter or member 'name' not described in 'vc4_debugfs_add_file'
 drivers/gpu/drm/vc4/vc4_debugfs.c:62: warning: Function parameter or member 'show' not described in 'vc4_debugfs_add_file'
 drivers/gpu/drm/vc4/vc4_debugfs.c:62: warning: Function parameter or member 'data' not described in 'vc4_debugfs_add_file'

Cc: Eric Anholt <eric@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index 4fbbf980a299f..6da22af4ee911 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -16,7 +16,7 @@ struct vc4_debugfs_info_entry {
 	struct drm_info_list info;
 };
 
-/**
+/*
  * Called at drm_dev_register() time on each of the minors registered
  * by the DRM device, to attach the debugfs files.
  */
@@ -46,7 +46,7 @@ static int vc4_debugfs_regset32(struct seq_file *m, void *unused)
 	return 0;
 }
 
-/**
+/*
  * Registers a debugfs file with a callback function for a vc4 component.
  *
  * This is like drm_debugfs_create_files(), but that can only be
-- 
2.25.1

