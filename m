Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F622C8DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgK3TGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:06:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51501 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgK3TGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:06:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A13D996B0F;
        Mon, 30 Nov 2020 14:05:29 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=o66
        fWbDxu+vGpURX5At9CAiXLE4=; b=PcKSpcZ9oM7uDPT45ErjBTVolofrnX5gOWt
        5OzWmzw6OvlgeCfThWvwXIplQ4mympN21xsOpMnxDezCjECOoJv1JCreZtXnv10T
        qrD4+9TpObGzh2WgBYq4+efEAAiMT8hUIr5/0w/AHO0JZvXaR6+WDh2vIvY6ucAU
        N0z09+3E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9786996B0E;
        Mon, 30 Nov 2020 14:05:29 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=ErmNPUoVS3ShlHVWHlrVlkcjC8rXScMfTvlvNDZ16wk=;
 b=Bw0KrWMDblg/4kRnvcZDyUnFY1r9HO+JDXw/iRd6daZX47gC+yXpnbXuEC6Cep2nw7oOjGT7rmmI4CkLbtRsDe8/kwpXfrvMBV96QuGZ5uv30akPbZemVGJJoXehSgzeq/3Bse/u+78jzZw8b+6ufXfqh+nQw9WyMkyeTJ+/yZs=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1249A96B0D;
        Mon, 30 Nov 2020 14:05:29 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id E65612DA09EC;
        Mon, 30 Nov 2020 14:05:27 -0500 (EST)
Date:   Mon, 30 Nov 2020 14:05:27 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>, Antony Yu <swpenim@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] __div64_32(): straighten up inline asm constraints
Message-ID: <pr6q9q72-6n62-236q-s59n-7osq71o285r9@syhkavp.arg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 02FBCF5A-333F-11EB-B898-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM version of __div64_32() encapsulates a call to __do_div64 with 
non-standard argument passing. In particular, __n is a 64-bit input 
argument assigned to r0-r1 and __rem is an output argument sharing half 
of that 40-r1 register pair.

With __n being an input argument, the compiler is in its right to 
presume that r0-r1 would still hold the value of __n past the inline 
assembly statement. Normally, the compiler would have assigned non 
overlapping registers to __n and __rem if the value for __n is needed 
again.

However, here we enforce our own register assignment and gcc fails to 
notice the conflict. In practice this doesn't cause any problem as __n 
is considered dead after the asm statement and *n is overwritten. 
However this is not always guaranteed and clang rightfully complains.

Let's fix it properly by making __n into an input-output variable. This 
makes it clear that those registers representing __n have been modified. 
Then we can extract __rem as the high part of __n with plain C code.

This asm constraint "abuse" was likely relied upon back when gcc didn't 
handle 64-bit values optimally Turns out that gcc is now able to 
optimize things and produces the same code with this patch applied.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
---

This is related to the thread titled "[RESEND,PATCH] ARM: fix 
__div64_32() error when compiling with clang". My limited compile test 
with clang appears to make it happy. If no more comments I'll push this 
to RMK's patch system.

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 898e9c78a7..595e538f5b 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -21,29 +21,20 @@
  * assembly implementation with completely non standard calling convention
  * for arguments and results (beware).
  */
-
-#ifdef __ARMEB__
-#define __xh "r0"
-#define __xl "r1"
-#else
-#define __xl "r0"
-#define __xh "r1"
-#endif
-
 static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
 {
 	register unsigned int __base      asm("r4") = base;
 	register unsigned long long __n   asm("r0") = *n;
 	register unsigned long long __res asm("r2");
-	register unsigned int __rem       asm(__xh);
-	asm(	__asmeq("%0", __xh)
+	unsigned int __rem;
+	asm(	__asmeq("%0", "r0")
 		__asmeq("%1", "r2")
-		__asmeq("%2", "r0")
-		__asmeq("%3", "r4")
+		__asmeq("%2", "r4")
 		"bl	__do_div64"
-		: "=r" (__rem), "=r" (__res)
-		: "r" (__n), "r" (__base)
+		: "+r" (__n), "=r" (__res)
+		: "r" (__base)
 		: "ip", "lr", "cc");
+	__rem = __n >> 32;
 	*n = __res;
 	return __rem;
 }
