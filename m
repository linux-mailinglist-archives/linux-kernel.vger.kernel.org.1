Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E736B2F83D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbhAOSQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbhAOSQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:16:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6808C061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k10so8219254wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2FyQ5jLhIdHZJD6YWNJEO3BdrWd8ejeRewtSriPKvY=;
        b=oo8H3DQngcMqzuyQv+p0ndzTcx2a6xa46E1LV17pUiKJmFYB/HLEV/rZzoO2TuB5Rf
         WlggPv9nQYUiOsj4KyUx0khpoZNaWM6Dj+FyMlf7zxiRftfs0AXqTWSDDhT/9JdcxuZp
         tCxeL7ReDwA/x1dZXTqfgIrQki9sQW0m3eqOzvSvIZuNEgesuZVukjlYcR+9kFOvW4a7
         BWhUcye5v59wpx3O/6PrS31N3SZPmIH1Ahzoh39Lxz5rFSX3JhzQhqVT5MKc0uETdAsx
         Tl7YjhMnuu+37Hv2pSNoIlTS2lmZoGJiGbYXAjdJfEfIdeThyga1i04Poq2MH3kQIjP6
         Q0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2FyQ5jLhIdHZJD6YWNJEO3BdrWd8ejeRewtSriPKvY=;
        b=NUdY/BhMKmkR39+b9nK/vbwqLunDusuJPhrfsX1DirEUY7oFo7RecieEp6IZFhVnPv
         qjRK02+GMFogzvTwp2ocS+CYma0wbKsFiY2IQoVOq4kXQBw99jKalZo10xap+yp5Rwts
         GJM/ugtjpZ1/jLZx5SiEKD1+P90CSfVAYoFai2bOVg/OwGz9y7CaP5EBTISus2hiXiyS
         BZa/y4/0GORfTr6IuiUvL3occBsqnwUm0DQBrCjZiN43CVJ5WIQZHihuiDv9sCqXJyvN
         s2uuEXiwUSEKItuhdn2LECqxVcVcQCNGISWUFVwuDLreoPtq+havp30wcjbhdmgHxI1P
         iwww==
X-Gm-Message-State: AOAM530v0EYLaIbQAtkVFoproQfKitPEUlaRITB2dplfnJsiMkHXw8AC
        Ir5oOQaIDITNNJYBeyNk7cQW4w==
X-Google-Smtp-Source: ABdhPJwcwyOAr0PXhJz2jEx6tQz9gFzPXrNLH0m28OazHlbt4inlSogSJGqy1K3YHg7BHui7FtTezw==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr5656814wmb.98.1610734567515;
        Fri, 15 Jan 2021 10:16:07 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/29] drm/vmwgfx/vmwgfx_cmdbuf: Fix misnaming of 'headers' should be plural
Date:   Fri, 15 Jan 2021 18:15:33 +0000
Message-Id: <20210115181601.3432599-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:137: warning: Function parameter or member 'headers' not described in 'vmw_cmdbuf_man'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 3158924ffa852..2e23e537cdf52 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -89,7 +89,7 @@ struct vmw_cmdbuf_context {
  * @max_hw_submitted: Max number of in-flight command buffers the device can
  * handle. Immutable.
  * @lock: Spinlock protecting command submission queues.
- * @header: Pool of DMA memory for device command buffer headers.
+ * @headers: Pool of DMA memory for device command buffer headers.
  * Internal protection.
  * @dheaders: Pool of DMA memory for device command buffer headers with trailing
  * space for inline data. Internal protection.
-- 
2.25.1

