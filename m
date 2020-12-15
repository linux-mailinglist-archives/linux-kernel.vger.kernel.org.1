Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0002DAECD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgLOOVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727407AbgLOOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608041980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z3TqDXYTrGVqsSIDRniqa/WcfXLe/DQvrpWiN/hP9FQ=;
        b=JkcHFYBU8YZyojdUocxbLjOm/2k29XH5MuNJ3o2tZsiZ94ly3Cb+sBBKWxbcx15OwTDYwc
        IqQ0VsKNMXsp0InaD4B0eHlACJxCHUlC8Q275Z4wehqg1H6Bmsz7tcEeQC54qgcCTG1Wz0
        L5H1Y9EDTVhuQj4hLU1kRBbcrDSyHNQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-S_iqSNG5PA-DLqlKTKiNkg-1; Tue, 15 Dec 2020 09:19:39 -0500
X-MC-Unique: S_iqSNG5PA-DLqlKTKiNkg-1
Received: by mail-qt1-f200.google.com with SMTP id e14so14429513qtr.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3TqDXYTrGVqsSIDRniqa/WcfXLe/DQvrpWiN/hP9FQ=;
        b=kBdF/3eYPdOeqo3bY1WjGRNWAx8TQhpnhpLFsQc68lVhnPaOsxazttIePuu/9BCjub
         6T4yJkC9zmJRFjs4RjoIxdI/v9k6DorVqZWnxE4+4oxvnrDUqEq0R9SSgqZN29fq0EW0
         o0EgzAigNmwniE+ZhEcCaDFe7VNU5RXbaTIs049nZaQ4Fpoa172TOm/+TN5lliMCE/t7
         Vruyp3fOKfcj2vOQzLvx+AxPRL8W56KVIf+4vwxcAL9XPCnLXKb3AY8NmQZaGRHquUO2
         ySQ10XVl1eHDzK5AuMncUQh+Ik1kN+D1e/cJfdyS0B4tohe5sj2wOS7jc9mDFmwISoJ4
         f8uA==
X-Gm-Message-State: AOAM531U1FgayohC0SxRg4Rxu1tbaT4HF6XMqr7OJZMWVC90leyZb8Sr
        fLK5fx0Du3EL1T4oTa4mh5GZWDhf0BZ3tJ1vCppjbEkci9IekxUIa7CKQ4ajHJZXtiJ2u9BZjEx
        F8SqRD8sGHFG+t+sRhe/45A+5
X-Received: by 2002:a37:478d:: with SMTP id u135mr38765551qka.18.1608041978713;
        Tue, 15 Dec 2020 06:19:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+ZzZa0WD/Ej4vI9fS/ZixPp7H1H8UZ20hRDiXxOQEVAg58/9K8bvm/hRxltPP57NZ2fsTrw==
X-Received: by 2002:a37:478d:: with SMTP id u135mr38765529qka.18.1608041978553;
        Tue, 15 Dec 2020 06:19:38 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x65sm15956032qkc.130.2020.12.15.06.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:19:37 -0800 (PST)
From:   trix@redhat.com
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mm: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:19:31 -0800
Message-Id: <20201215141931.1842379-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/mm/fault.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 907b54d3b990..4bc4c9a6a8ae 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -486,13 +486,13 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 	}
 
 	if (offset + sizeof(struct ldttss_desc) >= gdt->size) {
-		pr_alert("%s: 0x%hx -- out of bounds\n", name, index);
+		pr_alert("%s: 0x%x -- out of bounds\n", name, index);
 		return;
 	}
 
 	if (copy_from_kernel_nofault(&desc, (void *)(gdt->address + offset),
 			      sizeof(struct ldttss_desc))) {
-		pr_alert("%s: 0x%hx -- GDT entry is not readable\n",
+		pr_alert("%s: 0x%x -- GDT entry is not readable\n",
 			 name, index);
 		return;
 	}
@@ -501,7 +501,7 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 #ifdef CONFIG_X86_64
 	addr |= ((u64)desc.base3 << 32);
 #endif
-	pr_alert("%s: 0x%hx -- base=0x%lx limit=0x%x\n",
+	pr_alert("%s: 0x%x -- base=0x%lx limit=0x%x\n",
 		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
 }
 
@@ -569,7 +569,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		/* Usable even on Xen PV -- it's just slow. */
 		native_store_gdt(&gdt);
 
-		pr_alert("IDT: 0x%lx (limit=0x%hx) GDT: 0x%lx (limit=0x%hx)\n",
+		pr_alert("IDT: 0x%lx (limit=0x%x) GDT: 0x%lx (limit=0x%x)\n",
 			 idt.address, idt.size, gdt.address, gdt.size);
 
 		store_ldt(ldtr);
-- 
2.27.0

