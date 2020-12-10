Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52CF2D594C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389562AbgLJLdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:33:23 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389478AbgLJLam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:42 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXm1Ymdz9sXW; Thu, 10 Dec 2020 22:29:59 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        mathieu.desnoyers@efficios.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <25e6fca46fda3e2a4298448edbf654f64756eee7.1603358942.git.christophe.leroy@csgroup.eu>
References: <25e6fca46fda3e2a4298448edbf654f64756eee7.1603358942.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/3] powerpc/uaccess: Don't use "m<>" constraint with GCC 4.9
Message-Id: <160756607298.1313423.51020418885826665.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:59 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 09:29:19 +0000 (UTC), Christophe Leroy wrote:
> GCC 4.9 sometimes fails to build with "m<>" constraint in
> inline assembly.
> 
>   CC      lib/iov_iter.o
> In file included from ./arch/powerpc/include/asm/cmpxchg.h:6:0,
>                  from ./arch/powerpc/include/asm/atomic.h:11,
>                  from ./include/linux/atomic.h:7,
>                  from ./include/linux/crypto.h:15,
>                  from ./include/crypto/hash.h:11,
>                  from lib/iov_iter.c:2:
> lib/iov_iter.c: In function 'iovec_from_user.part.30':
> ./arch/powerpc/include/asm/uaccess.h:287:2: error: 'asm' operand has impossible constraints
>   __asm__ __volatile__(    \
>   ^
> ./include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                                           ^
> ./arch/powerpc/include/asm/uaccess.h:583:34: note: in expansion of macro 'unsafe_op_wrap'
>  #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
>                                   ^
> ./arch/powerpc/include/asm/uaccess.h:329:10: note: in expansion of macro '__get_user_asm'
>   case 4: __get_user_asm(x, (u32 __user *)ptr, retval, "lwz"); break; \
>           ^
> ./arch/powerpc/include/asm/uaccess.h:363:3: note: in expansion of macro '__get_user_size_allowed'
>    __get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err); \
>    ^
> ./arch/powerpc/include/asm/uaccess.h:100:2: note: in expansion of macro '__get_user_nocheck'
>   __get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
>   ^
> ./arch/powerpc/include/asm/uaccess.h:583:49: note: in expansion of macro '__get_user_allowed'
>  #define unsafe_get_user(x, p, e) unsafe_op_wrap(__get_user_allowed(x, p), e)
>                                                  ^
> lib/iov_iter.c:1663:3: note: in expansion of macro 'unsafe_get_user'
>    unsafe_get_user(len, &uiov[i].iov_len, uaccess_end);
>    ^
> make[1]: *** [scripts/Makefile.build:283: lib/iov_iter.o] Error 1
> 
> [...]

Patches 2-3 applied to powerpc/next.

[2/3] powerpc: Fix incorrect stw{, ux, u, x} instructions in __set_pte_at
      https://git.kernel.org/powerpc/c/d85be8a49e733dcd23674aa6202870d54bf5600d
[3/3] powerpc: Fix update form addressing in inline assembly
      https://git.kernel.org/powerpc/c/ff57698a9610fcf7d9c4469bf68c881eff22e2f8

cheers
