Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9892ADF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbgKJTbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbgKJTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20232C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:40 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so10633717wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Cw+c1bijBRNEJBNcuwyoDPT+QgFeRvOvo7TvhybLeo=;
        b=PWC66NBKBqbAKeaPvh+fIwPsUTrr77JZ5lJi/VUiSXJz+i6RhEnKMMZYfcZ/G2UmHS
         a+YlBfDGygGt7q/35lioOB52huJFQ/4W9ARw4RzVniBughzQAP5QgMHLhRrq49dkGIZQ
         mrepcU/Fv2c8lxZAr8DKuEPWqETk1RPZplypE7HhSn+lhM5ghhYl6M7bZ4qm3m1/kyOX
         ZhiIum/62edwMQSW1uEp2T+OvozCXyvm6gkVMi+ecPlH/CDWgw/452hJo0RsadXjeS8O
         7o3rXLRHMKFP34+OMUWPe7ofQIIgEZYs93wyJzCrnPT1ezVxMW9/AgiXTgoXrIqC1yNL
         57Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Cw+c1bijBRNEJBNcuwyoDPT+QgFeRvOvo7TvhybLeo=;
        b=ZQTrzUm9gwc6VtyS+E8WlpVX/eyHfBvWg4ROjlp/II74yJRt7r0pXwHb+89CG4KRvn
         LfqgTYfLKoU9Th0CRKUqo5jbnFq/7dKv5muR/tA1WQcPnL3v8tFZ9vct3Ea5ppEihg3W
         nz+3HLCjc2bOzGJDVqVP5Rc632WSpfp/D+GAc+aWrx65ZHvGl8VfEM8ZsM6EMjY6wtER
         smxvoz0XEXsOALUWSVmsSGOAZ+F31ROs8PluCpKmk/4IAHpUAZdHjaBzRkF3fxhY2uzZ
         WbFf7450899pIK1v6gTeriikwG4/0A3xxx9YzPt3se8R8YHDSWqNBKYvzncs1FDIV5uB
         4TdQ==
X-Gm-Message-State: AOAM532mmdfrro1t1mW1fBUNowabV/jhNAtabgLzjOX4C6Sc0+jY9V39
        O7dGUrvTSB7q8BG6tCVF31vXsg==
X-Google-Smtp-Source: ABdhPJwObJNUH9bI5UnaQ5h1STq51/iqMrbw6I4FyP3eBEcoNXfxnJeJsn/CCHYRK5M0Re6eIDZ8gg==
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr25343044wrw.125.1605036698892;
        Tue, 10 Nov 2020 11:31:38 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/30] drm/radeon/evergreen_cs: Fix misnaming issues surrounding 'p' param
Date:   Tue, 10 Nov 2020 19:31:00 +0000
Message-Id: <20201110193112.988999-19-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/evergreen_cs.c:1026: warning: Function parameter or member 'p' not described in 'evergreen_cs_packet_parse_vline'
 drivers/gpu/drm/radeon/evergreen_cs.c:1026: warning: Excess function parameter 'parser' description in 'evergreen_cs_packet_parse_vline'
 drivers/gpu/drm/radeon/evergreen_cs.c:1095: warning: Function parameter or member 'p' not described in 'evergreen_cs_handle_reg'
 drivers/gpu/drm/radeon/evergreen_cs.c:1095: warning: Excess function parameter 'parser' description in 'evergreen_cs_handle_reg'
 drivers/gpu/drm/radeon/evergreen_cs.c:1757: warning: Function parameter or member 'p' not described in 'evergreen_is_safe_reg'
 drivers/gpu/drm/radeon/evergreen_cs.c:1757: warning: Excess function parameter 'parser' description in 'evergreen_is_safe_reg'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index c410cad28f19f..53b75cf201958 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -1015,7 +1015,7 @@ static int evergreen_cs_track_check(struct radeon_cs_parser *p)
 
 /**
  * evergreen_cs_packet_parse_vline() - parse userspace VLINE packet
- * @parser:		parser structure holding parsing context.
+ * @p:		parser structure holding parsing context.
  *
  * This is an Evergreen(+)-specific function for parsing VLINE packets.
  * Real work is done by r600_cs_common_vline_parse function.
@@ -1087,7 +1087,7 @@ static int evergreen_cs_parse_packet0(struct radeon_cs_parser *p,
 
 /**
  * evergreen_cs_handle_reg() - process registers that need special handling.
- * @parser: parser structure holding parsing context
+ * @p: parser structure holding parsing context
  * @reg: register we are testing
  * @idx: index into the cs buffer
  */
@@ -1747,7 +1747,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 
 /**
  * evergreen_is_safe_reg() - check if register is authorized or not
- * @parser: parser structure holding parsing context
+ * @p: parser structure holding parsing context
  * @reg: register we are testing
  *
  * This function will test against reg_safe_bm and return true
-- 
2.25.1

