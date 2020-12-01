Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268002C9AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgLAJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbgLAJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:02:51 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37364C0613D3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 01:02:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id 7so2605442ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 01:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDvIJMhlhbrcaZHTtPoHJae6p6FFPV7vNipTH4CUP9o=;
        b=Dec+sEdHmLSDqyTu5G5KOPfHpdiLteuXIWyxpaHGP4vCxzpVZmxBEVsrvUWQ9xQWQL
         QVV0hYRMK3nFfYaoijLP0UFuyP/lnWugd9M+FWf58vC/E5a1GqAH5wXjKEUmUIIbiTO+
         sDETYjo3GvcenttvV6F+hGuEGgdqS5OX6N0EBG+7tP4joiLSbYniZ55ebSNTPvxDgYxp
         PDCwEZ3Sx9eVLxAfLeajZftlJM5KKcem1/+9a46lS7XZt74Z5R40yfasxSExAZzNzaLY
         ZjRNeKD4qtoW2Sut/8JwrNkEVVQPE2BJlONN4OuI6/w6CzL/5UGckd6sQopUhhJdzK+j
         NMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDvIJMhlhbrcaZHTtPoHJae6p6FFPV7vNipTH4CUP9o=;
        b=DKwMqSsYNaenzX8aA/WQOBn+G69Yx/S04Dze/fnA/OKx+kjVjCOx66pXHf+J0Faqq/
         V71ug5oSQqb1W91XXtDQUzmfHqMP3Znvv13bLgQrvHnjyVVYmwGl5AVwxftxNxM8EFYh
         EJpxnfkQ9JNIVFnIxSAltOGM3S+oZGkt6Zjn7xniudkYaK5Duuue7j+tuMw02MxZ9sn1
         RFIyjyDwAUzyf1f68YQV4oRgJ4ex6PWb7qalb3jxqE1Als2OjdyvjBhFsRnbcSg6WIYQ
         W6MGAgWVTEyZ0ZDL8yKNROm79l4+83cxrT4Q/2F9r7DTnLt/Q5VANhtF7I6uvfSVCMZJ
         L+Qg==
X-Gm-Message-State: AOAM533VNb9ukDd7UonNXQBpk2IWuv85w4naOYMqWPYUNFqccC50VC4y
        Jj1qZFXcwX52SDBV0ODZdLSsQ+9nfgV23j9uHY18lg==
X-Google-Smtp-Source: ABdhPJz7vu2cf/TiJi1hPlD1R4Scd7jUKjPZLB0GXqqB6CETMZRu/DRvakA6ibxBxwdxwttYYHcWjalRQ74UKbD39N4=
X-Received: by 2002:a17:906:1498:: with SMTP id x24mr1989437ejc.170.1606813323723;
 Tue, 01 Dec 2020 01:02:03 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYt0qHxUty2qt7_9_YTOZamdtknhddbsi5gc3PDy0PvZ5A@mail.gmail.com>
 <X79NpRIqAHEp2Lym@kroah.com> <CAKwvOdmfEY6fnNFUUzLvN9bKyeTt7OMc-Uvx=YqTuMR2BuD5XA@mail.gmail.com>
 <X8X8y4j9Ip+C5DwS@kroah.com>
In-Reply-To: <X8X8y4j9Ip+C5DwS@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 1 Dec 2020 14:31:52 +0530
Message-ID: <CA+G9fYtWappsU-njZx87ZJVxmTHOr1zUNE_q=k0Dz5cW16rBkQ@mail.gmail.com>
Subject: Re: [stable 4.9] PANIC: double fault, error_code: 0x0 - clang boot
 failed on x86_64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 at 13:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 30, 2020 at 12:12:39PM -0800, Nick Desaulniers wrote:
> >
> > (For historical records, separate from the initial bug report that
> > started this thread)
> >
> > I consider 785f11aa595b ("kbuild: Add better clang cross build
> > support") to be the starting point of a renewed effort to upstream
> > clang support. 785f11aa595b landed in v4.12-rc1.  I think most patches
> > landed between there and 4.15 (would have been my guess).  From there,
> > support was backported to 4.14, 4.9, and 4.4 for x86_64 and aarch64.
> > We still have CI coverage of those branches+arches with Clang today.
> > Pixel 2 shipped with 4.4+clang, Pixel 3 and 3a with 4.9+clang, Pixel 4
> > and 4a with 4.14+clang.  CrOS has also shipped clang built kernels
> > since 4.4+.
>
> Thanks for the info.  Naresh, does this help explain why maybe testing
> these kernel branches with clang might not be the best thing to do?

It is clear now.

FYI,
With this note LKFT will not test 4.14+clang and old branches.

- Naresh
