Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23142661F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIKPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 11:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgIKPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:15:24 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA980C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:15:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a19so4723220ilq.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufdcEHy1PC/ezqsDkWS+TD6mTdL2tp2wTQ8CZ+/qEf4=;
        b=Bc90pNkLgX/h4MhEiVG6O4ps43IfI/m7/Zc7dCGFHr18Vx68b8DyKVqeGXSvVPfImY
         p3UbApPC5gPzgFbeD/tTJddfuQtyP2DuUCzY9ldYyi1uN1s3/JPjNz4ncAVRVhWbGs8w
         PMOiLoSSFz84Cck5e/jpWOOp9rKhln9p6EbkwJ6kydDU5QFXDF12jgUuv2sea45R0aiO
         JFrV+VIva6QeigZwcNREL7G5Xb92/fxuQ0uJ3ni5LofpK+I72th9YigCYAnqcdpV9nVp
         9OCa1A7lmyHBBI3ai9XaOMNzh8HDgDFBCi5aIvVos8p7VtWo8DL1t/FpR4KSx17aAv8Z
         ZU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufdcEHy1PC/ezqsDkWS+TD6mTdL2tp2wTQ8CZ+/qEf4=;
        b=ui0ISI9hOJ0TYBrAphiSmRA4oOAW+TlQGXV1oQK0sE6Ck1x4wEUU+Vrz+ibcXYBlYg
         NUBY3HayGK8fvDJTQoXp8YHz33RVTKfLoLBiqhw49VKdg20FDkMqyJxvlTS5to/Gw9br
         SxkClOhBcLZ5+ri5SXfYvAUi/eFOKZiiwDGJtOBIzqBVjyBL3q9Xq+g4bxMhmG633VTI
         z+Aw016UNFLyuN2N3ACgN6VdOBxeL13sCxchLKPXHT1uTJTVfeN/U7DT6S1LiPj2UWEl
         ax+OypRFMiUd2OkH2+tYv8naLFFwbLYZNQb3H9FeGCHkMjQR4QIVi2/ACscbqFmrIsL1
         3dLQ==
X-Gm-Message-State: AOAM533GQvJt0prJvMuLaFELFt0zhIOGll1Q+ShpXwwVFNunt7faIKPX
        /K1bQcQQQn0YH5OV89XsSnKVNuZ1GSPMCHRl4Qz5Qw==
X-Google-Smtp-Source: ABdhPJyvZhR8i/gmsNhZsOdEJ+iRUX+LvrerRs093pQQn9n7rb6cL2TL4s+8cWYimF1Ux+s7FkMTaMK3o/zc9ap7hNg=
X-Received: by 2002:a05:6e02:1141:: with SMTP id o1mr2099807ill.275.1599837320632;
 Fri, 11 Sep 2020 08:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200910134802.3160311-1-lenaptr@google.com> <CAG48ez3x51kkDt19ONXbi8Se+2swMgwfmaj7AFbBqmss=D38Ug@mail.gmail.com>
In-Reply-To: <CAG48ez3x51kkDt19ONXbi8Se+2swMgwfmaj7AFbBqmss=D38Ug@mail.gmail.com>
From:   Elena Petrova <lenaptr@google.com>
Date:   Fri, 11 Sep 2020 16:15:09 +0100
Message-ID: <CABvBcwY2FLJxc80Leibv=zZ-e_YbjkE+ZBH2LNoFy8HAeD8m6Q@mail.gmail.com>
Subject: Re: [PATCH] sched.h: drop in_ubsan field when UBSAN is in trap mode
To:     Jann Horn <jannh@google.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Thu, 10 Sep 2020 at 20:35, Jann Horn <jannh@google.com> wrote:
>
> On Thu, Sep 10, 2020 at 3:48 PM Elena Petrova <lenaptr@google.com> wrote:
> > in_ubsan field of task_struct is only used in lib/ubsan.c, which in its
> > turn is used only `ifneq ($(CONFIG_UBSAN_TRAP),y)`.
> >
> > Removing unnecessary field from a task_struct will help preserve the
> > ABI between vanilla and CONFIG_UBSAN_TRAP'ed kernels. In particular,
> > this will help enabling bounds sanitizer transparently for Android's
> > GKI.
>
> The diff looks reasonable to me, but I'm curious about the
> justification in the commit message:
>
> Is the intent here that you want to be able to build a module without
> CONFIG_UBSAN and load it into a kernel that is built with
> CONFIG_UBSAN? Or the inverse?

The former. But more precisely, with GKI Google gives a promise, that
when certain GKI is released, i.e. at 4.19, its ABI will never ever
change (or, perhaps only change with <next letter> Android release),
so vendor modules could have an independent development lifecycle. And
this patch, when backported, will help enable boundsan on kernels
where ABI has already been frozen.

> Does this mean that in the future, gating new exported functions, or
> new struct fields, on CONFIG_UBSAN (independent of whether
> CONFIG_UBSAN_TRAP is set) will break Android?

I don't understand what you mean here, sorry.

> If you really want to do this, and using alternatives to patch out the
> ubsan instructions is not an option, I wonder whether it would be more
> reasonable to at least add a configuration where CONFIG_UBSAN is
> enabled but the compiler flag is not actually set. Then you could
> unconditionally build that android kernel and its modules with that
> config option, and wouldn't have to worry about structure size issues,
> dependencies on undefined symbols and so on.

Such setup might be confusing for developers. We were considering
something similar: to keep the in_ubsan field regardless of the
CONFIG_UBSAN option. But since non-trap mode is unlikely to be used on
production devices due to size and performance overheads, I think it's
better to just get rid of an unused field, rather than balloon
task_struct.

Cheers,
*lenaptr
