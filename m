Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24442F4DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbhAMOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbhAMOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90369C061344
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w5so2387203wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AKZe0pvPLHu3x895juPn/Z4GbXtcqzxxje+6pz86KU=;
        b=MweOdz1mBiZ3YANYAenthalC1RAZ2L7YBzcfY2mxwBScLf0FZ7dfPLhGVCYJ3wStLt
         C3s1vvBrFa415Wr1aCWWYyc6yuvzFexaNiSTEv/rsPJ+qSMCxbo/gkIkbK6PkL7+YYiN
         j4X4qJFw6IVfKE3+eKxdcIPKq3uf/B3BN8WWKumhwaTV44EooXi7ZrrsGRMN/hPU9R9g
         aM2d+N3S2d8PdXVSrkZFhnz4GytrdOwPuh2vbjAk7nR/Um1bObWFqsibjGktJZnkTX2+
         LSnF9sH+yRTO8ixzJlE682O8bs4obJ1NQRctXzq69GkYjy20O7QmRaSjmdm9hW95TO4e
         51pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AKZe0pvPLHu3x895juPn/Z4GbXtcqzxxje+6pz86KU=;
        b=UWuoMu4zrk1gpfmbTEGi15ZzucbiW3JVkmzzGlhDMt8VR1JOWha+bjRIHGbD2hctly
         FSToy6sW7rT4XYsdzl8nN5wSQNEZk7pUornqphNg0wG1C+QhJzxfosFOQV9bvQNG4kDi
         o+O1x+m8DcFWpLTIpcIL8cSzqHJcQyPnvNG9olgioJrWkuTGknuJ4YdZ8QElV1EdOLqD
         7qqrTw6oW1/+o2RR3Nyz7cxHUyw2kd8u/9onv9qL8LNMi9xuhWolBLCXvCa1s25jA48s
         iSwCxWlLH9CaEtjK/mFyv712uv2u8m3V4LIQovljNu6OvHLxUy04GVdBNpMbspmFLSBp
         bKPw==
X-Gm-Message-State: AOAM531D4NgraeWWMrwUmrFlteIx00UpnjbsyH+ixjL8Om98mWGwcvkN
        vl/qetzmyD4jyZXDvEk21oziLQ==
X-Google-Smtp-Source: ABdhPJw5rVCSN67wNU6TdCizFMPeOQwAc4JEScwBmwUscxQjY1orEkpeVLOPrWKc5N9q4Vjxl5enIA==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr3073602wrx.310.1610549443321;
        Wed, 13 Jan 2021 06:50:43 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, carter@compsci.bristol.ac.uk,
        William Rucklidge <wjr@cs.cornell.edu>,
        Jes Sorensen <jds@kom.auc.dk>,
        Emmanuel Marty <core@ggi-project.org>,
        Jakub Jelinek <jj@ultra.linux.cz>, Martin Mares <mj@ucw.cz>,
        Brad Douglas <brad@neruo.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 20/31] video: fbdev: core: fbcon: Mark 'pending' as __maybe_unused
Date:   Wed, 13 Jan 2021 14:49:58 +0000
Message-Id: <20210113145009.1272040-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pending' is only used if FBCONDEBUG is defined.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/core/fbcon.c: In function ‘fbcon_exit’:
 drivers/video/fbdev/core/fbcon.c:3295:7: warning: variable ‘pending’ set but not used [-Wunused-but-set-variable]

Cc: carter@compsci.bristol.ac.uk
Cc: William Rucklidge <wjr@cs.cornell.edu>
Cc: Jes Sorensen <jds@kom.auc.dk>
Cc: Emmanuel Marty <core@ggi-project.org>
Cc: Jakub Jelinek <jj@ultra.linux.cz>
Cc: Martin Mares <mj@ucw.cz>
Cc: Brad Douglas <brad@neruo.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bf61598bf1c39..f3d628fd07dc1 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3292,7 +3292,7 @@ static void fbcon_exit(void)
 #endif
 
 	for_each_registered_fb(i) {
-		int pending = 0;
+		int __maybe_unused pending = 0;
 
 		mapped = 0;
 		info = registered_fb[i];
-- 
2.25.1

