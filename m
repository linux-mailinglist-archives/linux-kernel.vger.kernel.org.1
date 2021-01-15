Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F52F83DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbhAOSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388349AbhAOSRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934CEC061798
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w5so10186979wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JlEOg7Zszo3ldqPVK/e9O2X0GMgkDBvEfp3oSty5OZg=;
        b=ti7uQ0hCTPPxB9beBVtUZ4SzOifYKrXMyvwtnJOZCMb3piPKWkCgRTtMToHUtDW4m3
         4WXWjh1OaQVCg+r/ZvpIYeHfusCUkZUj7brQ8Z6i2KqCDkvkgefT3VSB4cfgBpnT9l7d
         fZTtBeOOXIaCL+tnKJYqVgYdIQvNtf8WdZhYmuDlPcWgAM/BTOSLyk2cNPYPGa7p5IOE
         fqT1nQGdfJIi7q3R1OCk+kzBt61lMtJXPbziIht+qigatuOJfxVVF+URzLNJeHhozO3g
         mocvqhE4OctWN5LLKk+smzy//CbEyENiGJN2PJnimVwPeKAr1Ufu/v7i+akBwSaVbbGI
         8FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JlEOg7Zszo3ldqPVK/e9O2X0GMgkDBvEfp3oSty5OZg=;
        b=i+n3bgkStd+c7icyscCmlL3YtfeJchVV3j6V7cAaQwTrZdHI5T5gA8VutDAZwV5N58
         ly9D9OrX5Vm5dMLfvChiPXS24czBAp/Iqo8yvJugLRaMKE3RvY/8O1gJ32QYhOmzUXK4
         ZUh4niCUpFaNrxZx7STWl5HXc786IvnT9OdRgU+lTZm112pZa3Ml5NMCPlwjoshUJPsx
         wyDn+xhEctAy7sn+D72FyWVbTrNCeRtHIIuG3Q82RqBXRy1zJvsmidIkvwcIHfDs5ajB
         5EezoC4AgRohkWGAvNLynnEJBgTtoin1F+WkLZqZwDprn66B9KWnZFNV4jP4ee/8URDY
         nMSA==
X-Gm-Message-State: AOAM532RmyfYWK9+3rSxO6054RkkHs/jgQQqsj7PrSEcZBJ8Z0MXoSEE
        iKl2gx23ucTWzRaLb0sotqIMxg==
X-Google-Smtp-Source: ABdhPJyn4QddbfxLAegv+OX8NnX4aenp5m0W9RYEo8aeaDslhCWzAZbZOuRU1WhBNg3JBgAGTD1cCQ==
X-Received: by 2002:adf:8285:: with SMTP id 5mr14062860wrc.289.1610734570384;
        Fri, 15 Jan 2021 10:16:10 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/29] drm/vmwgfx/vmwgfx_so: Add description for 'vmw_view's 'rcu' member
Date:   Fri, 15 Jan 2021 18:15:35 +0000
Message-Id: <20210115181601.3432599-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_so.c:73: warning: Function parameter or member 'rcu' not described in 'vmw_view'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
index 7369dd86d3a9c..2877c7b43bd78 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
@@ -42,6 +42,7 @@
 /**
  * struct vmw_view - view metadata
  *
+ * @rcu: RCU callback head
  * @res: The struct vmw_resource we derive from
  * @ctx: Non-refcounted pointer to the context this view belongs to.
  * @srf: Refcounted pointer to the surface pointed to by this view.
-- 
2.25.1

