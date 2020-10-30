Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7272A0CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgJ3Rqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3Rqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:46:46 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6766C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:46:46 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv1so3142862qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DWGshIzBKZkowUsfKXy+FsPzRhu2gsbri/5lPafTJ0=;
        b=ZXXWtx1Pbs8pMJTJnYFVoEtqtLap1iZkY6G5Fh8lMVJqCCGDYhY8E19a8EJdRMGo2Z
         Ee9+8bxgmGo1AN6ABpJ16CdUth6nAF3Jhy+uZWhEwrizCMp5Rjs+ApCkssS/Op58bOcZ
         a+qPbIediFWA4I80Rx/D9tyV6Pr4aeYud9kivqbxpOR1CesWSbSge91Bl1/8joF1HZNG
         ZgOyvBgdhQoVzFCLj8+YhsSJJ9sZIIJo1yXEs9Axoj9n5GN9SiJcwByYMooQGJEV/2gC
         L8RrkDMuOf4AVdX0O6Rd5ubKxeRs2JdB4gv6wwXscN8uqGlKdQw6iWBla39gWxFOcHwd
         9DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DWGshIzBKZkowUsfKXy+FsPzRhu2gsbri/5lPafTJ0=;
        b=Z4XHYiuXP0LAjTH8OUqwOMNgdqGAZZWGdUuZdbKEQAbMw50sW1ZvZ9UbbGOK5C/cfz
         JsT1/xIJx7fAydr21WIsAJXGq+6fkvlRMkGIFwLQfzIIY5+/Fbff1ybxbDjn0YK0pIQv
         Gur6zQKU6q2MVVTIsJYaocMp3xI1tiKLmxPgVtmRJqkv6n/AQm6aKRsKEvYkDSwGLVuo
         DopRISWM5Jqnv0w59nI3r38oxIE97NGeclnRQCsb3WEij4Qo3IaiPRvMphURfmPBJ0OE
         t4z5W8IqCyZnen3Ak3vXpxnhqRmqBpr0s+Hr3AOE0h5bH0nUQl8FCZ4S1BPTu/5fNSIk
         yC4g==
X-Gm-Message-State: AOAM532aHBNu3qIAIYdYFctYQO8fJ6+4P0rMt4833tS/gvQlOkhsNRYk
        QIa3hf4yEvatP66ot6tAEiochK5C/R+itT/OaVee+w==
X-Google-Smtp-Source: ABdhPJxQ9rQz32r4JmDJAlhCcli/7SKf2LLsP72XKDpHUf2yg2onReDSTMzkXEBq7AlNv74LToj085dqk3VHcI/DfbQ=
X-Received: by 2002:a05:6214:a0f:: with SMTP id dw15mr10113630qvb.44.1604080005622;
 Fri, 30 Oct 2020 10:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <6f87cb86aeeca9f4148d435ff01ad7d21af4bdfc.1603372719.git.andreyknvl@google.com>
 <CACT4Y+bJxJ+EeStyytnnRyjRwoZNPGJ9ws20GfoCBFGWvUSBPg@mail.gmail.com> <CAAeHK+wkjVVHy+fB2SHpqNOC3s2afKEGG-=gs=Z8nwwF7hJdmA@mail.gmail.com>
In-Reply-To: <CAAeHK+wkjVVHy+fB2SHpqNOC3s2afKEGG-=gs=Z8nwwF7hJdmA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 30 Oct 2020 18:46:33 +0100
Message-ID: <CACT4Y+ZUTkMgtQUiaS-7r-G=urYJo7LFZihZ4ZeimAmkg=0MyA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 12/21] kasan: inline and rename kasan_unpoison_memory
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Fri, Oct 30, 2020 at 5:35 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> > On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > Currently kasan_unpoison_memory() is used as both an external annotation
> > > and as internal memory poisoning helper. Rename external annotation to
> > > kasan_unpoison_data() and inline the internal helper for for hardware
> > > tag-based mode to avoid undeeded function calls.
> > >
> > > There's the external annotation kasan_unpoison_slab() that is currently
> > > defined as static inline and uses kasan_unpoison_memory(). With this
> > > change it's turned into a function call. Overall, this results in the
> > > same number of calls for hardware tag-based mode as
> > > kasan_unpoison_memory() is now inlined.
> >
> > Can't we leave kasan_unpoison_slab as is? Or there are other reasons
> > to uninline it?
>
> Just to have cleaner kasan.h callbacks definitions.
>
> > It seems that uninling it is orthogonal to the rest of this patch.
>
> I can split it out into a separate patch if you think this makes sense?

I don't have a strong opinion either way.
