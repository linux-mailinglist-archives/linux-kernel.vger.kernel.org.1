Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C087327D2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgI2Pj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgI2Pj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:39:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 08:39:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so6841380edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/ndqPAMEfMRymlJX6dxjBJfNF/RdG7bAvnqIWB8lEs=;
        b=m6ew1pj/QCtmtZdVPKnuFy/yv9ikzPhdzLQZb3eTh7KNJANrqRcPQiJEVwwigx97ST
         7qToS47jUQXt9AY2dttqo+p/YyvGEMMH9woupRvvs/CwdLsLjYbwrE+EH+8VQsFit4UJ
         +CTrbQOEDF0pwC3LNjxK36v3KNrLTCnVcn9hqU/ysYdjhpyAFE5smjZi2UKRfcvJ0MYE
         XNIrg0HOOHpTGHP/WVefkWKXPCq+AdDbxDIAmSETPKQK1+a1K5bazpcKmhXcIORGxM0+
         PP6Tqo0w+efWK18koinSdhezu0kZHorH69OHpLxvyETwOWeNBSFPivYsY/yJo7Iyulgr
         WZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/ndqPAMEfMRymlJX6dxjBJfNF/RdG7bAvnqIWB8lEs=;
        b=gRxIxMCdWEDLd3HGfkb9nRJUeih11Ae9UXJufpNbhrwdoNvfjAYhaNHnY7dCpHKlNa
         bUZCScYX8MSJ4PLLwoZZboTfKa0nF85B1RTPCwjt2UdCVhJ8mr+okYcgI4zfhIKaA4AR
         y7fF6Kr1R5XRrrysfVoRzE6CkVAkLSTu2CsJlzXI+QNuxby+Zjb4+fKsGhc9sbOV15vv
         hOBqMhFaagp6sLPDpc7V18BY2ZaQlQzETaN1t6ybgPY/iDQzknwGw3a7HSJLDAhs95YD
         vBZwhCXsiqshjqdKC+enb81VJyH7H4myaEfo9xlizmpEargzzAqmV1vrIBQ1paFTEuo+
         YW6A==
X-Gm-Message-State: AOAM531Mtv0Jp2xPI0y6byar3Us86oGxYPqA48hnQ7HDygUD+Ep+vh6Z
        xKQCPepZQIGoU0zclicq6E3Wu+U8IY1lboUagjtyVg==
X-Google-Smtp-Source: ABdhPJzj08jD7SN2swqY0zDXlDRACi7t2mNBaSDLWh7De4wwnpuPdoYrVjW716dcYk4mBausg229OJ6uDeEDcfzXL9Q=
X-Received: by 2002:a05:6402:78b:: with SMTP id d11mr4046267edy.341.1601393994450;
 Tue, 29 Sep 2020 08:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200928230939.5574-1-natechancellor@gmail.com>
In-Reply-To: <20200928230939.5574-1-natechancellor@gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 29 Sep 2020 08:39:43 -0700
Message-ID: <CABCJKuft6NaesrL+840n3ZNjwaWfrc7Z++QFM=e7Ludom_BhLQ@mail.gmail.com>
Subject: Re: [PATCH] static_call: Fix return type of static_call_init
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Mon, Sep 28, 2020 at 4:09 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Functions that are passed to early_initcall should be of type
> initcall_t, which expects a return type of int. This is not currently an
> error but a patch in the Clang LTO series could change that in the
> future.
>
> Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
> Link: https://lore.kernel.org/lkml/20200904044559.GA507165@ubuntu-n2-xlarge-x86/
> Link: https://lore.kernel.org/lkml/20200903203053.3411268-17-samitolvanen@google.com/
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  include/linux/static_call.h | 6 +++---
>  kernel/static_call.c        | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index bfa2ba39be57..695da4c9b338 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -136,7 +136,7 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
>
>  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
>
> -extern void __init static_call_init(void);
> +extern int __init static_call_init(void);
>
>  struct static_call_mod {
>         struct static_call_mod *next;Thank you for sending the patch, this looks correct to me.
> @@ -187,7 +187,7 @@ extern int static_call_text_reserved(void *start, void *end);
>
>  #elif defined(CONFIG_HAVE_STATIC_CALL)
>
> -static inline void static_call_init(void) { }
> +static inline int static_call_init(void) { return 0; }
>
>  struct static_call_key {
>         void *func;
> @@ -234,7 +234,7 @@ static inline int static_call_text_reserved(void *start, void *end)
>
>  #else /* Generic implementation */
>
> -static inline void static_call_init(void) { }
> +static inline int static_call_init(void) { return 0; }
>
>  struct static_call_key {
>         void *func;
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index f8362b3f8fd5..84565c2a41b8 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -410,12 +410,12 @@ int static_call_text_reserved(void *start, void *end)
>         return __static_call_mod_text_reserved(start, end);
>  }
>
> -void __init static_call_init(void)
> +int __init static_call_init(void)
>  {
>         int ret;
>
>         if (static_call_initialized)
> -               return;
> +               return 0;
>
>         cpus_read_lock();
>         static_call_lock();
> @@ -434,6 +434,7 @@ void __init static_call_init(void)
>  #ifdef CONFIG_MODULES
>         register_module_notifier(&static_call_module_nb);
>  #endif
> +       return 0;
>  }
>  early_initcall(static_call_init);
>
>
> base-commit: de394e7568ce2cdb4643ed230169f484f25f9442
> --
> 2.28.0

Thank you for sending the patch, this looks correct to me.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
