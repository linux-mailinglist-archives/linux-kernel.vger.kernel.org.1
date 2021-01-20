Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7ED2FCB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbhATHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbhATHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:09:02 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:07:49 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x18so12015733pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FnCdmEEGSQX+RKqefc8hvZ3CGNJpcGjSObBIm4DdhU=;
        b=p121J/5GsWmVdei7cT5XCaB6DnT64K+rfFzJkY39ir4WPYYzyq7KIO+Ugk7wQBADoB
         /4iIz9ubKkAsoSDacb7idNt0mGXFoXywGrxtHOJgGQZb1+9eEODzZHSDS6w2HsIKJ/2G
         ZJNYnAqTWppIIEFDD4WpVl63Ib0GoXFFxfRSxadg+h/oJ2pIG7QrKlcTGqLz4xXQ4rwE
         MiG4iR5jL4eyqFlKlI9ucth8ysBqSN+VLpTnwlbzfiFCb/tgnZJng/F1ywROa9Byou4a
         zN9d4/FFKwnFf6SyEJdKSgaORetLdCB3ixACy0uBcpIjBnL/+Krwbk8h4FZw3rQTI2hr
         BSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FnCdmEEGSQX+RKqefc8hvZ3CGNJpcGjSObBIm4DdhU=;
        b=oRXILnXszRdEDXvX3PXpmkNbsFVabuhzsj7/qVBGEfPisqUlAMaBD/QN52oiwCBgBj
         j7p8+ws/G6FF5w/5PwCvfTSaz0/T0Z/qW8GWxc+1OMnPahHIoOY37sZOFqqcHi9VbEq5
         6PVKtSqfNafXgfslYU37tTBW4qeGoMPNruk+cfHwL/Vx5lQfY0kXGc+vhT8X6GxvTzI8
         yDSB/2RL2TLy8jHNuj+9WhQllz1nOUQjRUDUdSmSW1Sl2GkKmJbAih+fuKFLDM46bVZx
         jsoxTU08aETxtGhrm0Gh8MjNwaViX8d3k8WKXSxn9b3dcG5TPr7wztKm24ShNkNkKKxo
         uHGA==
X-Gm-Message-State: AOAM5325/bsW0WBmBxNV0URkC/IDRhUmCqqNDLdNnPGj1eC+N4VcEdZ3
        ORR+gd1voPDz7QBxTAefACLKBA==
X-Google-Smtp-Source: ABdhPJw6HkistZYcKuaCfe3iZrbqMD1djc2Dih+9k2pXvG0RRQWi68xmBHWyDXpS1CSaiT+SV5sj9g==
X-Received: by 2002:a17:90a:d255:: with SMTP id o21mr4113781pjw.151.1611126468885;
        Tue, 19 Jan 2021 23:07:48 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f29sm1128623pgm.76.2021.01.19.23.07.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 23:07:48 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: [PATCH V5 3/5] scripts: dtc: Remove the unused fdtdump.c file
Date:   Wed, 20 Jan 2021 12:36:45 +0530
Message-Id: <f63b3fd7fadf8912e8e7e8653df45b5b78f5d005.1611124778.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611124778.git.viresh.kumar@linaro.org>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was copied from external DTC repository long back and isn't used
anymore. Over that the dtc tool can be used to generate the dts source
back from the dtb. Remove the unused fdtdump.c file.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/dtc/fdtdump.c | 163 ------------------------------------------
 1 file changed, 163 deletions(-)
 delete mode 100644 scripts/dtc/fdtdump.c

diff --git a/scripts/dtc/fdtdump.c b/scripts/dtc/fdtdump.c
deleted file mode 100644
index 7d460a50b513..000000000000
--- a/scripts/dtc/fdtdump.c
+++ /dev/null
@@ -1,163 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * fdtdump.c - Contributed by Pantelis Antoniou <pantelis.antoniou AT gmail.com>
- */
-
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <ctype.h>
-
-#include <fdt.h>
-#include <libfdt_env.h>
-
-#include "util.h"
-
-#define ALIGN(x, a)	(((x) + ((a) - 1)) & ~((a) - 1))
-#define PALIGN(p, a)	((void *)(ALIGN((unsigned long)(p), (a))))
-#define GET_CELL(p)	(p += 4, *((const uint32_t *)(p-4)))
-
-static void print_data(const char *data, int len)
-{
-	int i;
-	const char *p = data;
-
-	/* no data, don't print */
-	if (len == 0)
-		return;
-
-	if (util_is_printable_string(data, len)) {
-		printf(" = \"%s\"", (const char *)data);
-	} else if ((len % 4) == 0) {
-		printf(" = <");
-		for (i = 0; i < len; i += 4)
-			printf("0x%08x%s", fdt32_to_cpu(GET_CELL(p)),
-			       i < (len - 4) ? " " : "");
-		printf(">");
-	} else {
-		printf(" = [");
-		for (i = 0; i < len; i++)
-			printf("%02x%s", *p++, i < len - 1 ? " " : "");
-		printf("]");
-	}
-}
-
-static void dump_blob(void *blob)
-{
-	struct fdt_header *bph = blob;
-	uint32_t off_mem_rsvmap = fdt32_to_cpu(bph->off_mem_rsvmap);
-	uint32_t off_dt = fdt32_to_cpu(bph->off_dt_struct);
-	uint32_t off_str = fdt32_to_cpu(bph->off_dt_strings);
-	struct fdt_reserve_entry *p_rsvmap =
-		(struct fdt_reserve_entry *)((char *)blob + off_mem_rsvmap);
-	const char *p_struct = (const char *)blob + off_dt;
-	const char *p_strings = (const char *)blob + off_str;
-	uint32_t version = fdt32_to_cpu(bph->version);
-	uint32_t totalsize = fdt32_to_cpu(bph->totalsize);
-	uint32_t tag;
-	const char *p, *s, *t;
-	int depth, sz, shift;
-	int i;
-	uint64_t addr, size;
-
-	depth = 0;
-	shift = 4;
-
-	printf("/dts-v1/;\n");
-	printf("// magic:\t\t0x%x\n", fdt32_to_cpu(bph->magic));
-	printf("// totalsize:\t\t0x%x (%d)\n", totalsize, totalsize);
-	printf("// off_dt_struct:\t0x%x\n", off_dt);
-	printf("// off_dt_strings:\t0x%x\n", off_str);
-	printf("// off_mem_rsvmap:\t0x%x\n", off_mem_rsvmap);
-	printf("// version:\t\t%d\n", version);
-	printf("// last_comp_version:\t%d\n",
-	       fdt32_to_cpu(bph->last_comp_version));
-	if (version >= 2)
-		printf("// boot_cpuid_phys:\t0x%x\n",
-		       fdt32_to_cpu(bph->boot_cpuid_phys));
-
-	if (version >= 3)
-		printf("// size_dt_strings:\t0x%x\n",
-		       fdt32_to_cpu(bph->size_dt_strings));
-	if (version >= 17)
-		printf("// size_dt_struct:\t0x%x\n",
-		       fdt32_to_cpu(bph->size_dt_struct));
-	printf("\n");
-
-	for (i = 0; ; i++) {
-		addr = fdt64_to_cpu(p_rsvmap[i].address);
-		size = fdt64_to_cpu(p_rsvmap[i].size);
-		if (addr == 0 && size == 0)
-			break;
-
-		printf("/memreserve/ %llx %llx;\n",
-		       (unsigned long long)addr, (unsigned long long)size);
-	}
-
-	p = p_struct;
-	while ((tag = fdt32_to_cpu(GET_CELL(p))) != FDT_END) {
-
-		/* printf("tag: 0x%08x (%d)\n", tag, p - p_struct); */
-
-		if (tag == FDT_BEGIN_NODE) {
-			s = p;
-			p = PALIGN(p + strlen(s) + 1, 4);
-
-			if (*s == '\0')
-				s = "/";
-
-			printf("%*s%s {\n", depth * shift, "", s);
-
-			depth++;
-			continue;
-		}
-
-		if (tag == FDT_END_NODE) {
-			depth--;
-
-			printf("%*s};\n", depth * shift, "");
-			continue;
-		}
-
-		if (tag == FDT_NOP) {
-			printf("%*s// [NOP]\n", depth * shift, "");
-			continue;
-		}
-
-		if (tag != FDT_PROP) {
-			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n", depth * shift, "", tag);
-			break;
-		}
-		sz = fdt32_to_cpu(GET_CELL(p));
-		s = p_strings + fdt32_to_cpu(GET_CELL(p));
-		if (version < 16 && sz >= 8)
-			p = PALIGN(p, 8);
-		t = p;
-
-		p = PALIGN(p + sz, 4);
-
-		printf("%*s%s", depth * shift, "", s);
-		print_data(t, sz);
-		printf(";\n");
-	}
-}
-
-
-int main(int argc, char *argv[])
-{
-	char *buf;
-
-	if (argc < 2) {
-		fprintf(stderr, "supply input filename\n");
-		return 5;
-	}
-
-	buf = utilfdt_read(argv[1]);
-	if (buf)
-		dump_blob(buf);
-	else
-		return 10;
-
-	return 0;
-}
-- 
2.25.0.rc1.19.g042ed3e048af

