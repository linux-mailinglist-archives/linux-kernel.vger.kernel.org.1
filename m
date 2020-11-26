Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3748C2C5609
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390747AbgKZNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390234AbgKZNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:42:48 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F7EC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:47 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so2192674wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmY41ceyc6chYcpESZmZP3QGDnanFIcluGLqchr029A=;
        b=e1rVMTz6bLbCWASJmqUfDpitRKv9ISCBYaTNCD0SsSAd2EevlEBxrDdSKB+rQAYuFU
         8rr0oxy3WkZj1teuHpAo7OhQRMfaVPWERVifkADPWDCscLCwxlhpbpAl2LORsJ9Ui0rg
         OObbVbb/IohqBdFI9IFOxkjXusCH1fFfn4hLae9Cnj+rpHn0caLy1qwtkD2LImtKrn8v
         6tA0xY4l+ViFaqf7bT6YmrhuJQiz/rwJyTU8lb6/112ic37dwpE9bXfBwZeB9WBS9kIl
         hZIA2MDWZJQC0Hp2Lh0GAUnYFNRGY2M6211dL4sn+pPH9Jk9PvbofcF7LWhBFxx9C5BD
         /UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmY41ceyc6chYcpESZmZP3QGDnanFIcluGLqchr029A=;
        b=p/BR8+KTlq0XqasFWwQEkEZZ/Hu0Kwj91gRKc7UtXPr6g/WZWLQA90BZtX+IYrargl
         IHlF4/6o1s5+mooEjclRQFOGf1zpqi6fL2kShs/FSWwOyiB/SaON86s0G0RQObTV6oDD
         pHKnQqBVU2uXmaddKOhxqCSTdJoz5YkNVQvKdLRX1PnQGdqqLoqUVGeBm5yCdSxHbENJ
         RW9nBQ3yXalFmq3fxSCXd+/VoAb8+upK1B4ry/oDsLvAiPXnV9gnwPWAwViXJaz8NqIy
         lbgNBvHqDHT7+QQn9cWpUJwQQu6qNJvfd7EAZkrgNso43MA48EKzC+X8j2cUuZfNeIcy
         EiqQ==
X-Gm-Message-State: AOAM531J6tskT6P5l32QAu80I0DgR9hr9TiERG7xYvGXIaO3dvmlK7tV
        4iRUIneUzBfI3jMD7O/0hhvZS/YJ9EXTEMTt
X-Google-Smtp-Source: ABdhPJwQFSXC5wh+xxoo2UvAuPfEbz5ABc/LCULY9XBt+X2t0p9Y7pi4DpLwBb/4gHK4J8jJ1Nl8MQ==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr3870152wrp.142.1606398166640;
        Thu, 26 Nov 2020 05:42:46 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:42:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/40] drm/amd/pm/powerplay/smumgr/polaris10_smumgr: Make function called by reference static
Date:   Thu, 26 Nov 2020 13:42:02 +0000
Message-Id: <20201126134240.3214176-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/polaris10_smumgr.c:2145:5: warning: no previous prototype for ‘polaris10_thermal_avfs_enable’ [-Wmissing-prototypes]

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 052bc88cf33c9..45214a364baa9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -2142,7 +2142,7 @@ static int polaris10_program_mem_timing_parameters(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-int polaris10_thermal_avfs_enable(struct pp_hwmgr *hwmgr)
+static int polaris10_thermal_avfs_enable(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 
-- 
2.25.1

