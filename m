Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECD123E138
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 20:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgHFSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 14:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgHFSXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:23:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79F8722D2C;
        Thu,  6 Aug 2020 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738139;
        bh=owgygttJoaXudGgUle7hLKq1gI0hpguByw/gxau5EAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pncnbxRS1YGYxt5bbAaV7uBIk0K2zEZ5T7EBjSFe25aAcC8Vb0JYpISWHBN3IpNCW
         oYnKChADpbr5IMtWx4MKAJMVjfGvF4PB67Cooqq9YZiEzQFIEWib+zEJLW8HXza4ki
         KQqoD3mm9rjQrMJZReiQ4t5XcnGJXqwFyHaw3XLE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/41] ARM: samsung: don't build plat/pm-common for Exynos
Date:   Thu,  6 Aug 2020 20:20:27 +0200
Message-Id: <20200806182059.2431-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This file has not had any callers since linux-4.7, so
stop building it.

Fixes: 5901f4c279f7 ("ARM: EXYNOS: Remove SROM related register settings from mach-exynos")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/plat-samsung/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index ce339a96fbf7..d8a80fbcebb3 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_GPIO_SAMSUNG)     += gpio-samsung.o
 # PM support
 
 obj-$(CONFIG_PM_SLEEP)		+= pm-common.o
-obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm-common.o
 obj-$(CONFIG_SAMSUNG_PM)	+= pm.o
 obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
-- 
2.17.1

