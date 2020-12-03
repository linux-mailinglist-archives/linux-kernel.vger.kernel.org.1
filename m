Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562EE2CE22A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgLCWxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:53:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbgLCWxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:53:37 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Thor Thayer <thor.thayer@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: altera-sysmgr: Fix physical address storing more
Date:   Thu,  3 Dec 2020 23:52:48 +0100
Message-Id: <20201203225252.1476897-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent fix improved the way the resource gets passed to
the low-level accessors, but left one warning that appears
in configurations with a resource_size_t that is wider than
a pointer:

In file included from drivers/mfd/altera-sysmgr.c:19:
drivers/mfd/altera-sysmgr.c: In function 'sysmgr_probe':
drivers/mfd/altera-sysmgr.c:148:40: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  148 |   regmap = devm_regmap_init(dev, NULL, (void *)res->start,
      |                                        ^
include/linux/regmap.h:646:6: note: in definition of macro '__regmap_lockdep_wrapper'
  646 |   fn(__VA_ARGS__, &_key,     \
      |      ^~~~~~~~~~~
drivers/mfd/altera-sysmgr.c:148:12: note: in expansion of macro 'devm_regmap_init'
  148 |   regmap = devm_regmap_init(dev, NULL, (void *)res->start,
      |            ^~~~~~~~~~~~~~~~

I had tried a different approach that would store the address
in the private data as a phys_addr_t, but the easiest solution
now seems to be to add a double cast to shut up the warning.

As the address is passed to an inline assembly, it is guaranteed
to not be wider than a register anyway.

Fixes: d9ca7801b6e5 ("mfd: altera-sysmgr: Fix physical address storing hacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/altera-sysmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 41076d121dd5..591b300d9095 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -145,7 +145,8 @@ static int sysmgr_probe(struct platform_device *pdev)
 		sysmgr_config.reg_write = s10_protected_reg_write;
 
 		/* Need physical address for SMCC call */
-		regmap = devm_regmap_init(dev, NULL, (void *)res->start,
+		regmap = devm_regmap_init(dev, NULL,
+					  (void *)(uintptr_t)res->start,
 					  &sysmgr_config);
 	} else {
 		base = devm_ioremap(dev, res->start, resource_size(res));
-- 
2.27.0

