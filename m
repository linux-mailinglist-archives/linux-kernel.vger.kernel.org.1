Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC62547FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgH0O5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgH0MiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:38:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10F0C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:38:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 31so3244680pgy.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5sih6/oMnkYkkS4cZqAk1lLuHR7D9bxWXGtKLgy7ous=;
        b=crL7nHRgDL6EYVd4SPOphDL7ayvhOANRH0SS14x5PME3S6QDy/8CjwFEhnh5jNMMsX
         +aGRaEjd8vkwjKv3A0GgdlYsHTz/PIxBLY+sqbXxDoZGLpI829YiRwLYHdjXhj7HMkKo
         XdI6PWvxhTZHL5fo5aYbpxgVu54v3pRbUtHC0KXp1W7zdnDpfJ3dGN0CGc1UASxvteCa
         g4RZhpt3yCS7niq/EkYg8sX+siekdpNjdQ1/O4Mm5/fLmqsCAGWBPp/rrSE/pYujCcvI
         0dj2sxYci3WMyZPdZAVla5Y8RvrIFgjFUyXJ6sSaXGzHMoehwVOeOPc1UyOx9r8jBB2P
         dV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sih6/oMnkYkkS4cZqAk1lLuHR7D9bxWXGtKLgy7ous=;
        b=Z8P8YvZ7V56BxeLB1mY9l7M46mvwJYe+zAAP3cHAjc3XA2fDPm3PMkkGL7pxLKUAoz
         BgTHlSODthNDr9n4Hwt1trg2t+71r/5Wd92estSnU1zgHbK4jzuMFC2hTkEbtHEpjNko
         KIFLbaI9SO2ttuZdljfIINTuyxpfru5rue6JKCQB1vL0ShlMlUlzoSsc2kXiodpbxp3A
         /bDGwWw8XGCfPNe4W0j7MK04PC+j0L8HUWuASOWzUdwH/EafL4o3bE8SubtudDbEur/n
         YxXZwgJHjo02qD+jPRYc/xyn+K3E+9i+VjPz5f+tc65MwjOWz0G4rtRTdDj+U48goNYO
         3Sgw==
X-Gm-Message-State: AOAM531CfUrtEKDbBc4vDqhbYcyuOHU1MszEhbBL5SAr19xzEFWf2FIP
        YZhanlfXK9WupjWKZnwCTgH8Im1SixiUEET+gt/0Hg==
X-Google-Smtp-Source: ABdhPJwcv+HIw2fTTEzf/r324JRbSbst5zk+Xxyw2x8H8damlHOBL7tGL4/iW+RZZqqulewQX1qyqFolYBORJa+oZQA=
X-Received: by 2002:a62:2bcc:: with SMTP id r195mr7684877pfr.123.1598531888012;
 Thu, 27 Aug 2020 05:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <4e86d422f930831666137e06a71dff4a7a16a5cd.1597425745.git.andreyknvl@google.com>
 <20200827104517.GH29264@gaia>
In-Reply-To: <20200827104517.GH29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 14:37:57 +0200
Message-ID: <CAAeHK+zY_MaquqrpYFVcH5XtsWT6WtREqUa897V-UpBpqoiGCQ@mail.gmail.com>
Subject: Re: [PATCH 31/35] kasan, arm64: implement HW_TAGS runtime
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:45 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 14, 2020 at 07:27:13PM +0200, Andrey Konovalov wrote:
> > diff --git a/mm/kasan/mte.c b/mm/kasan/mte.c
> > new file mode 100644
> > index 000000000000..43b7d74161e5
> > --- /dev/null
> > +++ b/mm/kasan/mte.c
>
> Since this is an arm64-specific kasan backend, I wonder whether it makes
> more sense to keep it under arch/arm64 (mte-kasan.c).

I'm not sure if we do. I'd rather keep everything together, spreading
the implementation around the kernel is inconvenient. We already have
software tag-based KASAN implementation (which is also arm64-specific)
in the common code. We could, perhaps, rename mte.c into something
more generic, with other potential future hardware modes in mind.

> > diff --git a/mm/kasan/report_mte.c b/mm/kasan/report_mte.c
> > new file mode 100644
> > index 000000000000..dbbf3aaa8798
> > --- /dev/null
> > +++ b/mm/kasan/report_mte.c
>
> Same for this one.
