Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD98829343D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 07:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391611AbgJTFUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 01:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391604AbgJTFUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 01:20:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA98C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 22:20:18 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f21so572928qko.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 22:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9wYYqXSCH9hJsvZCRRfPmiplKII60fDiq3y/0UOTRQ=;
        b=nFj+RhH527dSF15OyCknqBlNqu/5E4YnS1qpIFJZvkK0948u69zvGZW4bKEqndnMFz
         8yyx70GM4gugorWaNi9Kci+S9s4l/cZTT/4+wlXS78kRrYtRgPdN4mgLPQ6Xh7ovioJR
         gUO2EnXkClA3Rx+rf65BWHug7V0rfi7T4GnGTpLU0Ez5EEZ0aXY6b1Ga9I8unR45iRM4
         righHXZWlAPHkljP5Y23955u2C47+j6rgw7tV/zyL1TqZpFVY8JhWYzmwEGFLnHsz/i1
         ido0lhbQv3Uryk5j7uKTd5JqVqzYSe8vbOBMaxvzBaZ7BX2Bq64/CxUZqemmfqlASOAn
         ioog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9wYYqXSCH9hJsvZCRRfPmiplKII60fDiq3y/0UOTRQ=;
        b=rvficZHWNgqiYYGgzyHbmdOxf1genNnGDlTvAptAotL6n5sb8VOJV2/IlyPlcyuFeJ
         x+bsiGo+5Q/t4AhZxMkfCwDMJkThx1cLzXalz4CMSLXiQDBY3gM7/hpoXHaAfYY+/zJa
         X/gkKIa0rI7UfNd71kfkk3UpEKK11KlPeYjP+mDnPPddmqc2ddIvynzjD+gMq1RWC+YD
         Vs+pfR8qVsj1IEUqsQ+JM3gZCNRljL14BfZBMGT3RrvAZZQvcjOBom8JKd2L0OBoVShb
         DcakM5MGsEXHTfL9LPiIosnc48ZmCsz8+hvWcWOwhACR24Nxc9Rxajku6/+/UT5rJVNB
         epmw==
X-Gm-Message-State: AOAM53307XnbllWrv9KBFBjc8lrOpZCdIX5lqNiZGy3yayKptW6/+psr
        rVkkjmRh13DVPVGuDMBKlpzX7PbvVXcH8L/Pz2HrYA==
X-Google-Smtp-Source: ABdhPJyx8CWXpC5StOxXKhwfKyIBUtcww66CulSXXuA5OMvHecs0nRH1A9mqu15lKale74SmTIIJ6I71TjzxvW0MI9I=
X-Received: by 2002:a37:9301:: with SMTP id v1mr1244436qkd.350.1603171216987;
 Mon, 19 Oct 2020 22:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <CANpmjNN3Ax2_CfxXixh8-NipXOx7s8vprg23ua-M_tvUKZGq0Q@mail.gmail.com>
In-Reply-To: <CANpmjNN3Ax2_CfxXixh8-NipXOx7s8vprg23ua-M_tvUKZGq0Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 20 Oct 2020 07:20:05 +0200
Message-ID: <CACT4Y+a=twL5eKnpZE18g4j57+PEYMPC0Loyx_mepn4u+hJTxg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Serban Constantinescu <serbanc@google.com>,
        Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 2:23 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 14 Oct 2020 at 22:44, Andrey Konovalov <andreyknvl@google.com> wrote:
> [...]
> > A question to KASAN maintainers: what would be the best way to support the
> > "off" mode? I see two potential approaches: add a check into each kasan
> > callback (easier to implement, but we still call kasan callbacks, even
> > though they immediately return), or add inline header wrappers that do the
> > same.
>
> This is tricky, because we don't know how bad the performance will be
> if we keep them as calls. We'd have to understand the performance
> impact of keeping them as calls, and if the performance impact is
> acceptable or not.
>
> Without understanding the performance impact, the only viable option I
> see is to add __always_inline kasan_foo() wrappers, which use the
> static branch to guard calls to __kasan_foo().

This sounds reasonable to me.
