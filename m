Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577AA29B7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1795636AbgJ0PPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1794438AbgJ0PLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:11:50 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6EF820657;
        Tue, 27 Oct 2020 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811509;
        bh=MEOHJpFg/hSBwnyU+/C/N9+Qa7RXtkpK49digCQfxBc=;
        h=From:To:Cc:Subject:Date:From;
        b=KnT5lraBfZ/7vx1hN0P7obGVygBSAmfYDK5mhWAeewS2ufv945b4XfWIPctftNSu2
         6uV1JiXXLV7UI09v6GGxXzmfoI3hQKzpePSNzgHbsdJQDf3txT0lub1uHSc+Qo5OQJ
         lMeyoA/vUucITAcnBqlmd1TsxQJZ0VFWzZINtLi8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Ard Biesheuvel <ardb@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] module: use hidden visibility for weak symbol references
Date:   Tue, 27 Oct 2020 16:11:32 +0100
Message-Id: <20201027151132.14066-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert reports that commit be2881824ae9eb92 ("arm64/build: Assert for
unwanted sections") results in build errors on arm64 for configurations
that have CONFIG_MODULES disabled.

The commit in question added ASSERT()s to the arm64 linker script to
ensure that linker generated sections such as .got, .plt etc are empty,
but as it turns out, there are corner cases where the linker does emit
content into those sections. More specifically, weak references to
function symbols (which can remain unsatisfied, and can therefore not
be emitted as relative references) will be emitted as GOT and PLT
entries when linking the kernel in PIE mode (which is the case when
CONFIG_RELOCATABLE is enabled, which is on by default).

What happens is that code such as

	struct device *(*fn)(struct device *dev);
	struct device *iommu_device;

	fn = symbol_get(mdev_get_iommu_device);
	if (fn) {
		iommu_device = fn(dev);

essentially gets converted into the following when CONFIG_MODULES is off:

	struct device *iommu_device;

	if (&mdev_get_iommu_device) {
		iommu_device = mdev_get_iommu_device(dev);

where mdev_get_iommu_device is emitted as a weak symbol reference into
the object file. The first reference is decorated with an ordinary
ABS64 data relocation (which yields 0x0 if the reference remains
unsatisfied). However, the indirect call is turned into a direct call
covered by a R_AARCH64_CALL26 relocation, which is converted into a
call via a PLT entry taking the target address from the associated
GOT entry.

Given that such GOT and PLT entries are unnecessary for fully linked
binaries such as the kernel, let's give these weak symbol references
hidden visibility, so that the linker knows that the weak reference
via R_AARCH64_CALL26 can simply remain unsatisfied.

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7ccdf87f376f..6264617bab4d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -740,7 +740,7 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
 }
 
 /* Get/put a kernel symbol (calls should be symmetric) */
-#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
+#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
 #define symbol_put(x) do { } while (0)
 #define symbol_put_addr(x) do { } while (0)
 
-- 
2.17.1

