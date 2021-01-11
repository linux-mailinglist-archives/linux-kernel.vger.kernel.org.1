Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD52F1F07
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbhAKTU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403774AbhAKTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49389C0617A9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t30so972690wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcsXd93K7BxPfLMZix7N1m2GKT2azGUOXW7pu1fAJ6Q=;
        b=ZgN070xj9zEPxR6Eju8xm/BGEJNz26qAu8AK4hz5kXNIOjqsQxjUOJqZ4iQ7ohXe6P
         bmOVqJpchg0VBixwo6iK1krjte9+L1Afe75VVKj8jbMEDib/VMRKbvNvdmJxJkH2g8/6
         iwod8WTWIKRUyQbScNhoFkgfi7OPMNWCymJ+arxVjLaP8grMv96/ZLuyiflsT+b20Q30
         NTKQsNA0WpV1M6zAsBxspLjTpqdatanlXZJYFC2nQWTNPOjPHBf6+Fm9NCw8cIocOCHe
         kJBjojkgFDNH2+DGSSjAgMTKyWIborbM1NB5Srr8x6osaizYXvHLlU7A1ucFe1eiWRWb
         ykJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcsXd93K7BxPfLMZix7N1m2GKT2azGUOXW7pu1fAJ6Q=;
        b=H4/0Nw5GSpQCgp+CNpZnYWcAD3xglSCiRAm3EozNKHQcIZjY8dCqq9yeoCmSR8uAmR
         b6AICEVzFrUNpBXmxsbxGzAdzPxVQn28eshs/vbXawwKJgtNbgdlR2VHlmLXkyz0/AXK
         TdAB6aelI/u0mn0/H9uVjfoOf6wwWtzzYi9R2Y9n9uBdXxaxZAfasdfY6ikFTKQWSzFI
         B30DAN+1s4M5RXo1qfdSlsHpN/mopNpuUUS0IOR/z7OJxJYsrpAD3kpNjX/54GA7IJq2
         9CATo7LqnAMIPPdNPV6QlPRtDD5GNCYZI9gxRvI+wU6YU192o/2/Tpgh3wLaAjVBQHMc
         1a5A==
X-Gm-Message-State: AOAM532BmVWguJ4xTnAmmJcR3yj5b6qhN9vVTJl6dd2RthHTQRHmy5iJ
        I5ujMZyImviRv0Zgxw8VYCoBO31oZZQBz9DC
X-Google-Smtp-Source: ABdhPJy5wbRWhf0qduM/ZnCT/0hOR9xgNX/ehbryzeIZj8Uyts1DMTt3SiRFvp6CxAUQd1iERwcZYQ==
X-Received: by 2002:adf:f344:: with SMTP id e4mr593240wrp.25.1610392782031;
        Mon, 11 Jan 2021 11:19:42 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:41 -0800 (PST)
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
Subject: [PATCH 09/40] drm/amd/display/dc/gpio/diagnostics/hw_factory_diag: Include our own header containing prototypes
Date:   Mon, 11 Jan 2021 19:18:55 +0000
Message-Id: <20210111191926.3688443-10-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_diag.c:50:6: warning: no previous prototype for ‘dal_hw_factory_diag_fpga_init’ [-Wmissing-prototypes]

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
 .../gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
index df68430aeb0c2..c6e28f6bf1a27 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
@@ -28,6 +28,7 @@
  */
 
 #include "dm_services.h"
+#include "hw_factory_diag.h"
 #include "include/gpio_types.h"
 #include "../hw_factory.h"
 
-- 
2.25.1

