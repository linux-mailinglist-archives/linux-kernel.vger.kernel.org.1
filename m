Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536ED2F83D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbhAOSPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbhAOSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113AC061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d26so10188181wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Clem9oGlYEGrbDU0lDjY42b02EcBqg1/k29GPavGgpg=;
        b=w7kJiKffb+UC6FN4MbUl3hcif4Ao5PrzLRGEJBPBjkUCSG9AJgdTwQm0TtB3bhU4eC
         2E5zcBTxMAM9x7bVsuwBM4gxxzPdYkRkC9mJ7Yyl0LUZpwSFrevFqHUQ11rXy7O1CcjA
         huRymOZyg36Fs7ojzhz66e0zhryoc5NCBAj+WSUBIsDLS4H2oemqmnZC3w+C/RYBvLdV
         SYf6iz35K1ReS5FwE6GOuzYP0ISGJsazo9iwFUl/U0MJn9GPMmHZaK8HrTQbRNTbvaG1
         do7wy1cbFdwiVT2Zns7YE2MWRne9n7I9qENsTVzKjBYzZL++G+XG6qXkQ6oykegTYwjj
         eQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Clem9oGlYEGrbDU0lDjY42b02EcBqg1/k29GPavGgpg=;
        b=kssPw4DsNwGlwj/5EDDxQGwsVgcl18pHh9aURTxN0NSr4zvmM73QdT+g1es0jjm6NW
         OhSkdUjlPMEQmEwA1P1CRyLUFC5uK+RdJawHn5iMzxDDHaEqYHTrtsLepPMdkOT55KEX
         KwQS4w0A7WeJNmKCqt9c026TFgNb7gGRuP/S8NJJsotm3AuPvSxVAUViRAiKXZBlonTR
         4jVc/L3/HD9jY5RcMulxoLSWUPAsD3mixBEETBy2Ulcg4Hp6nFXqxRAxxvT3hSyAxcPY
         Z9Jyn+dq6PDysoopXSUNwBa7dYv9oU/bO4hBn1MRbzYzukVrmqBcpndouAJDyFXyGydl
         gVjQ==
X-Gm-Message-State: AOAM533SaZeWxD8cyNXaCUPY4DfPa2rXI9jPJpMMv4HvuE6nbMITDdh7
        bIex+qBj7M2YFUjDfMky3mf2fw==
X-Google-Smtp-Source: ABdhPJyv/fDErsavQlK/fWf8PXQiUArsAlsCjCiC/JaSrC/YrLefouSMJ01A21nPnYQKjJDUWtgXCg==
X-Received: by 2002:adf:d187:: with SMTP id v7mr73152wrc.50.1610734438759;
        Fri, 15 Jan 2021 10:13:58 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 27/40] drm/vmwgfx/vmwgfx_bo: Remove superfluous param description and supply another
Date:   Fri, 15 Jan 2021 18:13:00 +0000
Message-Id: <20210115181313.3431493-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:142: warning: Excess function parameter 'pin' description in 'vmw_bo_pin_in_vram_or_gmr'
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:647: warning: Function parameter or member 'p_base' not described in 'vmw_user_bo_alloc'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 63dbc44eebe0b..ab0844b47d4d7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -131,7 +131,6 @@ int vmw_bo_pin_in_placement(struct vmw_private *dev_priv,
  *
  * @dev_priv:  Driver private.
  * @buf:  DMA buffer to move.
- * @pin:  Pin buffer if true.
  * @interruptible:  Use interruptible wait.
  * Return: Zero on success, Negative error code on failure. In particular
  * -ERESTARTSYS if interrupted by a signal
@@ -635,6 +634,7 @@ static void vmw_user_bo_ref_obj_release(struct ttm_base_object *base,
  * @handle: Pointer to where the handle value should be assigned.
  * @p_vbo: Pointer to where the refcounted struct vmw_buffer_object pointer
  * should be assigned.
+ * @p_base: The TTM base object pointer about to be allocated.
  * Return: Zero on success, negative error code on error.
  */
 int vmw_user_bo_alloc(struct vmw_private *dev_priv,
-- 
2.25.1

