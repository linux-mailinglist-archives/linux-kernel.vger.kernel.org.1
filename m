Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F3F280016
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgJAN0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbgJAN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:26:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC7FC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 06:26:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so1870770pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dyJ2sj/jIF8pANfWrdKS4wO/w/c80JtIdKDMdTMpK1M=;
        b=nbhzVcCwe/4ggtrrNLABwhJy6td0B3JULllMNYY9YcTba6b2CF3Zslt5DCRKSmN4cI
         IbERYJiYDVPd3XYOtiFo0y/98fWeImvuyhHdUjM+hvg46qUVygpW/pUtOjDLc1QsQFy7
         jW9HXW9kGag2qlde3EopjoSeVnt4tgv8DeD3v87lJupn4/iVI1er937Bph4DdgCSxOVd
         LRrLyZt4mnw/+spv3Ct6aaJyvkwJYhvOabkrag/Jfe8y46xeuZ0LpouTDHKgE/3Y9S5f
         NBRBZAfczmtfmZ3M+/I3SrxwT4gNvEwleXmA9I1StJQHgTUcpv/hT+H5trytroMms/ZW
         mAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dyJ2sj/jIF8pANfWrdKS4wO/w/c80JtIdKDMdTMpK1M=;
        b=c5ORb1LgjWjNmFAIyqTqRPNZi9/in+vWvUrluW3BgBSKQ4VH+Oc5hKWlwH1j67NKk/
         gUeatKxJPGJwo87kcWAvF9CPRqJL3SmgFm0F7lC7hon1WSGD7uxOjVimt5io/v/dOAYU
         rMNrKcTlMZNSppgLIn7YPlivk6GInXHC9A3GqEKf6FLl4hDppu1o0zI9K0pReV8eR1gY
         QQ3QkL7iEdisd+CyiA4IQnNzNSa2LtF2aIEG5Yglr1mt32dZyGdOolBjxyBSDdZBa8Uf
         UzH3OMoTwWdigz6WbW3QYDaDuWil+7dtRlaj41Yat+qnTJSKm3mBNTwEwn+BWwpIAO2g
         PKUA==
X-Gm-Message-State: AOAM530qaRLKpfkW1QOmMaSgviMWtvAv5fZ0SARcT3ufHc1scuZC9AK+
        Ffh7L589koRlTHHphzZ4aNgMjQ==
X-Google-Smtp-Source: ABdhPJyrvWCcM4gMUuL76HkVjeV8BrcgmllF8abHSSZOp5q6frI92mmQtyTuWXuGKpj0B9n9UhKxRw==
X-Received: by 2002:a17:90a:f3cc:: with SMTP id ha12mr9142pjb.168.1601558801790;
        Thu, 01 Oct 2020 06:26:41 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([122.177.0.128])
        by smtp.gmail.com with ESMTPSA id c3sm6468583pfo.120.2020.10.01.06.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 06:26:40 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ran Wang <ran.wang_1@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Tanveer <tanveer.alam@puresoftware.com>
Subject: [PATCH v1] acpi: processor_throttling: Add supprt for System Memory
Date:   Thu,  1 Oct 2020 18:56:23 +0530
Message-Id: <20201001132623.172-1-kuldip.dwivedi@puresoftware.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing driver does not support System Memory so
adding support of system meory so that this can be used
on platforms which has ACPI_ADR_SPACE_SYSTEM_MEMORY type
system registers.

Function that creates sysfs entries in processor_driver in Linux,
is enabled to be compiled for arm64 platform

Signed-off-by: Tanveer <tanveer.alam@puresoftware.com>
Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
---

Notes:
    1.  Added package in CPU.asl in edk2-platform to support
        _PCT: Performance Control and provide cluster status/control
        register like below..
    
        Name(_PTC, Package () {
          ResourceTemplate() {Register(SystemMemory, 32, 0, CPU_CLK_CSSR_REG,
                              CPU_DWORD_ACCESS)},
          ResourceTemplate() {Register(SystemMemory, 32, 0, CPU_CLK_CSSR_REG,
                              CPU_DWORD_ACCESS)}
        })
      for reference please see line:100 to line:105
    https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platforms/tree/Platform/NXP/LS1046aRdbPkg/AcpiTables/Dsdt/CPU.asl?h=LX2160_UEFI_ACPI_EAR3
    2. This feature is tested on LS1046A platform

 drivers/acpi/Kconfig                |  2 +-
 drivers/acpi/processor_throttling.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7540a5179a47..78b3e45f05e0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -274,7 +274,7 @@ config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || IA64 || ARM64
 	select ACPI_PROCESSOR_IDLE
-	select ACPI_CPU_FREQ_PSS if X86 || IA64
+	select ACPI_CPU_FREQ_PSS if X86 || IA64 || ARM64
 	default y
 	help
 	  This driver adds support for the ACPI Processor package. It is required
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index a0bd56ece3ff..8ace1fb76712 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -767,6 +767,7 @@ static int acpi_read_throttling_status(struct acpi_processor *pr,
 {
 	u32 bit_width, bit_offset;
 	u32 ptc_value;
+	u64 ptc_value_64;
 	u64 ptc_mask;
 	struct acpi_processor_throttling *throttling;
 	int ret = -1;
@@ -784,6 +785,17 @@ static int acpi_read_throttling_status(struct acpi_processor *pr,
 		*value = (u64) ((ptc_value >> bit_offset) & ptc_mask);
 		ret = 0;
 		break;
+	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
+		bit_width = throttling->status_register.bit_width;
+		bit_offset = throttling->status_register.bit_offset;
+
+		acpi_os_read_memory((acpi_physical_address)
+				throttling->status_register.address,
+				&ptc_value_64, (u32) (bit_width + bit_offset));
+		ptc_mask = (1UL << bit_width) - 1;
+		*value = (u64) ((ptc_value_64 >> bit_offset) & ptc_mask);
+		ret = 0;
+		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		ret = acpi_throttling_rdmsr(value);
 		break;
@@ -817,6 +829,18 @@ static int acpi_write_throttling_state(struct acpi_processor *pr,
 					(u32) (bit_width + bit_offset));
 		ret = 0;
 		break;
+	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
+		bit_width = throttling->control_register.bit_width;
+		bit_offset = throttling->control_register.bit_offset;
+		ptc_mask = (1UL << bit_width) - 1;
+		ptc_value = value & ptc_mask;
+
+		acpi_os_write_memory((acpi_physical_address)
+				throttling->control_register.address,
+					(u64) (ptc_value << bit_offset),
+					(u32) (bit_width + bit_offset));
+		ret = 0;
+		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		ret = acpi_throttling_wrmsr(value);
 		break;
-- 
2.17.1

