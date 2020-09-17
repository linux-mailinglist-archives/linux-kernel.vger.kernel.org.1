Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798AC26D81E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIQJvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgIQJve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:51:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 02:51:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so1362122wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1z0Dzoz+hRHyGT5fLUrVWCjo5PxPXHMObR+QlG59yhI=;
        b=G2R7ulBTU9c5dYXtC3MYccrDA+Ffcx8heJQxw6ZGWY0f4Jf/wKoCDPwFEJdPQjqJY7
         3hJgJ6hVTXPVmQENRP7Sd81Q78EXP1mZlytu3a3+Sdl1VZr7D5mqqfDcRbWRhKlZhjaM
         1/lUceDIrEzfG75yh9QwFu3x24GH6fu1csNQboGJ8TZc7Onv6MTafL682UNedHWLHoPb
         loIDKYpSlWYPPDFE6D0n89acqNQtqzDkJSfX3uDPdeO9OgG1J5VUGDLsei4BTMfN8UVW
         bBuNjg0zDtYDRoDh3jrGHaRvvAyW64d3s/v/NGlSIid8oAAthGBjywiebwB0Nbn4Xz17
         3udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1z0Dzoz+hRHyGT5fLUrVWCjo5PxPXHMObR+QlG59yhI=;
        b=rzz0Dn2MqNdHVjG8B7nfJNG1LTwd9wsCnxeZgPVRd9N8PT3nl4HExOj33JGsdUz2GD
         YXa801rWCKFD6m4o/8jyUCSDmvdKrLQhUqtTjQO8EgvfSNJ6DWMDFEbCH9As6R7HPIti
         op5QR3CBn6Q8oyPh0D4O00bt+o5fU//VBodOtSsJM0KTsAt8ZRuSL6/vheiDqk/FG3bd
         bp3g8CRSAQzdYjKRj74zCT/aKeswbATYxPwWTlMQmC7GikAdjSznC5a8yel21aKn6dBW
         uu8K2BqJo5byTtPUTUBc/HuxS8VoJx9KDIf9LWuV43TWJ4ksOVcav0NIJLr6GNRPWpxu
         m/6A==
X-Gm-Message-State: AOAM530Fz6eEdxUTW75UjTR/DLtTBRK/mErKTKDhVVKHn4+dguBPiHNV
        OfHRhLfEKrlLWo1xW5UrL+OzNS+YyUGo2GLVuHLC+w==
X-Google-Smtp-Source: ABdhPJxp3caZkciDO+kZlUmnf4BVgA4nM2LwzCMfmtO8IXe8l0MGsqh3S+LXbtGEI7UMy2c4M0H9WHgAwQUzzWRYWQQ=
X-Received: by 2002:adf:e312:: with SMTP id b18mr8525505wrj.372.1600336291198;
 Thu, 17 Sep 2020 02:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200915132046.3332537-1-elver@google.com> <20200915132046.3332537-6-elver@google.com>
 <alpine.DEB.2.22.394.2009170938030.1492@www.lameter.com>
In-Reply-To: <alpine.DEB.2.22.394.2009170938030.1492@www.lameter.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 17 Sep 2020 11:51:19 +0200
Message-ID: <CAG_fn=W1CqBgCqpYBNgYE7V+i4iqK4iyVydJyz7K4Zfc0zZvEw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mm, kfence: insert KFENCE hooks for SLUB
To:     Christopher Lameter <cl@linux.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:40 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Tue, 15 Sep 2020, Marco Elver wrote:
>
> >  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
> >  {
> > -     void *ret =3D slab_alloc(s, gfpflags, _RET_IP_);
> > +     void *ret =3D slab_alloc(s, gfpflags, _RET_IP_, s->object_size);
>
> The additional size parameter is a part of a struct kmem_cache that is
> already passed to the function. Why does the parameter list need to be
> expanded?

See my response to the similar question about the SLAB allocator:
https://lore.kernel.org/linux-arm-kernel/CAG_fn=3DXMc8NPZPFtUE=3DrdoR=3DXJH=
4F+TxZs-w5n4VuaWKTjcasw@mail.gmail.com/



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
