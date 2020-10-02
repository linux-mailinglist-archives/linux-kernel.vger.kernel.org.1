Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B5280F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbgJBIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:35:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE10C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 01:35:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t17so801368wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICZkcERGPwITMiBHpXHw7j+8+AV94Q7APOnZgsUkBfo=;
        b=IMxU52erZh/xiOPhbLBpcxqKwtRZfXjweyO+UtYR4IJNnIe1f9eFihMm5Jcn41x3Gx
         RhJ4rWOXXvNiyZKuABKa9c9V8R8dy5RNWdm/ukovw/gG6hVed/YCL2hfKOgltUX8wNEn
         /LKdlaHs4z1D6ZkZ4ADpT5ebZcXyOZSBcRwQRORKBuq/6yl9f5fizWUYktEY7jT9wujV
         /cu/swC2jtq5/PH7/QXl3Bjzbid8DeWouQ6O4SyO4DXX0Xo5sldFGtC9xUC2MPfikbID
         PghylftdsKzOXWJEpwYXGUyIKCf0zra68EIEIUx+odRQKMhnZiTL9DzrpoadO6gMu8Qr
         OASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICZkcERGPwITMiBHpXHw7j+8+AV94Q7APOnZgsUkBfo=;
        b=BrL3itz2aQV6brLOIUIZAe2tbJeRP7k+LLeKgT074hEDLifqN7NmW/L+E8CnIYEoFh
         OI1y9dgB5VQ2BoLrGw/gMrrPxdFRMc8BhKvtHyfLV0dLnPANHVOIA8usnx6tqIHymHqI
         MPfCSb7Ktz9tguvIWTgSQDzq6DaqgZN8IUtFWf+SUJTOXnr2xAYdieBkJByAUk+bGibX
         EkQs02rv4Updb8kBJJQWgQK3P5YXi6Mm9c3w2Vn6PirK+JgThjWl9buV25ha8YC+F3Jl
         ambdzaH7LeW9x7TkP6bU4t5TF0HX6DcSYY71aBlalcmv/SduJ10PHxVDfCJ1wGFKwYTG
         cveA==
X-Gm-Message-State: AOAM530RLvW3CfgL3zit7iVLhHeyZE5hAWMlCjQhDFGdpuFrd0N8pC4f
        xYtrG1OzEB5ZvQ+Y9O9fhzs2Ng==
X-Google-Smtp-Source: ABdhPJyMXtkyJ9bmiNJZpb0GmN7b7aS3RFVcJ34mtyHwB5dqIXA9urSnyPVveYwF67X++jrg2uInuw==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr1598984wmi.30.1601627725544;
        Fri, 02 Oct 2020 01:35:25 -0700 (PDT)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id g12sm892386wro.89.2020.10.02.01.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 01:35:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/1] mfd: sl28cpld: Depend on I2C
Date:   Fri,  2 Oct 2020 09:35:00 +0100
Message-Id: <20201002083500.796843-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following randconfig build error:

 ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
 simple-mfd-i2c.c:(.text+0x48): undefined reference to `__devm_regmap_init_i2c'
 ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_driver_init':
 simple-mfd-i2c.c:(.init.text+0x14): undefined reference to `i2c_register_driver'
 ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_driver_exit':
 simple-mfd-i2c.c:(.exit.text+0xd): undefined reference to `i2c_del_driver'

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index bdf8cb962027b..8b99a13669bfc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1188,6 +1188,7 @@ config MFD_SIMPLE_MFD_I2C
 
 config MFD_SL28CPLD
 	tristate "Kontron sl28cpld Board Management Controller"
+	depends on I2C
 	select MFD_SIMPLE_MFD_I2C
 	help
 	  Say yes here to enable support for the Kontron sl28cpld board
-- 
2.25.1

