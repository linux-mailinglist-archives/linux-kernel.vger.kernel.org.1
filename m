Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB15A2CB4C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgLBF5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:57:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLBF5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:57:30 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 00:57:30 EST
Received: from [IPv6:2601:646:8680:a581:c193:6030:78e:4f19] ([IPv6:2601:646:8680:a581:c193:6030:78e:4f19])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0B25nN3V155135
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 1 Dec 2020 21:49:25 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0B25nN3V155135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020112401; t=1606888166;
        bh=lZoblTuZ444n2VQoIdUJL4/MfqKhqZBv8uTRQf1VZY4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=XND2Rhi/utuc5YnXZUnHFKLdV6vb8JXm6AWHHdCTsA8laaJzGEI7T8Lewd10hK03L
         /KxJc5u+zVu39wb73d9if8kXn9sYEzqDFdB+mY3GizF9mzy3ZlqyWWb8fdFJZcUSWy
         BH+A7E0dSBXux8GsqSc8OYttWzD6sssQcReZqgjZrvvE8WjV51GJgW17tliE2ADO3V
         rBwN7ldujS2cKofXyA2ozrcKgYPH2TY2RNnCr7R48HZ8i+aJr4eVk7xQ3WPXChDACc
         JJivUgsMsm1ow4qPnzNNdf9Z45s2YMTOh8Ye42/QeUHdTmdEocLb7dRhgtnI2geMjN
         lO+AerWfBD4YA==
Date:   Tue, 01 Dec 2020 21:49:15 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20201201011307.3676986-1-ndesaulniers@google.com>
References: <20201201011307.3676986-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86, build: remove -m16 workaround for unsupported versions of GCC
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     David Woodhouse <dwmw2@infradead.org>, x86@kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
From:   hpa@zytor.com
Message-ID: <E9235D82-F8D5-43E0-B990-C2F0410A997C@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 30, 2020 5:13:06 PM PST, Nick Desaulniers <ndesaulniers@google=
=2Ecom> wrote:
>A revert of the following two commits=2E
>commit de3accdaec88 ("x86, build: Build 16-bit code with -m16 where
>possible")
>commit a9cfccee6604 ("x86, build: Change code16gcc=2Eh from a C header to
>an assembly header")
>
>Since commit 0bddd227f3dc ("Documentation: update for gcc 4=2E9
>requirement") the minimum supported version of GCC is gcc-4=2E9=2E  It's
>now
>safe to remove this code=2E
>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google=2Ecom>
>---
> arch/x86/Makefile         |  9 +--------
> arch/x86/boot/code16gcc=2Eh | 12 ------------
> 2 files changed, 1 insertion(+), 20 deletions(-)
> delete mode 100644 arch/x86/boot/code16gcc=2Eh
>
>diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>index 1bf21746f4ce=2E=2E7116da3980be 100644
>--- a/arch/x86/Makefile
>+++ b/arch/x86/Makefile
>@@ -24,14 +24,7 @@ endif
>=20
># How to compile the 16-bit code=2E  Note we always compile for
>-march=3Di386;
> # that way we can complain to the user if the CPU is insufficient=2E
>-#
>-# The -m16 option is supported by GCC >=3D 4=2E9 and clang >=3D 3=2E5=2E=
 For
>-# older versions of GCC, include an *assembly* header to make sure
>that
>-# gcc doesn't play any games behind our back=2E
>-CODE16GCC_CFLAGS :=3D -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc=2Eh
>-M16_CFLAGS	 :=3D $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
>-
>-REALMODE_CFLAGS	:=3D $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
>+REALMODE_CFLAGS	:=3D -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
> 		   -Wall -Wstrict-prototypes -march=3Di386 -mregparm=3D3 \
> 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
> 		   -mno-mmx -mno-sse
>diff --git a/arch/x86/boot/code16gcc=2Eh b/arch/x86/boot/code16gcc=2Eh
>deleted file mode 100644
>index e19fd7536307=2E=2E000000000000
>--- a/arch/x86/boot/code16gcc=2Eh
>+++ /dev/null
>@@ -1,12 +0,0 @@
>-/* SPDX-License-Identifier: GPL-2=2E0 */
>-#
>-# code16gcc=2Eh
>-#
>-# This file is added to the assembler via -Wa when compiling 16-bit C
>code=2E
>-# This is done this way instead via asm() to make sure gcc does not
>reorder
>-# things around us=2E
>-#
>-# gcc 4=2E9+ has a real -m16 option so we can drop this hack long term=
=2E
>-#
>-
>-	=2Ecode16gcc

With enthusiasm:

Acked-by: H=2E Peter Anvin <hpa@zytor=2Ecom>
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
