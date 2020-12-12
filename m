Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CF2D872B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439207AbgLLO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 09:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLLO5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 09:57:17 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E30C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 06:56:37 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t6so6252051plq.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wWwJ669lTeCpssXldT+YJE4GyoQKhiRX94niReA0gzI=;
        b=o5dfbjaG8jXLrBxlQ6Ax9TfOP6nZDGA4umNMXsiyq2Oe3Q4ktKt3aWYU56ZgIpKnco
         IJM7Y6/4oaEdUOw9qrw+D57xQ+O8kFYcdsfOVQbyb3kU8QlWojp2Z1UDPPfjYUhnPkNR
         0Z+C97P35JhJIMHm9BSCZR5Tq9y61KWKd4Ieyd69sy62qD5ahZRMXyVLHw3k55y9Hk+g
         29sznuz45RJUuIu1lByXkMYGkY7o/fermueh6q6xyMCdlD4GO4ssvrTaHGHd2tksIWw/
         Nbovy8bPRinNr6wVLm81nrWd9CnJuha++let3QpuWo4ZbpMB8FfMKgRHrxFTYDO/wfHf
         quqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wWwJ669lTeCpssXldT+YJE4GyoQKhiRX94niReA0gzI=;
        b=KI8LRF/k8hOtQoJzgtXh/xmIcCX3+adL2nbqkszuPQBGCqkgm0Xj7pm9Vtjznr7HBg
         Bd/npsSx6HYJml++XUB4IlnlcA2CfskBYbZ1ir1DcFI6U8DDUUQgQdKRv+dcw1d0Bg26
         ecyBrdyOumvqcLCoDSpurGbeDt5xsLbWjX7HP4dhyObBHg+lhcXebACvrqMCnJ04Xt//
         Uq5sso3sw7NDQVTeCjcNV+Ln58hqOtSRfXQokn7xz/Wp5rpB99XTtf6jgAlHihRKT5yU
         kvwvRGC+aFPvnNGwjYE/jeuc0Qk5P94RbQxC5ZZoSDNaJ+r/n/E/a4RB2gftlx7/9Yih
         MzgA==
X-Gm-Message-State: AOAM532CbSzZ+PlbBQrIzaVzNEsnkVzEFydIAR5yhisFwPlTtGAAcOhv
        VmkIzyef6Mv7hVcD9Rk8Hs6hHJp6GcoElA==
X-Google-Smtp-Source: ABdhPJwIQwJ4b2qAYQt5HsmV5nWvEGMjeR0Xl7sLwvLaQsHwazMfZrsMIRxw6+4ROB6RL+et6d1lrw==
X-Received: by 2002:a17:902:b213:b029:db:3a3e:d8ad with SMTP id t19-20020a170902b213b02900db3a3ed8admr15632490plr.73.1607784996476;
        Sat, 12 Dec 2020 06:56:36 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.87.107])
        by smtp.gmail.com with ESMTPSA id b11sm13769005pjl.41.2020.12.12.06.56.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Dec 2020 06:56:35 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, yongqiang.sun@amd.com,
        bindu.r@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH linux-next] drm/amd/display: Adding prototype for dccg21_update_dpp_dto()
Date:   Sat, 12 Dec 2020 20:26:24 +0530
Message-Id: <1607784984-4542-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_dccg.c:46:6:
warning: no previous prototype for 'dccg21_update_dpp_dto'
[-Wmissing-prototypes]

Adding prototype for dccg21_update_dpp_dto().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
index b7efa77..e44a374 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h
@@ -32,5 +32,6 @@ struct dccg *dccg21_create(
 	const struct dccg_shift *dccg_shift,
 	const struct dccg_mask *dccg_mask);
 
+void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk);
 
 #endif /* __DCN21_DCCG_H__ */
-- 
1.9.1

