Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC72F4C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbhAMNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbhAMNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:51:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD8C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:50:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i9so2208058wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvT+2CTfKbHCHIxTXmD+DKXWE8FcgOY0OyqMKXLif8Q=;
        b=NKUIMcSrJVLhOs83499n0cgM2auXTaw3V0wMCpbP6nahPLsfkAPGyoyFNXRG9v4Nsn
         ikZjMacmCsbVlSXqzqw7YCzLe3NEXA5pvt+0sTC0Uo4RLV/bPoGczi/L2sWLBAJAMKUO
         S7pQyxfXo/popuIGMo5lZ4TZTZhLrAE7MFZik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvT+2CTfKbHCHIxTXmD+DKXWE8FcgOY0OyqMKXLif8Q=;
        b=WJG4qVGJ2cs6MxuCy7ot1AGaA5SXUp8ixjwIRg88uLGAsClrsZrfzCJ0tlSfb3lfAA
         gzXDI3RrYw8uH3dm69rplZfN1G9FL3/EnLUdz5b0la2vHnue/6+PK4xkNibPsfyiczT2
         ENMUzx14qnHFGmpZdtueCGpp+IYZfuCHr4T2EUBz9JFRcK0lWP0D0TPqmDYEODS12IbY
         IHHudxZfJOYLUWq9zzPfgloCTrV+nB/N1aoNNPoy5PZw0NM6WnmzS42uSC0eZkEDEKHX
         oMaBgqmsR7eorlsse0CGeTB+hufBWfsMoDBLT2CaQkuxUS394bbMtXa72kctS4nuSm2+
         RKIA==
X-Gm-Message-State: AOAM530ZFTwJSCoVbUhQwwkPUjEHv8vDL/nTcJKKvCXGTg6dg4j+EGvG
        2zcaiVPH14MiyknRvO6rKXCwj1ZdSRlH6rtG
X-Google-Smtp-Source: ABdhPJzN633ZtBb+JvWBQCilmzXbJKynfVTWxJR1N9WuCGxfKsOqVbeuxDt7n6vPl6QegJN9+Yzw/w==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr2694952wrt.287.1610545821657;
        Wed, 13 Jan 2021 05:50:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u17sm3011205wmj.35.2021.01.13.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 05:50:21 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 2/2] bdi: Use might_alloc()
Date:   Wed, 13 Jan 2021 14:50:09 +0100
Message-Id: <20210113135009.3606813-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113135009.3606813-1-daniel.vetter@ffwll.ch>
References: <20210113135009.3606813-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that my little helper has landed, use it more. On top of the
existing check this also uses lockdep through the fs_reclaim
annotations.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
--
v2: git add everything ... oops
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e33797579338..5666a0056580 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -580,7 +580,7 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 {
 	struct bdi_writeback *wb;
 
-	might_sleep_if(gfpflags_allow_blocking(gfp));
+	might_alloc(gfp);
 
 	if (!memcg_css->parent)
 		return &bdi->wb;
-- 
2.29.2

