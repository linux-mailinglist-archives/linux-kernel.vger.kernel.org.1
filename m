Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6192F0E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbhAKIrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbhAKIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:47:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC44C061786;
        Mon, 11 Jan 2021 00:46:49 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id w1so23446517ejf.11;
        Mon, 11 Jan 2021 00:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YlWsX4vIpjnJ+C3Yar4M2WF0HiBoobe/CVqoUsW6rVo=;
        b=COw2rqB77zW6ZIOfu7OjUku4N7nfgax8oJ9zq1ttqjWKsRXGjatsHvgc6ObraJj3v6
         Z+JDkxvucKWw1riQrOqDrq1qyGO8Jj/73spV6l1EgiO1BB54dNqyeFIAC6EY6GRg1/3X
         77C+7c1DTWy2+5FwfzUB+PCZIv2JhiYxVLrfuTdHhwJ6+c2FNgy0hlzw1fj/Gnf5fiBG
         QJsNi5alVtS8/6D06g0QFg8P/IvtuxBUhy2FqFS8DSAoyctBr44V8MDp6WFcHVabHeo/
         RY1AvfGCBzjfJ9ZYX1f7tnOIWUfN0tpnjepI7koTzaoA7D4zIGVObe6zEydk13m8blH4
         IyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YlWsX4vIpjnJ+C3Yar4M2WF0HiBoobe/CVqoUsW6rVo=;
        b=mOyYx6W7wQz+6L8tPOATDfv6ZA540lONNcasxXKj0fWW7Y1hTn7vA11xRAvawBp+GD
         EZVbZ8vCaqqqdwDh6sO1XETvOf5K7zP/rcp4R9lL3+T5sgwzgtxBJmxf6/5mw048Aa4w
         Qw8OcsQma7ToMHm88bb5Xvkx8XZZgMZ5sG4tLoPWjEl4vaMJMuBCUKoWIFI+bm27k8ep
         5RHDcm9kaWQkcpH3ZKOm5mpZQRy8GUL17TTLEy9bUX/upHRFVBs+z98kkBf3ObUy3g13
         7T6+YoimEcdoDBfMsbRF9E5Auwn2Z7+sg5gMPZnDNpchKZVpjB89RQneuAK3ulNPcPPF
         i4Pw==
X-Gm-Message-State: AOAM532IuJ7if252H7frEomt+hThDuq6N3DhtObiQtv4AfxltKrFjKk3
        VgO+K4igHCMk4aqkIlycq2LhU17KR/aMWw==
X-Google-Smtp-Source: ABdhPJwACYUF7sGeZamayddBFCwllD7sJkbrh/rFulbE6JzAxqy1K0DMg/EsOWVzFKaoobUwwyrblg==
X-Received: by 2002:a17:907:6e9:: with SMTP id yh9mr9959389ejb.131.1610354808059;
        Mon, 11 Jan 2021 00:46:48 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d2f:cf00:597a:a5a4:31de:992e])
        by smtp.gmail.com with ESMTPSA id j7sm6775313ejj.27.2021.01.11.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:46:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nick Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH -next] drm/amd/display: tweak the kerneldoc for active_vblank_irq_count
Date:   Mon, 11 Jan 2021 09:46:40 +0100
Message-Id: <20210111084640.28500-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71338cb4a7c2 ("drm/amd/display: enable idle optimizations for linux
(MALL stutter)") adds active_vblank_irq_count to amdgpu_display_manager
in ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h.

The kerneldoc is incorrectly formatted, and make htmldocs warns:

  ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:
    340: warning: Incorrect use of kernel-doc format:          * @active_vblank_irq_count
    379: warning: Function parameter or member 'active_vblank_irq_count' not described in 'amdgpu_display_manager'

Tweak the kerneldoc for active_vblank_irq_count.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies on amdgpu's -next and next-20210111

Bhawanpreet, Nick, please review and ack.

Alex, Christian, please pick on top of the commit above.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f084e2fc9569..5ee1b766884e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -337,7 +337,7 @@ struct amdgpu_display_manager {
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
 	/**
-	 * @active_vblank_irq_count
+	 * @active_vblank_irq_count:
 	 *
 	 * number of currently active vblank irqs
 	 */
-- 
2.17.1

