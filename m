Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00E42F83D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbhAOSP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388123AbhAOSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE00C0617B1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:54 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so2966928wrz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJ7KZtujQH+M7WYSfXjbrtwaSb8NJHqNOy8ewxmrog0=;
        b=OSCRWS4K/ajKw4Zi62PGwkpsViCnA1HR+jyZqd33c/Gif+UcKSsDy8nuLWTbb3ulgG
         Rj1cIl3zLmJhOQ3MJPneCnt9fDjPHh5TAsfxE+72eyp+SUxRNiB4p2PuxgDlimgbLUfa
         plzZs5+VpWcoElqvf5DLn2vTz/22SVU+wUWqit2ToY3K6EJV9XUQ+ph5uPLgHKMhFqgc
         ABpG/zvcdfEn+mOSiw5xbsC8VcrnmFCCim8bHA8vH58iFKjf2Muercbsjc0M/Ij4NJnJ
         nPbsjeMoJUMrj12Y4ywpbkhGfEDkDECm04cazUNkd7SpfTE/ocAR7f2LFr2Qf1wjiVbl
         EQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJ7KZtujQH+M7WYSfXjbrtwaSb8NJHqNOy8ewxmrog0=;
        b=rH5SYQBV3x3DImBQC933QNcBxa1n+uo5v5TWYEaYv3nA8oy5Js5G2lGd5fXyB1TlbJ
         DZa8HPM7ZNUq7go1sAxfXU8FMqI01tA6EEBX7FincgrCVqEHE8AyGBxuE3DTgwYCgLpB
         pylVNh5e3yMzJnTCwFv5/FuIqol/oKtNLkxSRFNnKUqIG7w1IysDj/2wduZEyul+4k+K
         MNf33RqdRJZWwFAn7RXpcRqUy0lj6ywfr9nnr01hHW4lXXeoRNYma2aZHVvwvTkMHX6a
         dnM30vA8cE38Ia0bUywuo6yMCdyijiL5mR4E/zShSJzavGGwYh/Ggf7tzBVKKDDqbFvd
         nB1g==
X-Gm-Message-State: AOAM533/aAkuT7hue5n2IguBScs187kXnJBwqceHZ8D7IVKPQhh01/bM
        iv+XOf02/ux+1qyOrXSlvYMnEQ==
X-Google-Smtp-Source: ABdhPJwTmbb/YEI7MMSglrxGwfHJHkweU2le7lzyioimqu7GtEcCKqgv4qCRYVcve28UlB7pszj7eA==
X-Received: by 2002:adf:dc84:: with SMTP id r4mr14097827wrj.232.1610734433220;
        Fri, 15 Jan 2021 10:13:53 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 23/40] drm/vmwgfx/vmwgfx_overlay: Demote kernel-doc abuses to standard comment blocks
Date:   Fri, 15 Jan 2021 18:12:56 +0000
Message-Id: <20210115181313.3431493-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:48: warning: cannot understand function prototype: 'struct vmw_overlay '
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:98: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_send_put'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:98: warning: Function parameter or member 'buf' not described in 'vmw_overlay_send_put'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:98: warning: Function parameter or member 'arg' not described in 'vmw_overlay_send_put'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:98: warning: Function parameter or member 'interruptible' not described in 'vmw_overlay_send_put'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:186: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_send_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:186: warning: Function parameter or member 'stream_id' not described in 'vmw_overlay_send_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:186: warning: Function parameter or member 'interruptible' not described in 'vmw_overlay_send_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:228: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_move_buffer'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:228: warning: Function parameter or member 'buf' not described in 'vmw_overlay_move_buffer'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:228: warning: Function parameter or member 'pin' not described in 'vmw_overlay_move_buffer'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:228: warning: Function parameter or member 'inter' not described in 'vmw_overlay_move_buffer'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:253: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:253: warning: Function parameter or member 'stream_id' not described in 'vmw_overlay_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:253: warning: Function parameter or member 'pause' not described in 'vmw_overlay_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:253: warning: Function parameter or member 'interruptible' not described in 'vmw_overlay_stop'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:301: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_update_stream'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:301: warning: Function parameter or member 'buf' not described in 'vmw_overlay_update_stream'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:301: warning: Function parameter or member 'arg' not described in 'vmw_overlay_update_stream'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:301: warning: Function parameter or member 'interruptible' not described in 'vmw_overlay_update_stream'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:364: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_resume_all'
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:398: warning: Function parameter or member 'dev_priv' not described in 'vmw_overlay_pause_all'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index d6d282c13b7f7..ac4a9b7222795 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -42,7 +42,7 @@ struct vmw_stream {
 	struct drm_vmw_control_stream_arg saved;
 };
 
-/**
+/*
  * Overlay control
  */
 struct vmw_overlay {
@@ -85,7 +85,7 @@ static inline void fill_flush(struct vmw_escape_video_flush *cmd,
 	cmd->flush.streamId = stream_id;
 }
 
-/**
+/*
  * Send put command to hw.
  *
  * Returns
@@ -174,7 +174,7 @@ static int vmw_overlay_send_put(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Send stop command to hw.
  *
  * Returns
@@ -216,7 +216,7 @@ static int vmw_overlay_send_stop(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Move a buffer to vram or gmr if @pin is set, else unpin the buffer.
  *
  * With the introduction of screen objects buffers could now be
@@ -235,7 +235,7 @@ static int vmw_overlay_move_buffer(struct vmw_private *dev_priv,
 	return vmw_bo_pin_in_vram_or_gmr(dev_priv, buf, inter);
 }
 
-/**
+/*
  * Stop or pause a stream.
  *
  * If the stream is paused the no evict flag is removed from the buffer
@@ -285,7 +285,7 @@ static int vmw_overlay_stop(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Update a stream and send any put or stop fifo commands needed.
  *
  * The caller must hold the overlay lock.
@@ -353,7 +353,7 @@ static int vmw_overlay_update_stream(struct vmw_private *dev_priv,
 	return 0;
 }
 
-/**
+/*
  * Try to resume all paused streams.
  *
  * Used by the kms code after moving a new scanout buffer to vram.
@@ -387,7 +387,7 @@ int vmw_overlay_resume_all(struct vmw_private *dev_priv)
 	return 0;
 }
 
-/**
+/*
  * Pauses all active streams.
  *
  * Used by the kms code when moving a new scanout buffer to vram.
-- 
2.25.1

