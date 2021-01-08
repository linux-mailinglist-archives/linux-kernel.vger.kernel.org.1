Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF06A2EF8F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbhAHUTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbhAHUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C97C0612A6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:18 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c124so8712412wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuCvcfeQ9OZsudnyJmzZpphQ6g8eEGgjPIsQH1HjJMU=;
        b=pne4rAbZBHxNVygLejDzerI+GyLe4DR8+s+f+EwFJCm7dbYva47u/bhXWYGv9Kqj6F
         1J+ii3YummtSTnKiXqsYDG7xCGZYoWur28Mb0N2tyOdgYE2VrSNLkGGAmzWqJoCSd3ue
         qmKQ7WIf3Wrgi4mrILRD/f/wJfLd4v98OBmYeHDwQU11lsNI11wulKXu6Glm56eyWrar
         4xfZbbue2cQ/9bfdessylAChzygEP7o7u3hOubC+oV+D2q3ETllTIihbF/wdvGtJk/21
         entgOPhY820LPhWkMD/4Jme5U33tuCIMo9w4xv5KngXws94s++vfKojaZgcnJdoiCYLe
         tsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuCvcfeQ9OZsudnyJmzZpphQ6g8eEGgjPIsQH1HjJMU=;
        b=l8FJkHhsxTOvJAuA9GQ4lh3rtXv05vw+dQoYLOmW6z9qSwlCMO9UDHJTGF7ZdyzvmC
         YK+9dUKvQpCby2nZMdTCLTwdD9IAu8I6Wofvcucse6FLnuxdurPgMQOe1osT4Djw/whb
         GhKRpOCgm5mh+RSoDUdvP3k6fic9RJ55WX5OY4PZAltRzRYwghZc149xHjvwJ1mxKGkp
         NPcbFANF9nF5wtA00cUy1VfSJwdbQUpnAGqooP+UVbZpiKPtv8abifFC+bnf95Z/wQWF
         Ow/0bknpyDn/4G0O2Y2aX4YUkkdUNSN8NZwggBg0Slu72STylm75CpCIOtA0oGWU5kAZ
         7tlA==
X-Gm-Message-State: AOAM530yTvpf5oDJz8xiI4ZJlAl6tJUxu+d7aQgXpYJDK2XbRa5zl4uc
        vSUOqjQiMDaNMuknNH0xFJpZsQ==
X-Google-Smtp-Source: ABdhPJz9+13rhPDFO4I1ZfvGScIu+pZSDc2MLpxUyYYYlqvYjy3rBTQqDRhdsgr1aIj/W/y508Xzdw==
X-Received: by 2002:a1c:730f:: with SMTP id d15mr4459541wmb.135.1610136917730;
        Fri, 08 Jan 2021 12:15:17 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/40] drm/amd/pm/powerplay/hwmgr/smu7_hwmgr: Fix formatting and spelling issues
Date:   Fri,  8 Jan 2021 20:14:27 +0000
Message-Id: <20210108201457.3078600-11-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:242: warning: Function parameter or member 'hwmgr' not described in 'smu7_enable_smc_voltage_controller'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4508: warning: Function parameter or member 'us_max_fan_rpm' not described in 'smu7_set_max_fan_rpm_output'
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4508: warning: Excess function parameter 'usMaxFanRpm' description in 'smu7_set_max_fan_rpm_output'

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 82676c086ce46..c57dc9ae81f2f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -235,7 +235,7 @@ static int smu7_get_current_pcie_lane_number(struct pp_hwmgr *hwmgr)
 /**
  * smu7_enable_smc_voltage_controller - Enable voltage control
  *
- * @hwmgr  the address of the powerplay hardware manager.
+ * @hwmgr:  the address of the powerplay hardware manager.
  * Return:   always PP_Result_OK
  */
 static int smu7_enable_smc_voltage_controller(struct pp_hwmgr *hwmgr)
@@ -4501,7 +4501,7 @@ static int smu7_display_configuration_changed_task(struct pp_hwmgr *hwmgr)
  * smu7_set_max_fan_rpm_output - Set maximum target operating fan output RPM
  *
  * @hwmgr:  the address of the powerplay hardware manager.
- * @usMaxFanRpm:  max operating fan RPM value.
+ * @us_max_fan_rpm:  max operating fan RPM value.
  * Return:   The response that came from the SMC.
  */
 static int smu7_set_max_fan_rpm_output(struct pp_hwmgr *hwmgr, uint16_t us_max_fan_rpm)
-- 
2.25.1

