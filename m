Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B73270148
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRPqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:46:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A85C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:46:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s14so4432584pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkgDDbxZ0ilYITjWl8C63+E3bk69jBdfnUZGv0u3+yE=;
        b=DuSddiKU58AUP/n7xqynLIDV6aGggzLwPpQvdlS76i6QN2Pq/fmkGuOEID2Ld5Xk/w
         SOA/gNLariAGcorvyKjcSDpm0434qHkSdWD16ADHmyP4auPFVXp2aIxXyk+R+yItxLOn
         2Ygls0aSH1HZOuPc8x+skY2EnXESAvg6/DO0mqq8mxmS2y3HgUgocuyL17frrSF7mgXv
         B483rs51EK2Sef8QG8uPSeGEiQBhaYtGR3+qRJQF5X/qwGwF4WRfwn9n/hJz3ssS2HXS
         zGbn1uROFj0NFHIpjP7HDQ3hR8jk+opplnatdx6WOa2StX9ahda3qrdeDnfOnrVxtvse
         jhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkgDDbxZ0ilYITjWl8C63+E3bk69jBdfnUZGv0u3+yE=;
        b=X33/LGjCIvck7c+0GGn0VB+VaCvsDGiS/eKhQJ13LBw8YPgCVfynychfK8IBBwzmQb
         DdizPQhbska47BAfXo1pPfvSXApQYnpYsKCTZdl++/AUNyX9T8luMs0GQBHJp2HgVXkL
         h9p7kp0Ht49xPsxk9RAZSBqlOPptgUN2J0SS2iiSCdtGut6gyoO40fnKgMZy7HN8GlxY
         85dbiK3ZX+41EejAMSNyaYkAANYoWbjwlRpIUUk8V61N4ZlF1oyjPcUKLphhRsuqQrqr
         2vc92QEbSwpzDyC5knY7WxHgsXnNF8sTiB5laXSHOQdM1liwqT0PYzPijfhIObYwDL3k
         VjEQ==
X-Gm-Message-State: AOAM530yun2tmZaCAgZVl5XaGFC7xu/yNGJQibDjx2M1sdWOJkBDmwYS
        7vMGaRrwits9uT80FxOPZR8Ip403B69YtoWn712G4w==
X-Google-Smtp-Source: ABdhPJxGorRTMUyDtWd2xSOIntBilFG3dQo44Ho+eGPonH84X6ooJ+So+Qk32Bqicn7FQje2enaN7vNH3BuA5SSHppg=
X-Received: by 2002:a17:90a:cc0e:: with SMTP id b14mr12978124pju.166.1600443965540;
 Fri, 18 Sep 2020 08:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <329ece34759c5208ae32a126dc5c978695ab1776.1600204505.git.andreyknvl@google.com>
 <20200918123249.GC2384246@elver.google.com> <CAAeHK+wF_tkBqHd7ESSa5jOy50AW1WfzSAM-qNf_+iMkLwptTQ@mail.gmail.com>
 <CANpmjNNrBX624GJWY3GK6YR9xoYX8BwstXaRYXJT1QgSFORSaQ@mail.gmail.com>
In-Reply-To: <CANpmjNNrBX624GJWY3GK6YR9xoYX8BwstXaRYXJT1QgSFORSaQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 17:45:54 +0200
Message-ID: <CAAeHK+z5pqSYJifvpLoHNe83UaJSsuR8WdBS8-JOwgCeHTi8ow@mail.gmail.com>
Subject: Re: [PATCH v2 21/37] kasan: introduce CONFIG_KASAN_HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 5:36 PM Marco Elver <elver@google.com> wrote:
>
> > > How about something like the below change (introduce KASAN_INSTRUMENTED
> > > Kconfig var) to avoid the repeated "KASAN_GENERIC || KASAN_SW_TAGS".
> > > This could then also be used in the various .c/.h files (and make some
> > > of the code more readable hopefully).
> >
> > I tried doing that initially, but it didn't really look good. The
> > reason is that we actually have two properties that are currently
> > common for the software modes, but aren't actually tied to each other:
> > instrumentation and shadow memory. Therefore we will end up with two
> > new configs: KASAN_INSTRUMENTED and KASAN_USES_SHADOW (or something),
> > and things get quite confusing. I think it's better to keep
> > KASAN_GENERIC || KASAN_SW_TAGS everywhere.
>
> Ah, I see. So in some cases the reason the #ifdef exists is because of
> instrumentation, in other cases because there is some shadow memory
> (right?).

Correct.

> The only other option I see is to call it what it is ("KASAN_SW" or
> "KASAN_SOFTWARE"), but other than that, I don't mind if it stays
> as-is.

Let's leave it as is then. I don't think the code will get much better
in terms of readability if we add KASAN_SOFTWARE, but we'll get
another "indirect" config option, which makes things a bit more
confusing.
