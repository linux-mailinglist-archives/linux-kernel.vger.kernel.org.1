Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F20C273A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 07:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgIVFsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 01:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIVFsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:48:22 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820A6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 22:48:22 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p15so8864331qvk.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a6SQCCgOvcVnYbZwR03FGL/qrYw5HjNsY2fRdLjl82U=;
        b=tyxd8motev6kgLZAmtucstDnnqDnmRrH1bXuX8dpwrbECLXnH1JtDxKqoxjgE0uC84
         7n9GPEGtLPig1f11FKwN4BbeUiL1H/uO1foqLPkARf/52IgAKH7ztxlGaHfn526dxaZJ
         NPqKyOEc281EQ9Uab7r0EdPwKX0dUaJnPSKEokB9UWfFPSVNz8HMkBbbCKUGeh/VmQHK
         b+hqP2KuGBETHFdMYNxVA/P4hCdE7gUbgI0JS6i+iJyLP1oMz1gaYc2yGX8On+Baqodm
         qpr+KvJnF+ZqjtAwln2PwQLrkuTppySz8EskYw5z/3PQZpru3gb+V5z7k2L8P+HyAbIu
         BVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a6SQCCgOvcVnYbZwR03FGL/qrYw5HjNsY2fRdLjl82U=;
        b=ND+25Itq3dlZBXFtZeR6F2GsRLDZngdVDE0CRfxjmdFNDzX08An0sc26E26nMouXX5
         QQsjY+aIQ29M3hrdIQuOsrIOTpxHZK0nGFWyrD8T4T+r/sq3jTqbQI1HiBOGivf30ep0
         dNPejty+rnFhGsrA8Xii3k6xEXxgmgAwdzo/HMdbJRPQURJUXDVH7hJv0oez65Wmj4Au
         J2+jhjkYm1NMKrY5t/E1YTJgYCVpNtIddVJBFLcXShtX6uH4AIG10inCQGrqwDm5Waao
         C42CT8A2bpuyEL26mtXdpgekEB+THd63j1WnQNWMjNneJ51fKzuM33jdXIA5Cl9ekqqc
         PFTA==
X-Gm-Message-State: AOAM530N17CC67ZHPG5Sk2nAyrINHTNuS40Ilscwj5LCBWZvszrrpHR6
        8e7/i80dHZ3Ki8VKAnOTzEo=
X-Google-Smtp-Source: ABdhPJwDGs7jGImCpG+LB2Wp3WIK7lBkKjX1BDHsgY5T+UNvYa3EP/dCUzbFJjmmzMUvzLl0gjP1ew==
X-Received: by 2002:a0c:a4c5:: with SMTP id x63mr4315522qvx.58.1600753701601;
        Mon, 21 Sep 2020 22:48:21 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id i187sm10961909qke.43.2020.09.21.22.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 22:48:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Simplify condition in try_disable_dsc
Date:   Mon, 21 Sep 2020 22:47:43 -0700
Message-Id: <20200922054743.2422929-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:637:8:
warning: logical not is only applied to the left hand side of this
comparison [-Wlogical-not-parentheses]
                                && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
                                   ^                             ~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:637:8:
note: add parentheses after the '!' to evaluate the comparison first
                                && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
                                   ^
                                    (
)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:637:8:
note: add parentheses around left hand side expression to silence this
warning
                                && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
                                   ^
                                   (                            )
1 warning generated.

The expression "!a == 0" can be more simply written as "a", which makes
it easier to reason about the logic and prevents the warning.

Fixes: 0749ddeb7d6c ("drm/amd/display: Add DSC force disable to dsc_clock_en debugfs entry")
Link: https://github.com/ClangBuiltLinux/linux/issues/1158
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9d7333a36fac..0852a24ee392 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -634,7 +634,7 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 	for (i = 0; i < count; i++) {
 		if (vars[i].dsc_enabled
 				&& vars[i].bpp_x16 == params[i].bw_range.max_target_bpp_x16
-				&& !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
+				&& params[i].clock_force_enable) {
 			kbps_increase[i] = params[i].bw_range.stream_kbps - params[i].bw_range.max_kbps;
 			tried[i] = false;
 			remaining_to_try += 1;

base-commit: 6651cdf3bfeeaeb499db11668313666bf756579a
-- 
2.28.0

