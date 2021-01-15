Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6246A2F83D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbhAOSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbhAOSRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24CBC061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c124so8210504wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRnDlHVa12JoDS+1Cu3+Ec4HFRbAYSztolaDSiDve+E=;
        b=e7F9l+/dUV6ABxBCDtb/BidpEhKGM4UyqXYYkGDUNjAhYHxnuY9f3ElU0sjsZtNelV
         x/yJl6ti64qxc2h+OnEbh2MwY8KBYmeJZKU2yuyfvID0Yx8V2d/uBWhGXmYMDnmhmys9
         6UYpMRgXvHThOA49/yJSUvpYCLe0wk3zbUQuvpSPknEt9y/sQjN98kjXlrLp64GlqGpG
         7KMt6pJP/fyQkFaUKSl6k5RN94/I+jEnP4VsteeAk6fpsjH49xwIfPJABsJyaZ4YN4iv
         ZKfmjn/l98cpku1bSU5Kz7MEKHFBEw/hAVSZN1IAA7Fepu0nwoScJdvHIfXlFviqWmG1
         B/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRnDlHVa12JoDS+1Cu3+Ec4HFRbAYSztolaDSiDve+E=;
        b=FqDf2aNtoShzzNz+084Izij23W/Y4oiTerJ42cv+Na9mDqoStP8LoKTCq4iu4pKpJb
         JijeQH1IHe+F/YpdZCByaBHSMBgZp39v4fEGBMgUAi2mC9puXKKC2IU8Hcgn3HbVPryL
         uA6TrDOvfJaFVNVohlr/nTVvRoqh11tA+vIS4lkAXdy0az4+vWq0ONq/a6TX2V2k6w3H
         FjVPf3HNC6AXC9YQN2U81udW4EYBJ+vDUwORJAe7bjMQohMXQYPddmMeNjts1g//Muc7
         LAUdrupx1hloJeIsVF+lVGS2dFFe6A/krHhE3bH+l1QLXgNlXK70E1+U/McuF1hjutj0
         9Kkw==
X-Gm-Message-State: AOAM533DJeyRLStA9kPvtT8b3FAvhCkMlVc5AAhSaI0TCzTLIbQlBgUH
        lp8TUz+RtHVaZ71JoKorgxMXwA==
X-Google-Smtp-Source: ABdhPJwIyOV6NzKrLV231nC6Q0q+ZFXfNYtZgTm4tQRyqu2f2dD4dK1RNYIlr9iv2Ic1kMUN2xmJXQ==
X-Received: by 2002:a1c:4b10:: with SMTP id y16mr10129104wma.73.1610734568698;
        Fri, 15 Jan 2021 10:16:08 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/29] drm/vmwgfx/vmwgfx_cotable: Fix a couple of simple documentation problems
Date:   Fri, 15 Jan 2021 18:15:34 +0000
Message-Id: <20210115181601.3432599-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c:72: warning: Function parameter or member 'unbind_func' not described in 'vmw_cotable_info'
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c:308: warning: Function parameter or member 'val_buf' not described in 'vmw_cotable_unbind'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index ba658fa9cf6c6..42321b9c8129f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -63,6 +63,7 @@ struct vmw_cotable {
  * @min_initial_entries: Min number of initial intries at cotable allocation
  * for this cotable type.
  * @size: Size of each entry.
+ * @unbind_func: Unbind call-back function.
  */
 struct vmw_cotable_info {
 	u32 min_initial_entries;
@@ -297,7 +298,7 @@ int vmw_cotable_scrub(struct vmw_resource *res, bool readback)
  *
  * @res: Pointer to the cotable resource.
  * @readback: Whether to read back cotable data to the backup buffer.
- * val_buf: Pointer to a struct ttm_validate_buffer prepared by the caller
+ * @val_buf: Pointer to a struct ttm_validate_buffer prepared by the caller
  * for convenience / fencing.
  *
  * Unbinds the cotable from the device and fences the backup buffer.
-- 
2.25.1

