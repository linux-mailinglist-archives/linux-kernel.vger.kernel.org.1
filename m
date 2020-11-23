Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F762C0458
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgKWLUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgKWLUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:07 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8589AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:06 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so17515121wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVQkRWnV9jg6+Ada1H2Ew94/golbusCXMuvb/nmCqqU=;
        b=tj5vDTXoZ7s7BPKmO/w/NnSIr9175PGoUapOPiOyTm9MIvdIVTwGlWFPjgvv6ccVwu
         BPNoyYf9q/lfk+xKsUamao8DV4+aNU8DZRD/W6KSeAxQd2jm5pb/K4oOwPmyXlyutKyw
         6jf5zucwL+kphS42Ud1rMc58qo/BM/kjXcGp2cOKoy+BOHyvMNfUKwWlG+uwWKogNljr
         J7edQrZj8GhEgIV4msgKIOWfO0B2hZkrK4NVEltL3QApq+hvQwih476iQyw08FtEyU9i
         rfeV1BdjA7rWMJcWEMP16O5ZnllwohZp31bhDl8WhtP6Jfkt3A70v4Pgi779K0P+UMtO
         IJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVQkRWnV9jg6+Ada1H2Ew94/golbusCXMuvb/nmCqqU=;
        b=toVHI7i/T/TWvDG9S14sQoA8PxI2DvTy0V2i0xkuTbb+NnHea2YQjibUV6UMnXN2ld
         Ter86lT9UvP2SX8Rymb5SLu2Y1MYeKi6zrRsgb2Y2/7TT1F8Hc1603phw1fVobhSE9xf
         I/kySjYNPMnLpPsMhtca2ILI1kFOTDF79owjwa205JY0uMPjPvazDTHPTRoIxP1ZjMZP
         OwAmvGopByzP6tqeRe7Qr0XHeSFxtw2MAaF3SwyMU85wEfLQiknbmlf5Yhmap1SbyXYw
         ND3iq/1ReL/rbpGOMeVNv7/ZExqdzM3G+Ttyl0CWzXQqc7Q4k2pr8tw3tT0WCNIiLZa+
         mFUQ==
X-Gm-Message-State: AOAM530xIULO/Uuv8MdjwVPvAIu/OKAExkROt5xta29pN9QxSxzkWoAD
        ydqwNIF+KsuOOG4A/IbjEhlyIg==
X-Google-Smtp-Source: ABdhPJzJTRphnS4m5QCyP59RQ8emH9hrAl6jgmA4rnoY67SeHNnqPkBKDiNGxhkeGQXBc1q0SBqu5w==
X-Received: by 2002:a1c:2d47:: with SMTP id t68mr23427316wmt.148.1606130405294;
        Mon, 23 Nov 2020 03:20:05 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Tao Zhou <tao.zhou1@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 30/40] drm/amd/include/dimgrey_cavefish_ip_offset: Mark top-level IP_BASE as __maybe_unused
Date:   Mon, 23 Nov 2020 11:19:09 +0000
Message-Id: <20201123111919.233376-31-lee.jones@linaro.org>
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

In file included from drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c:28:
drivers/gpu/drm/amd/amdgpu/../include/dimgrey_cavefish_ip_offset.h:151:29: warning: ‘UMC_BASE’ defined but not used [-Wunused-const-variable=]
151 | static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0, 0 } },
| ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/dimgrey_cavefish_ip_offset.h:81:29: warning: ‘FUSE_BASE’ defined but not used [-Wunused-const-variable=]
81 | static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0, 0 } },
| ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../include/dimgrey_cavefish_ip_offset.h:74:29: warning: ‘DPCS_BASE’ defined but not used [-Wunused-const-variable=]
74 | static const struct IP_BASE DPCS_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
| ^~~~~~~~~

NB: Snipped lots of these

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Jiansong Chen <Jiansong.Chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h b/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
index b41263de8a9b6..f84996a73de94 100644
--- a/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
@@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x02408C00, 0, 0, 0, 0 } },
-- 
2.25.1

