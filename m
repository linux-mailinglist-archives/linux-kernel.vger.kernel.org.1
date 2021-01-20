Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02B22FC55A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbhATAHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbhATAB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 19:01:28 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 16:00:39 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n10so13993768pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SH9bBVJUgUjKxtfcctlC8lxhxAiLxM+GP/4tST0dfVs=;
        b=QIEooEDgt2O3DJ2wqxJ91NasnTDn471D3xaebTAftI0xv3WBgOKnqUUxK6dh0RpLiX
         BduPONtP8ovFS9X4YjHoX6UmicbJNdi9XVRe0MZW97mY1kqEu9sVWMyBEnUaix3yB8dV
         v/NtGyF4JBd4U7rRdT1ZUmLMyGvfxkalmJD7/akoMLl+OwEskETjyNy+fj1dHARJmBhf
         PV6XnjgG3BduHt2qoGBj5XsgQeuWY/P7EB7UK9zPvKTs3V5H40/S2LmDvB8A3x3HqFWI
         5dgZUpGpQ4jRZPUZq2rzbEmmsk+jopiWF2BEaZJvK40k7LNIcM1x1LRsOvV9sl1j5z/K
         FjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SH9bBVJUgUjKxtfcctlC8lxhxAiLxM+GP/4tST0dfVs=;
        b=MfmUbJpMmexw+u1Z2jCFBL1cQzIybIU0MPAXkMjt6BIpjXWBzz5/g1axZvTwXqqHvX
         ZbC8LFAM1jVxW6H9xlramaf24E4jOnyArS4quN8jYXxXYXCIGKrDkwbtYvo2EvOxnbVj
         hGNKYPbX//7GaBVJ/zV+w2hfYEbIwY+yUNfVkD3Q1SCIuci2kuBgPKADeUpIneNz1e3Y
         eCS6unqGYx1oAHS2vZ5Kga+sBa/JBHy0ly82caLXpNFkitdEBOsU0iXTt98znWK1VghT
         SwIc2CP2FNkf9D6/U5acwsoQBfLAYSFNdlIh7n0AtwqGmRG3JvQM4kIyZJgQOKLN144s
         vn4g==
X-Gm-Message-State: AOAM533dhRRqa+3illcCHB2euD5XUILhDFxrnQcVlTsy+W7huG8siGML
        p4r4yHGrOLSgWVhT3Xgh/ah+6OcGsPDnHZmwuEkCyibm8Vh/Og==
X-Google-Smtp-Source: ABdhPJwvhroTgfl8Ny2Z+x07bJFaGzwlX2Fydm6voS3+M/4kgOHAS27zmFyTfYJwVMiDSYz2ZQMLR3RJ9o38xP6XmOI=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr6685640pgm.10.1611100838601;
 Tue, 19 Jan 2021 16:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20210114175934.13070-1-will@kernel.org> <20210114175934.13070-5-will@kernel.org>
 <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
 <20210114190021.GB13135@willie-the-truck> <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
 <20210114194129.GA13314@willie-the-truck> <CAHk-=wixswKjAPt0eEVSHqOQB9tBuO5FeqfyKyxFWyBLEG6EcQ@mail.gmail.com>
 <20210115092313.GA13700@willie-the-truck> <CAHk-=wjWQFSZci+By4wXAEx6EDH4nss7tf5QimQpF53rnHa7Wg@mail.gmail.com>
In-Reply-To: <CAHk-=wjWQFSZci+By4wXAEx6EDH4nss7tf5QimQpF53rnHa7Wg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jan 2021 16:00:26 -0800
Message-ID: <CAKwvOdkwi1huq-xNDKjfw8ooL69E03Ue3LzstG7T-bGX-cM9aA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 1:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 15, 2021 at 1:23 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hmm. The feedback on the clang bug suggests that GCC is the one in the
> > wrong here (although the argument is based on C11 and I haven't trawled
> > through the standards to see how this has evolved):
>
> Oh well.
>
> That writing is absolutely the _worst_ kind of weaselwording standards
> language reading, trying to make excuses for bad behavior by basically
> depending on "this language is unclear", and trying to say that the
> buggy behavior is required by C11.
>
> What a disappointment.

I don't really understand British humor either, but I assume that's
how the language lawyers throw shade on one anothers' standards.
Richard is both the WG21 spec editor (C++) and British, IIRC.
Apparently, there's a long conversion (behind closed doors; it's the
ISO way) going on in regards to the thread Richard has kicked off with
them (WG14; C).  Moreso on what should happen with the _Atomic
qualifier, assignments, and memcpy.  So it is still an important thing
to nail down the language spec.

Note there were also a lot of discussions lately on "where should the
volatile qualifier be allowed, or not."
http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1152r0.html
https://www.youtube.com/watch?v=KJW_DLaVXIY
(2018? ok, maybe not lately.  Lately for C)

I view this similarly as "where should the const qualifier be allowed, or not."
-- 
Thanks,
~Nick Desaulniers
