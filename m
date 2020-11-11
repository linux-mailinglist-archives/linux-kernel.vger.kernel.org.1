Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA52AF89B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgKKSzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKKSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:55:01 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C42C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:55:01 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id w11so1439477pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WeV7hUrwro5zFQ6cbjkRFYCH8+pe7+r1CSRKZroL8E=;
        b=OOpFfVi/gVy3Ut+OvJxI25rQEImfpUbgYF9V6jx/0UFT7h7TkXGH51fM6/RjYFDW17
         obuvmP9bEGYLo7FWYXb/XCQIr1Lgn+6C+bxD3jCLNZPAsMIwxIYiUTfRSkc8Z4u6JF+D
         NLgnujAr7tytsqwCPjP1GyDipCfBaqNu3nG4+eGjzedAzAer/6lDPK14L1sm1+033hhp
         DSUFcsWjGRKkesSLPhe42w+Y6XHEWvox9/lKqIgGKx16HPbi31IUni3jjipTBzmZ+0x4
         t+K3OV7s//7HZtarBx8kyTbk7N15Qp/Qf4yabZhpDdWkmbj3oz9zbamQU/Z3/MtiUkn9
         6ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WeV7hUrwro5zFQ6cbjkRFYCH8+pe7+r1CSRKZroL8E=;
        b=jQN6qX62sAHyI8cZJWhJewfMyrNKOIaIAtk63I/EXuge9IiEPkdI9bYRp0BRXjcQ35
         NtHTYuy7cJ3LqZcdh+0hWDttPcwWBnBPjvOEoMVJSr2qy3VvDjtUF2i2N+2ckvTGcyon
         IecpKV6xo/Ksi4ttMOdZdym3GE5ojh1UJet05UQJtlg0WDCa+pC7axm12vuGQuuXankQ
         5JT6hXfZAshtWUuEhJLcoNiLQkC/sJhUS0l2l07lj6ELacPEsZu+e0IlPQSXFUJyJySW
         SzdIysCi54LnMq/cFetNih9C25d1rZn1L3Lj2MzMoB97HcLAcAlL/y5+4Ja2RyuxWehr
         2O2g==
X-Gm-Message-State: AOAM532RMFNxOAlyzTqBV5dEzdtJNJAFHWZLdIBFKaa+5ge5/veZnjUt
        0PRtcOk6pG9MC9nJhOqsoTYXfaNGHRFx0by2noIP9A==
X-Google-Smtp-Source: ABdhPJyQZ5eQvqybr3BJ/5FSSyY2drvPVG9WdMj9qDTwqgoShNEtsMOA0jv0Ggva8IBP26cwt8EVrvJcVSIQ6tPAzFI=
X-Received: by 2002:a17:902:8d95:b029:d8:c2ee:7dc with SMTP id
 v21-20020a1709028d95b02900d8c2ee07dcmr2128379plo.57.1605120900544; Wed, 11
 Nov 2020 10:55:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <e9077072bcdd4ccaecb1c84105f54bac5dc6f182.1605046192.git.andreyknvl@google.com>
 <CAG_fn=XvXDe=+wuBNBq=fmidZkghNx_g6RbHRjgMMa658_1LXA@mail.gmail.com>
In-Reply-To: <CAG_fn=XvXDe=+wuBNBq=fmidZkghNx_g6RbHRjgMMa658_1LXA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 11 Nov 2020 19:54:49 +0100
Message-ID: <CAAeHK+xoPQ5sVFVf2aRqcLJX8d9e7t1sNAF5F=gwTArDVN99Aw@mail.gmail.com>
Subject: Re: [PATCH v9 43/44] kasan: add documentation for hardware tag-based mode
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

On Wed, Nov 11, 2020 at 5:57 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Add documentation for hardware tag-based KASAN mode and also add some
> > clarifications for software tag-based mode.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Marco Elver <elver@google.com>
> > ---
> > Change-Id: Ib46cb444cfdee44054628940a82f5139e10d0258
>
> > +
> > +Software tag-based KASAN currently only supports tagging of slab memory.
>
> I think the reader may confuse "slab memory" here with "memory
> returned by SLAB" (as opposed to SLUB).
> Maybe "heap memory" is less ambiguous?

I think heap memory isn't widely used in the kernel context. But I'll
clarify this part in v10, thanks!
