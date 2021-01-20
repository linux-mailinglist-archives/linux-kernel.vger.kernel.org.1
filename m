Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB02FD8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbhATSys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:54:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390116AbhATRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHhNdzHCl7p80Y/M7nY7DxKk34o5+fUa+j9rxomz5s4=;
        b=WuXuTBDi8bQ3vMwLCsxMo2Pxya3H25uhuJhr3pHx1ONHItK6owHwv3Da+G+XbjDkzrV/rK
        i2iRWAC9s1vTeWlKQDT2VWrAgd7X0+tSDkfsG5wiCHK2GVUkQcRG/TKn3nCYTxBuUd0JzS
        5s02ITNTCgzpgo+6y0/r5RHdFMlrRqk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-B-2ongoVODujxmHf_GQ-1g-1; Wed, 20 Jan 2021 12:38:37 -0500
X-MC-Unique: B-2ongoVODujxmHf_GQ-1g-1
Received: by mail-wm1-f69.google.com with SMTP id x20so1837997wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHhNdzHCl7p80Y/M7nY7DxKk34o5+fUa+j9rxomz5s4=;
        b=HgyLwDTA34Dn4gFl/p521x9LLL8kQB3CDhU6SVGnqDgR/CHo132pgwfPTf12L23kjO
         bETJKwJWEDXvVrS+oKPe9oFTiZIMmL3A2K3lMtEaW3kz2lzjUHM36rF4PuxE95h4HSMq
         oBe/R9J30OheRNvxJMa51/EzP5XAuewfJ2cr5ILngInQW/6xeOZg3QKM6qE/BhIvZkcT
         L+qLD1haLyDwU7N3WleJgNHUrClRbGAvL2WQ0o8TvMkDsSwHWZ/27N8BiFT7fkoaC4tp
         sP+/+Kv8ug+4Is2JzJjWGsgY1Ii/V0M9smZUTd6l/2AoxYSKU6UfnPttvPjuRX2/aefd
         4hUQ==
X-Gm-Message-State: AOAM532PDjDRuYR3wO7//3Tn6w6Hzd9kT2EdZmwiRl286GmWcsOydhcM
        ZQ0MOLZixIAOECCIIF2BkrzaqFodAprvPqup16OsHMrZatJTos1pd3gQVSHFU+xRno0IvHNY0/7
        Biz3Tf/20aMGclNp0eYpRU+WZoKufqzunC+Dx+yaaB/SpkfUgZeOb1eqCmI/+bQIWtlLcyz20+g
        kL
X-Received: by 2002:a5d:40d2:: with SMTP id b18mr10109915wrq.369.1611164315825;
        Wed, 20 Jan 2021 09:38:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjV6xTRe8CsL12wyOOS7WHO27yHrkDMb/ei4CrUSn1wqWS6eScNSd6CJ15BCe3ivDz3BoWUQ==
X-Received: by 2002:a5d:40d2:: with SMTP id b18mr10109889wrq.369.1611164315617;
        Wed, 20 Jan 2021 09:38:35 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:35 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Raphael Gault <raphael.gault@arm.com>,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect switch table on arm64
Date:   Wed, 20 Jan 2021 18:37:55 +0100
Message-Id: <20210120173800.1660730-13-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

This plugins comes into play before the final 2 RTL passes of GCC and
detects switch-tables that are to be outputed in the ELF and writes
information in an ".discard.switch_table_info" section which will be
used by objtool.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T.: Change section name to store switch table information,
       Make plugin Kconfig be selected rather than opt-in by user,
       Add a relocation in the switch_table_info that points to
       the jump operation itself]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/Kconfig                            |  1 +
 scripts/Makefile.gcc-plugins                  |  2 +
 scripts/gcc-plugins/Kconfig                   |  4 +
 .../arm64_switch_table_detection_plugin.c     | 85 +++++++++++++++++++
 4 files changed, 92 insertions(+)
 create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 05e17351e4f3..93a320cc8e03 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -100,6 +100,7 @@ config ARM64
 	select DMA_DIRECT_REMAP
 	select EDAC_SUPPORT
 	select FRAME_POINTER
+	select GCC_PLUGIN_SWITCH_TABLES if STACK_VALIDATION
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 952e46876329..8af322311f6b 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -46,6 +46,8 @@ ifdef CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK
 endif
 export DISABLE_ARM_SSP_PER_TASK_PLUGIN
 
+gcc-plugin-$(CONFIG_GCC_PLUGIN_SWITCH_TABLES)	+= arm64_switch_table_detection_plugin.so
+
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index ab9eb4cbe33a..76efbb97d223 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -104,4 +104,8 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
 
+config GCC_PLUGIN_SWITCH_TABLES
+	bool
+	depends on GCC_PLUGINS && ARM64
+
 endif
diff --git a/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c b/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
new file mode 100644
index 000000000000..60ef00ff2c5b
--- /dev/null
+++ b/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include "gcc-common.h"
+
+__visible int plugin_is_GPL_compatible;
+
+#define GEN_QUAD(rtx)	assemble_integer_with_op(".quad ", rtx)
+
+/*
+ * Create an array of metadata for each jump table found in the rtl.
+ * The metadata contains:
+ * - A reference to first instruction part of the RTL expanded into an
+ *   acutal jump
+ * - The number of entries in the table of offsets
+ * - A reference to each possible jump target
+ *
+ * Separate each entry with a null quad word.
+ */
+static unsigned int arm64_switchtbl_rtl_execute(void)
+{
+	rtx_insn *insn;
+	rtx_insn *labelp = NULL;
+	rtx_jump_table_data *tablep = NULL;
+	section *swt_sec;
+	section *curr_sec = current_function_section();
+
+	swt_sec = get_section(".discard.switch_table_info",
+			      SECTION_DEBUG | SECTION_EXCLUDE, NULL);
+
+	for (insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
+		/*
+		 * Find a tablejump_p INSN (using a dispatch table)
+		 */
+		if (!tablejump_p(insn, &labelp, &tablep))
+			continue;
+
+		if (labelp && tablep) {
+			rtx_code_label *label_to_jump;
+			rtvec jump_labels = tablep->get_labels();
+			int nr_labels = GET_NUM_ELEM(jump_labels);
+			int i;
+
+			label_to_jump = gen_label_rtx();
+			SET_LABEL_KIND(label_to_jump, LABEL_NORMAL);
+			emit_label_before(label_to_jump, insn);
+			LABEL_PRESERVE_P(label_to_jump) = 1;
+
+			switch_to_section(swt_sec);
+			GEN_QUAD(GEN_INT(0)); // mark separation between rela tables
+			GEN_QUAD(gen_rtx_LABEL_REF(Pmode, label_to_jump));
+			GEN_QUAD(GEN_INT(nr_labels));
+			for (i = 0; i < nr_labels; i++)
+				GEN_QUAD(gen_rtx_LABEL_REF(Pmode,
+							   label_ref_label(RTVEC_ELT(jump_labels, i))));
+			switch_to_section(curr_sec);
+			delete_insn(label_to_jump);
+		}
+	}
+	return 0;
+}
+
+#define PASS_NAME arm64_switchtbl_rtl
+
+#define NO_GATE
+#include "gcc-generate-rtl-pass.h"
+
+__visible int plugin_init(struct plugin_name_args *plugin_info,
+			  struct plugin_gcc_version *version)
+{
+	const char * const plugin_name = plugin_info->base_name;
+
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		error(G_("incompatible gcc/plugin versions"));
+		return 1;
+	}
+
+	PASS_INFO(arm64_switchtbl_rtl, "final", 1,
+		  PASS_POS_INSERT_BEFORE);
+
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  NULL, &arm64_switchtbl_rtl_pass_info);
+
+	return 0;
+}
-- 
2.25.4

