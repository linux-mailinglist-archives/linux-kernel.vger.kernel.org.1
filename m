Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5297E27329B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgIUTQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:16:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53612 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIUTQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:16:26 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4326720B7179;
        Mon, 21 Sep 2020 12:16:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4326720B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600715785;
        bh=8CDBkbWqi7jmeptriwB/XXPzNgTpQrUhkmwhC0B3WfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SORF9vuuTF03n1R5hJEerbQWL4I5UPCnmvwaI5zdUutoxgFStNev8cAgJzBHuYqqs
         lV88R9zHaLS/WndpgM4eQEUPdWznSxtO3IIyZ840qqqrLw3Z2JxF4gUiTuPEB6EBBx
         kVI03gCK9NcvQ5QQwY+XRhSLkVPHgzxizluyN7V0=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: Extend the kernel command line from the bootloader
Date:   Mon, 21 Sep 2020 14:15:57 -0500
Message-Id: <20200921191557.350256-3-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide support for additional kernel command line parameters to be
concatenated onto the end of the command line provided by the
bootloader. Additional parameters are specified in the CONFIG_CMDLINE
option when CONFIG_CMDLINE_EXTEND is selected, matching other
architectures and leveraging existing support in the FDT and EFI stub
code.

Special care must be taken for the arch-specific nokaslr parsing. Search
the bootargs FDT property and the CONFIG_CMDLINE when
CONFIG_CMDLINE_EXTEND is in use.

There are a couple of known use cases for this feature:

1) Switching between stable and development kernel versions, where one
   of the versions benefits from additional command line parameters,
   such as debugging options.
2) Specifying additional command line parameters, for additional tuning
   or debugging, when the bootloader does not offer an interactive mode.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 arch/arm64/Kconfig        | 23 ++++++++++++++++++++++-
 arch/arm64/kernel/kaslr.c |  9 ++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e5eb6a69b1e3..466df3415fff 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1864,15 +1864,36 @@ config CMDLINE
 	  entering them here. As a minimum, you should specify the the
 	  root device (e.g. root=/dev/nfs).
 
+choice
+	prompt "Kernel command line type" if CMDLINE != ""
+	default CMDLINE_FROM_BOOTLOADER
+	help
+	  Choose how the kernel will handle the provided default kernel
+	  command line string.
+
+config CMDLINE_FROM_BOOTLOADER
+	bool "Use bootloader kernel arguments if available"
+	help
+	  Uses the command-line options passed by the boot loader. If
+	  the boot loader doesn't provide any, the default kernel command
+	  string provided in CMDLINE will be used.
+
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	help
+	  The command-line arguments provided by the boot loader will be
+	  appended to the default kernel command string.
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
-	depends on CMDLINE != ""
 	help
 	  Always use the default kernel command string, even if the boot
 	  loader passes other arguments to the kernel.
 	  This is useful if you cannot or don't want to change the
 	  command-line options your boot loader passes to the kernel.
 
+endchoice
+
 config EFI_STUB
 	bool
 
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 4c779a67c2a6..0921aa1520b0 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -71,7 +71,14 @@ static __init bool is_kaslr_disabled_cmdline(void *fdt)
 		prop = fdt_getprop(fdt, node, "bootargs", NULL);
 		if (!prop)
 			goto out;
-		return cmdline_contains_nokaslr(prop);
+
+		if (cmdline_contains_nokaslr(prop))
+			return true;
+
+		if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+			goto out;
+
+		return false;
 	}
 out:
 	return cmdline_contains_nokaslr(CONFIG_CMDLINE);
-- 
2.25.1

