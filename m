Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C529940A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788107AbgJZRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:39:51 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:53653 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408264AbgJZRjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:39:51 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 09QHdAMQ004526
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 18:39:10 +0100
Received: from [167.87.42.1] ([167.87.42.1])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 09QHd6EJ017254;
        Mon, 26 Oct 2020 18:39:06 +0100
Subject: [PATCH v2] x86: pat: Do not compile stubbed functions when X86_PAT is
 off
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
 <87r1z6xxh5.fsf@nanos.tec.linutronix.de>
 <a2788ff7-c524-52de-3f45-82613410f872@siemens.com>
Message-ID: <a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com>
Date:   Mon, 26 Oct 2020 18:39:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a2788ff7-c524-52de-3f45-82613410f872@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Those are already provided by linux/io.h as stubs.

The conflict remains invisible until someone would pull linux/io.h into
memtype.c.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Change in v2:
 - correct commit message

 arch/x86/mm/pat/memtype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 8f665c352bf0..41a4ac585af3 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -800,6 +800,7 @@ void memtype_free_io(resource_size_t start, resource_size_t end)
 	memtype_free(start, end);
 }
 
+#ifdef CONFIG_X86_PAT
 int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
 {
 	enum page_cache_mode type = _PAGE_CACHE_MODE_WC;
@@ -813,6 +814,7 @@ void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
 	memtype_free_io(start, start + size);
 }
 EXPORT_SYMBOL(arch_io_free_memtype_wc);
+#endif
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				unsigned long size, pgprot_t vma_prot)
-- 
2.26.2
