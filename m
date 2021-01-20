Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600BE2FD8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbhATSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:54:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390146AbhATRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItOqFi7Hkwlfc8KmljIH1mggd+0HU8t9o2eCKjOp56I=;
        b=ijE99I4Yucd8Y6nh5XnVLMTyvCbWbFYR+PZox87tVKXwySkxckvFMzOnqf3jMw5k0UJWbB
        yOuaJch9u974dJWiIRmXKBv68SPyNsjq+zR+Ds5nVzt2hVP7pQNHZ7HW0Z7Q/O4gsbE892
        4GX2n2e4tjpORy2keLs+nuMQLIe6WUE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-7hT70bAwMZuB57xJpH99Dg-1; Wed, 20 Jan 2021 12:38:39 -0500
X-MC-Unique: 7hT70bAwMZuB57xJpH99Dg-1
Received: by mail-wr1-f70.google.com with SMTP id v7so11878774wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItOqFi7Hkwlfc8KmljIH1mggd+0HU8t9o2eCKjOp56I=;
        b=QajCQb1bMos95WYRf8rkpAWcSTe24BNHYQIMbpknZ6hiPojxS95/CE0HDaYx7USla3
         o0myL5lBmcJrI5lljervAHRbsTsW9+vtMunHHB+2wU2fVm2oXKdFMO3FBcXycMhC5Bes
         KR3lDaZbwGijc8f189mLyjXpofBkLzXaBiCWYGtD3k1YkoVOP34QLc8cj8dSToAcMQSp
         pENoziAlXquGJEmdD2GlI7eP5sqkLqxzWuwqJlw293eyAlrgFn6oN3TR6XRxbLRBY1GW
         7vdEHiTQQ90btWkQZoPphfSQ4fqVwW6gC4D50qCu33AoqLbZpfwhoffaFnzqHEe0Lbt5
         1w7w==
X-Gm-Message-State: AOAM532j8FMUq5NuEeFoZnTlm+CaF/DXC0jYaBbXN3GJgyZJVbRCSwUB
        wRHfYX1T0BZwciiRUMYownI0W/GLKOOA0uKfbUjHJ2RZ93sPTLY4/Jr5yoTRs1idlYtkfn3qD34
        N3UMR2dH5vVVoVdhmBv04c2p3EaEyE7IJGNq7Mk5//4yZ4JQhZtKbws8Q6uzKPP4yc9E2zujDjC
        cD
X-Received: by 2002:adf:e705:: with SMTP id c5mr10165923wrm.303.1611164318377;
        Wed, 20 Jan 2021 09:38:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyI7z1jfE1krdbjitvV3YQPLDza0TWB9nv2zK4QcJTxmxyvfDnFk8J4YJ4dvyZr3q+eSQSNsg==
X-Received: by 2002:adf:e705:: with SMTP id c5mr10165894wrm.303.1611164318164;
        Wed, 20 Jan 2021 09:38:38 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:37 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC PATCH 13/17] objtool: arm64: Implement functions to add switch tables alternatives
Date:   Wed, 20 Jan 2021 18:37:56 +0100
Message-Id: <20210120173800.1660730-14-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the functions required to identify and add as
alternatives all the possible destinations of the switch table.
This implementation relies on the new plugin introduced previously which
records information about the switch-table in a
.discard.switch_table_information section.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T.: Update arch implementation to new prototypes,
       Update switch table information section name,
       Do some clean up,
       Use the offset sign information,
       Use the newly added rela to find the corresponding jump instruction]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 .../objtool/arch/arm64/include/arch/special.h |  2 +
 tools/objtool/arch/arm64/special.c            | 85 +++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/objtool/arch/arm64/include/arch/special.h b/tools/objtool/arch/arm64/include/arch/special.h
index a82a9b3e51df..b96bcee308cf 100644
--- a/tools/objtool/arch/arm64/include/arch/special.h
+++ b/tools/objtool/arch/arm64/include/arch/special.h
@@ -3,6 +3,8 @@
 #ifndef _ARM64_ARCH_SPECIAL_H
 #define _ARM64_ARCH_SPECIAL_H
 
+#include <linux/types.h>
+
 #define EX_ENTRY_SIZE		8
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index 45f283283091..396b9c5feebd 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -1,6 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <stdlib.h>
+#include <string.h>
+
+#include <asm/aarch64-insn.h>
+
 #include <objtool/special.h>
+#include <objtool/warn.h>
+#include <arch/special.h>
+
+/*
+ * The arm64_switch_table_detection_plugin generate an array of elements
+ * described by the following structure.
+ * Each jump table found in the compilation unit is associated with one of
+ * entries of the array.
+ */
+struct switch_table_info {
+	u64 padding;
+	u64 jump_ref;
+	u64 nb_entries;
+	u64 dest_relocations[];
+} __attribute__((__packed__));
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
@@ -14,8 +34,73 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 }
 
 
+/*
+ * Aarch64 jump tables are just arrays of offsets (of varying size/signess)
+ * representing the potential destination from a base address loaded by an adr
+ * instruction.
+ *
+ * Sadly, extracting the actual offset might require to consider multiple
+ * instructions and decoding them to understand what they do. To make life
+ * easier, the gcc plugin will generate a list of relocation entries for
+ * each jump table target, conforming to the format expected by
+ * add_jump_table().
+ *
+ * Aarch64 branches to jump tables are composed of multiple instructions:
+ *
+ *     ldr<?>  x_offset, [x_offsets_table, x_index, ...]
+ *     adr     x_dest_base, <addr>
+ *     add     x_dest, x_target_base, x_offset, ...
+ *     br      x_dest
+ *
+ * The arm64_switch_table_detection_plugin will make the connection between
+ * the instruction setting x_offsets_table (jump_ref) and the list of
+ * relocations.
+ */
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				     struct instruction *insn)
 {
+	struct switch_table_info *sti;
+	struct section *table_info_sec;
+	void *sti_sec_start;
+	struct reloc *text_reloc;
+
+	table_info_sec = find_section_by_name(file->elf,
+					      ".discard.switch_table_info");
+	if (!table_info_sec)
+		goto try_c_jmptbl;
+
+	sti_sec_start = table_info_sec->data->d_buf;
+	sti = sti_sec_start;
+
+	while ((char *)sti - (char *)sti_sec_start <  table_info_sec->len) {
+		struct reloc *target_reloc = find_reloc_by_dest(file->elf,
+								table_info_sec,
+								(char *)&sti->jump_ref - (char *)sti_sec_start);
+
+		if (!target_reloc) {
+			WARN("Malformed switch table entry");
+			return NULL;
+		}
+
+		if (target_reloc->sym->sec == insn->sec &&
+		    target_reloc->addend == insn->offset)
+			return find_reloc_by_dest(file->elf, table_info_sec,
+						  (char *)&sti->dest_relocations[0] - (char *)sti_sec_start);
+
+		/* Get next jump table entry */
+		sti = (struct switch_table_info *) (&sti->dest_relocations[0] + sti->nb_entries);
+	}
+
+try_c_jmptbl:
+	text_reloc = find_reloc_by_dest(file->elf, insn->sec, insn->offset);
+	if (!text_reloc || text_reloc->sym->type != STT_SECTION ||
+	    !text_reloc->sym->sec->rodata)
+		return NULL;
+
+	/* Handle C jump tables */
+	if (!strcmp(text_reloc->sym->sec->name, C_JUMP_TABLE_SECTION))
+		return find_reloc_by_dest(file->elf, text_reloc->sym->sec,
+					  text_reloc->addend);
+
 	return NULL;
 }
-- 
2.25.4

