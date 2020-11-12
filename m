Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C82B0D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKLTBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgKLTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:07 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42787C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:07 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so7133573wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9hqlcpW7hereULOoI8627Xoa15VHuxF/Ol1jNzvX80=;
        b=s8i5onDX/rg5gWCD7HaLyJM+wKiQn/RZHAN9N9s+jIYLgKocbJRWeJW96iZ7piGHrf
         cUr8rpL/UIFShlV4GrkjRsUCsedoNDq/fh/oUHIWBIyscRKe8qiIrkvUYW/2CpQF45so
         T9ZB4CcBZIJOhzW8rea3CXj3gRVDYzXC/aMzOvVQKn+pceTygbzdDUdFCj3gng5sd9HD
         iolE2XLyKcEBDSYrqmdxvTp1D5N8IfFOYD6+jUfNaUD08qpeq5jIcTWy9qcFqonNF+LH
         PT+Rpe69EN5bZ4oNGoUhkIJ767NqzJSxU+YIikqm+6fYF3H56oTb8abF9G3LtFRQtClZ
         +Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9hqlcpW7hereULOoI8627Xoa15VHuxF/Ol1jNzvX80=;
        b=XxNhM7wU47PZV5nwJaPLsPNNzM98dlIOwLFDzoJprMtxljYYt3JuiGzsze2lqR6hXH
         3mAjj7BoTO7vawG82Fu08DMAoCkIU6VYOQonumdK+2QoiBXBynAFYrQjCk9mWOVLKXt8
         12IofkqQHiuGZsNgbpK/KzT4a1Oh87GlS1KZps1MP55d1lfSKy6lmuCwC0hwn58QZ8Ev
         cd9LxRcohcWxc0BQfgFOc9mcOT6ZokhteHAC8nFfjFOX4DngQQu3EU3aNmYv3Zzq0T3Z
         p59dMDQM3MvcmSoAFMK7bQx2f+OlhGtTSo84rk7rweUMlrnlC1SIPRzD1cZbfC5IdeIh
         hd1A==
X-Gm-Message-State: AOAM53224Qa2hcgblzAFf4HPOp1aHDat1MFoI1+HgmBM6YdgN87q9K3f
        jPzHYZ+Gz4pwsV95jga3gUd7IQ==
X-Google-Smtp-Source: ABdhPJzqYmCuCuPGUHhvR1gFv1JTE0Oj+Uvn7zIksuPSSRPWbaMe6RqDfiiHzGBdAR4sf5iqgyFqWw==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr1071487wrv.359.1605207665964;
        Thu, 12 Nov 2020 11:01:05 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/30] drm/vc4/vc4_hdmi_regs: Mark some data sets as __maybe_unused
Date:   Thu, 12 Nov 2020 19:00:19 +0000
Message-Id: <20201112190039.2785914-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alternative is to move them into the source file that uses then,
but they are large and intrusive, so that strategy is being avoided.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vc4/vc4_hdmi_regs.h:282:39: warning: ‘vc5_hdmi_hdmi1_fields’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h:206:39: warning: ‘vc5_hdmi_hdmi0_fields’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h:145:39: warning: ‘vc4_hdmi_fields’ defined but not used [-Wunused-const-variable=]

Cc: Eric Anholt <eric@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_regs.h b/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
index 7c6b4818f2455..96d764ebfe675 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
@@ -142,7 +142,7 @@ struct vc4_hdmi_register {
 #define VC5_RAM_REG(reg, offset)	_VC4_REG(VC5_RAM, reg, offset)
 #define VC5_RM_REG(reg, offset)		_VC4_REG(VC5_RM, reg, offset)
 
-static const struct vc4_hdmi_register vc4_hdmi_fields[] = {
+static const struct vc4_hdmi_register __maybe_unused vc4_hdmi_fields[] = {
 	VC4_HD_REG(HDMI_M_CTL, 0x000c),
 	VC4_HD_REG(HDMI_MAI_CTL, 0x0014),
 	VC4_HD_REG(HDMI_MAI_THR, 0x0018),
@@ -203,7 +203,7 @@ static const struct vc4_hdmi_register vc4_hdmi_fields[] = {
 	VC4_HDMI_REG(HDMI_RAM_PACKET_START, 0x0400),
 };
 
-static const struct vc4_hdmi_register vc5_hdmi_hdmi0_fields[] = {
+static const struct vc4_hdmi_register __maybe_unused vc5_hdmi_hdmi0_fields[] = {
 	VC4_HD_REG(HDMI_DVP_CTL, 0x0000),
 	VC4_HD_REG(HDMI_MAI_CTL, 0x0010),
 	VC4_HD_REG(HDMI_MAI_THR, 0x0014),
@@ -279,7 +279,7 @@ static const struct vc4_hdmi_register vc5_hdmi_hdmi0_fields[] = {
 	VC5_CSC_REG(HDMI_CSC_34_33, 0x018),
 };
 
-static const struct vc4_hdmi_register vc5_hdmi_hdmi1_fields[] = {
+static const struct vc4_hdmi_register __maybe_unused vc5_hdmi_hdmi1_fields[] = {
 	VC4_HD_REG(HDMI_DVP_CTL, 0x0000),
 	VC4_HD_REG(HDMI_MAI_CTL, 0x0030),
 	VC4_HD_REG(HDMI_MAI_THR, 0x0034),
-- 
2.25.1

