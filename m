Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7901E2B145A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 03:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKMCkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 21:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgKMCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 21:40:42 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEDC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 18:40:41 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdP0q-004lse-UG; Fri, 13 Nov 2020 02:40:33 +0000
Date:   Fri, 13 Nov 2020 02:40:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ansuelsmth@gmail.com, 'Will Deacon' <will@kernel.org>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Pavel Tatashin' <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: R: [PATCH] arm64: fix missing include in asm uaccess.h
Message-ID: <20201113024032.GF3576660@ZenIV.linux.org.uk>
References: <20201111004440.8783-1-ansuelsmth@gmail.com>
 <20201111005826.GY3576660@ZenIV.linux.org.uk>
 <20201111010910.GZ3576660@ZenIV.linux.org.uk>
 <000001d6b7c8$bfed23e0$3fc76ba0$@gmail.com>
 <20201112164809.81f1c14f5d1f1d998f279287@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112164809.81f1c14f5d1f1d998f279287@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 04:48:09PM -0800, Andrew Morton wrote:

> [viro@zeniv.linux.org.uk: use linux/uaccess.h]
>   Link: https://lkml.kernel.org/r/20201111005826.GY3576660@ZenIV.linux.org.uk
> Link: https://lkml.kernel.org/r/20201111004440.8783-1-ansuelsmth@gmail.com
> Fixes: df325e05a682 ("arm64: Validate tagged addresses in access_ok() called from kernel threads")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/arm64/include/asm/uaccess.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/arch/arm64/include/asm/uaccess.h~arm64-fix-missing-include-in-asm-uaccessh
> +++ a/arch/arm64/include/asm/uaccess.h
> @@ -7,6 +7,8 @@
>  #ifndef __ASM_UACCESS_H
>  #define __ASM_UACCESS_H
>  
> +#include <linux/uaccess.h>
> +
>  #include <asm/alternative.h>
>  #include <asm/kernel-pgtable.h>
>  #include <asm/sysreg.h>

Huh?  You are creating a loop for no reason whatsoever.  Again,
	* asm/uaccess.h should be included only by linux/uaccess.h
	* asm/uaccess.h should NOT, NOT, NOT! include linux/uaccess.h
	* any place other than linux/uaccess.h that includes asm/uaccess.h,
should include linux/uaccess.h instead (assuming it really needs either of
those).

The last one applies to arch/arm64/include/asm-prototypes.h - the include
of asm/uaccess.h there should be replaced with include of linux/uaccess.h.

diff --git a/arch/arm64/include/asm/asm-prototypes.h b/arch/arm64/include/asm/asm-prototypes.h
index 1c9a3a0c5fa5..80077350dbc5 100644
--- a/arch/arm64/include/asm/asm-prototypes.h
+++ b/arch/arm64/include/asm/asm-prototypes.h
@@ -15,7 +15,7 @@
 #include <asm/ftrace.h>
 #include <asm/page.h>
 #include <asm/string.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include <asm-generic/asm-prototypes.h>
 
diff --git a/arch/nds32/math-emu/fpuemu.c b/arch/nds32/math-emu/fpuemu.c
index 46558a15c0dc..6fabf75c19b3 100644
--- a/arch/nds32/math-emu/fpuemu.c
+++ b/arch/nds32/math-emu/fpuemu.c
@@ -2,7 +2,7 @@
 // Copyright (C) 2005-2018 Andes Technology Corporation
 
 #include <asm/bitfield.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/sfp-machine.h>
 #include <asm/fpuemu.h>
 #include <asm/nds32_fpu_inst.h>
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index d0c2db0e07fa..3a4468cd21b9 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -12,7 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/file.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/kvm_book3s.h>
 #include <asm/kvm_ppc.h>
 #include <asm/hvcall.h>
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 3adcf730f478..93aaeaf24151 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -27,7 +27,7 @@
 #include <asm/sections.h>
 #include <asm/smp.h>
 #include <asm/trace.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/ultravisor.h>
 
 #include <trace/events/thp.h>
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 85a1a4533cbe..88b74ddd88f0 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -47,7 +47,7 @@
 #include <asm/ccwdev.h>
 #include <asm/ccwgroup.h>
 #include <linux/bitops.h>	/* instead of <asm/bitops.h> ok ? */
-#include <linux/uaccess.h>	/* instead of <asm/uaccess.h> ok ? */
+#include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
 #include <asm/idals.h>
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index c7c6e8b8344d..3743957e207f 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -8,6 +8,11 @@
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
+/*
+ * NOTE: This is the one and only place that has any business trying
+ * to include asm/uaccess.h; if you see such include anywhere else,
+ * kill it.
+ */
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_SET_FS
