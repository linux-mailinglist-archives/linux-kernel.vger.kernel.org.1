Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3922F38DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392690AbhALS1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392645AbhALS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:27:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0345C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:26:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2so1884173pfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vQT4NtiVFJodkrD1RgJ5Y9lFxIHZicjdW+dmh6bdf4=;
        b=R0DjcdFXGvldorX8vRzjkNOxMsb8kWQ5jjPSiPBg+xE5YcFva81QCoNtw84KPs0YRP
         EzribJYibzqA57wSaGCth/bMHS0oAnUm3PxCLgUbdWAJB7TI5PchcD/Sz0yj3sGBmcY7
         j/5bdfxGf0WOmuCr6NqDqyua/V+QDsif+yS6F+0lGqdKSoqssdWqfL3HW+DJ0hAQC+T2
         eI29yPOZWSCMLpmvGLBUaLrvw+lTaBXlUsthzGocfxeLHQHrI3mdfWeOVC1TweacpRQ6
         yGp+TLBRvia/w4C+kwGDGA8c59G+w1lgCg8ErQxhtt4keOTCI7lVz7ZpWUv0OL/3ud/G
         YV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vQT4NtiVFJodkrD1RgJ5Y9lFxIHZicjdW+dmh6bdf4=;
        b=ZCqNnP5S/uGB+JkihEA1k7aPP7leJcV7nZTXbbvoTOCEParh5IwVaEcoZB/ZqSNOPp
         85KuQIVOuJUv/1YGC1/zEPKBGuSku4x1MLzwr2XrYlv6bhbTezyrPv2BAbuxsRWbqB2V
         5poIKZU9l8KdPY+G0IWjnowwdvcuz+nvc51w1jVBICKtaxJkyiX5+UMpn2mkeCrPFUWF
         Xi0qV3SwtRRs+HtWpomzxx2SvroSk9m82OjwyfRJuTHUQFCkAwBhhpzqXQe985Viq7h9
         Wk0/2PaljnLEUFkOJwBeRzSwFOyszEKEORPV3j7zcKq3btVryE+fpQ9l2G5ohyrXXaIY
         HKnA==
X-Gm-Message-State: AOAM532KrQ33yARX3GQtFeG8jTzHXHmL9XhWG+lTkMYqaVFL2VOgk9ml
        av1/hqq/R0S8QPMGV2FeGHKkMaDX7p8852ZPYmWPaA==
X-Google-Smtp-Source: ABdhPJx3aPLdoAqssJRv4JHo6B5rd+3wkT+HY84pSBGc0msNYdPiDcCHU1hpDc1cateaEMeCsdgNJUjuNNwyKKQG4G8=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr543993pfh.24.1610475998075; Tue, 12 Jan
 2021 10:26:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <ae666d8946f586cfc250205cea4ae0b729d818fa.1609871239.git.andreyknvl@google.com>
 <CAG_fn=U86QGTTp+vgQQhjMBY=_dQgPbWKJ1MKt8YHdyLi3deMw@mail.gmail.com>
In-Reply-To: <CAG_fn=U86QGTTp+vgQQhjMBY=_dQgPbWKJ1MKt8YHdyLi3deMw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 19:26:27 +0100
Message-ID: <CAAeHK+wkqPwtbBrpZ3dgEi1eRH6NmyXYKx6R-3vi28JdZm1c-g@mail.gmail.com>
Subject: Re: [PATCH 06/11] kasan: rename CONFIG_TEST_KASAN_MODULE
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Tue, Jan 12, 2021 at 9:10 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Rename CONFIG_TEST_KASAN_MODULE to CONFIG_KASAN_MODULE_TEST.
> >
> > This naming is more consistent with the existing CONFIG_KASAN_KUNIT_TEST.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/Id347dfa5fe8788b7a1a189863e039f409da0ae5f
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
>
> >  KASAN tests consist on two parts:
>
> While at it: "consist of".

Will do in v2, thanks!
