Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B25429A6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509252AbgJ0Iqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404009AbgJ0Iqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:46:46 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C162224E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603788405;
        bh=vsxUUAOXqyP7qK5QCUqe8n8ns1GI6ih7irunW79BlGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RG7CdBgLIrBVtSdtOApL9xWA/gNp7mGQbzRLimFuWdKoBK+eAC7VmF20cOPj5wiMr
         d2mN0cqAXxdKIBzVZ0ZF9lJZmvrfnAlxiRAPTzfBQWMuBxfCLDBdXqYWSV1yi4pOgp
         ZUrcsDLmr4P6zYwtl2pk3VqAjp29F3ktfND+R6jQ=
Received: by mail-qk1-f180.google.com with SMTP id k9so451916qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 01:46:45 -0700 (PDT)
X-Gm-Message-State: AOAM532q3UGXQzda5LNaqj8dTmPwcSZZSg6XR3L+3kYxcN78We0QBPtN
        4fDKTAGHzUITNr0Elp42ZEF81arht6ziBjbrHVQ=
X-Google-Smtp-Source: ABdhPJx2f7yx+xY8uUiSAjSShOB6pY+ko49lhZeA00CUJban0ASzxbn1TbQd9z2+c1kYMuxO33xr1KuMXANQbP1itAs=
X-Received: by 2002:a05:620a:74f:: with SMTP id i15mr1070105qki.352.1603788404671;
 Tue, 27 Oct 2020 01:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201026215004.3893088-1-arnd@kernel.org> <8f5c673a-0265-a6d0-57fc-98c788caadc9@rasmusvillemoes.dk>
In-Reply-To: <8f5c673a-0265-a6d0-57fc-98c788caadc9@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 09:46:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2WhAP7Cj+cgYyFEVVQL-1oSOdS1mcN7=o75u24s09-Uw@mail.gmail.com>
Message-ID: <CAK8P3a2WhAP7Cj+cgYyFEVVQL-1oSOdS1mcN7=o75u24s09-Uw@mail.gmail.com>
Subject: Re: [PATCH] printf: fix Woverride-init warning for EDEADLK errno
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 8:23 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 26/10/2020 22.49, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
>
> NAK. That would end up using the "EDEADLOCK" string for the value 35 on
> those architectures where they are the same, despite EDEADLK being the
> by far the most used symbol. See the comments and original commit log,
> the placement of these is deliberate.

Ok, I see.

> How about we do this instead?
>
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
> The table of errno value->name contains a few duplicate entries since
> e.g. EDEADLK == EDEADLOCK on most architectures. For the known cases,
> the most used symbolic constant is listed last so that takes
> precedence - the idea being that if someone sees "can't do that:
> -EDEADLK" in dmesg, grepping for EDEADLK is more likely to find the
> place where that error was generated (grepping for "can't do that"
> will find the printk() that emitted it, but the source would often be
> a few calls down).
>
> However, that means one gets
>
>   warning: initialized field overwritten [-Woverride-init]
>
> when building with W=1. As the use of multiple initializers for the
> same entry here is quite deliberate, explicitly disable that warning
> for errname.o.
>
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Fixes: 57f5677e535b ("printf: add support for printing symbolic error
> names")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index ce45af50983a2a5e3582..a98119519e100103818d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -224,6 +224,7 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
>
>  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
> +CFLAGS_errname.o += $(call cc-disable-warning, override-init)
>

This works, but it conflicts with a different patch series I have, and
it disables a potentially useful warning in case we get another conflict
in this file, so I'd prefer to find a way to avoid the warning rather
than force-disabling it.

How about adding the #ifdef around the EDEADLOCK line
instead of the EDEADLK one? Something like

diff --git a/lib/errname.c b/lib/errname.c
index 0c4d3e66170e..93043fb960cc 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -38,7 +38,10 @@ static const char *names_0[] = {
        E(ECOMM),
        E(ECONNABORTED),
        E(ECONNRESET),
+       E(EDEADLK), /* EDEADLOCK */
+#if EDEADLK != EDEADLOCK /* mips, sparc, powerpc */
        E(EDEADLOCK),
+#endif
        E(EDESTADDRREQ),
        E(EDOM),
        E(EDOTDOT),
@@ -169,7 +172,6 @@ static const char *names_0[] = {
        E(ECANCELED), /* ECANCELLED */
        E(EAGAIN), /* EWOULDBLOCK */
        E(ECONNREFUSED), /* EREFUSED */
-       E(EDEADLK), /* EDEADLOCK */
 };
 #undef E

      Arnd
