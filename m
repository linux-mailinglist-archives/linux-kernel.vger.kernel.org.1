Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B196229CC13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506743AbgJ0Whq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506441AbgJ0Whq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:37:46 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C45221F7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 22:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603838265;
        bh=hSG59B+oo+w7cnGRqcw2dDLdyCWNWqs5dL81KWE/cPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hy9Spsx7u4MatMjVakZL8zYs9569eHGl3Rr9z8ESYOfSaelRaW0JeeAPaXoz+zW0L
         5mP0RJtDiwLrSC79UcfXqAnSL7XyjZU24VaC0gNaZzBqJX4upfylmG07B5jqooA4RT
         EkdRpBolEv6/d0+J6n+2kPPZBjBN7xXhs73TzJ/w=
Received: by mail-qt1-f177.google.com with SMTP id h12so2300111qtu.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 15:37:45 -0700 (PDT)
X-Gm-Message-State: AOAM5334gCXcFnBr6U0boUdui/iWvevJmkhRD7iSKEMwjqJwmAY4uu6Z
        w94wEzqaE1pnRUNuMa/cJFgPKkcc/1eY9l1pNd4=
X-Google-Smtp-Source: ABdhPJxRt0bc0+qxSdPg63w2D06sD0HesPZMSY0XpAUdbG07EN32ZyBfv2TWSEm3I4ZZDjcmA7EHnV3VlFjslctECuw=
X-Received: by 2002:aed:26c2:: with SMTP id q60mr3953199qtd.7.1603838264856;
 Tue, 27 Oct 2020 15:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201026192117.3811525-1-arnd@kernel.org> <CANiq72n72FMnNnWveSZOj_3_beXKX03CVL8=cQqqa8QyK-PKig@mail.gmail.com>
In-Reply-To: <CANiq72n72FMnNnWveSZOj_3_beXKX03CVL8=cQqqa8QyK-PKig@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 23:37:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a269o2Dqm500MAtp5JZD3-Diaa3iaMecONeyLAuE7r7Rw@mail.gmail.com>
Message-ID: <CAK8P3a269o2Dqm500MAtp5JZD3-Diaa3iaMecONeyLAuE7r7Rw@mail.gmail.com>
Subject: Re: [PATCH v2] ctype.h: remove duplicate isdigit() helper
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:47 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 27, 2020 at 12:57 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > +#ifdef __has_builtin
> > +#define has_builtin(x) __has_builtin(x)
> > +#else
> > +#define has_builtin(x) (0)
> > +#endif
>
> Could this be
>
>     #ifndef __has_builtin
>     # define __has_builtin(x) 0
>     #endif
>
> ? i.e. mimicking what we do for `__has_attribute`.

Ah, I didn't know about that

> It would also be a nice idea to put a reminder comment like:
>
>     /*
>      * __has_builtin is supported on gcc >= 10, clang >= 3 and icc >= 21.
>      * In the meantime, to support gcc < 10, we implement __has_builtin
>      * by hand.
>      */

Sounds good, I'll take that. Are the clang and icc version numbers
the actual ones we should list here, or is this just an example?

       Arnd
