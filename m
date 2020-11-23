Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C502C0454
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgKWLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgKWLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:56 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51876C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so16859489wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dt3qGeaR7mDkGDOtCiBYSSJ0FSX/4GBqlT4FsqhW3aU=;
        b=A7aG4NUk01QTYOgfaJYXiLRsQmxZSN2RZbte2BKCTWb7GV74h+fgN95VPh8F+EWuHa
         ZwehXJ9Gp9hSTDJO0D6lO5a1PodY3r/JCC30/5lOfGZBR47e6USHjp4tlQ5FPr3WXGeq
         JIyXY0TKeYAtUVV5rTxyT/XUhbnbWDN2sVGU9IZ36KXptQ75GggISLQEwO/Ai/GpDXlC
         8QwJICGLpEy/GYJomAU2bCtyEqLPVpIh+LAstN5RbeKJg4yXPLuC+gYD1EYhlkJbexPE
         Zg5/3luMgUlZMF0HEVjFxIa3rQvyNcIsXwEikhJINH3R+7McVWPCMDJ0FBI8h4gCcRin
         tocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dt3qGeaR7mDkGDOtCiBYSSJ0FSX/4GBqlT4FsqhW3aU=;
        b=ukvDSOyLiqjH3yMNcMeTxnMli9vD8DxPzA4r0VoOJbMYOL9yaDyVaqhwM1oZRn0gyu
         RRL9YxC78xeKHhl00SscHDV2rRzwZDF5eUeTe8LlVKBpjaGyFqqEzW8ClZaV/zxaOH51
         dZNS1FI+jMcE1vZw6mKKrMJ4jopSBicaEczG3X9SuniT6SK1TYQlkQXVGxNFN1sqGmlr
         0l0fDIppe5w02vQxjmCAC+niJpgQH7PnxAa+xkNc22fNvyYZTxE1gIHhKmSpZyM+aVi/
         u7amTNfHzVGQ3Ft37Cng0t3Xnbl+2ut/thb0+/FnBB9YQ6nyVQDPVhgkEpSda5hTOp1Z
         B+cw==
X-Gm-Message-State: AOAM530ViIA5xh9xHXQlBr48DJ8LvvpW6R8rMIbXyQk8i3CyVT+U2wT/
        9Ielsjk2Qp6C+Q3LrEnYMNKopA==
X-Google-Smtp-Source: ABdhPJx4JMSzWkbKceWi1SW5fvksRYsrwwvS0sk1EeQb+wukDZgTmz/qJ1SYCh17VozYRM5jUgtzIg==
X-Received: by 2002:a1c:2384:: with SMTP id j126mr23896282wmj.116.1606130394092;
        Mon, 23 Nov 2020 03:19:54 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 25/40] drm/amd/include/arct_ip_offset: Mark top-level IP_BASE definition as __maybe_unused
Date:   Mon, 23 Nov 2020 11:19:04 +0000
Message-Id: <20201123111919.233376-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/arct_reg_init.c:27:
 drivers/gpu/drm/amd/amdgpu/../include/arct_ip_offset.h:227:29: warning: ‘DBGU_IO_BASE’ defined but not used [-Wunused-const-variable=]
 227 | static const struct IP_BASE DBGU_IO_BASE ={ { { { 0x000001E0, 0x000125A0, 0x0040B400, 0, 0, 0 } },
 | ^~~~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/arct_ip_offset.h:127:29: warning: ‘PCIE0_BASE’ defined but not used [-Wunused-const-variable=]
 127 | static const struct IP_BASE PCIE0_BASE ={ { { { 0x000128C0, 0x00411800, 0x04440000, 0, 0, 0 } },
 | ^~~~~~~~~~
 In file included from drivers/gpu/drm/amd/amdgpu/arct_reg_init.c:27:
 drivers/gpu/drm/amd/amdgpu/../include/arct_ip_offset.h:63:29: warning: ‘FUSE_BASE’ defined but not used [-Wunused-const-variable=]
 63 | static const struct IP_BASE FUSE_BASE ={ { { { 0x000120A0, 0x00017400, 0x00401400, 0, 0, 0 } },
 | ^~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/arct_ip_offset.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/arct_ip_offset.h b/drivers/gpu/drm/amd/include/arct_ip_offset.h
index a7791a9e1f905..af1c46991429b 100644
--- a/drivers/gpu/drm/amd/include/arct_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/arct_ip_offset.h
@@ -28,12 +28,12 @@
 struct IP_BASE_INSTANCE
 {
     unsigned int segment[MAX_SEGMENT];
-};
+} __maybe_unused;
 
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C20, 0x00012460, 0x00408C00, 0, 0, 0 } },
-- 
2.25.1

