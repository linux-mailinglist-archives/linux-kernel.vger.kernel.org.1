Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95839268D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgINOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgINOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:21:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:21:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so18962204wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouLLBB71MhyAg7cMX0BP37uhOtAVXyfejLB2F4clRRw=;
        b=jrgwn5mu2PMzca842yB4ncq2yiMP4FsMcmYN2CJ977wDsSuwJt8QmFLdii/PI+3JWF
         k3AOsTo2++2Xnfd5FfA0TZBia2mkZpJJDA9PVCp+3NvkfAwTcTCQXMickGcwnyXkoxD8
         mcjG/8nKgvZWoGrIr1g3ey1m2BD6lDCaWqrDKBi5XVApic5oPQYZwUlEvLb17c6y8ICX
         lWaBGmI0Ok5KMYlLCg8wYyrIEEXtAKlHbKr7UPKhbIST0J2Le4BVfeLjSjn9jyGI+NoN
         Y2Hm39O/FhfLmsfaxPCrrvUxq3QTnLnTAt6I9K1tR7NpQg04RH1AHVR2t5dfejbxYBl7
         Jkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouLLBB71MhyAg7cMX0BP37uhOtAVXyfejLB2F4clRRw=;
        b=un93JngfBnxaGhxNIbaJ1KJAJ6I2tdX4CVGzlgWeHvxHkVfZxhE94Nn3KtvmxUi+oW
         09PonJdgsjkvDeN4tgzR6uUXj73cRfivqHTbPiE68vZAWNvrQnF4GJy/CRMgHyd0JF7W
         PcuJYwJGxon/wrxP+pgqPibPWobnSYh6UlkYNv/xYmECHlFZnaq16tukvp3xKVkg1pHW
         6krE94Q/RdrgNRGR+WyCNtIuHNrK6m3BQv6hTyDYuEOA7Nh3WIgXb4LP/GjOAgIH8eAU
         2MITI6CaghvgEP6652P/swUVrHkop74PdgnV02pT/JADt1bmIMTtvhrh03gpjWY4BAKJ
         +n4A==
X-Gm-Message-State: AOAM530rdbki6ir4/9oBLIWMNVwlOUBf9pAcheVP1xHiUu/AHMyYnyQY
        ilppFsVkYPb+SoHvEnaG3IU=
X-Google-Smtp-Source: ABdhPJyBkeH639gpmxUu4EBk1c5TfnFJ/18t5q/8xof1GxQyUirG+AKeMaPlVO28GPbsBSMakadMXg==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr16039892wrl.127.1600093281468;
        Mon, 14 Sep 2020 07:21:21 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id b187sm19192697wmb.8.2020.09.14.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:21:20 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     nsekhar@ti.com
Cc:     geert+renesas@glider.be, bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] ARM: davinci: fix kconfig dependency warning when !GPIOLIB
Date:   Mon, 14 Sep 2020 17:19:55 +0300
Message-Id: <20200914141954.337859-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MACH_DAVINCI_DA830_EVM is enabled and GPIOLIB is disabled, it results
in the following Kbuild warning:

WARNING: unmet direct dependencies detected for GPIO_PCF857X
  Depends on [n]: GPIOLIB [=n] && I2C [=y]
  Selected by [y]:
  - MACH_DAVINCI_DA830_EVM [=y] && ARCH_DAVINCI [=y] && ARCH_DAVINCI_DA830 [=y] && I2C [=y]

The reason is that MACH_DAVINCI_DA830_EVM selects GPIO_PCF857X without
depending on or selecting GPIOLIB while GPIO_PCF857X is subordinate to
GPIOLIB.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: 77316f057526 ("davinci: DA830/OMAP-L137 EVM: use runtime detection for UI card")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 arch/arm/mach-davinci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index e0cbcda6f087..3a6307d85828 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -130,6 +130,7 @@ config MACH_DAVINCI_DA830_EVM
 	bool "TI DA830/OMAP-L137/AM17x Reference Platform"
 	default ARCH_DAVINCI_DA830
 	depends on ARCH_DAVINCI_DA830
+	select GPIOLIB if I2C
 	select GPIO_PCF857X if I2C
 	help
 	  Say Y here to select the TI DA830/OMAP-L137/AM17x Evaluation Module.
-- 
2.25.1

