Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521C1249DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgHSM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgHSM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:29:28 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A04EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 05:29:28 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id HQVU2300C4C55Sk06QVU8j; Wed, 19 Aug 2020 14:29:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NDc-0002Cr-0q; Wed, 19 Aug 2020 14:29:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NDb-0004q2-VV; Wed, 19 Aug 2020 14:29:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] h8300: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Wed, 19 Aug 2020 14:29:25 +0200
Message-Id: <20200819122925.18557-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H8/300 platform code is not a clock provider, and just needs to call
of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
v2:
  - Add Reviewed-by.
---
 arch/h8300/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index 28ac88358a89a4f9..0ecaac7dd7e93d9f 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -24,7 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_address.h>
-#include <linux/clk-provider.h>
+#include <linux/of_clk.h>
 #include <linux/memblock.h>
 #include <linux/screen_info.h>
 #include <linux/clocksource.h>
-- 
2.17.1

