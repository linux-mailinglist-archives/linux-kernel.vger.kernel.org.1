Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C5E2E2D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 08:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgLZHgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 02:36:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45243 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgLZHgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 02:36:48 -0500
Received: from [IPv6:2601:646:8680:a581:d14d:32a7:89c6:43d1] ([IPv6:2601:646:8680:a581:d14d:32a7:89c6:43d1])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 0BQ7ZZEF1648151
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 25 Dec 2020 23:35:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0BQ7ZZEF1648151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020112401; t=1608968138;
        bh=ThqNBZY49YARTr9BrAiKVbq1UzyshrhkR+ie4Ruo14s=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=T4GiYWZ/lReUVj4BdOLSEAtIuqptLtOIrnVFzGvJuPfAQPX4tNBBadVML9mFIotsA
         u0d6SktLL4VpAZ5Qrpb7UA/eSOyS0nCWL5M8d8gFM4ndCNBsWasyUQrJn596NqsO90
         St39JeBwI/jAXaS9rYFRJEkgHuyeXZ9twQm2M8ANzWWtzL5iFlRW8ufcg4KsANjl1d
         SnU39CmDjhuDDMNvXHGvCnXISZHFj4Z3v5ow5f4GH8dXHe/VUlCefeV9lAu2MwKBpm
         ghINNq+92Q+dF/ItgyuaXIbYedEK8DSjXFpqtSi0yjwykkyIeGS4R8bf0DCTs4nYHY
         Ks9Vs8/coc6WQ==
Date:   Fri, 25 Dec 2020 23:35:28 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
References: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] arch/x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
To:     John Millikin <jmillikin@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC:     clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        John Millikin <john@john-millikin.com>
From:   hpa@zytor.com
Message-ID: <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 25, 2020 11:29:30 PM PST, John Millikin <jmillikin@gmail=2Ecom>=
 wrote:
>When compiling with Clang, the `$(CLANG_FLAGS)' variable contains
>additional flags needed to cross-compile C and Assembly sources:
>
>* `-no-integrated-as' tells clang to assemble with GNU Assembler
>=C2=A0 instead of its built-in LLVM assembler=2E This flag is set by defa=
ult
>=C2=A0 unless `LLVM_IAS=3D1' is set, because the LLVM assembler can't yet
>=C2=A0 parse certain GNU extensions=2E
>
>* `--target' sets the target architecture when cross-compiling=2E This
>=C2=A0 flag must be set for both compilation and assembly (`KBUILD_AFLAGS=
')
>=C2=A0 to support architecture-specific assembler directives=2E
>
>Signed-off-by: John Millikin <john@john-millikin=2Ecom>
>---
>=C2=A0arch/x86/Makefile | 5 +++++
>=C2=A01 file changed, 5 insertions(+)
>
>diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>index 7116da3980be=2E=2E725c65532482 100644
>--- a/arch/x86/Makefile
>+++ b/arch/x86/Makefile
>@@ -33,6 +33,11 @@ REALMODE_CFLAGS +=3D -ffreestanding
>=C2=A0REALMODE_CFLAGS +=3D -fno-stack-protector
>=C2=A0REALMODE_CFLAGS +=3D $(call __cc-option, $(CC), $(REALMODE_CFLAGS),
>-Wno-address-of-packed-member)
>=C2=A0REALMODE_CFLAGS +=3D $(call __cc-option, $(CC), $(REALMODE_CFLAGS),
>$(cc_stack_align4))
>+
>+ifdef CONFIG_CC_IS_CLANG
>+REALMODE_CFLAGS +=3D $(CLANG_FLAGS)
>+endif
>+
>=C2=A0export REALMODE_CFLAGS
>=C2=A0
>=C2=A0# BITS is used as extension for files which are available in a 32 b=
it

Why is CLANG_FLAGS non-null when unused? It would be better to centralize =
that=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
