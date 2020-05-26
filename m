Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5871B7666
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgDXNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 09:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbgDXNHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:22 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C124921655;
        Fri, 24 Apr 2020 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587733641;
        bh=Rq9Zgw5lpwdmGrew3EhHp1AIC3L8S+HChhCU2bywjL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyJ127whe6iBPLth4kYvPq3P8V9fPoACmVZ64S1LGZque3WSsYfU1pH7NkEoYmyZl
         6mFV3+0zPv80zl509uWwBqiT9CWFoBV18KgVYyIkb+sltPAEslW97b+3PIy602Vq6i
         ZZU+niuMm2WA9VQBwI0HB+xhuHAZHmxa5QgCk0AA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH 32/33] efi: Clean up config table description arrays
Date:   Fri, 24 Apr 2020 15:05:30 +0200
Message-Id: <20200424130531.30518-33-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
References: <20200424130531.30518-1-ardb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase legibility by adding whitespace to the efi_config_table_type_t
arrays that describe which EFI config tables we look for when going over
the firmware provided list. While at it, replace the 'name' char pointer
with a char array, which is more space efficient on relocatable 64-bit
kernels, as it avoids a 8 byte pointer and the associated relocation
data (24 bytes when using RELA format)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/ia64/kernel/efi.c          | 12 ++++++------
 arch/x86/platform/efi/efi.c     |  8 ++++----
 drivers/firmware/efi/arm-init.c |  4 ++--
 drivers/firmware/efi/efi.c      | 28 ++++++++++++++--------------
 include/linux/efi.h             |  2 +-
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index f69f3fe0532e..a54eacbc61a9 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -57,12 +57,12 @@ unsigned long hcdp_phys = EFI_INVALID_TABLE_ADDR;
 unsigned long sal_systab_phys = EFI_INVALID_TABLE_ADDR;
 
 static const efi_config_table_type_t arch_tables[] __initconst = {
-	{ESI_TABLE_GUID, "ESI", &esi_phys},
-	{HCDP_TABLE_GUID, "HCDP", &hcdp_phys},
-	{MPS_TABLE_GUID, "MPS", &mps_phys},
-	{PROCESSOR_ABSTRACTION_LAYER_OVERWRITE_GUID, "PALO", &palo_phys},
-	{SAL_SYSTEM_TABLE_GUID, "SALsystab", &sal_systab_phys},
-	{NULL_GUID, NULL, 0},
+	{ESI_TABLE_GUID,				&esi_phys,		"ESI"		},
+	{HCDP_TABLE_GUID,				&hcdp_phys,		"HCDP"		},
+	{MPS_TABLE_GUID,				&mps_phys,		"MPS"		},
+	{PROCESSOR_ABSTRACTION_LAYER_OVERWRITE_GUID,	&palo_phys,		"PALO"		},
+	{SAL_SYSTEM_TABLE_GUID,				&sal_systab_phys,	"SALsystab"	},
+	{},
 };
 
 extern efi_status_t efi_call_phys (void *, ...);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 1aae5302501d..e966115d105c 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -62,12 +62,12 @@ static unsigned long efi_runtime, efi_nr_tables;
 unsigned long efi_fw_vendor, efi_config_table;
 
 static const efi_config_table_type_t arch_tables[] __initconst = {
-	{EFI_PROPERTIES_TABLE_GUID, "PROP", &prop_phys},
-	{UGA_IO_PROTOCOL_GUID, "UGA", &uga_phys},
+	{EFI_PROPERTIES_TABLE_GUID,	&prop_phys,		"PROP"		},
+	{UGA_IO_PROTOCOL_GUID,		&uga_phys,		"UGA"		},
 #ifdef CONFIG_X86_UV
-	{UV_SYSTEM_TABLE_GUID, "UVsystab", &uv_systab_phys},
+	{UV_SYSTEM_TABLE_GUID,		&uv_systab_phys,	"UVsystab"	},
 #endif
-	{NULL_GUID, NULL, NULL},
+	{},
 };
 
 static const unsigned long * const efi_tables[] = {
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 9e5e62f5f94d..c697e70ca7e7 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -54,8 +54,8 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
 static __initdata unsigned long screen_info_table = EFI_INVALID_TABLE_ADDR;
 
 static const efi_config_table_type_t arch_tables[] __initconst = {
-	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, NULL, &screen_info_table},
-	{NULL_GUID, NULL, NULL}
+	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
+	{}
 };
 
 static void __init init_screen_info(void)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 911a2bd0f6b7..e49c0b6db988 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -502,21 +502,21 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
 }
 
 static const efi_config_table_type_t common_tables[] __initconst = {
-	{ACPI_20_TABLE_GUID, "ACPI 2.0", &efi.acpi20},
-	{ACPI_TABLE_GUID, "ACPI", &efi.acpi},
-	{SMBIOS_TABLE_GUID, "SMBIOS", &efi.smbios},
-	{SMBIOS3_TABLE_GUID, "SMBIOS 3.0", &efi.smbios3},
-	{EFI_SYSTEM_RESOURCE_TABLE_GUID, "ESRT", &efi.esrt},
-	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi_mem_attr_table},
-	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi_rng_seed},
-	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
-	{LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
-	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &mem_reserve},
-	{EFI_RT_PROPERTIES_TABLE_GUID, "RTPROP", &rt_prop},
+	{ACPI_20_TABLE_GUID,			&efi.acpi20,		"ACPI 2.0"	},
+	{ACPI_TABLE_GUID,			&efi.acpi,		"ACPI"		},
+	{SMBIOS_TABLE_GUID,			&efi.smbios,		"SMBIOS"	},
+	{SMBIOS3_TABLE_GUID,			&efi.smbios3,		"SMBIOS 3.0"	},
+	{EFI_SYSTEM_RESOURCE_TABLE_GUID,	&efi.esrt,		"ESRT"		},
+	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID,	&efi_mem_attr_table,	"MEMATTR"	},
+	{LINUX_EFI_RANDOM_SEED_TABLE_GUID,	&efi_rng_seed,		"RNG"		},
+	{LINUX_EFI_TPM_EVENT_LOG_GUID,		&efi.tpm_log,		"TPMEventLog"	},
+	{LINUX_EFI_TPM_FINAL_LOG_GUID,		&efi.tpm_final_log,	"TPMFinalLog"	},
+	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
+	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
 #ifdef CONFIG_EFI_RCI2_TABLE
-	{DELLEMC_EFI_RCI2_TABLE_GUID, NULL, &rci2_table_phys},
+	{DELLEMC_EFI_RCI2_TABLE_GUID,		&rci2_table_phys			},
 #endif
-	{NULL_GUID, NULL, NULL},
+	{},
 };
 
 static __init int match_config_table(const efi_guid_t *guid,
@@ -529,7 +529,7 @@ static __init int match_config_table(const efi_guid_t *guid,
 		for (i = 0; efi_guidcmp(table_types[i].guid, NULL_GUID); i++) {
 			if (!efi_guidcmp(*guid, table_types[i].guid)) {
 				*(table_types[i].ptr) = table;
-				if (table_types[i].name)
+				if (table_types[i].name[0])
 					pr_cont(" %s=0x%lx ",
 						table_types[i].name, table);
 				return 1;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 251f1f783cdf..9b7c7ec319ac 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -379,8 +379,8 @@ typedef union {
 
 typedef struct {
 	efi_guid_t guid;
-	const char *name;
 	unsigned long *ptr;
+	const char name[16];
 } efi_config_table_type_t;
 
 #define EFI_SYSTEM_TABLE_SIGNATURE ((u64)0x5453595320494249ULL)
-- 
2.17.1

