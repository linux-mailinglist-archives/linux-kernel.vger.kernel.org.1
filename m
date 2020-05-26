Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1C1C8709
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgEGKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 06:41:03 -0400
Received: from foss.arm.com ([217.140.110.172]:56132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgEGKlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:41:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11DCD6E;
        Thu,  7 May 2020 03:41:02 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8B73F71F;
        Thu,  7 May 2020 03:41:01 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>
Subject: [PATCH] arm64: vdso: Add --eh-frame-hdr to ldflags
Date:   Thu,  7 May 2020 11:40:49 +0100
Message-Id: <20200507104049.47834-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM's unwinder depends on the .eh_frame_hdr being present for
unwinding. However, when compiling Linux with GCC, the section
is not present in the vdso library object and when compiling
with Clang, it is present, but it has zero length.

With GCC the problem was not spotted because libgcc unwinder does
not require the .eh_frame_hdr section to be present.

Add --eh-frame-hdr to ldflags to correctly generate and populate
the section for both GCC and LLVM.

Fixes: 28b1a824a4f44 ("arm64: vdso: Substitute gettimeofday() with C implementation")
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
Tested-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 3862cad2410c..54008ec39e3a 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -18,7 +18,7 @@ targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
 ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
-		--build-id -n -T
+		--eh-frame-hdr --build-id -n -T
 
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
-- 
2.26.2

