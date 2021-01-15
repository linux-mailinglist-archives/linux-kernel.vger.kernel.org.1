Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD742F83C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbhAOSPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbhAOSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4072FC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so6541970wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Sf7UxFKe3Y/0LIWjexcpC2JdFLtpHY5KwvFx7/VFjA=;
        b=w9NoGSZ/l11wfSZSeAI4t499CVHwCdmjQnsIudKi0BoQ1Qmcl/PevP5g/9yIqF1VZI
         zNb7qldTqI8Z8+nqxO3I0vxh6xYD4hsB/C1KIT71zz1hTeHDc3e1oztvaUrGon+1UwRd
         wPbyfic0PGsGSerU7GReFRPZW0JhETAtUZYpzyB/nM76gZBnlCXcJH4OZsu6Pslu+mha
         gjkrHspJ9en30gn8UHW92S0gUfchzdIRqmXAMzN+iJqizZAEc9UftalWpWiYmcZE6+/l
         23zmbg3+KPPZKhAiwhCoWV1v56PowvyZ96BIZLbFruHIadxswgoFKCDU85BHETPzOlmB
         6LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Sf7UxFKe3Y/0LIWjexcpC2JdFLtpHY5KwvFx7/VFjA=;
        b=UXtP5hf9Db5fOgSa2bgjqs5WJ5kaC3SJfz5T9Y+SVBXHqXjafW5qMVAjYq2Hf050ht
         OW/+3g+POECZKruoOGv7VciUV3nxn6sk7JZBVZ7apndvwuky6hJPDqywiybp2vxpy6sr
         Z+b/fE/mAEZCwSXSMWtaYJmngchm+uvcWpZPPK76h4XIS4iRJn7bneC4oyxwOxV4oBT7
         eQBowdoRqxiXJyS7YWzWq95sOV3toixM4U9aBHNKANRRxtCqvwLchPjFwOQF4rj81cn9
         Nw6/U/enoR8u2CdkSaZ09JBnsaInJZmDQTEKG60wOgz+pFsPFh4n2sZ5aN1SEQMwqfMv
         S/Xg==
X-Gm-Message-State: AOAM530EpQvua1z9BRrlcX/vgOW2uiTwfCos28+JRApVMencTtKRbbII
        eYdFMVT5Ek2xxfim+qLxxDB9QnD9OFBoyY7Q
X-Google-Smtp-Source: ABdhPJz6d+j7wki717P/WkT8b7Lqmx9P4yQ4dPmJKhA70mj3ZUr77wv0gL0gUdiALFkMDnci8VO2oA==
X-Received: by 2002:adf:b1db:: with SMTP id r27mr4599002wra.125.1610734423051;
        Fri, 15 Jan 2021 10:13:43 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/40] drm/gma500/intel_i2c: Remove superflouous parameter description and rename another
Date:   Fri, 15 Jan 2021 18:12:50 +0000
Message-Id: <20210115181313.3431493-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/intel_i2c.c:108: warning: Excess function parameter 'output' description in 'psb_intel_i2c_create'
 drivers/gpu/drm/gma500/intel_i2c.c:153: warning: Function parameter or member 'chan' not described in 'psb_intel_i2c_destroy'
 drivers/gpu/drm/gma500/intel_i2c.c:153: warning: Excess function parameter 'output' description in 'psb_intel_i2c_destroy'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/intel_i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/intel_i2c.c b/drivers/gpu/drm/gma500/intel_i2c.c
index cb92f24e6f1c5..5e1b4d70c3171 100644
--- a/drivers/gpu/drm/gma500/intel_i2c.c
+++ b/drivers/gpu/drm/gma500/intel_i2c.c
@@ -85,7 +85,6 @@ static void set_data(void *data, int state_high)
 /**
  * psb_intel_i2c_create - instantiate an Intel i2c bus using the specified GPIO reg
  * @dev: DRM device
- * @output: driver specific output device
  * @reg: GPIO reg to use
  * @name: name for this bus
  *
@@ -145,7 +144,7 @@ struct psb_intel_i2c_chan *psb_intel_i2c_create(struct drm_device *dev,
 
 /**
  * psb_intel_i2c_destroy - unregister and free i2c bus resources
- * @output: channel to free
+ * @chan: channel to free
  *
  * Unregister the adapter from the i2c layer, then free the structure.
  */
-- 
2.25.1

