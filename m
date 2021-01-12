Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727BC2F3CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437120AbhALVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406901AbhALT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:58:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568FC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:57:32 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so2046925pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8dVFyFiyF8C+YWyOq836m8QU0axjla2SznTviLPhcFk=;
        b=KhkahF+Q+s5CL6PHq2P1p5hNDDOSnWQVZeJHVkiJzQhVDLAvJhxj8n1E9aK1rgLP+i
         D+GyyNExLtp5vqHuX6XcII2nR2HAhVZ8lkxZwd4reXmQg3exTBn6wTnseA41PObhqgKI
         X5Jnnx7uSDTirc71GLq0F9EZXxJZqur5wErdPlF/qs4NtCir6SGBgne1wRnQjWCib11j
         MvYDBmNdZlu7oLX/ViQbbPVfWB0NVLfcAMTRTy66FUwgs67AVQR+uKE0fMB3TMxEoAOJ
         ZhgSJlPdp1tiT7pk4YaB/179iyH8zmCvUlG4DSvhXQiplw8sE2Ob4oeBhvKbW0TvnMVW
         T1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8dVFyFiyF8C+YWyOq836m8QU0axjla2SznTviLPhcFk=;
        b=gbFcK3QHGQSi/wyXClkQshtdWqXKiMJIuyWHMTidLH1zKEba4aicMCeteAr6Atcj3u
         I6z2i9pNJa8W2CDIzL4Rnl1GPzGyOhtZY9WeQHfLs0gyVEYzsn+qvD4zMCZNKyp6vaeF
         TzZslXAAaPLIuV7ycWkf2ytoFsfzjvT3q3GhY3DFjudXatVtaFsjcynpOrNMlypVdK3D
         NNH9uPVMN1X+neObZnWO0j7ZhdNLtLDtTzB33gms44RHCZGRQldbye9hiF1qiwQHIcol
         i5malp5S9ZlimRNpYWC3QqXKD1Oxiu7u1AvshJ9pxrFfXbi9GXIVR4gKD+HJRd+7pY7N
         kiww==
X-Gm-Message-State: AOAM530Wim/me18ZIC+pM8OkYy3BenuQ3GMEpBGmQ9D4hYI+nfl/kzB/
        NKbXtOf46meyT+ybqiyZZTI=
X-Google-Smtp-Source: ABdhPJxWZJ0yiE0hSvXxmHZNYo4sSoW3/0CiG7pxMwVjn8U2zFJvSb5sR5sDJhAAPd+z95PzYX+sEg==
X-Received: by 2002:aa7:9a07:0:b029:1a6:5f93:a19f with SMTP id w7-20020aa79a070000b02901a65f93a19fmr865506pfj.21.1610481451911;
        Tue, 12 Jan 2021 11:57:31 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.121.136])
        by smtp.gmail.com with ESMTPSA id 11sm4759328pgz.22.2021.01.12.11.57.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:57:31 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Xiaojian.Du@amd.com,
        ray.huang@amd.com, evan.quan@amd.com, lijo.lazar@amd.com,
        Jinzhou.Su@amd.com, Xiaomeng.Hou@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drm: amdgpu: pm: Mark vangogh_clk_dpm_is_enabled() as static
Date:   Wed, 13 Jan 2021 01:27:22 +0530
Message-Id: <1610481442-6606-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot throws below warnings ->

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:594:6:
warning: no previous prototype for 'vangogh_clk_dpm_is_enabled'
[-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:594:6:
warning: no previous prototype for function 'vangogh_clk_dpm_is_enabled'
[-Wmissing-prototypes]

Mark vangogh_clk_dpm_is_enabled() as static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 75ddcad..3ffe56e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -610,7 +610,7 @@ static int vangogh_get_profiling_clk_mask(struct smu_context *smu,
 	return 0;
 }
 
-bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
+static bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
 				enum smu_clk_type clk_type)
 {
 	enum smu_feature_mask feature_id = 0;
-- 
1.9.1

