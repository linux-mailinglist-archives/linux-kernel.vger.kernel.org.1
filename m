Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE12F4DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbhAMOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbhAMOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E05C0617BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t30so2434643wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Pf7w6hja2pyQaiiphc9339t7wWdI+GqQadABJm8g7Y=;
        b=sst9frRzW/IJefwutBUvPoGyyHkMdmNCE2/2cJ1SvAob/HspH1X56uzjWNN7XPuilz
         wdKSM/9Hqj3XNtAA/hBuaE7G/g9i5BxwEMY6nf9eunFCXOpEAB+tkTQ53x6HPpg6jtJ5
         4/CwTTvIH5eIMy9CUXAYqkwetX52U5C8J5iXu+ftxRcgI6ioB4TaWFUZokVU0jMRv4go
         iVThPqkc16K5jm14VkBnPxRc0KOF1l7502J6ctNsR0SVyVrAujPyJcOPpNmjUaQa0T2D
         QXsr/aNolpDchgMH7vINY63kaYmkDnVOFM9EKwvSgcfdyGaw5+y6o1AKmnSdmQwT2uZv
         +w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Pf7w6hja2pyQaiiphc9339t7wWdI+GqQadABJm8g7Y=;
        b=sd9UMyNJIGUG4UXJWI4RJkD133scg39LHrl6I0ms+YjMSo2QpawygcUMCXzOuCnS/P
         i9OSugRbcRbY6ydNjVww2YClj4d368sc9HPVzlhf605J3Z7m+t3iIZa87wW21rTYL/ls
         MRnE5hy8bDqkfHXBaFeqBsKniup8AmNGjITJRIuWhgP7kNU/biUIjitMX2QYLDOHwFaI
         dr5Oj4rmf9crVrtKUogUNS/HJp4uUgto4skGA4ymRytf8YMdZM9h6VMietTB2YGofiCH
         juif5Ie5FTkLdJYsYAgeHjBMIhvC6bAN8KLudr+JB5ew1AfNipO7fYdVwK1CE8hv9088
         IROA==
X-Gm-Message-State: AOAM532HF+AbFSrdVsJGkwvl8P7eSOl3Z/f7R5IvIxsZ5TBQsMAVMxhC
        4wfdtvS4vYkmth2bAwlqBbMPUg==
X-Google-Smtp-Source: ABdhPJw7YBO0Y3mdZUBWXhnPmv13OWbKuieV4zDqiFanxqcxWiLlKLymFuWigA/Hr4jjfIkyPRZuxQ==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr3137113wro.338.1610549428139;
        Wed, 13 Jan 2021 06:50:28 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 09/31] video: fbdev: sis: Remove superfluous include of 'init.h'
Date:   Wed, 13 Jan 2021 14:49:47 +0000
Message-Id: <20210113145009.1272040-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither 'sis.h' nor any of its consumers uses these tables.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/sis/init.h:144:28: warning: ‘SiS_VGA_DAC’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:132:28: warning: ‘SiS_EGA_DAC’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:120:28: warning: ‘SiS_CGA_DAC’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:108:28: warning: ‘SiS_MDA_DAC’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:106:29: warning: ‘ModeIndex_310_2048x1536’ defined but not used [-Wunused-const-variable
 drivers/video/fbdev/sis/init.h:105:29: warning: ‘ModeIndex_300_2048x1536’ defined but not used [-Wunused-const-variable
 drivers/video/fbdev/sis/init.h:104:29: warning: ‘ModeIndex_1920x1440’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:103:29: warning: ‘ModeIndex_1920x1080’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:102:29: warning: ‘ModeIndex_1600x1200’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:101:29: warning: ‘ModeIndex_1680x1050’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:100:29: warning: ‘ModeIndex_1400x1050’ defined but not used [-Wunused-const-variable=]

NB: Snipped - there are 277 of these!

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/sis.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis.h b/drivers/video/fbdev/sis/sis.h
index 9f4c3093ccb36..d632f096083b3 100644
--- a/drivers/video/fbdev/sis/sis.h
+++ b/drivers/video/fbdev/sis/sis.h
@@ -15,7 +15,6 @@
 
 #include "vgatypes.h"
 #include "vstruct.h"
-#include "init.h"
 
 #define VER_MAJOR		1
 #define VER_MINOR		8
-- 
2.25.1

