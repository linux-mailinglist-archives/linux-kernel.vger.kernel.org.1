Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F8F2F29C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392219AbhALIKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbhALIKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:10:42 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47ABC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:10:01 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 22so1154925qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s05pwcBYuLFgatCtLuiKcXyLuPX0VE24Igc6LpSnaVg=;
        b=IkA2W0UmXUfxssoEh+Tc3y+Uaa8JloH/qtMUdsiXXyxA7szC91ymmjmpzyxb7rdu2n
         49z7g6RcTFWDhQGmu5sw32JP/xz0BEa9XzVGLqkSjXkvqNtMbQqLzvqx29lMk2lXLjFt
         p0VJWeWXZudv/QrHmImsyXI82W/MYXkpPvVUy4Sk+ipzbGlyNCTBGbuZTrPVeNP+bfiN
         0T9ooIznX5gpSI92427e2cOazuP1MgyqAH1wIwgVj6giHWG7fr2dbF70d0K1zOWwsPrV
         yZFU9LvQTj78W+8pQaLWovmHeC/2f8Jg2LQJGWIAiX4THVLHjj2jIdim0i1+yl5u8BQD
         Wz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s05pwcBYuLFgatCtLuiKcXyLuPX0VE24Igc6LpSnaVg=;
        b=uEHyJErWWVM/BptsrT0unTmXd+LHIb3B5R46tOY80cDEsTf/MsspW6t9LdOY2IgfZd
         Ej7hCYsmm9eFdCCUGx9t5AM+qYAOF+owY/9FYfXiKT5ATgurW/enqkeBQKFWdu0SDo0o
         ByvQxejFDXRBmc82cWS2LCHhRQMy0TNLJ5CW1jVaQi0XKnW69ScZRkQh3hb1bi5PyBK3
         Cjm8vltfp6AOZ5jgOtEj2SuiZABCs7QHQohdvZ2WolD0jLUcDoOSSW4gib9PXx9MLmOk
         FOL4eEfDGFjcUNQiUqLaLOd5tSu070ykuWH+FxHr9Q1s3uYnnE/VR58HhImCPxUFSKNH
         BfnQ==
X-Gm-Message-State: AOAM532lvZ9LuxLxnLj605GyHFuXWxQff035E4Vsq7klikFraz36sY+X
        G3wQ3wXdXVXT6etAEfHP3zdROfXckKkflcdJ7MXN3w==
X-Google-Smtp-Source: ABdhPJwLm9tdmkbR/Ymrz7eE06GWlsqgbCCeS5Ul2r5SNUunseW8uhgMh6dRNlXpzKqHIRTm3QX8tiqsqJ50ABacdl8=
X-Received: by 2002:a37:9a09:: with SMTP id c9mr3334368qke.392.1610439000729;
 Tue, 12 Jan 2021 00:10:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <ae666d8946f586cfc250205cea4ae0b729d818fa.1609871239.git.andreyknvl@google.com>
In-Reply-To: <ae666d8946f586cfc250205cea4ae0b729d818fa.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 09:09:49 +0100
Message-ID: <CAG_fn=U86QGTTp+vgQQhjMBY=_dQgPbWKJ1MKt8YHdyLi3deMw@mail.gmail.com>
Subject: Re: [PATCH 06/11] kasan: rename CONFIG_TEST_KASAN_MODULE
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Rename CONFIG_TEST_KASAN_MODULE to CONFIG_KASAN_MODULE_TEST.
>
> This naming is more consistent with the existing CONFIG_KASAN_KUNIT_TEST.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Id347dfa5fe8788b7a1a189863e039f409da0ae5f
Reviewed-by: Alexander Potapenko <glider@google.com>


>  KASAN tests consist on two parts:

While at it: "consist of".
