Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0F2EF8CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbhAHUQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbhAHUQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C997C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m5so10133069wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EprdkygQQeeC3xFfzaC8MU1I4kxvwWaMs/mQ4lWUqWY=;
        b=QgbTBp7NIQ6cMjQpN9ajxDDhoxzEh3uB8E0xPXcX72UNdYf3NJAQMX2HmAolEzEQCl
         APJ9C/UfuCn5kvTUIkCcN3eOgy3d0WNKC4zdca3c0tNvyoDo5vpp31Bviol4UInGfPWM
         sIACr/f+bwjh+pKNVXolQnElxLlEcLNhIKmYhXOvo+Rgp6qz6rF6zXuIievOaQUMY8oD
         Ot7ptexOlSpzw+tA4Gvu9OKRvIz+CxeRf8y9hkBWePe9ACdGkaiKJmuI7oC5/CzVt/c/
         iqSdtGROS+v1QFwtpLBeBnUYJ2/Nydb+q208F74w1qbwtz0/kiZqxOvkI+To3yVcw6nM
         ewXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EprdkygQQeeC3xFfzaC8MU1I4kxvwWaMs/mQ4lWUqWY=;
        b=MjDTzZCIQDh+1e9+qrRaV0XV8ltlnx33nC76jdGvdwo0TQiQuV61ModxhNZeZDOxTv
         ahpfSvqyQ7f125jbHtuN/Z5eKzmenEuVujEMZ7vh7MIIbpYOp1IbcbgiZOn6BF4AUPDr
         W7UwxGn6W9B2UWFfiSfCQAYT+oViS6iFwxPryKhUMHdKWhxlnYfPMwWJxAXD+PjVslus
         RXHYPrVUV1GN0J0+he8oujS3ho/lrfX0DxQssmOEz3EP0lRzXwTDLZ3mYZZXR7CYONhu
         dczlWHtj3aA83P2F/FkUvsmsH1BPeb+lLN0DSxxuJwm1B+b6B7ReLGrKQb1Bzf2tfoXN
         OTtg==
X-Gm-Message-State: AOAM532GH11cIZtz6qY3gf3MKgEmTGyfLvKm4s0kz+ncWViqVjgCmTAe
        XTUMV99luTOE5R1r3Ie5TDZfQw==
X-Google-Smtp-Source: ABdhPJxZLiuupBgjimOBLQ9o78NI5+Pncd6QzWuKFO7HA12438j7MXJ1/hp4hVpMp/a39pOJnz8tug==
X-Received: by 2002:adf:e688:: with SMTP id r8mr5166369wrm.20.1610136925233;
        Fri, 08 Jan 2021 12:15:25 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Eryk Brol <eryk.brol@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/40] drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs: Demote non-kernel-doc comment blocks
Date:   Fri,  8 Jan 2021 20:14:31 +0000
Message-Id: <20210108201457.3078600-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:699: warning: Function parameter or member 'm' not described in 'dmub_tracebuffer_show'
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:699: warning: Function parameter or member 'data' not described in 'dmub_tracebuffer_show'
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:743: warning: Function parameter or member 'm' not described in 'dmub_fw_state_show'
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:743: warning: Function parameter or member 'data' not described in 'dmub_fw_state_show'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Eryk Brol <eryk.brol@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 11459fb09a372..d645f3e4610eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -691,7 +691,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	return size;
 }
 
-/**
+/*
  * Returns the DMCUB tracebuffer contents.
  * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_tracebuffer
  */
@@ -735,7 +735,7 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
 	return 0;
 }
 
-/**
+/*
  * Returns the DMCUB firmware state contents.
  * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_fw_state
  */
-- 
2.25.1

