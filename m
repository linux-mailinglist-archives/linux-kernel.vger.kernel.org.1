Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C400F1E6EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 00:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437073AbgE1WXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 18:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436997AbgE1WWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:22:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFCBC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:22:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o9so132402ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G22kYXML7tLF/Qm6fmw1wMduvw7Qs9a/nrPLifNe//k=;
        b=ELWOFCal0EeTIc1/idq8cg4c1801b2rPZj3VsNmuOidra2D5FUjrT9K0ppqPFn0tIB
         NQ4/iV+EIj20hIa+c5GZwB1yNT2EnkDib0/P1zDP3UGy8fRM5wa+f4qNHgkg0kSBb+m9
         WTS7HHrkffZzpSWzbK8n7jzcPgHJRjCdAFahQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G22kYXML7tLF/Qm6fmw1wMduvw7Qs9a/nrPLifNe//k=;
        b=JrWcc6cjxoqPR7/8nMRwRHWHDH45/3xZlOBugrNOBnlXPPgrs2q4bgfA5I7ipAaBq0
         vy9oj2ZGbdEB9KKG8auNYd0J6kIatnrlhcvU2pxQiOI903X9n5WKay8CrXg6BW3l5CVK
         VdOsIeLrWEm7274HEqR/Gup8Jkp0qhJWsDOPxhrSeIOfqyIRCE4SXHh37D40ft1D9vPx
         O9D6o/FAM2fSwV47RppikYIi0a9yciBRV4bqzxJjx7fG3r4YOLPnosVFKi3/h14/01DZ
         ZZWeuEBo6gExIS8gWRCunUcKxm0bGGta/aTTz8z5XRGK3NEHcvgo+w6Ixyblqz+3qdsp
         sHIw==
X-Gm-Message-State: AOAM531xn/kAfncpiCxwoSzg1FVFox8tGlD4wde+2SlCrP0OU34+Eel/
        AptPgf65tLcsARfbT+DSHBEZx8iiqnU=
X-Google-Smtp-Source: ABdhPJymHM7rs3JVMGDfxTqnBFrfS2IjDyQpcadQtvqEhbEe0OkcpoxDyGTitu+Edb/m/wBA9hBMDg==
X-Received: by 2002:a2e:9907:: with SMTP id v7mr2707157lji.0.1590704534330;
        Thu, 28 May 2020 15:22:14 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a1sm2136908lfi.36.2020.05.28.15.22.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 15:22:12 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id e125so110006lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:22:12 -0700 (PDT)
X-Received: by 2002:a19:4048:: with SMTP id n69mr2737484lfa.31.1590704532092;
 Thu, 28 May 2020 15:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200528135552.GA87103@google.com>
In-Reply-To: <20200528135552.GA87103@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 15:21:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgtD6drydXP5h_r90v0sCSQe7BMk7AiYADhJ-x9HGgkg@mail.gmail.com>
Message-ID: <CAHk-=wjgtD6drydXP5h_r90v0sCSQe7BMk7AiYADhJ-x9HGgkg@mail.gmail.com>
Subject: Re: [PATCH] sched/headers: Fix sched_setattr userspace compilation breakage
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        matthewb@google.com, Jesse Barnes <jsbarnes@google.com>,
        vapier@google.com, Christian Brauner <christian@brauner.io>,
        vpillai <vpillai@digitalocean.com>, vineethrp@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 6:55 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> On a modern Linux distro, compiling the following program fails:
>  #include<stdlib.h>
>  #include<stdint.h>
>  #include<pthread.h>
>  #include<linux/sched/types.h>

You shouldn't include kernel headers in user space - that's the job of
glibc and friends.

> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -4,9 +4,11 @@
>
>  #include <linux/types.h>
>
> +#if defined(__KERNEL__)
>  struct sched_param {
>         int sched_priority;
>  };
> +#endif

This makes no sense.

The point of a 'uapi' header is to export things to user space. Yes,
they sometimes mix kernel-internal thngs in there (because of how they
were created by just moving kernel headers to the uapi directory), but
that ' struct sched_param' is very much part of the very interface
definition that that file is all about exporting.

So no, this patch is fundamentally wrong. It negates the whole point
of having a uapi header at all.

The glibc-provided "<sched.h>" should have been where you got all
these declarations and #defines from, and the point of the uapi file
was always to help glibc (and other library implementations) get them
from the kernel.

So why are you including kernel header files and mixing them with
system-provided stuff?

              Linus
