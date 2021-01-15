Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535F02F8288
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbhAORbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:31:49 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56854 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbhAORbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:31:45 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 573DE20B6C49;
        Fri, 15 Jan 2021 09:30:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 573DE20B6C49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610731831;
        bh=1aotmbJQziKORS3Wqv9k380Z5OVfRIDlDlUpXWgDkCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brt42/YQlIYys51K/dU8hS75f0odrbrz1DCtM1XqjsmDvrhNeWLi+EerVR+0yW+7j
         H5mfZm0kSWSAGDFouK2eZARqB+AdYAhJz0loy2ZH2Xoar8kvWQWDvgP6mfJXipbk0V
         JfJIT3HpnWWP/khUuVciH0kWltn/LtMKDO0+fWrI=
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 10/10] arm64: Add IMA log information in kimage used for kexec
Date:   Fri, 15 Jan 2021 09:30:17 -0800
Message-Id: <20210115173017.30617-11-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115173017.30617-1-nramas@linux.microsoft.com>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address and size of the buffer containing the IMA measurement log need
to be passed from the current kernel to the next kernel on kexec.

Add address and size fields to "struct kimage_arch" for ARM64 platform
to hold the address and size of the IMA measurement log buffer.

Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC, if CONFIG_IMA
is enabled, to indicate that the IMA measurement log information is
present in the device tree for ARM64.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/arm64/Kconfig             | 1 +
 arch/arm64/include/asm/kexec.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d466addb078..ea7f7fe3dccd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1094,6 +1094,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select HAVE_IMA_KEXEC if IMA
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..2bd19ccb6c43 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,6 +100,11 @@ struct kimage_arch {
 	void *elf_headers;
 	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
+
+#ifdef CONFIG_IMA_KEXEC
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
+#endif
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
-- 
2.30.0

