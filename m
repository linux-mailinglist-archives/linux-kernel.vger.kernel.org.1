Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC221B0440
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDTIWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 04:22:55 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7674 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:22:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9d5ba10000>; Mon, 20 Apr 2020 01:21:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 01:22:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Apr 2020 01:22:54 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 08:22:54 +0000
Received: from abhsahu-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 08:22:50 +0000
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Abhishek Sahu <abhsahu@nvidia.com>
Subject: [PATCH] x86/mm: fix compilation error for unknown type name pgprot_t
Date:   Mon, 20 Apr 2020 13:52:31 +0530
Message-ID: <20200420082231.4202-1-abhsahu@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587370913; bh=Xnf7y8bSD9xXf13IUaHOpUizsvYJxEDzqXhctJyhHaY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=gEHyyQzqOGhbAngRjLJkn+zdO37qMvSCWaQN5jloxRQBOldoYb207q8Z1DEIfTA3F
         E9bFQmn/EItGYbx69j4JhaTG7AGHJ1ysuQybihTl/gAJ3awrPY9AuT4gyrgBmonQEs
         YKF6ZJvB6bk6u9gYueEw7J9lTHsG2RNv0i2GJtvSwSNzfuDa71LBXZCfLy1heR0P8j
         RCHZtu8bU+7BapTNu/sS3sQEOTVT+T3jxLcyzJ7X6kcO1qfkTCEDv/I2qLhkIVw5BM
         P7FSyDDit80zy2V9hXFRT9c4LRXR9oE2aIA3to3ZnUaWAWLeVxCNRyLpeGnvxTAxPQ
         tyh8eUiDqjOwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
added the function __set_memory_prot() which uses pgprot_t in
function prototype. The currently included header files in
<arch/x86/include/asm/set_memory.h> do not include type name
pgprot_t. The pgprot_t is defined in <asm/pgtable_types.h>.

Fixes: 30796e18c299 ("x86/mm: introduce __set_memory_prot()")
Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
---
 arch/x86/include/asm/set_memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ec2c0a094b5d..3138087b0d9a 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_SET_MEMORY_H
 
 #include <asm/page.h>
+#include <asm/pgtable_types.h>
 #include <asm-generic/set_memory.h>
 
 /*
-- 
2.17.1

