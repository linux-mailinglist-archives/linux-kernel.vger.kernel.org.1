Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3229F552
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgJ2TeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgJ2TeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:05 -0400
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B3D206DD;
        Thu, 29 Oct 2020 19:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604000044;
        bh=xL+Gnck9VFRvxvL3DC04fY1wTSerF+05uVp6J9Hxtyk=;
        h=From:To:Cc:Subject:Date:From;
        b=xViRp2ByKawZp2fS3ncCYY05ajudBnsp0GnpWzS4+eEfiofZkqpmpbuFpJE3UkB43
         adcIV+u0gLDdtzuXuK8pQtINuXLlDGXIw85Irh9BOxzB0viF1gmr+7HDxCSQGrqs9l
         WT4FHZzKfOoSS8S/t3/7huiu+Ra0ooiB7DlRM6EY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] memory: pl353-smc: fix compile test on !ARM_AMBA
Date:   Thu, 29 Oct 2020 20:33:57 +0100
Message-Id: <20201029193357.389593-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pl353-smc driver uses module_amba_driver so it has a build
dependency on CONFIG_ARM_AMBA:

    /usr/bin/arm-linux-gnueabi-ld: drivers/memory/pl353-smc.o: in function `pl353_smc_driver_init':
    pl353-smc.c:(.init.text+0x10): undefined reference to `amba_driver_register'

However it still can be compile tested on platforms other than ARM,
which in practice is limited to those selecting ARM_AMBA (so only
ARM64).

Reported-by: kernel test robot <lkp@intel.com>
Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 00e013b14703..eebd2ddcd860 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -191,8 +191,8 @@ config DA8XX_DDRCTL
 config PL353_SMC
 	tristate "ARM PL35X Static Memory Controller(SMC) driver"
 	default y if ARM
-	depends on ARM
-	depends on ARM_AMBA || COMPILE_TEST
+	depends on ARM || COMPILE_TEST
+	depends on ARM_AMBA
 	help
 	  This driver is for the ARM PL351/PL353 Static Memory
 	  Controller(SMC) module.
-- 
2.25.1

