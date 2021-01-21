Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0592FE08A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbhAUEXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:23:42 -0500
Received: from foss.arm.com ([217.140.110.172]:45094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732150AbhAUEST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:18:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97ADA1509;
        Wed, 20 Jan 2021 20:17:32 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BDAF3F719;
        Wed, 20 Jan 2021 20:17:32 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        bhelgaas@google.com, robh@kernel.org, vidyas@nvidia.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 1/1] arm64: PCI: Enable SMC conduit
Date:   Wed, 20 Jan 2021 22:17:29 -0600
Message-Id: <20210121041729.1858499-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121041729.1858499-1-jeremy.linton@arm.com>
References: <20210121041729.1858499-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that most arm64 platforms' PCI implementations need quirks
to deal with problematic config accesses, this is a good place
to apply a firmware abstraction. The ARM PCI Configuration Space
Access Firmware Interface specification details a standard SMC
conduit designed to provide a simple PCI config accessor. This
specification enhances the existing ACPI/PCI abstraction and
expects power, config, etc., is handled by the platform. It also
is very explicit that the resulting config space registers must
behave as is specified by the PCI specification.

Hook the ACPI/PCI config path, and when missing MCFG data is
detected, attempt to probe the SMC conduit. If the conduit
exists and responds to the requested segment,  provided by the
ACPI namespace, attach a custom pci_ecam_ops which redirects
all config read/write requests to the firmware.

The Arm PCI Configuration Space Access Firmware Interface:
https://developer.arm.com/documentation/den0115/latest

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/pci.c   | 111 ++++++++++++++++++++++++++++++++++++++
 include/linux/arm-smccc.h |  29 ++++++++++
 2 files changed, 140 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..80c60cc0137a 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -107,6 +108,114 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 	return status;
 }
 
+static int smccc_pcie_has_conduit(void)
+{
+	struct arm_smccc_res res;
+
+	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_FEATURES,
+			     SMCCC_PCI_WRITE, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_FEATURES,
+			     SMCCC_PCI_READ, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_FEATURES,
+			     SMCCC_PCI_SEG_INFO, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int smccc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *val)
+{
+	struct arm_smccc_res res;
+
+	devfn |= bus->number << 8;
+	devfn |= bus->domain_nr << 16;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_READ, devfn, where, size,
+			     0, 0, 0, 0, &res);
+	if (res.a0) {
+		*val = ~0;
+		return -PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	*val = res.a1;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int smccc_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 val)
+{
+	struct arm_smccc_res res;
+
+	devfn |= bus->number << 8;
+	devfn |= bus->domain_nr << 16;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_WRITE, devfn, where, size, val,
+			     0, 0, 0, &res);
+	if (res.a0)
+		return -PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static const struct pci_ecam_ops smccc_pcie_ops = {
+	.pci_ops	= {
+		.read		= smccc_pcie_config_read,
+		.write		= smccc_pcie_config_write,
+	}
+};
+
+static struct pci_config_window *
+pci_acpi_setup_smccc_mapping(struct acpi_pci_root *root)
+{
+	struct device *dev = &root->device->dev;
+	struct arm_smccc_res res;
+	struct resource *bus_res = &root->secondary;
+	struct pci_config_window *cfg;
+	u16 seg = root->segment;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_SEG_INFO, seg, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0) {
+		pr_warn("PCI: SMC segment %d doesn't exist\n", seg);
+		return NULL;
+	}
+
+	if (FIELD_GET(SMCCC_PCI_SEG_INFO_START_BUS, res.a1) != bus_res->start ||
+	    FIELD_GET(SMCCC_PCI_SEG_INFO_END_BUS, res.a1) != bus_res->end) {
+		pr_warn("PCI: SMC segment %d doesn't match ACPI description\n", seg);
+		return NULL;
+	}
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return NULL;
+
+	cfg->parent = dev;
+	cfg->ops = &smccc_pcie_ops;
+	cfg->busr.start = bus_res->start;
+	cfg->busr.end = bus_res->end;
+	cfg->busr.flags = IORESOURCE_BUS;
+	cfg->res.name = "PCI SMCCC";
+
+	pr_info("PCI: SMC conduit attached to segment %d\n", seg);
+
+	return cfg;
+}
+
 /*
  * Lookup the bus range for the domain in MCFG, and set up config space
  * mapping.
@@ -125,6 +234,8 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 
 	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
 	if (ret) {
+		if (!smccc_pcie_has_conduit())
+			return pci_acpi_setup_smccc_mapping(root);
 		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
 		return NULL;
 	}
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f860645f6512..a1a8fe0ea5aa 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -89,6 +89,35 @@
 
 #define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
 
+/* PCI ECAM conduit (defined by ARM DEN0115A) */
+#define SMCCC_PCI_VERSION						\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_STANDARD, 0x0130)
+
+#define SMCCC_PCI_FEATURES						\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_STANDARD, 0x0131)
+
+#define SMCCC_PCI_READ							\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_STANDARD, 0x0132)
+
+#define SMCCC_PCI_WRITE							\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_STANDARD, 0x0133)
+
+#define SMCCC_PCI_SEG_INFO						\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_STANDARD, 0x0134)
+
+#define SMCCC_PCI_SEG_INFO_START_BUS  GENMASK(7, 0)
+#define SMCCC_PCI_SEG_INFO_END_BUS    GENMASK(15, 8)
+
 /* Paravirtualised time calls (defined by ARM DEN0057A) */
 #define ARM_SMCCC_HV_PV_TIME_FEATURES				\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
-- 
2.26.2

