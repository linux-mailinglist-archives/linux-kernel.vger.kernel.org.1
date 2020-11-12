Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CFE2B114E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKLWUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKLWUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:20:40 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A899C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 14:20:40 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j14so7199567ots.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 14:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTAA2mjTH1s5gJvXfoqFOnb2RIhffz7/HPf/PMilg1s=;
        b=dFN+5nhP2JgNsIO+pN31g3PQMctzBg5Wp/ncFqisaXZKXLFc1gjnImkp1mqP4HzxON
         /6vtZoMbWfQBequoH+jOBoXPCJkahX7hmHKD5aCZNUSIVyUWnm1HzYhnxssg0THcn2kl
         YI8ecBu65VO7pscM9wkv1zVNMwoUkGC9rPEY9TUXiOsvH/YC+GwQxEqve3H00ZgdThWH
         DGILd7UgTmn2cTjSHq8lqRpZyINt3ffKMXVqA56W5EYUV3K8Y1wULP94qqdAM2dO9wm8
         sw5W0GmZTrRf1vtd82BIDHftPFaLSvE7gAsG4aEJSHcR+dvf1FcfCHOUeT7xh7t3X2F6
         ZrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTAA2mjTH1s5gJvXfoqFOnb2RIhffz7/HPf/PMilg1s=;
        b=NEE/jKddvldIMk7FkWK0/KISQzAD909LwLNcaihEVg1gtXK6R/jwCP70NtyA+jrSF8
         ZDOPpVCxPJcfxrh/1OaeiEOJToJDKvCDFusotCD5V7EqX8Na4pFJr37ydcRVIou27/fM
         T/YhjqpBa4O0LgwulpWrEyZQtJDkc89e/pAWkth8eK9HPl1AArxaJn7Zp8//nycfQOS2
         RmxBibe1yiz61nP0H6St9bQWi3IORcaNeN/r5rYb6kK1aWFVBn7W57ID0Cx1s6nXl9vU
         R7xgxRrF01YE7L2XEAOfA8ofdlXPOSC5L6Wz1mQXe0brE97QETkXNFGnt53fs5K/Q+26
         vR1Q==
X-Gm-Message-State: AOAM531L/yc7QK+0xoPNZ2dKCI2oxa5EkN9DuomKaVmfG+AnGq+4+NfE
        ymyJs+plYO9FJiIJs0al4E2L3FgyNwK069+C+pgueg==
X-Google-Smtp-Source: ABdhPJyMi4CuFKcE9FueG6D29GwD/cp6+XfVewyzA+L+8OXF8guN8DtLpuh/GzPAxMez1YVU5QiGgBLiUbCvu5CTvns=
X-Received: by 2002:a9d:649:: with SMTP id 67mr1045852otn.233.1605219638578;
 Thu, 12 Nov 2020 14:20:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <0a9b63bff116734ab63d99ebd09c244332d71958.1605046662.git.andreyknvl@google.com>
 <20201111174902.GK517454@elver.google.com> <CAAeHK+wvvkYko=tM=NHODkKas13h5Jvsswvg05jhv9LqE0jSjQ@mail.gmail.com>
 <CANpmjNOboPh97HdMGAESSEYdeyd9+9MVy6E3QsvVAYuWVReRew@mail.gmail.com> <CAAeHK+xhjUQAtJThUHcaGmd3muBZHiJPfTqj59CMxo44hbDniw@mail.gmail.com>
In-Reply-To: <CAAeHK+xhjUQAtJThUHcaGmd3muBZHiJPfTqj59CMxo44hbDniw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Nov 2020 23:20:27 +0100
Message-ID: <CANpmjNPxqOi8QCJ4VY6vfVkktEWO1=S5hcOBvTQcWhhL0L9B-w@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] kasan: inline and rename kasan_unpoison_memory
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 at 21:54, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, Nov 12, 2020 at 8:52 PM Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 12 Nov 2020 at 20:45, Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > On Wed, Nov 11, 2020 at 6:49 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > > > > Currently kasan_unpoison_memory() is used as both an external annotation
> > > > > and as an internal memory poisoning helper. Rename external annotation to
> > > > > kasan_unpoison_data() and inline the internal helper for hardware
> > > > > tag-based mode to avoid undeeded function calls.
> > > >
> > > > I don't understand why this needs to be renamed again. The users of
> > > > kasan_unpoison_memory() outweigh those of kasan_unpoison_slab(), of
> > > > which there seems to be only 1!
> > >
> > > The idea is to make kasan_(un)poison_memory() functions inlinable for
> > > internal use. It doesn't have anything to do with the number of times
> > > they are used.
> > >
> > > Perhaps we can drop the kasan_ prefix for the internal implementations
> > > though, and keep using kasan_unpoison_memory() externally.
> >
> > Whatever avoids changing the external interface, because it seems
> > really pointless. I can see why it's done, but it's a side-effect of
> > the various wrappers being added.
>
> It looks like unposion_memory() is already taken. Any suggestions for
> internal KASAN poisoning function names?

I still don't like that one of these functions just forwards to the
other, but we could use it to also give the external function a more
descriptive name.

I propose 2 options:

1. Name the internal helpers *poison_range().
2. Name the external function kasan_unpoison_range() instead of
kasan_unpoison_data().

Anything "memory" (or "data") in the allocators might not be too
helpful w.r.t. descriptive function names (i.e. stripping "memory"
from function names won't lessen descriptiveness given our context).
Perhaps kasan_poison_range() for the external function might in fact
improve the external interface (without looking at its arguments).

If we need to keep the internal helpers, I'd probably go so far as to
suggest renaming them to simply kasan_{poison,unpoison}(), and then
building the external kasan_{poison,unpoison}_foo() on top. But maybe
that's too much for now if it doesn't fit here. :-)

Thanks,
-- Marco
