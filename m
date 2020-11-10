Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF32ADF69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbgKJTbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbgKJTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:39 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00918C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:38 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so4362199wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sa4D9H3FopQ6FC9s62hXq/PcYKcafVSvMGNnPWttN0U=;
        b=bWEncwk9wr4hyGIAHgAfJ00TYqT033OOA+eahgRfxnsKrAZROWgGzK4sd1MmNS9oQh
         GvbtKa1pabul6vB72nEB1Z1XQjiEisZrnaYbvtUmksKjCeYfi3PX/VozLIBlVh4xq6UI
         +YjwyRORt6ZobT8cOQMaNz2JFglA/Ejzl9c68LomGj22IFWO/4Db/1SoszfAvaTa87qB
         oPBDIHnaFCRn1+y7xopvEOrQtiLc1NK2o6q5Dh8Q2zED+IdMw8r0K2GXUvtuDWRQl7kQ
         QYxR62UwnGQu9x4IsWiQgF9YKl27S1i+BEnsEIBco+s4+ATFiC8qmjqgffHlEHjAGSCc
         nrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sa4D9H3FopQ6FC9s62hXq/PcYKcafVSvMGNnPWttN0U=;
        b=NFsJu6S2H3Qe1xkPckuYDKFlrZbID+Bq6E/g/7AZfaw3to4EAeLzsLgwYzh1fQ4sT+
         p9LesuwOQ2zj8JURYTss6gJvsq5cUyogo8rKExucRId/FWaVjZCt/e6VPhzyhMXwZAop
         7YYB1OgF7rce5woL4YBXxwA/P/cEdhMmU/zpNzu1ISoRDbLShtGHJTJK8IQ0Z4UAlsWt
         /P4g/+daJErb+49EG2lVwD+yvX3+HGRSmqf4w6jWPpQ7c3K3QYnLNxbG+fLdiXUFJcD1
         o2nb/wPVoexngFzWgh466h2+klXOQJdYkI7wtK5tYUxUGluP1kNUDAjpuLwHn3PIzhVl
         nOTA==
X-Gm-Message-State: AOAM530aBrVixd3y5NpuB4ogtFYerF4I1SXqQnSO0iI26K7CzcDx9ELY
        8/KrWukoXksgWtQQaHGB7p24+A==
X-Google-Smtp-Source: ABdhPJxMzCyAB90AqZodmMsFV4EfQEGgS+LK3ffepxG/qIDXNCwgZsjcazcENDfW54TAA65US0X6Qw==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr754555wma.14.1605036697717;
        Tue, 10 Nov 2020 11:31:37 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/30] drm/radeon/r600_cs: Fix some doc-rot and supply missing function param docs
Date:   Tue, 10 Nov 2020 19:30:59 +0000
Message-Id: <20201110193112.988999-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/r600_cs.c:793: warning: Function parameter or member 'p' not described in 'r600_cs_packet_parse_vline'
 drivers/gpu/drm/radeon/r600_cs.c:793: warning: Excess function parameter 'parser' description in 'r600_cs_packet_parse_vline'
 drivers/gpu/drm/radeon/r600_cs.c:826: warning: Function parameter or member 'p' not described in 'r600_cs_common_vline_parse'
 drivers/gpu/drm/radeon/r600_cs.c:826: warning: Excess function parameter 'parser' description in 'r600_cs_common_vline_parse'
 drivers/gpu/drm/radeon/r600_cs.c:968: warning: Function parameter or member 'p' not described in 'r600_cs_check_reg'
 drivers/gpu/drm/radeon/r600_cs.c:968: warning: Excess function parameter 'parser' description in 'r600_cs_check_reg'
 drivers/gpu/drm/radeon/r600_cs.c:1473: warning: Function parameter or member 'base_offset' not described in 'r600_check_texture_resource'
 drivers/gpu/drm/radeon/r600_cs.c:1473: warning: Function parameter or member 'mip_offset' not described in 'r600_check_texture_resource'
 drivers/gpu/drm/radeon/r600_cs.c:1473: warning: Function parameter or member 'tiling_flags' not described in 'r600_check_texture_resource'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/r600_cs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 390a9621604ae..f20b619466816 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -782,7 +782,7 @@ static int r600_cs_track_check(struct radeon_cs_parser *p)
 
 /**
  * r600_cs_packet_parse_vline() - parse userspace VLINE packet
- * @parser:		parser structure holding parsing context.
+ * @p:		parser structure holding parsing context.
  *
  * This is an R600-specific function for parsing VLINE packets.
  * Real work is done by r600_cs_common_vline_parse function.
@@ -801,7 +801,7 @@ static int r600_cs_packet_parse_vline(struct radeon_cs_parser *p)
 
 /**
  * r600_cs_common_vline_parse() - common vline parser
- * @parser:		parser structure holding parsing context.
+ * @p:			parser structure holding parsing context.
  * @vline_start_end:    table of vline_start_end registers
  * @vline_status:       table of vline_status registers
  *
@@ -956,7 +956,7 @@ static int r600_cs_parse_packet0(struct radeon_cs_parser *p,
 
 /**
  * r600_cs_check_reg() - check if register is authorized or not
- * @parser: parser structure holding parsing context
+ * @p: parser structure holding parsing context
  * @reg: register we are testing
  * @idx: index into the cs buffer
  *
@@ -1460,6 +1460,9 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
  * @idx: index into the cs buffer
  * @texture: texture's bo structure
  * @mipmap: mipmap's bo structure
+ * @base_offset: base offset (used for error checking)
+ * @mip_offset: mip offset (used for error checking)
+ * @tiling_flags: tiling flags
  *
  * This function will check that the resource has valid field and that
  * the texture and mipmap bo object are big enough to cover this resource.
-- 
2.25.1

