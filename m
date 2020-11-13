Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC52B246B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKMTXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:23:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48962 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:22:55 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4053820C28CF;
        Fri, 13 Nov 2020 11:22:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4053820C28CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605295374;
        bh=E65rSNEs2YmfUHqh/GcM7UxWVoI5rH2mbnkR7MkuBzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1lXDyVMtVFA2CUGEnPXGcov3tXHTTMaSaOun/s7Mw24Sy+3vqFqv6g3P3sBQCCqU
         xLPrTOJ23JDIcWosSrcpNmxUYl6fsQzwycCTM70Wzz2pbwCvb0U96Or/hFHNoFE/Ll
         e4ZlRmGbwbFceCllU1kVKl7K33r1KBEPS3xah0iQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [PATCH v9 8/8] arm64: Add IMA kexec buffer to DTB
Date:   Fri, 13 Nov 2020 11:22:43 -0800
Message-Id: <20201113192243.1993-9-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113192243.1993-1-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any existing "linux,ima-kexec-buffer" property in the device tree
needs to be removed and its corresponding memory reservation in
the currently running kernel needs to be freed.

The address and size of the current kernel's IMA measurement log need
to be added to the device tree's IMA kexec buffer node and memory for
the buffer needs to be reserved for the log to be carried over to
the next kernel on the kexec call.

Remove any existing "linux,ima-kexec-buffer" property in the device
tree and free the corresponding memory reservation in the currently
running kernel.

Add "linux,ima-kexec-buffer" property to the device tree and reserve
the memory for storing the IMA log that needs to be passed from
the current kernel to the next one.

Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to indicate
that the IMA measurement log information is present in the device tree
for ARM64.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/kernel/machine_kexec_file.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..bcca4a467eda 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1094,6 +1094,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select HAVE_IMA_KEXEC
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 03210f644790..0a492bab29ae 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
+#include <linux/ima.h>
 #include <asm/byteorder.h>
 
 /* relevant device tree properties */
@@ -62,6 +63,8 @@ static int setup_dtb(struct kimage *image,
 
 	off = ret;
 
+	remove_ima_buffer(dtb, ret);
+
 	ret = fdt_delprop(dtb, off, FDT_PROP_KEXEC_ELFHDR);
 	if (ret && ret != -FDT_ERR_NOTFOUND)
 		goto out;
@@ -136,6 +139,21 @@ static int setup_dtb(struct kimage *image,
 				FDT_PROP_KASLR_SEED);
 	}
 
+	/* add ima-kexec-buffer */
+	if (image->arch.ima_buffer_size > 0) {
+		ret = fdt_appendprop_addrrange(dtb, 0, off,
+				"linux,ima-kexec-buffer",
+				image->arch.ima_buffer_addr,
+				image->arch.ima_buffer_size);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+
+		ret = fdt_add_mem_rsv(dtb, image->arch.ima_buffer_addr,
+				      image->arch.ima_buffer_size);
+		if (ret)
+			goto out;
+	}
+
 	/* add rng-seed */
 	if (rng_is_initialized()) {
 		void *rng_seed;
-- 
2.29.2

