Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEE2F4DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbhAMOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbhAMOvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD91C061386
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r4so1843179wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hcCYDUMcS26jDuM5+gRx+fiSHXa/31pKXfkIX189fZc=;
        b=WKJOrwZ97W06sGNe/8643fsBAhUrIy3pw+p8/Z4nnVsXP2eywnUTF/fuu6aqQ7IqnV
         6bqyAhBD4abY+s60Rl5IZigMaAmPXz8Uw2c1DpBJK4PQxmaJxmh9tA+R2LxW1BhiiZTk
         yiuf3i9VtB5gHvfNiYKnHs1w8ffM0OURr8SS6DOOcwdI/uLEYMkd3eiV0TcMkLorYNz2
         63JkGhf4cM01/SzrmAxd+HQf+HPnQA/eQoOZlRp6Lb9kAQGSlV4OiRy91CNfm/Ap5ieG
         bufuyVkbrh7vj7Mtxphu1YXK2MYICuU0icBn09Vb30KwCkk8oOWznjZavOmb2Rr1w40u
         CRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hcCYDUMcS26jDuM5+gRx+fiSHXa/31pKXfkIX189fZc=;
        b=hBwALFqsiY4DqAd6fQfRYLhQkQ7AbuROcWmp1dBq2TVFOlCl/xci5WA8eXw8q5Tj8f
         pORodOWmijdPYHm99tGN9CXl4OlCG8v3ZD0XCk0l3M4PgCbARpumgzJz+9nnPOoUu7ln
         eYMO31V5k094ccIAe5v74GYtU+dYd0/iKWmZJmRwS9x+RBmqsmgRQa8CLl5jnVpeU5y2
         NH3zP97pi1ybHUZc316qkx7YxEp19rj+HW44Tjxr/ui5jEj1cS7MWVZ6q5FAWdaRzB/L
         lqvv4V6VLMY5ilCz4CzDwnUaP976GgDrJyZbmX6s/lcP6x0+w7jqAZwr5iWN2XMdfrHV
         XMqg==
X-Gm-Message-State: AOAM530qlktCLmXT91e+Ef2UQK5v00Z3qYFsLHkIIMk0DZwXn8JJ7aog
        igl6xpPm5Ti3gbsP6WqeiGB1eQ==
X-Google-Smtp-Source: ABdhPJxI/06Eq2Rl5+qCibE+uAUvKG7ngE/AQ/AKyFAKVjTjbxsN6HN/O2nM7Z2/XWrJTZE0EwxiWQ==
X-Received: by 2002:a1c:2d92:: with SMTP id t140mr2585614wmt.114.1610549434915;
        Wed, 13 Jan 2021 06:50:34 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:34 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/31] video: fbdev: nvidia: nv_setup: Remove a couple of unused 'tmp' variables
Date:   Wed, 13 Jan 2021 14:49:51 +0000
Message-Id: <20210113145009.1272040-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/nvidia/nv_setup.c: In function ‘NVWriteAttr’:
 drivers/video/fbdev/nvidia/nv_setup.c:92:14: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/nvidia/nv_setup.c: In function ‘NVReadAttr’:
 drivers/video/fbdev/nvidia/nv_setup.c:104:14: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/nvidia/nv_setup.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
index 2fa68669613af..47a96a066f998 100644
--- a/drivers/video/fbdev/nvidia/nv_setup.c
+++ b/drivers/video/fbdev/nvidia/nv_setup.c
@@ -89,9 +89,7 @@ u8 NVReadSeq(struct nvidia_par *par, u8 index)
 }
 void NVWriteAttr(struct nvidia_par *par, u8 index, u8 value)
 {
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
+	VGA_RD08(par->PCIO, par->IOBase + 0x0a);
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
@@ -101,9 +99,7 @@ void NVWriteAttr(struct nvidia_par *par, u8 index, u8 value)
 }
 u8 NVReadAttr(struct nvidia_par *par, u8 index)
 {
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
+	VGA_RD08(par->PCIO, par->IOBase + 0x0a);
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
-- 
2.25.1

