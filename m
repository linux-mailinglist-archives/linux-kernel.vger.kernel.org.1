Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62E2F1F26
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404135AbhAKTXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391018AbhAKTVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39BFC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m5so905072wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6qinHvszbHKv20eCXlyTbSvavsiU8PbuOK8tq0MfV4=;
        b=U5WrAgLJ8zefgyYItfLqzBpx5oezBJvkiQLUCDgp7ycKfwDXDoTHty7FA+6ZV6b97D
         NN8TEmkq6DHq42uIgNLTOIEbRfkfbccMZETj/PMttJ2Y98DpPLI7id8ONWPkZT731Swt
         hJJbrMWLZs18go/1pgQ7/kTCSsK0LKmq1XTQYWl3hcHa9ku9VZArcO/7bdZBuG24mUHU
         jAsVtScfwlqZe499JuK+JNDp8T/I9067L96PqehBzZQY3UhKNs+wF/BO/EZyNbuy46m7
         DLB9O/gv8+AwO5AWSR0m98Ok8PU080KcvTE0cbgwxMiXuFobeFEEJbPYMBsdP5jApnat
         Z82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6qinHvszbHKv20eCXlyTbSvavsiU8PbuOK8tq0MfV4=;
        b=Qixo8ze/uUhjAU7Vj0Vdb2kmCrOdnAge7QFqQvU255YE3P00j/mmnYuCQhLJCs9yS5
         2ZTvYynde9NH/ipgENrWa6Uc6Fia4VNp79EMCkKslyxdzGpOXllO+/+m7ZSc7GrVx2nH
         lkJ9cRnDAgbjntaKgZBXe/u9lLMdRqGjQh+yY9GM4ft7hlP1IPWTHyehyoBXn2q9f1q3
         dMKE2+BudanVS/+gfwE7VquigvmRnXjs9ouLRUyIsK71bYS33uy7Bsdm5tmsixeVtMtz
         ZfhMvP7eLPOHO3c5bqLgNz4XzIMx28TJfAWcbfWjjQ6WbeO2ax5rnqk64tzV1GmB43ZK
         NIPA==
X-Gm-Message-State: AOAM533cDT43xZky14abN5YcGoiPxQ9u3uQXz+lK+pMu8Y40jCX0X99N
        rYwOMunm90aV7xoM7K4JUFrg7A==
X-Google-Smtp-Source: ABdhPJw9iB23UMo+bsaBTwuBmXwlBwb8fjpQuEWOiOMMgFvtZM8pnezg4Eom59nkxXii3Xp2BqKlnw==
X-Received: by 2002:adf:d085:: with SMTP id y5mr606162wrh.41.1610392810705;
        Mon, 11 Jan 2021 11:20:10 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:10 -0800 (PST)
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
Subject: [PATCH 31/40] drm/amd/display/dc/dce110/dce110_mem_input_v: Include our own header, containing prototypes
Date:   Mon, 11 Jan 2021 19:19:17 +0000
Message-Id: <20210111191926.3688443-32-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:1034:6: warning: no previous prototype for ‘dce110_mem_input_v_construct’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index 19b1976139b69..8bbb499067f74 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -34,6 +34,7 @@
 #include "inc/dce_calcs.h"
 
 #include "dce/dce_mem_input.h"
+#include "dce110_mem_input_v.h"
 
 static void set_flip_control(
 	struct dce_mem_input *mem_input110,
-- 
2.25.1

