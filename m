Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E866A26D1EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIQDxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIQDxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:53:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3607C061788
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 20:46:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jw11so526045pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 20:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cgDpaFzCGSid4Alu9HrD69vjL13qDjm+CokA2ioLn6s=;
        b=b1/U1KkeTQqJdg8I7jPhzGyMKLlH7kg7OxLTWMlfV6Yxo2+tDHN5Ns4sv/vliYl47A
         A5fvLdH8ihswHFeu317/DGw21E5OGxmEzNLdjh4IbyFu+0AyCOAzHhBUHj13jie8RvBB
         JLMANZJzBup1kINjerd2pLxgsijMjMqFY6PVcdv6vXRkOruqG1QLoUFMLilb5W39ZqmO
         k0ETLvo11KtOd600Y59J1wGH/ISM6pfL4l6MxjdXM2DgYRlAnuRh3HuWNcmpBsJsve9/
         XUGShIhlxzBNuXowc2I7XuKB5DbO6+HhpyXZPV1nrKBgZB9Es9ZwvyudPbm9OiW1Mie7
         JuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cgDpaFzCGSid4Alu9HrD69vjL13qDjm+CokA2ioLn6s=;
        b=ilQPj0fK7FSl+qXp1n9dlqEqn9FAEl69iBl20cEK7VwwT1QIzeKKcEWzXIzJvG/f47
         52aecoJFo7kkQO0JzilxpxENaKy8e4Sq2LUkzhhNu+t/e/Bzb2o/wAWJyw4rhs+oq44J
         jOC3L7BFfKz1lhTZQISuEttyoqo98gLRSTfYZuchbpptOL/iJJ8UC9Iq+LNyfEttqtXj
         OT1SMl4LR9k89S0rHvFJlI9uu3U26B8LzFhoU26+0XtBlxPGWnNv1SOQkplTBE6iGc1F
         ZHRuAEWeKvv+t/kafMqtIDbfKg5zpqGWOzUXGwW4Wgz2Y7RDUbn6XfnybbzR3ktVQSrK
         lhWQ==
X-Gm-Message-State: AOAM5304+olfwFTAxfnfZOt2+utAiG22YX8ANYraBK3f2A0gFrXLEg+C
        nqCPPECv/OZvZ9t3vEj1gYE=
X-Google-Smtp-Source: ABdhPJz9oepAeRBrxyHiQuBs0Jq+AhrcVd8RmyTw68dx4tLZpFwlR/8bpoU3OeUyX6zD8jKXhoCDaA==
X-Received: by 2002:a17:90a:eb06:: with SMTP id j6mr6662854pjz.46.1600314389278;
        Wed, 16 Sep 2020 20:46:29 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-52-163-24.us-west-1.compute.amazonaws.com. [13.52.163.24])
        by smtp.gmail.com with ESMTPSA id a5sm504042pgk.13.2020.09.16.20.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:46:28 -0700 (PDT)
From:   Xiaoliang Pang <dawning.pang@gmail.com>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        kenneth.feng@amd.com, zhengbin13@huawei.com, pelle@vangils.xyz,
        yttao@amd.com
Cc:     nirmoy.das@amd.com, JinHuiEric.Huang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        dawning.pang@gmail.com
Subject: [PATCH v1] powerplay:hwmgr - modify the return value
Date:   Thu, 17 Sep 2020 11:46:10 +0800
Message-Id: <20200917034610.21703-1-dawning.pang@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modify the return value is -EINVAL

Fixes: f83a9991648bb("drm/amd/powerplay: add Vega10 powerplay support (v5)")
Fixes: 2cac05dee6e30("drm/amd/powerplay: add the hw manager for vega12 (v4)")
Cc: Eric Huang <JinHuiEric.Huang@amd.com>
Cc: Evan Quan <evan.quan@amd.com>
Signed-off-by: Xiaoliang Pang <dawning.pang@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index c378a000c934..7eada3098ffc 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -4659,7 +4659,7 @@ static int vega10_display_configuration_changed_task(struct pp_hwmgr *hwmgr)
 	if ((data->water_marks_bitmap & WaterMarksExist) &&
 			!(data->water_marks_bitmap & WaterMarksLoaded)) {
 		result = smum_smc_table_manager(hwmgr, (uint8_t *)wm_table, WMTABLE, false);
-		PP_ASSERT_WITH_CODE(result, "Failed to update WMTABLE!", return EINVAL);
+		PP_ASSERT_WITH_CODE(result, "Failed to update WMTABLE!", return -EINVAL);
 		data->water_marks_bitmap |= WaterMarksLoaded;
 	}
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index a678a67f1c0d..04da52cea824 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -2390,7 +2390,7 @@ static int vega12_display_configuration_changed_task(struct pp_hwmgr *hwmgr)
 			!(data->water_marks_bitmap & WaterMarksLoaded)) {
 		result = smum_smc_table_manager(hwmgr,
 						(uint8_t *)wm_table, TABLE_WATERMARKS, false);
-		PP_ASSERT_WITH_CODE(result, "Failed to update WMTABLE!", return EINVAL);
+		PP_ASSERT_WITH_CODE(result, "Failed to update WMTABLE!", return -EINVAL);
 		data->water_marks_bitmap |= WaterMarksLoaded;
 	}
 
-- 
2.17.1

