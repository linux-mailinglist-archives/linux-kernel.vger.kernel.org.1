Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68822E2EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 17:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgLZQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 11:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgLZQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 11:33:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A22C0613C1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 08:33:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c133so5670263wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 08:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtpkeBVz5MREbJ4Hh4ldSey/zkGfhttgVGvyAUtLQ9o=;
        b=nsK5M8nz/VjeGsXTO6OlT+E3dnqJjuzsIRdYtR6PlPUDqdCDN3yCv6jqWygj6PLHjE
         ZSALb7CkX5KZG8SOH52v2VLIZguJ50ITS96gTh77X0LJ7l+SWt/QbV8E63X2YnRgQSZE
         6G5jvxVyoCUfMVlps4Y2zq3IDzS+1csIxUclM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtpkeBVz5MREbJ4Hh4ldSey/zkGfhttgVGvyAUtLQ9o=;
        b=cfW4o526ihwfD60r+nln0HKWFv7G58sIXv0c+r2KDZgaDMuicW+nRe1OO7uduy0+Mk
         Xbk+CQovmSOBmN/JGnqMdTAgNq3SIu//1Ky2cLO64IuI/TzDG9nSEbSRNzG/trmo9WSB
         6zVcEonRC8Zd1cOlEe5nrU9tqgaXyNH8mX/SRpGycpnTSNjAM48WaCPdxxD1U1rLy2qD
         MyWgXBfE/MUjFBYGeo2STHIZusMhL6FzQd/ApCwtEcnlr4Ov5fWg1+YzBd6JUHnPJawv
         9N7h3lnGoLQ8PA6yPplU//wzuzEWohzCuVLdPgTzBvwmjQugV+wqmNztLpU6mBSETOZJ
         igYA==
X-Gm-Message-State: AOAM533EZVRueBLZGBXhbS40WGpeHvgfZ2W/B7JjWCKnPNdZbHniuExs
        15hP6UXkKnr/YYU/0QROqSYYhg==
X-Google-Smtp-Source: ABdhPJwj20fCyOf4J8xCHJKDZdEjK/pMUpvZ5ueQPVxSkNMqC94ou5zgiSv6fCXwp7uWbqaG0FsL1A==
X-Received: by 2002:a1c:4b10:: with SMTP id y16mr13184416wma.73.1609000387485;
        Sat, 26 Dec 2020 08:33:07 -0800 (PST)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id r20sm52270387wrg.66.2020.12.26.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 08:33:06 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        damien.lemoal@wdc.com, devicetree@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH] riscv: add BUILTIN_DTB support for MMU-enabled targets
Date:   Sat, 26 Dec 2020 18:30:38 +0200
Message-Id: <20201226163037.43691-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, especially in a production system we may not want to
use a "smart bootloader" like u-boot to load kernel, ramdisk and
device tree from a filesystem on eMMC, but rather load the kernel
from a NAND partition and just run it as soon as we can, and in
this case it is convenient to have device tree compiled into the
kernel binary. Since this case is not limited to MMU-less systems,
let's support it for these which have MMU enabled too.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 arch/riscv/Kconfig   |  1 -
 arch/riscv/mm/init.c | 12 ++++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2b41f6d8e458..9464b4e3a71a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -419,7 +419,6 @@ endmenu
 
 config BUILTIN_DTB
 	def_bool n
-	depends on RISCV_M_MODE
 	depends on OF
 
 menu "Power management options"
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 87c305c566ac..5d1c7a3ec01c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -194,12 +194,20 @@ void __init setup_bootmem(void)
 	setup_initrd();
 #endif /* CONFIG_BLK_DEV_INITRD */
 
+	/*
+	 * If DTB is built in, no need to reserve its memblock.
+	 * OTOH, initial_boot_params has to be set to properly copy DTB
+	 * before unflattening later on.
+	 */
+	if (IS_ENABLED(CONFIG_BUILTIN_DTB))
+		initial_boot_params = __va(dtb_early_pa);
+	else
+		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
+
 	/*
 	 * Avoid using early_init_fdt_reserve_self() since __pa() does
 	 * not work for DTB pointers that are fixmap addresses
 	 */
-	memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
-
 	early_init_fdt_scan_reserved_mem();
 	dma_contiguous_reserve(dma32_phys_limit);
 	memblock_allow_resize();
-- 
2.29.2

