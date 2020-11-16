Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16322B4D69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgKPRh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbgKPRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:26 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10ABC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:25 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so19596548wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2n5EAuxxaWf0Dm92MV4U7zHBQN4uYE06MkP3Ik/k8Q=;
        b=BnwVbJwRHIrWiSelgE8VUORGPDGET5j5wYZz3HQcFJYdlMvspKOuspFebmEah8Hjz6
         gr31bK0POXAE4z3LwjHafVrjp8+fYHxVWnm2p9z34efZ830IGvN9jlKtUbJcGYdha7En
         xZXaENA81gYhIFOEhMERcLgH3znBEyebE00yYVb1zJ6NnnNzRoWmik/7PBmcPfB1TaGn
         8j+nSptwK8yJ904NRY4L9MeSNKIm0mEVS8vfrkxgDP6BDDczdt9JbFF4myk3nh9Rh79S
         H+8NNQZYtlq81stY+zFgFh3rmhvPAnYDZ93qgC1jbZDxICbEWjNQbSlwg0FLj0ak9QwW
         iK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2n5EAuxxaWf0Dm92MV4U7zHBQN4uYE06MkP3Ik/k8Q=;
        b=ctHakwxc0UD9F6KJfP/rKTceeZR86b+Bk3iahhGYY7PUnwVS72dPuXOOw4qN0MJKeG
         MgERylIBL/mggwcArDV734sC8qgE1FR4zks4DfEnZiJQ6FY/KCDc2eGbe/FKcMJnoMpx
         w7P7+DUjYUYWuv3EbEYsW4AjOMlKwLQm97EFpY8ZcY5/w5ZL3CvBUWxKTvEci8avxb2I
         4kGkMupOwlcJm71McVf5aiFeD1pd5VVx7Uy1JnEpgPI6rBz3TPiYALXRK3jVqQ7wjlru
         ew4qKB5/XCWruCCY9JoR2b+fhPqUlcWVK8LAaKoic1lavDKAKHmpMvK22rDQ2lxhW801
         v+gg==
X-Gm-Message-State: AOAM531cxJC/2rEhTWUAcLCaS/jUYY5+HNLg8LHgfLiJ+p/z1c20jpSG
        puD5JJEGiJ7kdgIkZBUtjXZ2nQ==
X-Google-Smtp-Source: ABdhPJxvANXM3aKchSP4W3dRVCrfAA1T8q3gatRW71Sh24RLgAx9VaHVKFdu4fZkQBtH1WN6XZq8UA==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr20526445wru.49.1605548244607;
        Mon, 16 Nov 2020 09:37:24 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 15/43] drm/radeon/atom: Move 'radeon_atom_hw_i2c_*()'s prototypes into shared header
Date:   Mon, 16 Nov 2020 17:36:32 +0000
Message-Id: <20201116173700.1830487-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/atombios_i2c.c:100:5: warning: no previous prototype for ‘radeon_atom_hw_i2c_xfer’ [-Wmissing-prototypes]
 100 | int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
 | ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/atombios_i2c.c:150:5: warning: no previous prototype for ‘radeon_atom_hw_i2c_func’ [-Wmissing-prototypes]
 150 | u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap)
 | ^~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/atom.h       | 7 +++++++
 drivers/gpu/drm/radeon/radeon_i2c.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atom.h b/drivers/gpu/drm/radeon/atom.h
index 1bf06c91cd959..5de0563b63d2e 100644
--- a/drivers/gpu/drm/radeon/atom.h
+++ b/drivers/gpu/drm/radeon/atom.h
@@ -154,6 +154,13 @@ bool atom_parse_data_header(struct atom_context *ctx, int index, uint16_t *size,
 bool atom_parse_cmd_header(struct atom_context *ctx, int index,
 			   uint8_t *frev, uint8_t *crev);
 int atom_allocate_fb_scratch(struct atom_context *ctx);
+
+struct i2c_msg;
+struct i2c_adapter;
+int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
+			    struct i2c_msg *msgs, int num);
+u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap);
+
 #include "atom-types.h"
 #include "atombios.h"
 #include "ObjectID.h"
diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon/radeon_i2c.c
index aa61b3cb4049c..e543d993f73ee 100644
--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -34,10 +34,6 @@
 #include "radeon.h"
 #include "atom.h"
 
-extern int radeon_atom_hw_i2c_xfer(struct i2c_adapter *i2c_adap,
-				   struct i2c_msg *msgs, int num);
-extern u32 radeon_atom_hw_i2c_func(struct i2c_adapter *adap);
-
 bool radeon_ddc_probe(struct radeon_connector *radeon_connector, bool use_aux)
 {
 	u8 out = 0x0;
-- 
2.25.1

