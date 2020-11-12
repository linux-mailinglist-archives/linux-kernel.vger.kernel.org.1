Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784912B036B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgKLLEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgKLLCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:02:21 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C6CC061A04
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:02:21 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so5550351wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYWVqLY7S/76cWfEGdUmj7rrU+UasLzWnb4c5U8gOxE=;
        b=FgtdmpwRrYsOn8FUB6Hpe4ElccdLfhBVC2lRp8Urqj16+B+T7tXk0ftLggcVea+k/9
         kVtlIgJ6EmASjM5YMA9fShkGvjbb02+DqpQzJI9cKIsHwyhJ+OzMZg9A6GQmMwaw/s5l
         6Y/n8AlPUlcwj8qkQXt3v2yIGNzRyfaDvTFTvJHCh5/EUjyaVRt16voCY1nEEVrLtHnu
         fs09xCf/l9CPRADbvxCSJv0Oc06iM88odOaY9rvrDzGMP3NV6BFkf2Rr23JswoIttinf
         ynccuJ7ur86ricWzBi2VmX9vehCGi7N8QVIxGHzJzOn6o2MtA9ZMQb9qwl4lAgCljwyL
         MDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYWVqLY7S/76cWfEGdUmj7rrU+UasLzWnb4c5U8gOxE=;
        b=Y4n2MDe5AiNftGjhw89d7Uw2EBP9XK8Zr6bMv2qJJScqE2LdRc1PEjXl3U9axaiYgY
         8aJECsVCwlhNFJZjb8/LxTgHEKDNiElyj2JvaDejLrFekk/JCmK5JMC5LQdz1QfZO7BM
         fMW8g8cETc8/O1wHJiy4PWGlukJ9fZzslxgR2bgLFV07aAg1pAIWy2ToG0GtbHRxuUfM
         fKTVz7tzX0q1cwKGF+hgqWF4JZLc0ko5Mi5s8rbB4X0Mxkb7B3tEPBhij5XvujetGJPK
         ZhrR0Xy1WbPSskqEw/ZtOrMw91gc4aaMWMkpxZH8gKpIH+TM51G1soi3iTmr9Tpw59Tj
         drTg==
X-Gm-Message-State: AOAM532nYs/Y35GF6U95MVDjG816sQ8td+s2j94tFiFAR+wFd7lAn/Ob
        DHb/BMvSAivyQO1wxrWLQsi0nahhANbkoEer
X-Google-Smtp-Source: ABdhPJzsfgHXHWLswyYB1RNmQMzrGY50nkRCRdx70M8c5gZjLUnS+JHYkd6dWaToI58kESLJp+ye3g==
X-Received: by 2002:adf:8063:: with SMTP id 90mr21087244wrk.148.1605178939843;
        Thu, 12 Nov 2020 03:02:19 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id x81sm6515329wmg.5.2020.11.12.03.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:02:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        patches@opensource.cirrus.com, linux-input@vger.kernel.org
Subject: [PATCH 09/15] input: misc: wm831x-on: Source file headers are not good candidates for kernel-doc
Date:   Thu, 12 Nov 2020 11:01:58 +0000
Message-Id: <20201112110204.2083435-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112110204.2083435-1-lee.jones@linaro.org>
References: <20201112110204.2083435-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/misc/wm831x-on.c:30: warning: cannot understand function prototype: 'struct wm831x_on '

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@opensource.cirrus.com
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/wm831x-on.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 1b44de265a0ad..a42fe041b73c6 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -1,4 +1,4 @@
-/**
+/*
  * wm831x-on.c - WM831X ON pin driver
  *
  * Copyright (C) 2009 Wolfson Microelectronics plc
-- 
2.25.1

