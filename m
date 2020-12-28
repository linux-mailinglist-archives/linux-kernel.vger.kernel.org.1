Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F62E6BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgL1Wzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgL1ULi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:11:38 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F62C061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:10:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id u12so10415039ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mefs6IO4fpe1pJKV+4QYYGcjGLqpTJy7UHVzYhuwOPM=;
        b=EoiNO5aWPDY6DDlLbkKtYaD0AJcJJv1vwvgPz2VtM7nXfBTE7EAzUNQB2mXXTvKn56
         Dxrm2NWgqQbxkV19pFy7gq736xDdcXuuTRQXNRdjl/C+fLEYX5WfsRR1WSvYiocpZhvg
         kbu+ouZptM7RrRwxICWDHP+0achtv8v3AhuusVerdg8zpEgHHrdQ2lKHFvvpobFHSxvC
         CnkDG59+ybucb0MK3j4Jf4tIOiBebZZk0vE7cPpoQ9qfKuStmDWYZ1Rhw8CT8XP/+5xr
         yoPvgmyJc/sFdQQ73ple+dBazch1q+XTYeePoCYx9kKErSgJjAmgByiaUHVKArlTsiUA
         F30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mefs6IO4fpe1pJKV+4QYYGcjGLqpTJy7UHVzYhuwOPM=;
        b=RWvSjpPafBAcNRxWTCxiojFgUe6ftwlMrixgLQSkV1+DkSGOxr3Tq6oagOtSMbwF+H
         nOHUBBur/f9IBaQrNjHDDHuKlnUj1ieowj9Y2iTf6QTXQNGR9rK4oa5Bpyqtl2CfsDJ2
         ZVdEnfIzc2b9l9Yxv+u8JX1hf7BBh99flpc5qH8TtuHn/I00Ll3mMgNtpAD1+/Wcj4PC
         7MzEiVNC5Oz9W8yXW3qZNnsrVo8YT0Q/zi29TldzY9Vhc6PvLXoC2ERC4C79Zw/5fTZ9
         Y1ZraH9EC24loDXLDGGloF/03SM9ooheyFQgv4DwCrl1ak3AzxRahcvqamhPz5sUcajD
         OPlQ==
X-Gm-Message-State: AOAM532cVW8zTi63GckApXiCEtjtJ1cvLWoZ6moKpjNmYdR/eN20s919
        hmSe3wln1YlxVmYNPY/kkdAxIsAHOyYJYbAzd8CXmC+jkDVAPQ==
X-Google-Smtp-Source: ABdhPJxEnQO3jsQFIuv4yIvYjaWAQY3ilomvnvPqceLdUypeVxYYEZoBYnAZl1ppK4rvrxW3lVoRiGaJEVLuOWCri9w=
X-Received: by 2002:a92:9881:: with SMTP id a1mr45981613ill.238.1609186257298;
 Mon, 28 Dec 2020 12:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20201228194343.88880-1-yury.norov@gmail.com> <20201228195016.GD4077@smile.fi.intel.com>
In-Reply-To: <20201228195016.GD4077@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 28 Dec 2020 12:10:46 -0800
Message-ID: <CAAH8bW9UvDAB4NSQB6CuhBU6D=R6Ex6=5V=Ld74hYGK474_Trw@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: use bitmap API to convert U32 to bitmap
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Carsten Haitzler <carsten.haitzler@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 11:49 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 28, 2020 at 11:43:43AM -0800, Yury Norov wrote:
> > The commit be3e477effba636ad25 ("drm/komeda: Fix bit
> > check to import to value of proper type") fixes possible
> > out-of-bound issue related to find_first_bit() usage, but
> > does not address the endianness problem.
>
> Hmm... Can you elaborate?
>
> ...
>
> >                                   u32 comp_mask)
>
> > -     unsigned long comp_mask_local = (unsigned long)comp_mask;
>
> Here we convert u32 to unsigned long (LSB is kept LSB since it happens in
> native endianess).
>
> > -     id = find_first_bit(&comp_mask_local, 32);
>
> Here it takes an address to unsigned long and tries only lower 32 bits.
>
> Are you telling that find_first_bit() has an issue?

It seems you're right, there's no issue with endianness in existing code.
In fact, the line

> > -     unsigned long comp_mask_local = (unsigned long)comp_mask;

is an opencoded version of bitmap_from_arr32(dst, src, 32).

Maybe it would be better to use the bitmap API here, but existing code is
correct. Sorry for the noise.

Yury
