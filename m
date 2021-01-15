Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59042F83D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbhAOSQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbhAOSPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155CC061382
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so6543255wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Am4t8b9En1HIfsclMg+25TY7LAvRdlrz1SUTzn1fYz4=;
        b=M77jBSyJi06eqwSb0fQBTfnZ6ireTJ4ExXO9TEhHwoQ0gXWo1v183KS92TUeVaZNun
         YaX4duc8tuj90M1fTQ98u9PMbQ7Bejo7m/hnKIcm49IzS1dh3qyft6nJFFvkFkYBiNry
         1Q/zs3xW7pMSKqv/lq/YTh6y5aZnafrgpq2vVAWsmVe0Q+UNzzL0nacr2TGkrdOlb/eq
         T3pzb174ylDgVUTO5QSkquN67H3RgsAoicWZOaTge4rkS7bE4D0HJRPNMF+NSBzgHaLx
         ZrQpEF7vifXb2dfhbkakdeZikPe+eIitwHnJCTNbbkkaP9BR8tNBrZemhTmDcmOFhh0g
         kzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Am4t8b9En1HIfsclMg+25TY7LAvRdlrz1SUTzn1fYz4=;
        b=RFwhzZ38QL6XYbyH2KZSHDO0251dccgSm31Jk8+5Pm2aywnzV7dFiTI9vRXB7em4U6
         j+j+XxCdf/fltvRP/YE+ocqJXtL8ESuIl/nUEsXPG90DEvQ7dBNbnZZCp3dZHYak5rP8
         VCcdZE0GnKi3RC7UH43LYXOpDIpJKUpwgKk8lH+fBDh2UZpq4H5Bpk+PETt0+Gc9kA2n
         4TwAh6pnZvV79VK2TH9lJ0mGlfbkpx059mLMqTAAMiJfkX0R/iBDYcS2jehyfnuDDoxy
         QVjiEkEv+n34VbJNXm6FcZE+ks/ShDPcHGK2LEjOWYM9sd+NsEsEsn9THym+lb6qvMHA
         beKQ==
X-Gm-Message-State: AOAM532061JfsfT6tw2JpvG8YAzCiFD4SOmPFv8FuS77CRvvi2LjHd3v
        z/m4k1lVOZ97M1d+HOSvItY1vg==
X-Google-Smtp-Source: ABdhPJxzcvRMerU+KtZl29WVJZPfR54Qpi1F+qdlK8hpl724S36xxPcQ89RHjXLf3mqalXSZNoQr5g==
X-Received: by 2002:adf:902a:: with SMTP id h39mr14400546wrh.147.1610734450977;
        Fri, 15 Jan 2021 10:14:10 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 37/40] drm/vmwgfx/vmwgfx_cmdbuf: Fix a bunch of missing or incorrectly formatted/named params
Date:   Fri, 15 Jan 2021 18:13:10 +0000
Message-Id: <20210115181313.3431493-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:58: warning: Function parameter or member 'block_submission' not described in 'vmw_cmdbuf_context'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:109: warning: cannot understand function prototype: 'struct vmw_cmdbuf_man '
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:164: warning: Function parameter or member 'handle' not described in 'vmw_cmdbuf_header'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:257: warning: Function parameter or member 'header' not described in '__vmw_cmdbuf_header_free'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:380: warning: Function parameter or member 'notempty' not described in 'vmw_cmdbuf_ctx_process'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:1168: warning: Function parameter or member 'context' not described in 'vmw_cmdbuf_preempt'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:1193: warning: Function parameter or member 'context' not described in 'vmw_cmdbuf_startstop'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 45fbc41440f1e..3158924ffa852 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -48,6 +48,7 @@
  * @hw_submitted: List of command buffers submitted to hardware.
  * @preempted: List of preempted command buffers.
  * @num_hw_submitted: Number of buffers currently being processed by hardware
+ * @block_submission: Identifies a block command submission.
  */
 struct vmw_cmdbuf_context {
 	struct list_head submitted;
@@ -58,7 +59,7 @@ struct vmw_cmdbuf_context {
 };
 
 /**
- * struct vmw_cmdbuf_man: - Command buffer manager
+ * struct vmw_cmdbuf_man - Command buffer manager
  *
  * @cur_mutex: Mutex protecting the command buffer used for incremental small
  * kernel command submissions, @cur.
@@ -143,7 +144,7 @@ struct vmw_cmdbuf_man {
  * @cb_context: The device command buffer context.
  * @list: List head for attaching to the manager lists.
  * @node: The range manager node.
- * @handle. The DMA address of @cb_header. Handed to the device on command
+ * @handle: The DMA address of @cb_header. Handed to the device on command
  * buffer submission.
  * @cmd: Pointer to the command buffer space of this buffer.
  * @size: Size of the command buffer space of this buffer.
@@ -249,7 +250,7 @@ static void vmw_cmdbuf_header_inline_free(struct vmw_cmdbuf_header *header)
  * __vmw_cmdbuf_header_free - Free a struct vmw_cmdbuf_header  and its
  * associated structures.
  *
- * header: Pointer to the header to free.
+ * @header: Pointer to the header to free.
  *
  * For internal use. Must be called with man::lock held.
  */
@@ -365,10 +366,11 @@ static void vmw_cmdbuf_ctx_submit(struct vmw_cmdbuf_man *man,
 }
 
 /**
- * vmw_cmdbuf_ctx_submit: Process a command buffer context.
+ * vmw_cmdbuf_ctx_process - Process a command buffer context.
  *
  * @man: The command buffer manager.
  * @ctx: The command buffer context.
+ * @notempty: Pass back count of non-empty command submitted lists.
  *
  * Submit command buffers to hardware if possible, and process finished
  * buffers. Typically freeing them, but on preemption or error take
@@ -1161,6 +1163,7 @@ static int vmw_cmdbuf_send_device_command(struct vmw_cmdbuf_man *man,
  * context.
  *
  * @man: The command buffer manager.
+ * @context: Device context to pass command through.
  *
  * Synchronously sends a preempt command.
  */
@@ -1184,6 +1187,7 @@ static int vmw_cmdbuf_preempt(struct vmw_cmdbuf_man *man, u32 context)
  * context.
  *
  * @man: The command buffer manager.
+ * @context: Device context to start/stop.
  * @enable: Whether to enable or disable the context.
  *
  * Synchronously sends a device start / stop context command.
-- 
2.25.1

