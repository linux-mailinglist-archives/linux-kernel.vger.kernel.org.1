Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECE2B0E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKLTpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKLTpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:45:30 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C96C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:45:30 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i7so5088629pgh.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUsjnJsE70MPGpys5UT1OEoJSxFeQtN6aLTMo3hfEjk=;
        b=rKHdDyXn6oy67dBTpOqWUs9smSJZlYHldHIVXW792bY88duJKOdd/NkTFB1d9HduJh
         P7Mf3B8aMHapHeIsfXPwxlINzYZn7DBii1N/WZDxfDADxzU94FU9xvanoou6XfEHZCjr
         whOOUFtVeiU0pmGOfojKOAhlF1sylbgR4v1J5V9xRPdS19rJQZxIqGDxRFUzZbC5opox
         W9uUvJxCeWfLX61dhfLmvQJl3jLwWBBLzRO8p8+woJeBg+gkiJF4ilo75Gwm6mpqinCN
         ApVM1EuWvnU9jDx23PEYN6g7Y0WYHKXOX64Y6Ap6CoCZCt76JGnCsAl0q8+9Nkjt9TWt
         R12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUsjnJsE70MPGpys5UT1OEoJSxFeQtN6aLTMo3hfEjk=;
        b=SfdQJWpSFuSSlk19E5xS80LOWsc6sl9wyD94IUbcpQbJdnUNAtkqijjFpBCpl5U0X8
         6FlR/vgscnP0ytGiKB0XNPRKf/x1734XjCqchak/w1T9AdSE5lOleyi0fTFPyfU0x3FH
         neF+6toHpAy2BDMJfOl0sl6fKQqS0Ddvz9hnaAvMF+NpnS2+C2rPU9QCXtWgJkTOobX9
         Ssp8NbXcLVKWAl9al27GMwJUEWX6yhkvBLwWAK3PYmXlUxdZtjJ00SmDkymSuLfCriDq
         iwx4X1fTp5x+wmA4Md1uzn1II0bx10X8In34h+lLrze6cIhySGkqP+DhriKyUvq6wZqg
         39kA==
X-Gm-Message-State: AOAM530iB+OczJ2tl+mJ4WB7cZjMZ552M70CPgcGPqX6xuGCT1cZ5QgR
        pjvsIm6Nbqa+pmHLCHZ+WJiTNvBhxMO9Ch3BfpL0hQ==
X-Google-Smtp-Source: ABdhPJymqAxJryKKC0ktlr8u0WBlSEAGCjBRalcMM6ulBX9LDg37qw1ly1XhtUHYBUIPWFyPX+Fs5wEsiV0gSU3nLUM=
X-Received: by 2002:a05:6a00:16c4:b029:162:bf9f:6458 with SMTP id
 l4-20020a056a0016c4b0290162bf9f6458mr947513pfc.55.1605210329356; Thu, 12 Nov
 2020 11:45:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <0a9b63bff116734ab63d99ebd09c244332d71958.1605046662.git.andreyknvl@google.com>
 <20201111174902.GK517454@elver.google.com>
In-Reply-To: <20201111174902.GK517454@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 20:45:18 +0100
Message-ID: <CAAeHK+wvvkYko=tM=NHODkKas13h5Jvsswvg05jhv9LqE0jSjQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] kasan: inline and rename kasan_unpoison_memory
To:     Marco Elver <elver@google.com>
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

On Wed, Nov 11, 2020 at 6:49 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > Currently kasan_unpoison_memory() is used as both an external annotation
> > and as an internal memory poisoning helper. Rename external annotation to
> > kasan_unpoison_data() and inline the internal helper for hardware
> > tag-based mode to avoid undeeded function calls.
>
> I don't understand why this needs to be renamed again. The users of
> kasan_unpoison_memory() outweigh those of kasan_unpoison_slab(), of
> which there seems to be only 1!

The idea is to make kasan_(un)poison_memory() functions inlinable for
internal use. It doesn't have anything to do with the number of times
they are used.

Perhaps we can drop the kasan_ prefix for the internal implementations
though, and keep using kasan_unpoison_memory() externally.

> So can't we just get rid of kasan_unpoison_slab() and just open-code it
> in mm/mempool.c:kasan_unpoison_element()? That function is already
> kasan-prefixed, so we can even place a small comment there (which would
> also be an improvement over current interface, since
> kasan_unpoison_slab() is not documented and its existence not quite
> justified).

We can, but this is a change unrelated to this patch.
