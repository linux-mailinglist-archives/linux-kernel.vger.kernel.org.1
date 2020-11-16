Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828C12B4DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbgKPRlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733304AbgKPRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:41:27 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C083C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:27 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so19701121wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VZRZT8daPeGmypqlkiDD/bg2WPWGzH9nAJzamvIbC4=;
        b=XIGydzF8ll59VzTwx4kHtiFKr4QqwikhLjU4KxNpkNO0xFCL6gbiHerhnJhc4VxFsA
         U6pAgqWoIzexOQ0HWONoLIorOt3ftCEcbtmeiCda3OiE6Q72KGWBPqJJQKx0hgUfEVSf
         Tokld58vv6fEOMcH9k9iiyKKM3S/RQH6KV4AGzmwzDlio0XzYHaq/AVLFHWrTM1qpnMf
         av3wkbOtgXzfr/5bc3/4hFY1W/OHs//CUW3gR4SIMavAauqcawoq2bTvMQkTrqudtJgw
         lL2/5lwSylp+ojXy4xQQQ2jyjvzJZywj1kLJnzLlJrL2RmjhIUmQOhYEIctCWcIZvDRU
         rK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VZRZT8daPeGmypqlkiDD/bg2WPWGzH9nAJzamvIbC4=;
        b=g7jYtBM7igXCa4evk2ajTb/VPMezY0MzwzzeOYZ8SPFGQeHBQnxWMVddk0nWsdA+DR
         8VKVarbngD5Itwq5yKk9/MssboX+UyttzDrEQyKJqhQvz3N3n6FHmST33j0r0C9k9l9r
         Veu2PHha4c+/m2OTje3yup8TgjYuvBOtApMlSiyLzRNSatb5bp3QKOgnaBhIYA7MwnGE
         7TH6EXvQFjnEuABc7P3HnA1RjMuao7qsm3COlLSu5hy+SpXu8Q/TqShFlzZ3DWVlUNf+
         nayBPmCPcb0A9nExRszpWbypYNBFqTvQ+QQxuetnLi40chJmSAqi9hQJhnv61CvaBddC
         N5Dg==
X-Gm-Message-State: AOAM531WK1v237CNwQ8t4SSNkRfTAbZHzILbelEPIC7R6B2TK5WbSIcD
        di+U4I7Jf/YVQojAgRyYZ4hXYQ==
X-Google-Smtp-Source: ABdhPJxJkSZPTj2E1cruHSDCJr8lL1DADQ2cLxDq8PU5VnhLFEqgzTcMDJzB1wObuub61ameieOo/g==
X-Received: by 2002:a5d:510a:: with SMTP id s10mr20122601wrt.402.1605548486009;
        Mon, 16 Nov 2020 09:41:26 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 05/42] drm/exynos/exynos_drm_fimd: Add missing description for param 'ctx'
Date:   Mon, 16 Nov 2020 17:40:35 +0000
Message-Id: <20201116174112.1833368-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/exynos/exynos_drm_fimd.c:733: warning: Function parameter or member 'ctx' not described in 'fimd_shadow_protect_win'

Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index bb67cad8371f0..49a2e0c539187 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -725,6 +725,7 @@ static void fimd_win_set_colkey(struct fimd_context *ctx, unsigned int win)
 /**
  * shadow_protect_win() - disable updating values from shadow registers at vsync
  *
+ * @ctx: local driver data
  * @win: window to protect registers for
  * @protect: 1 to protect (disable updates)
  */
-- 
2.25.1

