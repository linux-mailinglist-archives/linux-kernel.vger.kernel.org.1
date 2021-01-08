Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7102EF8E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbhAHUTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbhAHUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E00C0612A9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d13so10096994wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ch2gYAE2vDuTmkFhr3daFGk6qkpCbvS5cnZ4t3WwTr8=;
        b=eWMH5So3djuul8qB47/3pj9n9lXtnPj8xRPt9BjaVXr7omscVJhIB4YxEbAeWG+kVU
         V523YJopK++IkvFlH40/ocBNKEE2KCzUFsXZ0acwbVrjjcZE+vmVs6wcpIwM+lUH/TWE
         UGvwUmNRSZ2SXHtSNNkw+HlzMeX1+JmaaOV7SXPjUcI9jfmdroTxKE9uyW52BcyHNRcr
         Fd1/Ewe7GlTTC+mkHhelgArACGCH3CX9bsBdJWFtx+AtspM2pDGmxvUQo5eNd9HRSfef
         O/sIm9IVFTencRTxkmeiCoxBIA/tlAeVeCAzhZr2WZiz43T+nJLkvEXeP2Ch9JztHmSa
         /pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ch2gYAE2vDuTmkFhr3daFGk6qkpCbvS5cnZ4t3WwTr8=;
        b=Qw2xrZwhSafqBlbyoTgYGFsb+zLQZVSZ37PI6W1RTKMRVofZxheu6mCxTFAmUhRSqv
         H46uX46+92lUXf09ButDaAZjzH7W7DsMNoJ6dJ99Nz+kDxZYTwz7MKuZttgQ4BgMPRyc
         omFIxp5LT+C4CYLt9349+wgTIUxIU3Dcehss53Ys5Ml9nZ2kY+WeYZFbukipvs9VCmwK
         +4pEdeQvdYxROJ7wkb3wnQYbk8pNVH76rLdXbizRxKrl07eE0oTaXnrDSGhCxfBQZiiW
         NhAxND6bZQ1+IHTDzOOwYY6z97vFGiTD0T8I9+ZioJDw1nPFzbwoumcRqHan6IsjcRN/
         WPGQ==
X-Gm-Message-State: AOAM531wPDqBN0QZ88LOoP2wo7elQdyEa7/McTDZcJDozF8IakSf+SYo
        UjAotO0N8IAYca5LdKhpXPgrmw==
X-Google-Smtp-Source: ABdhPJyWHXz1lvcQZIGRwW+Sx8oVGMph2zWCusorEAyZWKLb5aQ14ApYuk5uNjw20CEbFeXTCbxgnw==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr5300851wrv.132.1610136922870;
        Fri, 08 Jan 2021 12:15:22 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:21 -0800 (PST)
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
Subject: [PATCH 13/40] drm/amd/display/dc/basics/conversion: Demote obvious kernel-doc abuse
Date:   Fri,  8 Jan 2021 20:14:30 +0000
Message-Id: <20210108201457.3078600-14-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:86: warning: Function parameter or member 'matrix' not described in 'convert_float_matrix'
 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:86: warning: Function parameter or member 'flt' not described in 'convert_float_matrix'
 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:86: warning: Function parameter or member 'buffer_size' not described in 'convert_float_matrix'
 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/conversion.c:86: warning: Excess function parameter 'param' description in 'convert_float_matrix'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/basics/conversion.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
index 24ed03d8cda74..6767fab55c260 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
@@ -73,12 +73,9 @@ uint16_t fixed_point_to_int_frac(
 
 	return result;
 }
-/**
-* convert_float_matrix
-* This converts a double into HW register spec defined format S2D13.
-* @param :
-* @return None
-*/
+/*
+ * convert_float_matrix - This converts a double into HW register spec defined format S2D13.
+ */
 void convert_float_matrix(
 	uint16_t *matrix,
 	struct fixed31_32 *flt,
-- 
2.25.1

