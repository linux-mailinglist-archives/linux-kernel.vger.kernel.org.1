Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D181ACC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897149AbgDPPyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506810AbgDPPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:54:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C332C061A0C;
        Thu, 16 Apr 2020 08:54:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c16so11027131qtv.1;
        Thu, 16 Apr 2020 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQhU4DjbdWpyuqVUQdoHx89tUP6DdEtCm9bIIU42nZ4=;
        b=OeglvIqNYsAhGVwtGrybgQGQhidyy109lHBX0bFl1n9Q7rpyocJoR/JGBv9IJtF9GL
         0uSvbW3gTjrU0OOo1AU/p/PZqQSz23SAmfY/AY5jSIZzv91h/peFOTp7ZTY3xM/aTFwW
         ArKo7GcVDsds711Q4RTDaAeZ6bCS0UYoBbgsNTFRGjs6MPCQymVgXTEfGz+wwVGNoXoo
         bQF+X+t9a5umUpSUnqJKtTmdt+iF/2hCIw+7xgVsNLjb53PD7EfVpX+btzD4xhWhzFjW
         XH1RejIOL7LmqxeLBIYusOI58aE8y0OE47ZYrUHQdN+IZI0J+Y+6pAxLKWmHYOKCH7aa
         BwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQhU4DjbdWpyuqVUQdoHx89tUP6DdEtCm9bIIU42nZ4=;
        b=N2bJXdstIBe3WCIUwhucG6cLcyp5bH5YVJ+oBTT4s+VgN2A946Ih3tZBU31Iwb85B/
         YKQP0ji+gBOhhgTIxUejcKR5QxO4LiyuJ342ee1Kp8arzRLUwE2FDEtUsy0LgYtkIZQC
         VPxILXkILOUk1rRJLLnpUMFxv1pxxzoHpIhJN6u8Y9jNipbSRrz/lUxsOhLwghIF7OJX
         JzFttwmcSpuiyGhcQcBPWyXLsb4Dy8RGnJ9o3ekSymygcqhtQnK0bzXULOM1R2+1o8dg
         cLChFIWl4ozD2NVDb9dOXsXsWxHFHOW0EFwqLtBHgJmohuE/MTNKD5CzLNLk8Fv2ttmu
         zTgw==
X-Gm-Message-State: AGi0PuZUsKN0hmL/1FqXa320xnnoJmdnFNC4Vg/WjTbszCCDgime2+vT
        oEKrfVzpxInIDAtMDMvsPFlV9rCO2CU=
X-Google-Smtp-Source: APiQypLSA2bYCM9D44POpaJ9cG7tOl5jZ1L78CSDiMOwqnSGusGDqC3tYuV/6BzpDS/cDMkX9BcoVA==
X-Received: by 2002:ac8:3f2c:: with SMTP id c41mr27743874qtk.338.1587052447243;
        Thu, 16 Apr 2020 08:54:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g47sm1724082qte.54.2020.04.16.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:54:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36217409A3; Thu, 16 Apr 2020 12:54:04 -0300 (-03)
Date:   Thu, 16 Apr 2020 12:54:04 -0300
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH 15/15] tools headers: Synchronize linux/bits.h with the
 kernel sources
Message-ID: <20200416155404.GE2650@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
 <20200414164854.26026-16-acme@kernel.org>
 <7951882d-d13a-7b1e-36f4-73c188015161@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7951882d-d13a-7b1e-36f4-73c188015161@arm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 15, 2020 at 10:14:06AM +0100, Vincenzo Frascino escreveu:
> On 4/14/20 5:48 PM, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > To pick up the changes in these csets:
> > 
> >   295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
> >   3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
> > 
> > To address this tools/perf build warning:
> > 
> >   Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
> >   diff -u tools/include/linux/bits.h include/linux/bits.h
> > 
> > This clashes with usage of userspace's static_assert(), that, at least
> > on glibc, is guarded by a ifnded/endif pair, do the same to our copy of
> > build_bug.h and avoid that diff in check_headers.sh so that we continue
> > checking for drifts with the kernel sources master copy.
> > 
> > This will all be tested with the set of build containers that includes
> > uCLibc, musl libc, lots of glibc versions in lots of distros and cross
> > build environments.
> > 
> > The tools/objtool, tools/bpf, etc were tested as well.
> >
> 
> Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com> # vDSO parts

Hey, thanks a lot for checking it! :-)

- Arnaldo
 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/include/linux/bits.h      | 24 ++++++++--
> >  tools/include/linux/build_bug.h | 82 +++++++++++++++++++++++++++++++++
> >  tools/include/linux/kernel.h    |  4 +-
> >  tools/include/vdso/bits.h       |  9 ++++
> >  tools/perf/check-headers.sh     |  2 +
> >  5 files changed, 115 insertions(+), 6 deletions(-)
> >  create mode 100644 tools/include/linux/build_bug.h
> >  create mode 100644 tools/include/vdso/bits.h
> > 
> > diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> > index 669d69441a62..4671fbf28842 100644
> > --- a/tools/include/linux/bits.h
> > +++ b/tools/include/linux/bits.h
> > @@ -3,9 +3,9 @@
> >  #define __LINUX_BITS_H
> >  
> >  #include <linux/const.h>
> > +#include <vdso/bits.h>
> >  #include <asm/bitsperlong.h>
> >  
> > -#define BIT(nr)			(UL(1) << (nr))
> >  #define BIT_ULL(nr)		(ULL(1) << (nr))
> >  #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
> >  #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > @@ -18,12 +18,30 @@
> >   * position @h. For example
> >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> >   */
> > -#define GENMASK(h, l) \
> > +#if !defined(__ASSEMBLY__) && \
> > +	(!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
> > +#include <linux/build_bug.h>
> > +#define GENMASK_INPUT_CHECK(h, l) \
> > +	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > +		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +#else
> > +/*
> > + * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > + * disable the input check if that is the case.
> > + */
> > +#define GENMASK_INPUT_CHECK(h, l) 0
> > +#endif
> > +
> > +#define __GENMASK(h, l) \
> >  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
> >  	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > +#define GENMASK(h, l) \
> > +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >  
> > -#define GENMASK_ULL(h, l) \
> > +#define __GENMASK_ULL(h, l) \
> >  	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> >  	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> > +#define GENMASK_ULL(h, l) \
> > +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> >  
> >  #endif	/* __LINUX_BITS_H */
> > diff --git a/tools/include/linux/build_bug.h b/tools/include/linux/build_bug.h
> > new file mode 100644
> > index 000000000000..cc7070c7439b
> > --- /dev/null
> > +++ b/tools/include/linux/build_bug.h
> > @@ -0,0 +1,82 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_BUILD_BUG_H
> > +#define _LINUX_BUILD_BUG_H
> > +
> > +#include <linux/compiler.h>
> > +
> > +#ifdef __CHECKER__
> > +#define BUILD_BUG_ON_ZERO(e) (0)
> > +#else /* __CHECKER__ */
> > +/*
> > + * Force a compilation error if condition is true, but also produce a
> > + * result (of value 0 and type int), so the expression can be used
> > + * e.g. in a structure initializer (or where-ever else comma expressions
> > + * aren't permitted).
> > + */
> > +#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > +#endif /* __CHECKER__ */
> > +
> > +/* Force a compilation error if a constant expression is not a power of 2 */
> > +#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
> > +	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
> > +#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
> > +	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
> > +
> > +/*
> > + * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
> > + * expression but avoids the generation of any code, even if that expression
> > + * has side-effects.
> > + */
> > +#define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
> > +
> > +/**
> > + * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
> > + *		      error message.
> > + * @condition: the condition which the compiler should know is false.
> > + *
> > + * See BUILD_BUG_ON for description.
> > + */
> > +#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> > +
> > +/**
> > + * BUILD_BUG_ON - break compile if a condition is true.
> > + * @condition: the condition which the compiler should know is false.
> > + *
> > + * If you have some code which relies on certain constants being equal, or
> > + * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
> > + * detect if someone changes it.
> > + */
> > +#define BUILD_BUG_ON(condition) \
> > +	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> > +
> > +/**
> > + * BUILD_BUG - break compile if used.
> > + *
> > + * If you have some code that you expect the compiler to eliminate at
> > + * build time, you should use BUILD_BUG to detect if it is
> > + * unexpectedly used.
> > + */
> > +#define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> > +
> > +/**
> > + * static_assert - check integer constant expression at build time
> > + *
> > + * static_assert() is a wrapper for the C11 _Static_assert, with a
> > + * little macro magic to make the message optional (defaulting to the
> > + * stringification of the tested expression).
> > + *
> > + * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
> > + * scope, but requires the expression to be an integer constant
> > + * expression (i.e., it is not enough that __builtin_constant_p() is
> > + * true for expr).
> > + *
> > + * Also note that BUILD_BUG_ON() fails the build if the condition is
> > + * true, while static_assert() fails the build if the expression is
> > + * false.
> > + */
> > +#ifndef static_assert
> > +#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> > +#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> > +#endif // static_assert
> > +
> > +#endif	/* _LINUX_BUILD_BUG_H */
> > diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
> > index cba226948a0c..a7e54a08fb54 100644
> > --- a/tools/include/linux/kernel.h
> > +++ b/tools/include/linux/kernel.h
> > @@ -5,6 +5,7 @@
> >  #include <stdarg.h>
> >  #include <stddef.h>
> >  #include <assert.h>
> > +#include <linux/build_bug.h>
> >  #include <linux/compiler.h>
> >  #include <endian.h>
> >  #include <byteswap.h>
> > @@ -35,9 +36,6 @@
> >  	(type *)((char *)__mptr - offsetof(type, member)); })
> >  #endif
> >  
> > -#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
> > -#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
> > -
> >  #ifndef max
> >  #define max(x, y) ({				\
> >  	typeof(x) _max1 = (x);			\
> > diff --git a/tools/include/vdso/bits.h b/tools/include/vdso/bits.h
> > new file mode 100644
> > index 000000000000..6d005a1f5d94
> > --- /dev/null
> > +++ b/tools/include/vdso/bits.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __VDSO_BITS_H
> > +#define __VDSO_BITS_H
> > +
> > +#include <vdso/const.h>
> > +
> > +#define BIT(nr)			(UL(1) << (nr))
> > +
> > +#endif	/* __VDSO_BITS_H */
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index c905c683606a..cf147db4e5ca 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -22,6 +22,7 @@ include/uapi/linux/usbdevice_fs.h
> >  include/uapi/linux/vhost.h
> >  include/uapi/sound/asound.h
> >  include/linux/bits.h
> > +include/vdso/bits.h
> >  include/linux/const.h
> >  include/vdso/const.h
> >  include/linux/hash.h
> > @@ -116,6 +117,7 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
> >  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
> >  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
> >  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
> > +check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
> >  check include/linux/ctype.h	      '-I "isdigit("'
> >  check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
> >  check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
> > 
> 
> -- 
> Regards,
> Vincenzo

-- 

- Arnaldo
