Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3582A8187
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgKEOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbgKEOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:39 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93108C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:35 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so1868184wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lzr2LZKkjeyh+0gXSjtszqjFcxymZo2/y4TJCmeBIoM=;
        b=swOlcuLUwLVsy5H0kZyJDIny5wOGPi4N36T5qjg/xyiN0ZRy/TR+lqUsJM/dksU6HV
         LRpj6JmHpaFZLKcgMPDDw95n0IWR1MQOO2UN4udOERsKfNg+qKMRbef8h/Pk7Rynqb7V
         ldZWi/RBJgzaXFam5OkPaWd/9Pwh0fjVkAQUZXoJcfL+6QR7ox+/FUSwFYJFBdzfrkjj
         d/tw9iWv6GAE0cL9vwkWbzs2WnsflB5dzqlm0JCj4kUOPF2Fww1gU8Deb9SxCMD/EAuZ
         n92AkxxE100PUWDbNbdgYLDNmHqxg7zOBJoYqfDD+QWhk5y+EVgYOUJorOQBpC2tRFUz
         sRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lzr2LZKkjeyh+0gXSjtszqjFcxymZo2/y4TJCmeBIoM=;
        b=bLrf6Eg4L8VgMvPRQwitkGY9RC8DbzWSAx6lGedxOZhHiGrj7RXzs9PAAgWH1EKltq
         lp9PtFUDH8sAgmdjE/bJNKRQ6aC7JTMXKcEYh4o/i5CBKExq0mtwdH9y5EbUIngcl+qp
         xtvRw7bb3EgDkYuVWNuuFEpshMx8YFiXf9EGeVS9NWOY/MD6NBWHigIXSWHICTUD4L02
         l7qajHzAbv4w24pj7uaQYLNql+q6KsnOaRUfsoFUAp+F4vYtdPr8CQflTqgulr1qezOh
         1y6J68fXm6yYMyi5usxTvnuTimaEh5CF358RdOGewSFeU4Co0t4MEkME756bRVWZ5RR0
         oDUw==
X-Gm-Message-State: AOAM531oSzplBZCvU/QY70ciEqTDTc2YTlbjVsLOLlk/41Twex35RjMf
        Qb/8rHC6f9Zr5x+PJCvH7PfG1w==
X-Google-Smtp-Source: ABdhPJwEQdQy1KXngQ0iziaR9HkA2R0NAcKEAYFhCBRARBNNh5ssNJoyNlHhkkm7K6yluAbMvU79zQ==
X-Received: by 2002:a1c:5f45:: with SMTP id t66mr3197691wmb.20.1604587954367;
        Thu, 05 Nov 2020 06:52:34 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 16/19] gpu: drm: panel: panel-ilitek-ili9322: Demote non-conformant kernel-doc header
Date:   Thu,  5 Nov 2020 14:45:14 +0000
Message-Id: <20201105144517.1826692-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_THROUGH' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_ALIGNED' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_DUMMY_320X240' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_DUMMY_360X240' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_DISABLED_1' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_PRGB_THROUGH' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_PRGB_ALIGNED' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_YUV_640X320_YCBCR' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_YUV_720X360_YCBCR' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_DISABLED_2' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_ITU_R_BT656_720X360_YCBCR' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_ITU_R_BT656_640X320_YCBCR' not described in enum 'ili9322_input'
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_UNKNOWN' not described in enum 'ili9322_input'

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
index 074e18559b9f6..8e84df9a0033d 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
@@ -152,7 +152,7 @@
 #define ILI9322_GAMMA_7			0x16
 #define ILI9322_GAMMA_8			0x17
 
-/**
+/*
  * enum ili9322_input - the format of the incoming signal to the panel
  *
  * The panel can be connected to various input streams and four of them can
-- 
2.25.1

