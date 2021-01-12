Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9702F348E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405100AbhALPro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391909AbhALPrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:47:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50F622312F;
        Tue, 12 Jan 2021 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610466423;
        bh=q+Pofp8jRp2xcjOfvDsfHdXfGkS6TiOxj2EkcvZcE/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=nB+GV/Ao2FJGa2/qsd2aioGTA73tsL+Fy/ISjrGuCxwlH3VH2Dptb5oF/HLziXRZv
         0A/cNKn9jDxot8d7A1iO9c5LtFQ2Wk5Fy57NM4dDhtMqG8L7c5hLrdXeYk0mSIr4GG
         F6xbxhfqw3a+mKXEZjQTMEcwZM+Fug8Mpus8ZWb3eVd1SQ6XgUEpIoHwBkjUAvbpMr
         hCaQMpC5KNeTRkGN6AqE9X+EvnCRaGhCiIwdZH4c3osj8yWXfGrrzpcu7p40dPo3n1
         2ZQqpWsI6Q5XNMJ7Os++Lt4j5/craDsVmER3KFWEqsu098FZKF+qhMoaP/xBvutnyY
         sIgydXBZWPbgw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ARM: fix link warning with XIP + frame-pointer
Date:   Tue, 12 Jan 2021 16:46:40 +0100
Message-Id: <20210112154658.850192-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When frame pointers are used instead of the ARM unwinder,
and the kernel is built using clang with an external assembler
and CONFIG_XIP_KERNEL, every file produces two warnings
like:

arm-linux-gnueabi-ld: warning: orphan section `.ARM.extab' from `net/mac802154/util.o' being placed in section `.ARM.extab'
arm-linux-gnueabi-ld: warning: orphan section `.ARM.exidx' from `net/mac802154/util.o' being placed in section `.ARM.exidx'

The same fix was already merged for the normal (non-XIP)
linker script, with a longer description.

Fixes: c39866f268f8 ("arm/build: Always handle .ARM.exidx and .ARM.extab sections")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 4d0b0cd9222e..ddb70c65d525 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -43,6 +43,10 @@ SECTIONS
 		ARM_DISCARD
 		*(.alt.smp.init)
 		*(.pv_table)
+#ifndef CONFIG_ARM_UNWIND
+		*(.ARM.exidx) *(.ARM.exidx.*)
+		*(.ARM.extab) *(.ARM.extab.*)
+#endif
 	}
 
 	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
-- 
2.29.2

