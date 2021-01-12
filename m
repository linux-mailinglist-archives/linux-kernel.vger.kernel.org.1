Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99012F2F46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbhALMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbhALMkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:40:39 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70FCC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:39:58 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q20so1312298pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBDp91phFwOqELMFCCbzVy/QFbR85TB6s1l42soxBSY=;
        b=b1IQXfFfB0WqLgMwjzZGdFkvztWcaKORJDWjoEmti0F6f9d8++NhUYfbgiBmy+6VSy
         BkOHL1mGceNBDNFJsFxx95rD6H4vx22vjHvQooT45K8HtMeSDlZTeIwkHBcuXOXXspc8
         jo6o7kBu88nzB6Hp4up09uW/MS0JXY1iqQNuOErl3nSwKV9Qf32edh+CXAEd7Z4IGXxZ
         XVrFoT6Fgz+pC3y8HZ7E1UgZb6JFHVM/+wPbf617FL50kmTUYHOIm3fa5/I4cMB8KO8Z
         pf8Xq7BvC7WNGEiAUdUESkkF7ILUhasfus5R2iLvHB4wIUMSeg799YCwvt6KqNgnoVo+
         +WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBDp91phFwOqELMFCCbzVy/QFbR85TB6s1l42soxBSY=;
        b=X3VtqpOnB0KlPnrYcnGfNMSSHkxGOyGfRTkkh3SJSRGVVZgdhDL5DshKbyqUwvA6Fg
         BtXNU6HhuqOyMpvBLXDZ2EZOh3S7ZGIJBz9vzEBacN57vbzYDnhMIpHh8KTcsQG34WO/
         zlVi0XYOCnwqbGXIkCllVxLnciTSG/MgOH0gh5eiI/ssL10miWM5iktGqRbdS9uqQwFs
         oSQ6ii3R6bGG/RBVKJi7lZDoT7JJWdWHNCXThVHXywZSCCgNQnuGbQIBfAIAnMDcINZ0
         cl87PdRNEUpuoBu24sPiNKaAWCuEDhiqHQdFzQ5wqr4QcVbbKXkpb0dFlsBZXLgGyPdN
         Wt8Q==
X-Gm-Message-State: AOAM532IkEB7pHEUvUzZITu22M8XVTUqLSyHN/a57Xd1oKjE0o0CG6WX
        rYd0SBcRDfRvteL+kUKcm7zOlzix5MA=
X-Google-Smtp-Source: ABdhPJxIyn0FELzOGmkw/2AhUmHkIrHXcb5e7Bq3inEYDGpjU+/yDl/NZqv2duTD9S9oOdG9GrZ5Ow==
X-Received: by 2002:a62:e818:0:b029:19e:31e6:e639 with SMTP id c24-20020a62e8180000b029019e31e6e639mr4381641pfi.81.1610455197933;
        Tue, 12 Jan 2021 04:39:57 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id o129sm3011166pfg.66.2021.01.12.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 04:39:57 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Gabriel Somlo <gsomlo@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>
Subject: [PATCH] soc: litex: Fix compile warning when device tree is not configured
Date:   Tue, 12 Jan 2021 21:39:37 +0900
Message-Id: <20210112123937.2612937-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test robot reported:

   drivers/soc/litex/litex_soc_ctrl.c:143:34: warning: unused variable 'litex_soc_ctrl_of_match' [-Wunused-const-variable]
   static const struct of_device_id litex_soc_ctrl_of_match[] = {
                                    ^
   1 warning generated.

As per the random config device tree is not configured causing the
litex_soc_ctrl_of_match match list to not be used.  This would usually
mean that we cannot even use this driver as it depends on device tree,
but as we also have COMPILE_TEST configured we allow it.

Fix the warning by surrounding the unused variable with an ifdef
CONFIG_OF.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 drivers/soc/litex/litex_soc_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 1217cafdfd4d..9b0766384570 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -140,12 +140,13 @@ struct litex_soc_ctrl_device {
 	void __iomem *base;
 };
 
+#ifdef CONFIG_OF
 static const struct of_device_id litex_soc_ctrl_of_match[] = {
 	{.compatible = "litex,soc-controller"},
 	{},
 };
-
 MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
+#endif /* CONFIG_OF */
 
 static int litex_soc_ctrl_probe(struct platform_device *pdev)
 {
-- 
2.26.2

