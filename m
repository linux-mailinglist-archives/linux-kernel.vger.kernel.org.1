Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72592FD8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbhATSxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390165AbhATRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+7NJAZ5HEs+o3c9ngN8mAhWOXYs+DN99Jpiq66kpMs=;
        b=Yw5rVZSwvs6aqU8vNNdV3rASPLwrytwktzAST4fNX6WhajyL0cPqWHZXXoUKkjq+g+NIWV
        tq1kRR4KPVcBrVDSkeUkDABSbEBTVgtLAEkIG+8nQunFh2GztfC7bnTrl3jAmh4ELDASed
        4MYceELonvfnd7zQFdo7CVcQp8Zbu2o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Alz-lFMbMpuPQtvTc962Mw-1; Wed, 20 Jan 2021 12:38:41 -0500
X-MC-Unique: Alz-lFMbMpuPQtvTc962Mw-1
Received: by mail-wm1-f72.google.com with SMTP id u1so1834172wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+7NJAZ5HEs+o3c9ngN8mAhWOXYs+DN99Jpiq66kpMs=;
        b=AnS0Wx0Y7vNGi5dcXHD8S7SgHETPQjV9QK8dXE6PgNDNOdgLASXjBsDSp0obtUDcJZ
         W+oRXYC9ypG1eXZpsRrsV2toOazMUmRiHSatxgkhX33mWKfBfFSty0lz3Dle0c5XwUbN
         WY9MldFxf1DHmkqu3q1NM15h8wE2tnMU7UVpJ1PdfCR9sSDjf0zSBfHkIUIaroUWF8cp
         /CyL3BDEZObzSOrGGtdEmZTyFKV1MSPCHme0dGn9zlKBnjXByNsnihd1eHfZtsHpL4lz
         JQ/XgJRHN4zW1MaTJfw76dOs1+M9qqHwzLimFLXxDjdcuufiUZwXM5AGx2xGBCkGhC7K
         Zm9w==
X-Gm-Message-State: AOAM530cKSeoxCjhX1Ob/5TaEhaC2SyVfrpAppd46f8joQKg3E0/oGo0
        LDMZxZbBVCSaS+oMS+SC9Rc9QI3RNvQ/3+V7aNCgLq83jPYCneDi+7Nd7IVK+zxrFEw2q1+2i7+
        Wt85lyEQX0ANgug2TMvyOY4dveIEF7io0LhKdCSpzcC4bYh99uOXvRGHihVWnY4uUBZ1UpCQZgp
        Fg
X-Received: by 2002:adf:fa92:: with SMTP id h18mr4344324wrr.142.1611164320568;
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDeWheflvYEpolU09LBJTJ+72qBUJL1UqdbbjxQT7QJExRg0tyCLTSK2CpCQqblVViiEwsaA==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr4344296wrr.142.1611164320375;
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 14/17] objtool: arm64: Cache section with switch table information
Date:   Wed, 20 Jan 2021 18:37:57 +0100
Message-Id: <20210120173800.1660730-15-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section ".discard.switch_table_info", created by the gcc plugin will
be looked up for every dynamic jump in the object file while the section
might not even exist.

Cache the result of the first lookup.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index 396b9c5feebd..c9c3e0bfd581 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -33,6 +33,19 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	return false;
 }
 
+static struct section *get_switch_table_info_section(struct objtool_file *file)
+{
+	static bool first = true;
+	static struct section *info_section = NULL;
+
+	if (first) {
+		first = false;
+		info_section = find_section_by_name(file->elf,
+						    ".discard.switch_table_info");
+	}
+
+	return info_section;
+}
 
 /*
  * Aarch64 jump tables are just arrays of offsets (of varying size/signess)
@@ -64,8 +77,7 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	void *sti_sec_start;
 	struct reloc *text_reloc;
 
-	table_info_sec = find_section_by_name(file->elf,
-					      ".discard.switch_table_info");
+	table_info_sec = get_switch_table_info_section(file);
 	if (!table_info_sec)
 		goto try_c_jmptbl;
 
-- 
2.25.4

