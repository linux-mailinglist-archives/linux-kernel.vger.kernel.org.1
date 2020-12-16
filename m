Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D52DBE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLPKWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLPKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:22:31 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C748BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 02:21:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g20so31956057ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 02:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wghwm/EuVz3bvh07GJWwq36XWmOx/mRqFhX5IlK9FwM=;
        b=Ql1R7eegxXBwWF8kMb4QtRHhzJsCMBzGkzpSrn92mQr+SsBu6aKuvnOvQrA+N+Fe6D
         wNMgahQyzRF5ZdSYPXlttvkVKofecdCWLsf0oo98I8ZFqx3N6X/f3k034kEPjQTnzHWm
         ZQ5Bid62sQZhdtWyfpJZI2zPy6RmQdmAbTRU9JjETlUzXY6lq1qL1VKSu8aFy2sqYOU2
         JKF4nqkhZLLoqD1wWjdtq8nCXudiLPyhNBhONqE1I02LHKtYpYpfhiZnZ+RIvi0TXZXN
         jKBRSoci25o0PcrQAHBT5/DRSrqnriPqZ6SrYoS6Wa7N6ZPT9Cue1g4Z2NY49kqJgGos
         l0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wghwm/EuVz3bvh07GJWwq36XWmOx/mRqFhX5IlK9FwM=;
        b=Ux0npI8/VlcWx8wwXOHVXgH/EjXseF3yyB9PaFqe6E8eJ6MtgY+vMXVPdHkbsGAbWW
         7rIatvKXQ/nMlBtQbjBHUMvodXMRyHioiREanY9WmW0Znf+69g7oTfZobzUCG0GNBZqm
         fHX+WZ1tBcWq7NwXm/jqnwdHOKkm8sdvpcvpWYkY/uAgOiweYKOjlc9IEzINQPp+hga+
         J9CqpVMPEzKc86w22G1jTlRLzP7VB9plNPR1Vrc2yQM84n17+sj31udZC+EpxpqqROMz
         7GvUCTrkWy54JTK8JdQc902nYAhTyGw1KBy/OZboWN8+joNeUF9qvEN2oH9azDfL3Sci
         B4Zg==
X-Gm-Message-State: AOAM531y6Y8YTTjMxiqgjk9jgT+BaSWCzc87RyuY+nI+OvOQzHNiZNSU
        nr0KYI3oqk72D/AdgBi8LxLBlplAYxxCMutS
X-Google-Smtp-Source: ABdhPJwAMFEgk4hYd2SUZ7WExP7oIXyGUffDy2/xMdiSwGKN35f3cmD00RzQUFNyuHwrJUfN27eA6g==
X-Received: by 2002:a17:906:2e85:: with SMTP id o5mr8119911eji.521.1608114109021;
        Wed, 16 Dec 2020 02:21:49 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id s5sm1070449eju.98.2020.12.16.02.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 02:21:48 -0800 (PST)
From:   Michal Simek <monstr@monstr.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] arch/microblaze patches for 5.11-rc1
Message-ID: <e14ec382-aaa4-b7d4-3134-1d79bcd1e28f@monstr.eu>
Date:   Wed, 16 Dec 2020 11:21:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these changes to your tree. The biggest change is to remove
support for noMMU configuration. FPGAs are bigger that's why people use
Microblaze with MMU for a lot of years and there is likely no user of
this code anymore. None is updating libraries for this configuration too.

Stephen Rothwell reported issue with merge because of highem changes
from Thomas Gleixner done by commit 7ac1b26b0a72
("microblaze/mm/highmem: Switch to generic kmap atomic")

Resolution of this merge conflict is here
https://lore.kernel.org/linux-next/20201210155808.717a7257@canb.auug.org.au/

I have also c&p resolution below. In
arch/microblaze/include/asm/mmu_context.h only asm/mmu_context_mm.h remains.

Please let me know if you want to prepare it differently.

Thanks,
Michal

diff --cc arch/microblaze/Kconfig
index 6acbb4571b0f,7f6ca0ab4f81..000000000000
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@@ -139,8 -143,19 +139,9 @@@ config ADVANCED_OPTION
  comment "Default settings for advanced configuration options are used"
  	depends on !ADVANCED_OPTIONS

 -config XILINX_UNCACHED_SHADOW
 -	bool "Are you using uncached shadow for RAM ?"
 -	depends on ADVANCED_OPTIONS && !MMU
 -	default n
 -	help
 -	  This is needed to be able to allocate uncachable memory regions.
 -	  The feature requires the design to define the RAM memory controller
 -	  window to be twice as large as the actual physical memory.
 -
  config HIGHMEM
  	bool "High memory support"
-	depends on MMU
+ 	select KMAP_LOCAL
  	help
  	  The address space of Microblaze processors is only 4 Gigabytes large
  	  and it has to accommodate user address space, kernel address
diff --cc arch/microblaze/mm/Makefile
index cd8a844bf29e,8ced71100047..000000000000
--- a/arch/microblaze/mm/Makefile
+++ b/arch/microblaze/mm/Makefile
@@@ -5,5 -5,4 +5,4 @@@

  obj-y := consistent.o init.o

 -obj-$(CONFIG_MMU) += pgtable.o mmu_context.o fault.o
 +obj-y += pgtable.o mmu_context.o fault.o
- obj-$(CONFIG_HIGHMEM) += highmem.o




The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.11

for you to fetch changes up to 05cdf457477d6603b207d91873f0a3d4c7f8c1cd:

  microblaze: Remove noMMU code (2020-11-26 16:39:35 +0100)

----------------------------------------------------------------
Microblaze patches for 5.11-rc1

- Remove noMMU support
- Add support for TIF_NOTIFY_SIGNAL
- Small header fix

----------------------------------------------------------------
Geert Uytterhoeven (1):
      microblaze: Replace <linux/clk-provider.h> by <linux/of_clk.h>

Jens Axboe (1):
      microblaze: add support for TIF_NOTIFY_SIGNAL

Michal Simek (1):
      microblaze: Remove noMMU code

 arch/microblaze/Kconfig                       |  53 +-----
 arch/microblaze/Makefile                      |  11 +-
 arch/microblaze/configs/mmu_defconfig         |   1 -
 arch/microblaze/configs/nommu_defconfig       |  90 ----------
 arch/microblaze/include/asm/dma.h             |   6 -
 arch/microblaze/include/asm/exceptions.h      |   5 -
 arch/microblaze/include/asm/io.h              |   3 -
 arch/microblaze/include/asm/mmu.h             |   4 -
 arch/microblaze/include/asm/mmu_context.h     |   4 -
 arch/microblaze/include/asm/page.h            |  59 -------
 arch/microblaze/include/asm/pgalloc.h         |   4 -
 arch/microblaze/include/asm/pgtable.h         |  43 -----
 arch/microblaze/include/asm/processor.h       |  37 ----
 arch/microblaze/include/asm/registers.h       |   2 -
 arch/microblaze/include/asm/setup.h           |   2 -
 arch/microblaze/include/asm/thread_info.h     |   2 +
 arch/microblaze/include/asm/tlbflush.h        |  14 --
 arch/microblaze/include/asm/uaccess.h         |  27 ---
 arch/microblaze/kernel/Makefile               |   4 +-
 arch/microblaze/kernel/asm-offsets.c          |   2 -
 arch/microblaze/kernel/entry-nommu.S          | 622
------------------------------------------------------------------
 arch/microblaze/kernel/exceptions.c           |   5 -
 arch/microblaze/kernel/head.S                 |  12 --
 arch/microblaze/kernel/hw_exception_handler.S | 130 +-------------
 arch/microblaze/kernel/microblaze_ksyms.c     |   2 -
 arch/microblaze/kernel/process.c              |  10 --
 arch/microblaze/kernel/setup.c                |   4 +-
 arch/microblaze/kernel/signal.c               |  10 +-
 arch/microblaze/kernel/unwind.c               |  19 --
 arch/microblaze/mm/Makefile                   |   2 +-
 arch/microblaze/mm/consistent.c               |  29 ----
 arch/microblaze/mm/init.c                     |  49 ------
 arch/microblaze/pci/pci-common.c              |   2 -
 33 files changed, 16 insertions(+), 1253 deletions(-)
 delete mode 100644 arch/microblaze/configs/nommu_defconfig
 delete mode 100644 arch/microblaze/kernel/entry-nommu.S


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

