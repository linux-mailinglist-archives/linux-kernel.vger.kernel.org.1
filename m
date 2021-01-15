Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917692F83D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbhAOSQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbhAOSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE5C061796
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a12so10180031wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAHTpQV67+yi8IQrXKtmnaLMIm66ZFnUBK29ghZYvfc=;
        b=Nhj14BJzABYIFqNisKEiHe7Xysxmd1ToE7+1Z1jwpfJT2WG2FjxKeE1v5ohYi1M+u2
         PwptNNWwEs2UT1csoXAAnC8d+x+92BeB9CpbKasePwnJu7qcmvY6/3Dwp0fPi7p0C2/m
         0wfu9hHvHgb3mY7ErQ5OX3aBEj80z8N0W1o5wrVgIbIhWRIF2UARd+crx/VxL2myuKKV
         CaeJK6h4Wb0OScZBmCHbxBE5exHnFWRlXf+KIt/E+T3lOB9y+7mof02reoPT6TAMmOfM
         cmcD3b2dpRs5adKgFBRo3x4OfAnRy5275lq9GH6pLyego75IXwUDd0X5LOJ70l6D8X0N
         gI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAHTpQV67+yi8IQrXKtmnaLMIm66ZFnUBK29ghZYvfc=;
        b=BwE7w1Z9m5vqMiGxdZzobD2yNj1PuQrbodre0eMlPo7HlZGSn6vD0uYf96zFQj4d0E
         H1E8q1gDYzjHy2yjbd0Hwyk2VyxdhTaraAmQNo8mmxeUTGy6XjBdgP4LkrhDs0hZlZvc
         7retEGe7TEkeoR7D0QZS0LLvGXP1T1WEchAKLQMCaN306pO18PDczqFoJHhW9tFfGWot
         Wfy1yUHuw928ZamZv3CHD3mrNrTS6v2OMOKwuULJRwEY66EzBAYTfJ/WWJv6+/zABIh1
         QFT3zEcZ9Ixxg16Mu5l3S3kymSEwOmSgyharo7JRRZVP23R6JHyZEauZvEt/5QWjyuhd
         uTCA==
X-Gm-Message-State: AOAM530flJmUd8LUwJHFuhh6Bu2Xcha6uL4vuBo0TUuf6PYt6k8/LIyC
        JEIxnfV11LYemPdFatcKocDn9w==
X-Google-Smtp-Source: ABdhPJya07h3DVptEeRHtjRpX4ZhUhiKUWJNJfS7SRBdQy1whh2AMhi6JfbWr5rUIdQF/chrtL/tsg==
X-Received: by 2002:adf:92c2:: with SMTP id 60mr14645619wrn.266.1610734448617;
        Fri, 15 Jan 2021 10:14:08 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 35/40] drm/vmwgfx/vmwgfx_cmdbuf_res: Rename param description and remove another
Date:   Fri, 15 Jan 2021 18:13:08 +0000
Message-Id: <20210115181313.3431493-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also fix a small formatting issue.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:83: warning: Function parameter or member 'res_type' not described in 'vmw_cmdbuf_res_lookup'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:83: warning: Excess function parameter 'resource_type' description in 'vmw_cmdbuf_res_lookup'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:161: warning: Excess function parameter 'man' description in 'vmw_cmdbuf_res_revert'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:330: warning: Cannot understand  *

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 44d858ce4ce7f..92509fbf2fd1d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -69,7 +69,7 @@ struct vmw_cmdbuf_res_manager {
  * vmw_cmdbuf_res_lookup - Look up a command buffer resource
  *
  * @man: Pointer to the command buffer resource manager
- * @resource_type: The resource type, that combined with the user key
+ * @res_type: The resource type, that combined with the user key
  * identifies the resource.
  * @user_key: The user key.
  *
@@ -148,7 +148,6 @@ void vmw_cmdbuf_res_commit(struct list_head *list)
 /**
  * vmw_cmdbuf_res_revert - Revert a list of command buffer resource actions
  *
- * @man: Pointer to the command buffer resource manager
  * @list: Caller's list of command buffer resource action
  *
  * This function reverts a list of command buffer resource
@@ -327,7 +326,6 @@ void vmw_cmdbuf_res_man_destroy(struct vmw_cmdbuf_res_manager *man)
 }
 
 /**
- *
  * vmw_cmdbuf_res_man_size - Return the size of a command buffer managed
  * resource manager
  *
-- 
2.25.1

