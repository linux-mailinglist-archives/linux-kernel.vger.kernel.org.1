Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3E2F83FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbhAOSTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388438AbhAOSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197DC06179C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g10so8398697wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PL3TvnHahiyQuBH3untCsJLaGNo3fbz0WaK+zME/+EY=;
        b=DIyCrhYGYpbXTN/gNG8S4708V0wlTtUJC0rGazGsRTPd8I7Lur/eKogJ36AAd6DXEU
         ewwzCVyEE21qQSsWcf5plqzyE+RsxPNRu/lRYI5mjSCBiukzvIaqxkLovyoMg6KuJHUC
         33oMhCOJJHO6rQCRUTYYA09SwaqrlQt3JDS8zJUgJPnAdDylZQiumxdVQ1wcJbY+ndTU
         eo4zJ0KYDXlQx8LqvG2k1FURlLljqinFUK8lxoxFB9Nbmc1ltw1FbDjfkcoa9uBOLPMg
         qR1EAoERH0wS8BTz96BZVS+1uUmDxe79lN58F9Etiu7y5cEg9Nwvf2EXXQLLT2YMVq2p
         2aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PL3TvnHahiyQuBH3untCsJLaGNo3fbz0WaK+zME/+EY=;
        b=q1NzO+F92LBdYO/LMdNv2/tfRI+53mg3AScGo+lXi4jZRUCbTLriWItea1oS4S2x99
         QA5/WGmJ8lciBxaBsBKVZAiyU0BIZJTcPE1JpY9Xw29fWV15n1UDOUv2+1R9aFrxsHiJ
         S4bSJSRDkZww0kvmyz+QW6Mogup2C0p83izjtkDEE/I8IV2X8+ijtNEKGdJYtuU6bSNq
         F3OP4kOlfF8p+C2I8Q2JBAsk3krdgQNNpUKFvAZ0N/vU5rXyeBF6q1NY/09B1d8cFPp0
         F9JrtuLv2Yzrkc21etxpP+y49oeqA3pSe6Lli6tNa20V2WzqyAZ049NUSgKcGH50T6sL
         YGwA==
X-Gm-Message-State: AOAM532tN8RO4EcM3JKqt4pghWCPEQor1rcOOgPxeDkEdmnyzq6Ozv0W
        DnkipVbmADIWQj8WmRsZYN5KIA==
X-Google-Smtp-Source: ABdhPJxGZsrxVnwaIHrrLxYumnCMb0fqwZs+ZBfd4wceHVmtJ3dsHgOV2CMExFctwoFBRy0gTF+Mfw==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr9751532wme.11.1610734576376;
        Fri, 15 Jan 2021 10:16:16 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/29] drm/vmwgfx/vmwgfx_blit: Add description for 'vmw_bo_cpu_blit's 'diff' param
Date:   Fri, 15 Jan 2021 18:15:39 +0000
Message-Id: <20210115181601.3432599-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:452: warning: Function parameter or member 'diff' not described in 'vmw_bo_cpu_blit'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 9f2779ddcf083..118db24eb756c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -431,6 +431,7 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
  * @src_stride: Source stride in bytes.
  * @w: Width of blit.
  * @h: Height of blit.
+ * @diff: The struct vmw_diff_cpy used to track the modified bounding box.
  * return: Zero on success. Negative error value on failure. Will print out
  * kernel warnings on caller bugs.
  *
-- 
2.25.1

