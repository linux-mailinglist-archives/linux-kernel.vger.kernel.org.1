Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E612EF8EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbhAHUQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbhAHUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:30 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0AC0612A4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c133so8745027wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=In1Q+qm5MHof1cMenavqGuBcxDO1piRqNKsllQjE02s=;
        b=F0x9Z4fMGLhfw4n1u93Uhq62eitL0BqRg63/OQZI2nqJtMtnb9XFw10b/oNSbZ/Cc0
         q31JJtFD6ZTSRwnAx4cJeg4an6vd/rYODFPbszdZtF93dGSF1MRSxMcgIEJOX6vMwZX+
         EqyACqU4CLHmNULkAudqGDWMnThQDuoKmVRbS7LWZW+kxv8MP4xtylC6wA+JIKcVlkdy
         7PKpzIU37QV483rrhKqjjM1TFYouFh0iiXuRKQm4l+0NVaAIecM2G1PIps8vSmApgcFQ
         0NeVx4QXyNmRNjJZyPvJjFrytki1lBlcvL3D6nGE1jt8TKEJRI4f6Ab0SIhiTiu8K+gJ
         iwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=In1Q+qm5MHof1cMenavqGuBcxDO1piRqNKsllQjE02s=;
        b=V7zba/WqNHjZUy9PX5JcVPCOEDqlZtDLvfWriI10Z421PGiNgH6kh0Iff8M+FnY/Ud
         TgTqACm5NGs7Id0uP3MGnPqV/dmjSqkdv42niGTYwDDG773OhotIReCmgcFautg0mLQ8
         0cDpRTNKGgayqDCpvh2FiEHxodlQLiKNttANRGIGHcpYIE1W8Ooeq7zews1Chck9ujum
         UrggC8HJ5LiCI+2ZrPQkYDBz+PVePjwCV3nx15SJdAlCc7SE5hFu5cFIBa/iNQ4x9Ccg
         w/6RZzwDiA5w0bpJrKxu84KeIdLs/Q6ZCZkjbXlBKENVUSoeWveZH3w8l46Q6TJM+Djr
         GW8w==
X-Gm-Message-State: AOAM530gb+CVoo1nde+froGDTatAgkTUzF8WtO3hE8X0kQZgK+3LhkEF
        JyQ0pJUXNe8Qf9o7FyG28qNgFQ==
X-Google-Smtp-Source: ABdhPJwFSK+0YlIspGTWyuvGUJ0/L03PXFBojprO/7tBVgl4tWjcjgXy4YV3r9026QikmhFjfkBElg==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr4479570wmj.52.1610136915105;
        Fri, 08 Jan 2021 12:15:15 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/40] drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Fix legacy function header formatting
Date:   Fri,  8 Jan 2021 20:14:25 +0000
Message-Id: <20210108201457.3078600-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_hwmgr.c:728: warning: Function parameter or member 'hwmgr' not described in 'vega12_init_smc_table'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index dc206fa88c5e5..c0753029a8e2a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -718,12 +718,11 @@ static int vega12_save_default_power_profile(struct pp_hwmgr *hwmgr)
 #endif
 
 /**
-* Initializes the SMC table and uploads it
-*
-* @param    hwmgr  the address of the powerplay hardware manager.
-* @param    pInput  the pointer to input data (PowerState)
-* @return   always 0
-*/
+ * Initializes the SMC table and uploads it
+ *
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * return:  always 0
+ */
 static int vega12_init_smc_table(struct pp_hwmgr *hwmgr)
 {
 	int result;
-- 
2.25.1

