Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206832A7F87
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgKENO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:14:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:56837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKENO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604582062;
        bh=hvl3a/DWoP3yKdUCuEnO965iNCdGwTGX9IdgK9GEq0c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jhdcsWVeG7mrfIXkpGSS9ZzerLWnZEoNFfundMNdRZv1Ln4NeaWBB1INcUjv0ed0p
         KHGmWOs331ogm8AwG/7Ba6n5i5uCnbn/Gv2SfRhEzVXeH03nDh2d+XKUJh8tNQtcCn
         prAh0zp7b6qRdpzdE+eko1E7CgeTdXR1DH75X2T8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.156.55]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1kgPSP0uoV-007U0t; Thu, 05
 Nov 2020 14:14:22 +0100
Subject: Re: [PATCH seccomp 2/8] parisc: Enable seccomp architecture tracking
To:     YiFei Zhu <zhuyifei1999@gmail.com>,
        containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
 <9bb86c546eda753adf5270425e7353202dbce87c.1604410035.git.yifeifz2@illinois.edu>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <8d86100a-a3d6-d3bd-856c-38d17f363864@gmx.de>
Date:   Thu, 5 Nov 2020 14:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9bb86c546eda753adf5270425e7353202dbce87c.1604410035.git.yifeifz2@illinois.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1QVEQuqTmgX7JJqdEkHcs098MrIPbhiET1stBdJlwnGaXA8bIuH
 tW64Kumdb/ZadHYHAmwWlDtRvnkZLheeVmHw0n+SNEN6lO0J+uCOH9+wGGTIeuYOSc6tkD+
 poAVk3TTqwiGNkfCAafeLOV5nxm9gzXgw5FNQM0x8N/zUaa4fR3cbkwefeor/CrqpGOfxfy
 T4uZ6SGJcO+c06shUWGlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zm6k9jpZc6g=://srLO+3z3UASrT4Ku8wWY
 p+UVgWkCiG2npqOmCd+TK5QLisIG3vnoU2YhFnLYIE71e1Q4IMptcfHTiGv85u1mTrMoY0kfZ
 KTZLvJ7v8FqEhp2pVGf1KX9H4csbzYjrrkvc44kb6ey1Y3oXf8a9HihMRs9uUocF26PP0J8YD
 q5qHXtcd9EqlblqcKcxPWkxu03qYhf2LRCeySqppq+qyX/DcOqjJIpCJ2cKGEk7QFDoaQXL8e
 0u/1fDLCFykbgC3GmWubqefKQC8JdSXl/gMXDo/iAaqTOR6g0rd97a8dQm48IviqbhtUBhaf8
 PyzbqTbjTlenSI5sEKQIGCqtZOZTKJBv2U9IJlodWcEd0c3DXmpdgCn7uKwNFP8OncuJiucUL
 cGXR3hq+P2rRZCB/0V8qa7krrc3eHVjq9DOHcX1dj7SRbnDCgBgwYludzkk6L8utwnyiC1Xjr
 qR+s7JF9tOtkYd01gdSUPntspUMyMdRdebTHbleMyWGItnsFbL+PTamgIYoxUsfkwPcZhpeNp
 4CH64IYJP3g2l23FC+hImWEzv0jDAXc1pEQmSiWPABYQbY/pU0wvID33YJM82r6f1hlGW5uvK
 wwOyIeJE2cYO48ufw3obHECg2+5RtrsOl7F/VREpnsiVWs/U9bR0QPyQ0m+bY+61jL7vkdbMH
 04GlOp/982qPBnN8KRa6tRQaxUiRbsnZAJu2VW1uMPStt8nJcMBhY2q5TTs67A/oBUmSJP/nm
 XVpPohmauLQH5UhaenS4gWSGJoUbUbz+XaMDlt1r0pToJy7t6fu9S4AM/cNtXIIBkFXnF8teV
 S2Wcc+gjGH/vA6WJTIuk0rdPbqRvytWlYR1X6pGzX5mhxES8Qx5WA35R9/Ulq9k0GNJho9zsv
 T6nB6eRPQ2R6CfvK3qcA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 2:42 PM, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size. Add these
> for parisc.
> > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

I did compile- and boot-tested it, works on 32- and 64-bit parisc kernel.
I don't know how to test it actually, but anyway:

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>  arch/parisc/include/asm/Kbuild    |  1 -
>  arch/parisc/include/asm/seccomp.h | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 arch/parisc/include/asm/seccomp.h
>
> diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kb=
uild
> index e3ee5c0bfe80..f16c4db80116 100644
> --- a/arch/parisc/include/asm/Kbuild
> +++ b/arch/parisc/include/asm/Kbuild
> @@ -5,5 +5,4 @@ generated-y +=3D syscall_table_c32.h
>  generic-y +=3D kvm_para.h
>  generic-y +=3D local64.h
>  generic-y +=3D mcs_spinlock.h
> -generic-y +=3D seccomp.h
>  generic-y +=3D user.h
> diff --git a/arch/parisc/include/asm/seccomp.h b/arch/parisc/include/asm=
/seccomp.h
> new file mode 100644
> index 000000000000..b058b2220322
> --- /dev/null
> +++ b/arch/parisc/include/asm/seccomp.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_SECCOMP_H
> +#define _ASM_SECCOMP_H
> +
> +#include <asm-generic/seccomp.h>
> +
> +#ifdef CONFIG_64BIT
> +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_PARISC64
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"parisc64"
> +# ifdef CONFIG_COMPAT
> +#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_PARISC
> +#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
> +#  define SECCOMP_ARCH_COMPAT_NAME	"parisc"
> +# endif
> +#else /* !CONFIG_64BIT */
> +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_PARISC
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"parisc"
> +#endif
> +
> +#endif /* _ASM_SECCOMP_H */
>

