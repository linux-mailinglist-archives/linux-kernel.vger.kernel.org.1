Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560E72C5637
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbgKZNnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390786AbgKZNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE93C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:02 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so2214149wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BcIKnQpZCXBlyLSzrwnOmG7IOwmHB9eXMhCgCsu56Io=;
        b=vvu/UfVh3sr3D9noct/cWTDN1mgiOnOg+oz22TAslEDpt+lPXAvTgH8gcxoZukTdnI
         Vnpm0xYCfE3rdiTsH5sOg/KSKJ3NMoqKZcaC7Be9cl+xfq1X2bU0YqiskJyOIufoynQu
         S4QArlHwAi+5WJOdFiqyKoH0JJt8nVKUprx6hv4CK132R6K80EdI77/nheAVXWsrASQp
         VVgAMybtmsm9QLSwb+amML5CCZvWtdhgEi+LX7LWIJrIiY6/AnsZqNwrtEEoq0B//9wa
         yFJjSe9lKZfAWlELH/KQ1DhxPTr+N2FUupYp84sW4gyLdH3uCnk77FFNdU5rMvEEybA3
         5IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BcIKnQpZCXBlyLSzrwnOmG7IOwmHB9eXMhCgCsu56Io=;
        b=BKNCN4J5D6sdmu8PSGF/DvX81Ml68cHjPHgTqCnDpbJJ4DneNtuVYM32KmuRQCglAr
         hKX7LjBZasdaUHUjaDN7y+FGcAYblNtikhiZd2iHMTYRQs+OL3tlv9vPZPTluC5WQ5GQ
         hOM6E79g7Xjv70vD/CpDvh2fCY0+o6yhr620xV4S2hmGc2Kkp6dX9Z46QMsNjXQAYR2C
         16S2lAXR/TDWuWN+JPeMvwIZKwbwlSCi1UV+zOfWksRMAzIsZLXOWZgv5yschPp7TOlA
         OWy7sUOxVrsQN4AQZTO54O5R6/WKPoShWNdEAwqatPcFqyJ1UYfIsOoISj2EQffqUEOZ
         Q6KA==
X-Gm-Message-State: AOAM533C1LVLSejaScvl7WDmbZecu97hB2ESsQ8J0avz5ei10o+RdDeb
        tWCWo+KgcGORKeq2pupTFPnT5Q==
X-Google-Smtp-Source: ABdhPJwfV1VcB+/Umf4WhhLpnnDC28fKOS4R+SFguNSbBQ9UWdlMDGBsSAqcvfHdLN18AN2SVA0mLw==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr3838073wru.279.1606398181420;
        Thu, 26 Nov 2020 05:43:01 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 10/40] drm/amd/pm/inc/pp_thermal: Mark 'SMU7Thermal{WithDelay}Policy' as __maybe_unused
Date:   Thu, 26 Nov 2020 13:42:10 +0000
Message-Id: <20201126134240.3214176-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are used by some source files which include pp_thermal.h, but not all.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:28:41: warning: ‘SMU7ThermalWithDelayPolicy’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:28:41: warning: ‘SMU7ThermalWithDelayPolicy’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:34:41: warning: ‘SMU7ThermalPolicy’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:34:41: warning: ‘SMU7ThermalPolicy’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:34:41: warning: ‘SMU7ThermalPolicy’ defined but not used [-Wunused-const-variable=]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Evan Quan <evan.quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/inc/pp_thermal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/inc/pp_thermal.h
index 3e30768f9e1cc..f7c41185097e4 100644
--- a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h
+++ b/drivers/gpu/drm/amd/pm/inc/pp_thermal.h
@@ -25,13 +25,13 @@
 
 #include "power_state.h"
 
-static const struct PP_TemperatureRange SMU7ThermalWithDelayPolicy[] =
+static const struct PP_TemperatureRange __maybe_unused SMU7ThermalWithDelayPolicy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
 
-static const struct PP_TemperatureRange SMU7ThermalPolicy[] =
+static const struct PP_TemperatureRange __maybe_unused SMU7ThermalPolicy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
-- 
2.25.1

