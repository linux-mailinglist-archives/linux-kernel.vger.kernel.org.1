Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29772DA03E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgLNTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:21:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58466 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440884AbgLNTUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:20:36 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0560320B718A;
        Mon, 14 Dec 2020 11:19:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0560320B718A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607973550;
        bh=wRDctihRsmviTPy9E5NQPqpLOD2WoC6cSXwR/EfWCQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvoE5zUbjq370aqAJLu0S1P/+To2Db1y926vIwGxyX6Vl87UAZeT9Xy5Yq6a+yH2L
         uWHUAB07L0v4zwni/eSwdZ5cBCaQgaGLy4spB4RzC/RKETGwN+6uW2m0aT9Ywn2FXz
         uVtMqVNogsV5LDJJkz7MWvgFqYKUbibyo5BeVbvY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v11 5/8] powerpc: Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to ima
Date:   Mon, 14 Dec 2020 11:18:51 -0800
Message-Id: <20201214191854.9050-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191854.9050-1-nramas@linux.microsoft.com>
References: <20201214191854.9050-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ima_get_kexec_buffer() retrieves the address and size of the buffer
used for carrying forward the IMA measurement logs on kexec from
the device tree.

ima_free_kexec_buffer() removes the chosen node
"linux,ima-kexec-buffer" from the device tree, and frees the buffer
used for carrying forward the IMA measurement logs on kexec.

These functions do not have architecture specific code, but are
currently limited to powerpc. Move ima_get_kexec_buffer() and
ima_free_kexec_buffer() to ima_kexec.c in IMA so that they are
accessible for other architectures as well.

With the above change the functions in arch/powerpc/kexec/ima.c are
defined only when the kernel config CONFIG_IMA_KEXEC is enabled.
Update the Makefile to build arch/powerpc/kexec/ima.c only when
CONFIG_IMA_KEXEC is enabled and remove "#ifdef CONFIG_IMA_KEXEC"
in arch/powerpc/kexec/ima.c.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h     |  3 --
 arch/powerpc/kexec/Makefile        |  7 +---
 arch/powerpc/kexec/ima.c           | 51 -----------------------------
 security/integrity/ima/ima_kexec.c | 52 ++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index fbc0c866b6bc..3875c9334d64 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -4,9 +4,6 @@
 
 #include <linux/of.h>
 
-int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
-
 #ifdef CONFIG_IMA_KEXEC
 int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
 			      size_t size);
diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 4aff6846c772..f54a9dbff4c8 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -9,12 +9,7 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
 
 obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
 
-ifdef CONFIG_HAVE_IMA_KEXEC
-ifdef CONFIG_IMA
-obj-y				+= ima.o
-endif
-endif
-
+obj-$(CONFIG_IMA_KEXEC)		+= ima.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_core_$(BITS).o := n
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 68017123b07d..82730c13a4df 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -9,59 +9,9 @@
 #include <linux/slab.h>
 #include <linux/kexec.h>
 #include <linux/of.h>
-#include <linux/memblock.h>
 #include <linux/libfdt.h>
 #include <asm/ima.h>
 
-/**
- * ima_get_kexec_buffer - get IMA buffer from the previous kernel
- * @addr:	On successful return, set to point to the buffer contents.
- * @size:	On successful return, set to the buffer size.
- *
- * Return: 0 on success, negative errno on error.
- */
-int ima_get_kexec_buffer(void **addr, size_t *size)
-{
-	int ret;
-	unsigned long tmp_addr;
-	size_t tmp_size;
-
-	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
-	if (ret)
-		return ret;
-
-	*addr = __va(tmp_addr);
-	*size = tmp_size;
-
-	return 0;
-}
-
-/**
- * ima_free_kexec_buffer - free memory used by the IMA buffer
- */
-int ima_free_kexec_buffer(void)
-{
-	int ret;
-	unsigned long addr;
-	size_t size;
-	struct property *prop;
-
-	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
-	if (!prop)
-		return -ENOENT;
-
-	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
-	if (ret)
-		return ret;
-
-	ret = of_remove_property(of_chosen, prop);
-	if (ret)
-		return ret;
-
-	return memblock_free(addr, size);
-}
-
-#ifdef CONFIG_IMA_KEXEC
 /**
  * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
  *
@@ -154,4 +104,3 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 
 	return 0;
 }
-#endif /* CONFIG_IMA_KEXEC */
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..9527118939b8 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -9,7 +9,11 @@
 
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
+#include <linux/of.h>
 #include <linux/kexec.h>
+#include <linux/ima.h>
+
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
@@ -133,6 +137,54 @@ void ima_add_kexec_buffer(struct kimage *image)
 }
 #endif /* IMA_KEXEC */
 
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	int ret;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+
+	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
+	*addr = __va(tmp_addr);
+	*size = tmp_size;
+
+	return 0;
+}
+
+/**
+ * ima_free_kexec_buffer - free memory used by the IMA buffer
+ */
+static int ima_free_kexec_buffer(void)
+{
+	int ret;
+	unsigned long addr;
+	size_t size;
+	struct property *prop;
+
+	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
+	if (!prop)
+		return -ENOENT;
+
+	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
+	if (ret)
+		return ret;
+
+	ret = of_remove_property(of_chosen, prop);
+	if (ret)
+		return ret;
+
+	return memblock_free(addr, size);
+}
+
 /*
  * Restore the measurement list from the previous kernel.
  */
-- 
2.29.2

