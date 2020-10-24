Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90C0297BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760936AbgJXK17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 06:27:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51663 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760929AbgJXK17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 06:27:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CJHNs1yYGz9sV1; Sat, 24 Oct 2020 21:27:57 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        mathieu.desnoyers@efficios.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <212d3bc4a52ca71523759517bb9c61f7e477c46a.1603179582.git.christophe.leroy@csgroup.eu>
References: <212d3bc4a52ca71523759517bb9c61f7e477c46a.1603179582.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/3] powerpc/uaccess: Don't use "m<>" constraint with GCC 4.9
Message-Id: <160353524065.3419015.15517113357931210947.b4-ty@ellerman.id.au>
Date:   Sat, 24 Oct 2020 21:27:57 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 07:40:07 +0000 (UTC), Christophe Leroy wrote:
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

Patch 1 applied to powerpc/fixes.

[1/3] powerpc/uaccess: Don't use "m<>" constraint with GCC 4.9
      https://git.kernel.org/powerpc/c/592bbe9c505d9a0ef69260f8c8263df47da2698e

cheers
