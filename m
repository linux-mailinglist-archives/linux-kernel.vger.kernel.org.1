Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA3231D21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgG2LDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgG2LCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:02:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B5DC0619D9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:02:52 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k13so12802061lfo.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FyosKiUG1TEw/awaC9dtkQGLFQT+7T/cshoI2oy7Wsk=;
        b=Bm9FpQwJkxa0g3btzp9YwxLVyI5W3BkWDQ9/hNloBuojKm6pp+k5TaHmeRe7YubDPj
         3Lkh6IN8F6YwHAVK383LGm2196M9bjOnBJFiYaWXvBvchtmjyZH5WroS5B0mxa+oli97
         jW4fswZouyyugZFUTNJ1DnjX/mrRI3dpd4TmMnObbiDDLUPjNHTB4Jj4hrUxos2ZN646
         bXykKbRrIrtnGycLbU9GJhBuxl3QmuFPL8D4LG5ELAxNXiIg/Gnr2xe7ygPyAtzDi99e
         Qz1HYbHaP2Uw9TmuOGeHmnJlPNPAzdl2kR4dk+1uYyCMfyMlYySd35uUCzpvawtKZq4Z
         vdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FyosKiUG1TEw/awaC9dtkQGLFQT+7T/cshoI2oy7Wsk=;
        b=l0H8+tVIMFNFztf6YHbwmzgoC77EOPnW6W8wLDT6WFn9Y7hxgmXWCcDR18330i/e/k
         mSztVC8I6C7ddAnTqBKKJBpQu+zVNoMXtNPfCTKFbrpjc66Hr+8D5tVARqsbRzdC3nO0
         /MOO4YMCMKHzi0UQuso7M6bP7EP8T1ToxQFyxeyPNqA+xP0EyjFbROideIxTN31DGdz/
         s20kW6wpni7IQmWSRhJik45pnjsEsm4FiZjo9GPMab4AVEe0LKFNEcnQdHrLXlrBcl5Q
         Cmk0JhxrxpJGKgWI1EglOSb9xE/dMDVvkEn2NobAFaQSbE1I6KOICTGwSleg1pd5CxEs
         W4Hw==
X-Gm-Message-State: AOAM533MdnnPotFTRH5KsmEKijkxoYEI2InMqUrh74VGRZXl8i1/eTzB
        ha0/WQN68aunXydQ8sHY/6dfVw==
X-Google-Smtp-Source: ABdhPJzIl8kWXfg0hf4axvRV+gDifot4zuMszXOeHVllnjKTGt3enXvKU4Nyo9QkAKo6Wtokwazgew==
X-Received: by 2002:a19:228a:: with SMTP id i132mr17056699lfi.178.1596020571254;
        Wed, 29 Jul 2020 04:02:51 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id e12sm329283ljk.74.2020.07.29.04.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 04:02:50 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ssantosh@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, santosh.shilimkar@oracle.com,
        robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wmills@ti.com, praneeth@ti.com, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 5/6] soc: ti: pruss: Add support for PRU-ICSS subsystems on 66AK2G SoC
Date:   Wed, 29 Jul 2020 13:02:07 +0200
Message-Id: <1596020528-19510-6-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596020528-19510-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1596020528-19510-1-git-send-email-grzegorz.jaszczyk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The 66AK2G SoC supports two PRU-ICSS instances, named PRUSS0 and PRUSS1,
each of which has two PRU processor cores. The two PRU-ICSS instances
are identical to each other with few minor SoC integration differences,
and are very similar to the PRU-ICSS1 of AM57xx/AM43xx. The Shared Data
RAM size is larger and the number of interrupts coming into MPU INTC
is like the instances on AM437x. There are also few other differences
attributing to integration in Keystone architecture (like no SYSCFG
register or PRCM handshake protocols). Other IP level differences
include different constant table, differences in system event interrupt
input sources etc. They also do not have a programmable module reset
line like those present on AM33xx/AM43xx SoCs. The modules are reset
just like any other IP with the SoC's global cold/warm resets.

The existing PRUSS platform driver has been enhanced to support these
66AK2G PRU-ICSS instances through new 66AK2G specific compatible for
properly probing and booting all the different PRU cores in each
PRU-ICSS processor subsystem. A build dependency with ARCH_KEYSTONE
is added to enable the driver to be built in K2G-only configuration.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 drivers/soc/ti/Kconfig | 2 +-
 drivers/soc/ti/pruss.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 99dbc14..c290343 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -103,7 +103,7 @@ config TI_K3_SOCINFO
 
 config TI_PRUSS
 	tristate "TI PRU-ICSS Subsystem Platform drivers"
-	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX
+	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE
 	select MFD_SYSCON
 	help
 	  TI PRU-ICSS Subsystem platform specific support.
diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 5df4caa..d5f128e 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -162,6 +162,7 @@ static const struct of_device_id pruss_of_match[] = {
 	{ .compatible = "ti,am4376-pruss0", .data = &am437x_pruss0_data, },
 	{ .compatible = "ti,am4376-pruss1", .data = &am437x_pruss1_data, },
 	{ .compatible = "ti,am5728-pruss" },
+	{ .compatible = "ti,k2g-pruss" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pruss_of_match);
-- 
2.7.4

