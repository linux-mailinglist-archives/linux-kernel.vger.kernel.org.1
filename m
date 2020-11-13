Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E174E2B1C75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKMNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgKMNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9EC061A48
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:13 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so8200750wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BXDPKXdRdueiwX/LiUMD6iJyASVIxZBD/garEIirGM=;
        b=brzqYYPJkw4pvefC6wQnPQA3Y6um+5RdpE0kqcXc8rWKOoh3kU8lFmA0iBxjIcgt00
         h4iU9zhdlP0z2tW1JX4ar2UoS2qeuZtG9qwEuJcfocBjGp1cudNK/Ek0NiHbnm47LD9L
         2K3Qpn/guN7e6yEew9UrNl6xP2g9fkryB13QzPj/hMBdym6w8zpGZtTqclPt8qV+E/Uf
         39UB1eN3IJD0X7z8smthTFYuEKmY4N/btLwe00Kqtf1Dmh3c+r6qrpMJlyUMvkXlhpaT
         F4IHPwYSN3v5J4jRWacrfkkh32cypL57qfFCSaYSqB1UHvJH0C8CHut+A0Om1rWcdKv0
         wrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BXDPKXdRdueiwX/LiUMD6iJyASVIxZBD/garEIirGM=;
        b=HMEo8FIGLc5fPiBCs8HYMPV4xT40G5Y88YP8MetlFFIUih2l+XUmQEeC9X0Lsphsor
         jn50U3GF8l/ogy3SN20JoU3pWmecfsn/Wu4g1Hr/nRxinFKHikFBHSbZfRcf5KuMSNyV
         pULvcV+0fW6fbYU47cD3HRQoAcyiBRu4xVQRilakOy3s/htvtRgRXabOt6fRnI2UyEeR
         nZYuCoCueIUB0ibIYnSeESh1Ncg4d7EDc7LcTCtxKugVGy6Uu1XxSRNZ2XIcYnzlmEF4
         7pkOE+SqnRK5QVHGMZzHRCLz30CZrXb5QUR9p6TxrBy4q/gQC/0n0UbRW/Iluf6fMc6f
         V33Q==
X-Gm-Message-State: AOAM531Pbe/Z2/VSG+8c4NDkpAPO+NJ7wIyDDp16b+FPWi6jtjml+k1H
        UKTVzL2IL027WQrh3nxsQJwnhQ==
X-Google-Smtp-Source: ABdhPJyDbcqcylUfZcRfA5p5RtVVJCF+uRX3XcI+SeufaMml8mxZb1Csg+ASZWxQSwiKwPF6J8dG1A==
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr2655258wmf.96.1605275412550;
        Fri, 13 Nov 2020 05:50:12 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 25/40] drm/amd/amdgpu/amdgpu_debugfs: Demote obvious abuse of kernel-doc formatting
Date:   Fri, 13 Nov 2020 13:49:23 +0000
Message-Id: <20201113134938.4004947-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:308: warning: Function parameter or member 'f' not described in 'amdgpu_debugfs_regs_read'
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:308: warning: Function parameter or member 'buf' not described in 'amdgpu_debugfs_regs_read'
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:308: warning: Function parameter or member 'size' not described in 'amdgpu_debugfs_regs_read'
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:308: warning: Function parameter or member 'pos' not described in 'amdgpu_debugfs_regs_read'
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:317: warning: Function parameter or member 'f' not described in 'amdgpu_debugfs_regs_write'
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:317: warning: Function parameter or member 'buf' not described in 'amdgpu_debugfs_regs_write'
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:317: warning: Function parameter or member 'size' not described in 'amdgpu_debugfs_regs_write'
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:317: warning: Function parameter or member 'pos' not described in 'amdgpu_debugfs_regs_write'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5c1f3725c7410..a6667a2ca0db3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -300,7 +300,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	return result;
 }
 
-/**
+/*
  * amdgpu_debugfs_regs_read - Callback for reading MMIO registers
  */
 static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
@@ -309,7 +309,7 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
 	return amdgpu_debugfs_process_reg_op(true, f, buf, size, pos);
 }
 
-/**
+/*
  * amdgpu_debugfs_regs_write - Callback for writing MMIO registers
  */
 static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
-- 
2.25.1

