Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE59D2FC56A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbhATAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:09:31 -0500
Received: from m12-11.163.com ([220.181.12.11]:53669 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392501AbhASNxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=EUC5tLPE5IX/PbJxbp
        IEWPF4cAyyoYnhehk08uhuRu8=; b=RgOk9WOGUPyYQOP/I2dpCVqD7NUw5yHy0e
        TLFjVWBAI7YgWpt8DoSHZpCCuLsuOZT9gbeoLXaGcMwrx3NWnLEWB2sX1AHx4TE6
        TURXwTDYSZXF00XPoYIcyPxix23MDHfHP7qe691nglzvNRhpFwtjLzfVeIv4+A0g
        juSiEeNZM=
Received: from localhost.localdomain (unknown [223.87.231.20])
        by smtp7 (Coremail) with SMTP id C8CowACHj5+t3wZgoShYJg--.38264S2;
        Tue, 19 Jan 2021 21:33:35 +0800 (CST)
From:   Hailong liu <carver4lio@163.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] arch/arm/mm/mmu.c: Remove duplicate header
Date:   Tue, 19 Jan 2021 21:33:20 +0800
Message-Id: <20210119133320.8557-1-carver4lio@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowACHj5+t3wZgoShYJg--.38264S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4Ma0DUUUU
X-Originating-IP: [223.87.231.20]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/xtbBXg8fnVaD5fs9qwAAsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

Remove asm/fixmap.h which is included more than once.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 arch/arm/mm/mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index c06ebfbc48c4..a25b660c3017 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -18,7 +18,6 @@
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/cachetype.h>
-#include <asm/fixmap.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
-- 
2.17.1

