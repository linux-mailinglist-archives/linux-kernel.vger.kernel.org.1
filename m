Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8922F7DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbhAOOMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbhAOOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:12:33 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:11:52 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e15so6035492qte.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gEonePWvzu8OtY+gNiF+A5sU1b7iiv5oXrRT2xFrUA=;
        b=EZ8VlQWZsvspepqQrNYbFkiG3YeAjO4Uky3v0HA2bfDqp1HNIQbb0/eIQYAl+u7mx0
         SwImgqTlH86h3NBIK3+/8iSnJDsJvtxcnbv0dGPyZ7pwCXvHqBbagaL/H2XEsVLoLur+
         fNymgaYne9X+U8clgfNxyHK0kKhrmwSt80lec+D2m6bRRq0tOg7xq0ItCZOBahwGKpTN
         K5bNm6yTE6XDaerJSwpqLGL/sNE2ll3aBN4Z2mjIStZGtHET4nz7tsQ1dwLfdxFgGAby
         MYMZQZpTz8K4MmRSrX+WezyiEYJ4QHHxICs9L6Apk65Htw2HfleBSXmzAEKPDMOwRy93
         AqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gEonePWvzu8OtY+gNiF+A5sU1b7iiv5oXrRT2xFrUA=;
        b=C0U0P18XfzgbY3mM31v8EeYiQw28MQDst8/5ktrFOHiQZLCugX1ckGEN2AAUNgjWTI
         Zwn4rk6UPOdtuNbwIbrnsnBvpv/7xvRJtIFpGsXzxEsr8stOsrYB7Lx43zdt83utsVeZ
         aO9xNg8V5RatBQof1fcAW145jJ6+ymojR5JvpPEVa/YiatPdfq0dWWCC/RHGDCqyUYFJ
         20fNIpYM2XNtVsFq2TsVrMPxxhrDGyV+u9blNHFe6nNWzUQAhZxAJyaqbTegZ/MfRpma
         YDS0ERm2f4lta3EQOHPVQiWBFO1XTvj1Svf68/7C7/MuOPpvCHMofL48JUnYmUaNTX/e
         sbzw==
X-Gm-Message-State: AOAM532J52w6e5U29P7HK9dKORGMIzVdYuYxLX/ZHx3lCCxJoanwAPYA
        toNuIYZUywiMjttft1rrW0DrDeLW7RKYPoz3gbcVTw==
X-Google-Smtp-Source: ABdhPJyxSI1F6HClbjvqLLR+s+hldMswtShzI/Y9lPCG/P3ZkcnV9ds5+hNrIdXazySsXeUPjd5DysBvJDnZH7aHH/8=
X-Received: by 2002:ac8:6f32:: with SMTP id i18mr11814637qtv.175.1610719911742;
 Fri, 15 Jan 2021 06:11:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com> <73283ddcceed173966041f9ce1734f50ea3e9a41.1610652890.git.andreyknvl@google.com>
In-Reply-To: <73283ddcceed173966041f9ce1734f50ea3e9a41.1610652890.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 15:11:40 +0100
Message-ID: <CAG_fn=VC=UPtVWfz81KeX+hEO1eC2PkZowWyFJbqz+jmiEeOQA@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
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

On Thu, Jan 14, 2021 at 8:36 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> It might not be obvious to the compiler that the expression must be
> executed between writing and reading to fail_data. In this case, the
> compiler might reorder or optimize away some of the accesses, and
> the tests will fail.
>
> Add compiler barriers around the expression in KUNIT_EXPECT_KASAN_FAIL
> and use READ/WRITE_ONCE() for accessing fail_data fields.
>
> Link: https://linux-review.googlesource.com/id/I046079f48641a1d36fe627fc8827a9249102fd50
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
