Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AB2F8418
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbhAOSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387486AbhAOSOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D6C06179C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m187so1957167wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDWfHFckN6NRo0EoYWwvHoK4Npcgdey+k/hT6ivHjRc=;
        b=SjYJ2xl8Kpk+haoC/WNAe19ka70TzQyHnukPq1XElB5bfIleTUP+UyDJS8Gh4FQj5Z
         Kl2nKN4tGIrvVbBS1KuO9xZxIrei4eyCFBrW4gl5Y0oDQr0EY0no4iJLSEtH6jmo9qo3
         LDjQcjt2A3sPpH5f5PMAgHzA68Hz1sCGX6dL9/S/J+1zUi6h6DsewtD6AiabgNcx7w7D
         7XMzT1titKw7oaDP9ZWGVFoddv0NNblbjqZXv6KKEXg2ZOrsSu1d8j9RLIz5Hon1OCHR
         /4Er5YRgwio31zKplqQDl3c9YYzA2n9JYh1VcNUDjKs5HO2nkEDlcJ+iXzcxXz2RqvFx
         ZAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDWfHFckN6NRo0EoYWwvHoK4Npcgdey+k/hT6ivHjRc=;
        b=RTZZL1KuMk2dsSoDU6qUSJRjhXBby7VJubyBMhW9VUqVYn5C5n2PEzGlNoTbRzXgSP
         4s/aB0z08PZkI8AiVpAquanffbqPeo5ia3gJSdztA4J7RLUp3DnRNtY8bzTm7rVuS4x8
         2bmDEg88b3abPxTKy3ONwECs4WvhShZciGxdEdN15XXXdp8UjmkdZxBI0mlvK1wK+69W
         F8X8U4tSWNJYDeLuYzTAC7rxCag5I5OFFp0Tn4HxXYYMLfXjIv45qCb2ABrGpOkoe7rr
         O4g72/1cnYhTfZHyFqJE8vMXEeXARb1JKLM2Z+OORkYz/N0l1aoEAvZvGHIwdCn41St9
         1Odg==
X-Gm-Message-State: AOAM5327u3ryvEhv/A3uCWSHhK1Fu8NpkAEIs7Zg0PpbAKbR5doNsuH3
        cXQMryuPCtD8Kx+aZkYUjsjd3A==
X-Google-Smtp-Source: ABdhPJzUCTGJPA/AxjzKMvGf7/YaN9xsQPUWPThrY+PvTWZnODZjT1Fb00+0QiDkBK7HxjMNPb4d+A==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr9872346wmj.170.1610734408578;
        Fri, 15 Jan 2021 10:13:28 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/40] drm/vmwgfx/vmwgfx_ioctl: Provide missing '@' sign required by kernel-doc
Date:   Fri, 15 Jan 2021 18:12:42 +0000
Message-Id: <20210115181313.3431493-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c:30:
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c:448: warning: Function parameter or member 'offset' not described in 'vmw_fops_read'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
index 80af8772b8c24..b36032964b2fe 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
@@ -437,7 +437,7 @@ __poll_t vmw_fops_poll(struct file *filp, struct poll_table_struct *wait)
  * @filp: See the linux fops read documentation.
  * @buffer: See the linux fops read documentation.
  * @count: See the linux fops read documentation.
- * offset: See the linux fops read documentation.
+ * @offset: See the linux fops read documentation.
  *
  * Wrapper around the drm_read function that makes sure the device is
  * processing the fifo if drm_read decides to wait.
-- 
2.25.1

