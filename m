Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2C26CA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgIPT7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:59:46 -0400
Received: from foss.arm.com ([217.140.110.172]:34562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgIPRfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7A61063;
        Wed, 16 Sep 2020 03:46:43 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C76083F68F;
        Wed, 16 Sep 2020 03:46:42 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kselftest: arm64: Add usercopy fixup accuracy tests
Date:   Wed, 16 Sep 2020 10:46:36 +0000
Message-Id: <20200916104636.19172-2-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916104636.19172-1-oli.swede@arm.com>
References: <20200916104636.19172-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test module checks the accuracy of the usercopy
fixup routines.

In kernel mode copy_*_user() can be invoked directly, removing the
dependencies on implementations of syscalls (e.g. any reductions to
the original copy size from within read/write), as well as
potentially reducing other overheads. This is also exposed to
copy_in_user() allowing it to be verified should its fixup differ
from the recovery from copy_{from,to}_user in the future.

This module is intended to be used in a more specific way than
lib/test_user_copy.c, which is expected to be used to verify the
usercopy functionality overall rather than exclusively the correctness
of the values returned by the fixups.

The behaviour of the copy algorithm varies depending on the copy size,
and the tests are currently exhaustive to ensure this is covered by the
fixup implementation.

Each testcase runs the usercopy function so that the user buffer base
address is set to be close to an invalid page so the copy intentionally
faults at the specified index. The return value (number of bytes not
copied due to the fault) is then compared against the number of bytes
remaining in the user buffer.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/Kconfig.debug                      |   7 +
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/test_usercopy_fixup.c          | 276 ++++++++++++++++++
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/README          |   2 +-
 .../testing/selftests/arm64/usercopy/Makefile |   3 +
 tools/testing/selftests/arm64/usercopy/config |   1 +
 .../arm64/usercopy/run_fixup_tests.sh         |   4 +
 8 files changed, 295 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/lib/test_usercopy_fixup.c
 create mode 100644 tools/testing/selftests/arm64/usercopy/Makefile
 create mode 100644 tools/testing/selftests/arm64/usercopy/config
 create mode 100755 tools/testing/selftests/arm64/usercopy/run_fixup_tests.sh

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 265c4461031f..83ea72f4f47b 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -20,4 +20,11 @@ config ARM64_RELOC_TEST
 	depends on m
 	tristate "Relocation testing module"
 
+config TEST_USERCOPY_FIXUP
+	tristate "Test correctness of the usercopy fixup"
+	depends on m
+	help
+	  This test module allows for the verification of the correctness
+	  of the fixup routines for each of the usercopy functions.
+
 source "drivers/hwtracing/coresight/Kconfig"
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 2fc253466dbf..8d9d478a963b 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -16,3 +16,5 @@ lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 obj-$(CONFIG_CRC32) += crc32.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+
+obj-$(CONFIG_TEST_USERCOPY_FIXUP) += test_usercopy_fixup.o
diff --git a/arch/arm64/lib/test_usercopy_fixup.c b/arch/arm64/lib/test_usercopy_fixup.c
new file mode 100644
index 000000000000..018993518729
--- /dev/null
+++ b/arch/arm64/lib/test_usercopy_fixup.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * This module can be used to verify the accuracy of the
+ * usercopy fixup routines in order to ensure there are
+ * is no over-(or under-)estimation of the number of
+ * bytes that haven't been copied once a fault occurs
+ * during a copy_{to,from,in}_user() call.
+ *
+ * On arm64 these should be exact, i.e. the number of bytes
+ * bytes returned by the fixup must be equal to the number
+ * of bytes that haven't copied, assuming that any data
+ * present in the buffer after the first gap is discarded.
+ * The testcases are therefore reported as succeeding or
+ * failing based on this requirement.
+ *
+ * This check suitable for systems with and without UAO,
+ * as each test is purely comparing the reported number of
+ * bytes remaining with the true value by probing the buffer,
+ * the result of which in both cases should be that the
+ * requirement above is satisfied.
+ *
+ * Another test module (located at lib/test_user_copy.c)
+ * can be used to check the usercopy functionality across
+ * architectures, but this involves more general checks of
+ * the fixup mechanism (e.g. to make sure no bytes are copied
+ * unexpectedly given invalid inputs, and to make sure that
+ * copying completes when all parameters are legal).
+ * This module meanwhile is intended to help check the
+ * correctness of the fixup routines, and the error-reporting
+ * is written with respect to the arm64-specific fixup
+ * requirements, as well as the range of copy sizes over
+ * which the behaviour of the AArch64 copy algorithms has
+ * been shown to vary (and is likely to vary in future updates).
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/mman.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/uaccess.h>
+
+#include "../tools/testing/selftests/kselftest_module.h"
+
+KSTM_MODULE_GLOBALS();
+
+#define MAX_COPY_SIZE 256
+
+/* Report information related to the last testcase */
+static int __init
+testcase_result(const char *function,
+		      unsigned long fault_offset,
+		      unsigned long n,
+		      unsigned long fixup_return,
+		      long bytes_remaining)
+{
+	/* Initial sanity check */
+	if (bytes_remaining < 0) {
+		pr_warn("The copy algorithm for %s is defective and "
+			"copied more bytes than requested - please "
+			"check this before verifying the fixup "
+			"correctness", function);
+		return -1;
+	}
+
+	/*
+	 * Log levels:
+	 *   - KERN_INFO if accurate
+	 *   - KERN_WARNING if over or under estimation
+	 */
+	if (fixup_return == bytes_remaining) {
+		pr_info("Fixup for %s is accurate for a fault on the "
+			"byte at index %lu for a copy size of %lu - "
+			"returned %lu with the same value of %ld "
+			"remaining", function, fault_offset, n,
+			fixup_return, bytes_remaining);
+		return 0;
+	} else if (fixup_return > bytes_remaining) {
+		pr_warn("Fixup for %s has under-estimated the bytes that "
+			"were copied for a fault on the byte at index %lu "
+			"for a copy size of %lu - returned %lu with an "
+			"actual value of %ld remaining", function,
+			fault_offset, n, fixup_return, bytes_remaining);
+		return -1;
+	} else {
+		pr_warn("Fixup for %s has over-estimated the bytes that "
+			"were copied for a fault on the byte at index %lu "
+			"for a copy size of %lu - returned %lu with an "
+			"actual value of %ld remaining", function,
+			fault_offset, n, fixup_return, bytes_remaining);
+		return -1;
+	}
+}
+
+/*
+ * On arm64 the destination in the kernel address space is
+ * zeroed past the point of the offset of the fault, so it
+ * is not possible for the fixup to under-report; the
+ * zeroing in linux/uaccess.h would be need to disabled.
+ * However, this is not necessary, as it's sufficient for the
+ * value returned to reflect the number of bytes remaining when
+ * the copy is interrupted, even if the zeroing obscures
+ * inaccuracies in the fixup return value itself.
+ */
+static int __init
+copy_from_user_testcase(unsigned long fault_offset, unsigned long n)
+{
+	char *kmem;
+	char __user *umem, *umem2, *umem_offset;
+	long bytes_remaining = 0;
+	unsigned long i, umem_byte, fixup_return = 0;
+
+	if (n >= (unsigned long)PAGE_SIZE || fault_offset > n) {
+		return -EINVAL;
+	}
+
+	/*
+	 * Zero the contents of kmem in preparation for copy_from_user
+	 * so that the later comparison is accurate
+	 */
+	kmem = kzalloc(PAGE_SIZE, GFP_KERNEL);
+
+	umem = (char __user *)vm_mmap(NULL, 0, PAGE_SIZE * 2,
+			PROT_READ | PROT_WRITE | PROT_EXEC,
+			MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	umem2 = (char __user *)vm_mmap(NULL,
+			(unsigned long)umem + PAGE_SIZE,
+			PAGE_SIZE, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, 0);
+
+	if ((unsigned long)umem >= TASK_SIZE
+	    || (unsigned long)umem2 >= TASK_SIZE) {
+		kfree(kmem);
+		return -ENOMEM;
+	}
+
+	umem_byte = 0x55;
+	for (i = (unsigned long)umem; i < (unsigned long)umem2; i++) {
+		put_user(umem_byte, (char __user *)i);
+	}
+
+	/*
+	 * Zero the contents of kbuf in preparation for copy_from_user
+	 * so that the later comparison is accurate
+	 */
+	kmem = kzalloc(PAGE_SIZE, GFP_KERNEL);
+
+	umem_offset = (char __user *)((unsigned long)umem2 - fault_offset + 1);
+
+	fixup_return = copy_from_user(kmem, umem_offset, n);
+
+	bytes_remaining = n;
+	for (i = 0; i < n; i++) {
+		if (kmem[i] == 0x55) {
+			bytes_remaining--;
+		} else {
+			/*
+			 * Data is expected to appear in the buffer from the
+			 * start, and from an in-order perspective only;
+			 * any incidental data as a result of out-of-order
+			 * stores can be ignored.
+			 */
+			break;
+		}
+	}
+
+	vm_munmap((unsigned long)umem, PAGE_SIZE);
+	vm_munmap((unsigned long)umem2, PAGE_SIZE);
+	kfree(kmem);
+
+	return testcase_result("copy_from_user()", fault_offset, n, fixup_return, bytes_remaining);
+}
+
+/*
+ * Test wrapper for copy_to_user(): performs a copy
+ * for a given copy size and address to fault on
+ */
+static int __init
+copy_to_user_testcase(unsigned long fault_offset, unsigned long n)
+{
+	char *kmem;
+	char __user *umem, *umem2, *umem_offset;
+	long bytes_remaining = 0;
+	unsigned long i, umem_byte, fixup_return = 0;
+
+	if (n >= PAGE_SIZE || fault_offset > n) {
+		return -EINVAL;
+	}
+
+	kmem = (char *)kmalloc(n, GFP_KERNEL);
+	if (!kmem) {
+		return -ENOMEM;
+	}
+
+	umem = (char __user *)vm_mmap(NULL, 0, PAGE_SIZE * 2,
+			PROT_READ | PROT_WRITE | PROT_EXEC,
+			MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	umem2 = (char __user *)vm_mmap(NULL,
+			(unsigned long)umem + PAGE_SIZE,
+			PAGE_SIZE, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, 0);
+
+	if ((unsigned long)umem >= TASK_SIZE
+	|| (unsigned long)umem2 >= TASK_SIZE) {
+		kfree(kmem);
+		return -ENOMEM;
+	} else {
+		umem_offset = (char __user *)((unsigned long)umem2 - fault_offset + 1);
+	}
+
+	memset(kmem, 0x55, n);
+
+	fixup_return = copy_to_user(umem_offset, kmem, n);
+
+	bytes_remaining = n;
+	for (i = (unsigned long)umem_offset; i < (unsigned long)umem2; i++) {
+		get_user(umem_byte, (char __user *)i);
+		if (umem_byte == 0x55) {
+			bytes_remaining--;
+		} else {
+			/*
+			 * Data is expected to appear in the buffer from the
+			 * start address, and from an in-order perspective
+			 * only; any incidental data as a result of
+			 * out-of-order stores can be ignored.
+			 */
+			break;
+		}
+	}
+
+	vm_munmap((unsigned long)umem, PAGE_SIZE);
+	vm_munmap((unsigned long)umem2, PAGE_SIZE);
+	kfree(kmem);
+
+	return testcase_result("copy_to_user()", fault_offset, n, fixup_return, bytes_remaining);
+}
+
+static void __init test_copy_from_user_fixup(void)
+{
+	unsigned long i, j;
+	for (i = 0; i < MAX_COPY_SIZE; i++) {
+		for (j = 0; j < i; j++) {
+			KSTM_CHECK_ZERO(copy_from_user_testcase(j, i));
+		}
+	}
+}
+
+static void __init test_copy_to_user_fixup(void)
+{
+	unsigned long i, j;
+	for (i = 0; i < MAX_COPY_SIZE; i++) {
+		for (j = 0; j < i; j++) {
+			KSTM_CHECK_ZERO(copy_to_user_testcase(j, i));
+		}
+	}
+}
+
+static void __init selftest(void)
+{
+	/*
+	 * Exhaustive tests for now: these repeat for faults
+	 * on indices all the way up to MAX_COPY_SIZE.
+	 *
+	 * If future copy algorithms vary significantly between
+	 * larger copy sizes, then a more appropriate approach
+	 * may be to specify a more selective range that checks
+	 * the corner cases of each of the different copy
+	 * subroutines.
+	 */
+	test_copy_to_user_fixup();
+	test_copy_from_user_fixup();
+}
+
+KSTM_MODULE_LOADERS(test_usercopy_fixup);
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 93b567d23c8b..204f0bc423ec 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal
+ARM64_SUBTARGETS ?= tags signal usercopy
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/README b/tools/testing/selftests/arm64/README
index a1badd882102..655946385f49 100644
--- a/tools/testing/selftests/arm64/README
+++ b/tools/testing/selftests/arm64/README
@@ -18,7 +18,7 @@ KSelfTest ARM64
 
       or, alternatively, only specific arm64/ subtargets can be picked:
 
-      $ make -C tools/testing/selftests TARGETS=arm64 ARM64_SUBTARGETS="tags signal" \
+      $ make -C tools/testing/selftests TARGETS=arm64 ARM64_SUBTARGETS="tags signal usercopy" \
 		INSTALL_PATH=<your-installation-path> install
 
    Further details on building and running KFST can be found in:
diff --git a/tools/testing/selftests/arm64/usercopy/Makefile b/tools/testing/selftests/arm64/usercopy/Makefile
new file mode 100644
index 000000000000..fb2dc00b1143
--- /dev/null
+++ b/tools/testing/selftests/arm64/usercopy/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS := run_fixup_tests.sh
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/usercopy/config b/tools/testing/selftests/arm64/usercopy/config
new file mode 100644
index 000000000000..7a62db6225db
--- /dev/null
+++ b/tools/testing/selftests/arm64/usercopy/config
@@ -0,0 +1 @@
+CONFIG_TEST_USERCOPY_FIXUP=m
diff --git a/tools/testing/selftests/arm64/usercopy/run_fixup_tests.sh b/tools/testing/selftests/arm64/usercopy/run_fixup_tests.sh
new file mode 100755
index 000000000000..4f751bec9851
--- /dev/null
+++ b/tools/testing/selftests/arm64/usercopy/run_fixup_tests.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+$(dirname $0)/../../kselftest/module.sh "run_fixup_tests" test_usercopy_fixup
-- 
2.17.1

