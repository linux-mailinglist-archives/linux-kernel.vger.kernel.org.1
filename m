Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F1720F5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbgF3Njq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgF3Njq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:39:46 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:39:45 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:503c:ab8:1424:9638])
        by albert.telenet-ops.be with bizsmtp
        id xRfi2200L49uj5306Rfi1w; Tue, 30 Jun 2020 15:39:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jqGUA-0005AS-Jj; Tue, 30 Jun 2020 15:39:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jqGUA-0007Ta-F3; Tue, 30 Jun 2020 15:39:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Olivier Sobrie <olivier.sobrie@silexinsight.com>,
        Waleed Ziad <waleed94ziad@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] hwrng: ba431 - HW_RANDOM_BA431 should not default to y
Date:   Tue, 30 Jun 2020 15:39:41 +0200
Message-Id: <20200630133941.28696-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As HW_RANDOM_BA431 does not have any platform dependency, it should not
default to enabled.

Fixes: 0289e9be5dc26d84 ("hwrng: ba431 - add support for BA431 hwrng")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/char/hw_random/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 7b876dfdbaafe7ad..9e91c556942b1c94 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -76,7 +76,6 @@ config HW_RANDOM_ATMEL
 
 config HW_RANDOM_BA431
 	tristate "Silex Insight BA431 Random Number Generator support"
-	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware based on Silex Insight BA431 IP.
@@ -84,8 +83,6 @@ config HW_RANDOM_BA431
 	  To compile this driver as a module, choose M here: the
 	  module will be called ba431-rng.
 
-	  If unsure, say Y.
-
 config HW_RANDOM_BCM2835
 	tristate "Broadcom BCM2835/BCM63xx Random Number Generator support"
 	depends on ARCH_BCM2835 || ARCH_BCM_NSP || ARCH_BCM_5301X || \
-- 
2.17.1

