Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE22A0B49
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgJ3QfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3QfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:35:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18261C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:35:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so5638740pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEG72fK9A86Aj1ReEdXuRoNmABKVsj8ImdviwWVYFfY=;
        b=niyYm0qY8CzMDjQFR0wk09rUFovgBIJqmkwyaohlBE8Xuf8D7EO7pmDLYAO52Q4Yvf
         82ZicSGjt6o0IgPJp09nq6DevXQ3+b0pAc6z3ZqEeQ0GHi8yBJqz7ty1e2sfPbG4sRz0
         1cOaAbENqXkyChFeCj5oGwedqUrwkqIaA9N4iN672mYgSp7HTiftJKBg2bOrWNpBz5lk
         +nGWSc2U2T0NPgIVEdW7PNQfTxFEhRqbbQXWLZf9txYposExkV0K1+kTiiGfuaJoxMC1
         eIkI2PvlQzLqzG2m5l2vTTq9uk9P+OGmAemu02kGvkUJyLwA/lOZsJ8GWC0Bf3jSpdGa
         AE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEG72fK9A86Aj1ReEdXuRoNmABKVsj8ImdviwWVYFfY=;
        b=qszaFfATO7xsmITlJdKLkpTVBFtbtwVgCi4Kwe+TkR72kI7FzHsgSOLuyPPoIuC29D
         5Ai0G8K/GTQxmrGsB3EU/QNBrDqSpXb4OiZX+ZXp2KYrHffrYm2uLTssYWAyg83/6foa
         XDiY9Q61KXOYz6jpNj1/wAI1l+VCxpDNbxbDM2XW1lpfiAJOse136mM/PTNG+f2BXR2V
         WFVfGy317/xec4alTQ/9+HgTZRnsl+Ue9I/z9DaWWo4UWFnpJawUI+OkOQ3YA6h5w/NU
         jRmF+HdBq6b2gvVtmdLgVtH9uVXAah0oJ/sk0auRrGabk4pii+dGq9G65nUBS431qkvI
         7G+Q==
X-Gm-Message-State: AOAM533H+otFp1Vl1ov8dAPdfkiZGlvlDDYOUIsgNJ1bZFRWJKBjkNpX
        6zQfUg8iJtgSeN2aQwgWv29qK0OxP6fVGfXMV3354g==
X-Google-Smtp-Source: ABdhPJypb5pDbULIOedvBhhhhPVQ4Wd1RYf+aGclJw2Xgj+SjC3Hpi43QPbQ/asszFlJWnfh3RXkLp7IystdA99AI/E=
X-Received: by 2002:a63:d456:: with SMTP id i22mr2896479pgj.440.1604075707465;
 Fri, 30 Oct 2020 09:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <6f87cb86aeeca9f4148d435ff01ad7d21af4bdfc.1603372719.git.andreyknvl@google.com>
 <CACT4Y+bJxJ+EeStyytnnRyjRwoZNPGJ9ws20GfoCBFGWvUSBPg@mail.gmail.com>
In-Reply-To: <CACT4Y+bJxJ+EeStyytnnRyjRwoZNPGJ9ws20GfoCBFGWvUSBPg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 30 Oct 2020 17:34:56 +0100
Message-ID: <CAAeHK+wkjVVHy+fB2SHpqNOC3s2afKEGG-=gs=Z8nwwF7hJdmA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 12/21] kasan: inline and rename kasan_unpoison_memory
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:36 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Currently kasan_unpoison_memory() is used as both an external annotation
> > and as internal memory poisoning helper. Rename external annotation to
> > kasan_unpoison_data() and inline the internal helper for for hardware
> > tag-based mode to avoid undeeded function calls.
> >
> > There's the external annotation kasan_unpoison_slab() that is currently
> > defined as static inline and uses kasan_unpoison_memory(). With this
> > change it's turned into a function call. Overall, this results in the
> > same number of calls for hardware tag-based mode as
> > kasan_unpoison_memory() is now inlined.
>
> Can't we leave kasan_unpoison_slab as is? Or there are other reasons
> to uninline it?

Just to have cleaner kasan.h callbacks definitions.

> It seems that uninling it is orthogonal to the rest of this patch.

I can split it out into a separate patch if you think this makes sense?
