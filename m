Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6DE2F83C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbhAOSPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388024AbhAOSPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11943C061381
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so6748701wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zk69YegOGJqysgGJbDn5xfrwzKa0lDxp7+yp3s1Kj6U=;
        b=dseFE4l/a7Wm6ykCQlC4gaq/QvUbmlCUt5gKH0q+IywCOX3NvEoX4BwK6m03B9VDXs
         1SuhGTsHQqMW0lwqBNgvjdN6LqP7wXL1vty08oacmKr1HNMacqDFja6hyg1EryPPh1Wz
         qxo4jjbHw3Knhoig20reJn2pzkM4e+gTMiKwBwz+tD53xJEA7BIKhGYysAKbmkH7jH+O
         WDtWvkXFDI9vzX74EWQET78aNV2d7JIUsoqMic7S/ma0eYZ/UQJ/vieSlU8W+dk4aI2q
         LPwi5vp8uhWFUS0YL6n0QoHiQBFn1GzjkjfIzCTrXXa8w2WQCfN3EI3TW/ycUM2X8gYj
         NPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zk69YegOGJqysgGJbDn5xfrwzKa0lDxp7+yp3s1Kj6U=;
        b=FXVCprjo03nF1V7FmrqiRYKdMDTSs8kevpqTOnJ6TUZRt99iqxEql241ohU1dLcNPo
         knw49II3llx93lYAnSQqPs8Dm3KragXw1f4ahjzB2P3gSMB24SjoHy/4NH2ujlA4J4R0
         j/5YRNsZvyfdEDIqFE/SBigusCWVZo1jNcnvqthvLd26FCIGxxd/5ryrK3IekRtSrGtE
         RbRU09XSxPYG2I13wJYiH2Gck7NU4NfW9ETDsCSkvgcXs/rGsSRO89OPossnIuM2XxrM
         6TkLwKG1Y9lf8Uv1zLdkFaGp1oZQfsRJzB+EaiCEWWpX38AtdQobq1QdKeZG+U5Ovx8q
         aKHw==
X-Gm-Message-State: AOAM531xtC+3Z8FFPxcfUR6lKVUr+DIaUhTXYXC3TlADRAI65/1tecIh
        jYWY07mIrf4twIw2/Z/EUQpN2A==
X-Google-Smtp-Source: ABdhPJxJn2M/cVUxIKsLXpE4PrVC/2KvRxL71cjUJKAp6k49EoS6r2Bcuo7xn4BEbu5GHJcv4KxSgw==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr14779840wrt.396.1610734449759;
        Fri, 15 Jan 2021 10:14:09 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 36/40] drm/vmwgfx/vmwgfx_shader: Demote kernel-doc abuses and fix-up worthy headers
Date:   Fri, 15 Jan 2021 18:13:09 +0000
Message-Id: <20210115181313.3431493-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:134: warning: Function parameter or member 'res' not described in 'vmw_res_to_shader'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:663: warning: Function parameter or member 'base' not described in 'vmw_user_shader_base_to_res'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:695: warning: Function parameter or member 'p_base' not described in 'vmw_user_shader_base_release'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:965: warning: Function parameter or member 'dev_priv' not described in 'vmw_compat_shader_add'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:965: warning: Function parameter or member 'size' not described in 'vmw_compat_shader_add'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:965: warning: Excess function parameter 'tfile' description in 'vmw_compat_shader_add'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index 905ae50aaa2ae..a0db065640131 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -125,7 +125,7 @@ static const struct vmw_res_func vmw_dx_shader_func = {
 	.commit_notify = vmw_dx_shader_commit_notify,
 };
 
-/**
+/*
  * Shader management:
  */
 
@@ -654,7 +654,7 @@ int vmw_dx_shader_add(struct vmw_cmdbuf_res_manager *man,
 
 
 
-/**
+/*
  * User-space shader management:
  */
 
@@ -686,7 +686,7 @@ static void vmw_shader_free(struct vmw_resource *res)
 			    vmw_shader_size);
 }
 
-/**
+/*
  * This function is called when user space has no more references on the
  * base object. It releases the base-object's reference on the resource object.
  */
@@ -945,13 +945,13 @@ int vmw_shader_remove(struct vmw_cmdbuf_res_manager *man,
  * vmw_compat_shader_add - Create a compat shader and stage it for addition
  * as a command buffer managed resource.
  *
+ * @dev_priv: Pointer to device private structure.
  * @man: Pointer to the compat shader manager identifying the shader namespace.
  * @user_key: The key that is used to identify the shader. The key is
  * unique to the shader type.
  * @bytecode: Pointer to the bytecode of the shader.
  * @shader_type: Shader type.
- * @tfile: Pointer to a struct ttm_object_file that the guest-backed shader is
- * to be created with.
+ * @size: Command size.
  * @list: Caller's list of staged command buffer resource actions.
  *
  */
-- 
2.25.1

