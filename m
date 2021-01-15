Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB0F2F7D22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbhAONuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731945AbhAONuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:50:17 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C2C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:49:37 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v5so5981915qtv.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImoEwuTdQjAc7TacOKy8igwa8R9Q6yFQgZN+WOt6oC8=;
        b=T9JdoQa+nKsCU/4kHeUpVWJSPmU9sgyVefju9am+d+6193DbcDOumSSSg6O0vIpHiB
         EANZKPxm8iRhVVUnocl99voUP0Z0g3bhg+uZw5cBhHYYBR10kCqZFU3t6qe+mPGMS8jZ
         Z1TG8o1hFqeG77v3TY3Uy8lpfeIWTro0hnAL81MjGuBP1wj/T+dt6UL4I4bcvd0PFOoY
         8mc9OSbJuYq29bm/l1vzCrw9w7nzpcRmeLrswYDJzN4cM4uo5wTLK56PNL7/aAigpYvg
         KgABbZUZ0tZJMgm853J+/Wl90wVK+kZm41dklNCMXUZrreEbXFb3+7M9NVlfog3lOdpB
         sW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImoEwuTdQjAc7TacOKy8igwa8R9Q6yFQgZN+WOt6oC8=;
        b=QsBd3f2mH0EUqMlKbms9IPf9g0T7Pzv2M3R1i42IWNH+IaDFQSz+vCklJ+ShNIOrMa
         NuS6tYsd7+IsgRpW1GzYguRYnbTTom94s5B3UxjjgQL+CR3a6c7uX07ds8WrfVUjjNee
         zZjEZ0dDmOwM5qsWge4MBKwdfVY57BeBOVlurZiFAn1oDBM9491HKvHv8dPBKKeD6dq2
         3RSNhMPpWOZvgSrEPalVgGO+5HGPVl7Hb5ZmEjfrPKR0t/INdh9q7MfDNGJAe2Y8pdGP
         6/UIHK7rAQlaEFoRZEba4BTqgu+BlcVbYgsqjBsF1GTX27SaF8gbWbcttuFZI/pPW1pr
         CjxA==
X-Gm-Message-State: AOAM530lEAqN8/RV0NR4SJ8HMjpEj0a5mctUN0TKR6T8iNkVUi/cWSH2
        9Hg0TEry8vw0DwIE3EykpddEC3qubaXZS2BlAWy18w==
X-Google-Smtp-Source: ABdhPJzV0cIgOgJIpi4NAFcfV4w1qu/54yP4I68IAk+60nCrAPVL/XnF7a15uKcRtuNT/1MDUc0JpmMFdXy/e066LFs=
X-Received: by 2002:ac8:6cf:: with SMTP id j15mr11672543qth.180.1610718576341;
 Fri, 15 Jan 2021 05:49:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com> <b75320408b90f18e369a464c446b6969c2afb06c.1610652890.git.andreyknvl@google.com>
 <YAGVqisrGwZfRRQU@elver.google.com>
In-Reply-To: <YAGVqisrGwZfRRQU@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 14:49:24 +0100
Message-ID: <CAG_fn=XnF1GmOsJbHNtH0nn3yXq5bghYDXDkeqawEXTzom8+sg@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] kasan: add a test for kmem_cache_alloc/free_bulk
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 2:16 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
> > Add a test for kmem_cache_alloc/free_bulk to make sure there are no
> > false-positives when these functions are used.
> >
> > Link: https://linux-review.googlesource.com/id/I2a8bf797aecf81baeac61380c567308f319e263d
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

(see a nit below)

> > +     cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
Looks like there's a tab between "test_cache" and size, please double-check.
