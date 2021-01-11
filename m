Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BC22F1F31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403783AbhAKTUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403768AbhAKTUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90600C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q18so965872wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAJr/GrILhLZ43nh9MNYnDn6VtEAVAp1VLhyj8VjtZY=;
        b=ZKvYlOSzjGWKUDGJudDlR+nNT4HXGZeiYCmcLqgSbXIAWWaMK3TVGyu5ojYZStFVAk
         ucVfGCsMKfaal5fZbPscd/OGWdciwFyLxC9UiSU/y2BCZCdw1+y4SBDTXhDPKrHL36S6
         iBxBetqmGUNT5sVgq5B3rDMbiStK1hSZ/XcRTqC/G0/wurOtC9e+QSqZIxHackHdBx3u
         qg5ntYjG+SQu8YWCFi444oT7avvkhVrdmaV1RbjPqDIv9IxQHmekARKG2jax7yvLhTuW
         HJBjzy9NW7H5Fi2dWH+LIhE/mNsar4fIe37QvruE2KCfoEnKlOt4axe2jydNyMfaPcEG
         PLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAJr/GrILhLZ43nh9MNYnDn6VtEAVAp1VLhyj8VjtZY=;
        b=me+Mxf3iYo4uI0Np/hbZ/EMKXzz/WF7q93mIHkvXoEGmoVTyDYwTt2PeYXbFSIEWkN
         /ZiEIh6h/M9EhjXkFRPHTrFQheaYf3y6ZcPO/4ys96irAtw1P/xRvEzCokiqAU4xg2I2
         Khb7PuyMKNp3CfA7dGZ0h2sHWExxJYa1G9uZNfBAf5vW+BJ4ExIMpk2UTtcH4P5frjKy
         d/2wILtSE/oyb1VipnL5Mr9+m3Wcoqf1KFsxIxcuOD/b6sQaop98guC3Erfr2NMmMM0D
         WK6oL6U/ExZZbaHO0Ung1vA2x/VdoOHtekOrLbiJf2JQa7OrElrBUQtW8ctjl8e0lIAQ
         /1qg==
X-Gm-Message-State: AOAM531y32ALXiF78YedFkXeQmZEAPS8p7oMQyWLOxQqwWOEErwhpP3V
        wFt3BMqzVMPBicUcGxCjYUiA2Q==
X-Google-Smtp-Source: ABdhPJyLEv5ADsN6eDoo3NVId0gB3w6P/NI6vrkMSf6H7Uqh/VOpd2nc+kz2pDZ5kA3Irm/13zrPRQ==
X-Received: by 2002:adf:d201:: with SMTP id j1mr612338wrh.212.1610392778311;
        Mon, 11 Jan 2021 11:19:38 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/40] drm/amd/display/dc/gpio/diagnostics/hw_translate_diag: Include our own header containing prototypes
Date:   Mon, 11 Jan 2021 19:18:52 +0000
Message-Id: <20210111191926.3688443-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_translate_diag.c:37:6: warning: no previous prototype for ‘dal_hw_translate_diag_fpga_init’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c
index bf90688469271..e5138a5a8eb5a 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c
@@ -24,6 +24,7 @@
  */
 
 #include "dm_services.h"
+#include "hw_translate_diag.h"
 #include "include/gpio_types.h"
 
 #include "../hw_translate.h"
-- 
2.25.1

