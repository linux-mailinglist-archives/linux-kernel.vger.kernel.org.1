Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155CB2E94D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhADM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhADM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:28:34 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F0FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 04:27:54 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4D8Zdz0LkCz9sVs; Mon,  4 Jan 2021 23:27:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1609763271;
        bh=v8wG597noNfuWICjVdBWzSu8L6bYdzednOXuYaV8Bmo=;
        h=From:To:Cc:Subject:Date:From;
        b=LU8GC11/wUmEVJMoE/TpTt42hD46k3xmSL2ev+vxfx4xhmkw/xSKDNjqj0F1i7YFe
         +e/Yp6p3hgJQASNp6cj66Cw8smUR5t8KpbJiiEIJELBPZfzC4KXmf58xIkcFDJnpVe
         LnQd2wpMDbAzr/x3m7pUAtkszdFhOqt8QxFPHyXxI95TTxnIKQUFITP7RMbunZKFW2
         I8H/ALbVUopEtdMrkdtYHnY2rNSiao3FnS6UhzGQhltClXoJ+hOpEFyJINBz7pF6Lt
         17gtXMNy9WvBjDoJB6PP3ujxSxLXLpltGiwsDFk6wJiIwPBn16FLz6wGyb0Prtn6d4
         WD7GPXYvpvVtA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     acme@redhat.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, yhs@fb.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, vt@altlinux.org
Subject: [PATCH] tools headers UAPI: Sync linux/types.h with the kernel sources
Date:   Mon,  4 Jan 2021 23:27:44 +1100
Message-Id: <20210104122744.4095768-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other headers in tools/include/uapi/linux, types.h has
never been synced from the exported headers, instead it's been hand
written over time. This means it doesn't match the exported headers
which can cause build errors on some architectures.

For example on powerpc, tools/bpf doesn't build:

  $ make O=/build -C tools/bpf/
  make: Entering directory '/linux/tools/bpf'

  Auto-detecting system features:
  ...                        libbfd: [ on  ]
  ...        disassembler-four-args: [ on  ]

    CC       /build/bpf_jit_disasm.o
    LINK     /build/bpf_jit_disasm
    CC       /build/bpf_dbg.o
  In file included from /usr/include/powerpc64le-linux-gnu/asm/sigcontext.h:14,
                   from /usr/include/powerpc64le-linux-gnu/bits/sigcontext.h:30,
                   from /usr/include/signal.h:288,
                   from /linux/tools/bpf/bpf_dbg.c:51:
  /usr/include/powerpc64le-linux-gnu/asm/elf.h:160:9: error: unknown type name '__vector128'
    160 | typedef __vector128 elf_vrreg_t;
        |         ^~~~~~~~~~~
  make: *** [Makefile:67: /build/bpf_dbg.o] Error 1

This is because tools/include/uapi/linux/types.h doesn't include
asm/types.h, where __vector128 is defined in the powerpc headers.

We can fix it by syncing the tools header with the exported kernel
header, as is done for the other headers in tools/include/uapi/linux.

Reported-by: Vitaly Chikunov <vt@altlinux.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

Earlier discussion: https://lore.kernel.org/netdev/20201024203040.4cjxnxrdy6qx557c@altlinux.org/

Build tested on powerpc and x86.
---
 tools/include/uapi/linux/types.h | 41 ++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/tools/include/uapi/linux/types.h b/tools/include/uapi/linux/types.h
index 91fa51a9c31d..999cb0fa88eb 100644
--- a/tools/include/uapi/linux/types.h
+++ b/tools/include/uapi/linux/types.h
@@ -1,11 +1,26 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _UAPI_LINUX_TYPES_H
-#define _UAPI_LINUX_TYPES_H
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_TYPES_H
+#define _LINUX_TYPES_H
 
-#include <asm-generic/int-ll64.h>
+#include <asm/types.h>
+
+#ifndef __ASSEMBLY__
+
+#include <linux/posix_types.h>
+
+
+/*
+ * Below are truly Linux-specific types that should never collide with
+ * any application/library that wants linux/types.h.
+ */
+
+#ifdef __CHECKER__
+#define __bitwise__ __attribute__((bitwise))
+#else
+#define __bitwise__
+#endif
+#define __bitwise __bitwise__
 
-/* copied from linux:include/uapi/linux/types.h */
-#define __bitwise
 typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
 typedef __u32 __bitwise __le32;
@@ -16,8 +31,20 @@ typedef __u64 __bitwise __be64;
 typedef __u16 __bitwise __sum16;
 typedef __u32 __bitwise __wsum;
 
+/*
+ * aligned_u64 should be used in defining kernel<->userspace ABIs to avoid
+ * common 32/64-bit compat problems.
+ * 64-bit values align to 4-byte boundaries on x86_32 (and possibly other
+ * architectures) and to 8-byte boundaries on 64-bit architectures.  The new
+ * aligned_64 type enforces 8-byte alignment so that structs containing
+ * aligned_64 values have the same alignment on 32-bit and 64-bit architectures.
+ * No conversions are necessary between 32-bit user-space and a 64-bit kernel.
+ */
 #define __aligned_u64 __u64 __attribute__((aligned(8)))
 #define __aligned_be64 __be64 __attribute__((aligned(8)))
 #define __aligned_le64 __le64 __attribute__((aligned(8)))
 
-#endif /* _UAPI_LINUX_TYPES_H */
+typedef unsigned __bitwise __poll_t;
+
+#endif /*  __ASSEMBLY__ */
+#endif /* _LINUX_TYPES_H */
-- 
2.25.1

