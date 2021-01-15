Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA522F83FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbhAOSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388436AbhAOSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC8C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y187so8414807wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdzYhU96phNVr/cQmxntosfoEfrUPlI8/6w18TG83mk=;
        b=TgDPtz5OvXkvw5Kk9fA2xhsW71qTJ9nYJUgdLHH5EdsH+0RK/3EQ6dpwnKsx95hrKT
         2NFRLoQ2wNRsll1ImY+Eb83/QcJDfxPVKvKy2h7sSp13zL4UOUv9eBJvnJoXM5mLbgCP
         +jYHH/dPinV1RgllXaAYNLMVRpK8iV00cfHsW2kmDYxA2/nb6ljeeZmFMjX0A0/Vl8wz
         Swytj0YA1VCE58u+SRc09oFwc1jtE2W+zl2kQdPZ/I/+6Kb8zuw6NZwmd7H4KQCzVMg6
         SrZxc1Kr0wnWa/zW8WK/VRDyWYgg+Td4hVQawOpdIfsMQ9xu7Rc+D2V7CHcCQbFWd0B1
         ab0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdzYhU96phNVr/cQmxntosfoEfrUPlI8/6w18TG83mk=;
        b=PuKqfUbmUebk6BSiXrY9zr4KxEmkKz6dBNryyvpWqzshEm0qOPZvJN0BwtnAsQqekp
         9gfghXhNWUgGpKmA0dcDN1LMwzt9zlbIMpdGzJ5weJkQ+VFZ70Y3mUAnZQvCIjjlusAQ
         1z2rWWancoU7NZoxXQ94TCtAMc42CHxiM16C/M31pSMiDuOzx8GpAbDWvZDSyJl637fs
         VGK0WTYc5mrDKN8MZJF+qFALfKPG6DIjQOPAD6HRLEvToNRdylr4fl+cYqNCvgHTQAhp
         DpFn19+zN+cbEPsEM6ge34QtveYGn453WVCxzhf5NEC0rg5c9dC9gttKdv829Yj1x6Pt
         1ZWQ==
X-Gm-Message-State: AOAM530YGVWKSk6k5oMI2QzmtNbFniy2866JuizjGwX+tMgYtMGvAD7Q
        Xh1HZCD/LRzdEjCEBl2ungXRKA==
X-Google-Smtp-Source: ABdhPJy21scXSg9Gt64WbnwT54rQj3vczsfR+JtkjO+2ZBJ0m98nx3kMeC4U5h6q1waF82ERzsOFQQ==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr2837058wma.6.1610734577506;
        Fri, 15 Jan 2021 10:16:17 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/29] drm/vmwgfx/vmwgfx_validation: Add some missing struct member/function param descriptions
Date:   Fri, 15 Jan 2021 18:15:40 +0000
Message-Id: <20210115181601.3432599-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:85: warning: Function parameter or member 'dirty' not described in 'vmw_validation_res_node'
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:85: warning: Function parameter or member 'dirty_set' not described in 'vmw_validation_res_node'
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:216: warning: Function parameter or member 'res' not described in 'vmw_validation_find_res_dup'
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:216: warning: Excess function parameter 'vbo' description in 'vmw_validation_find_res_dup'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index f2e2bf6d1421f..e7570f422400d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -48,7 +48,6 @@ struct vmw_validation_bo_node {
 	u32 as_mob : 1;
 	u32 cpu_blit : 1;
 };
-
 /**
  * struct vmw_validation_res_node - Resource validation metadata.
  * @head: List head for the resource validation list.
@@ -64,6 +63,8 @@ struct vmw_validation_bo_node {
  * @first_usage: True iff the resource has been seen only once in the current
  * validation batch.
  * @reserved: Whether the resource is currently reserved by this process.
+ * @dirty_set: Change dirty status of the resource.
+ * @dirty: Dirty information VMW_RES_DIRTY_XX.
  * @private: Optionally additional memory for caller-private data.
  *
  * Bit fields are used since these structures are allocated and freed in
@@ -205,7 +206,7 @@ vmw_validation_find_bo_dup(struct vmw_validation_context *ctx,
  * vmw_validation_find_res_dup - Find a duplicate resource entry in the
  * validation context's lists.
  * @ctx: The validation context to search.
- * @vbo: The buffer object to search for.
+ * @res: Reference counted resource pointer.
  *
  * Return: Pointer to the struct vmw_validation_bo_node referencing the
  * duplicate, or NULL if none found.
-- 
2.25.1

