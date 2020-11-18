Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6572B87E4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKRWm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRWm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:42:57 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606AC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:42:56 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v144so5328515lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixC0u6OyfxUYrt6QPqUZ5rujN8BJlqxwPvY/3+nhmXw=;
        b=wM9aPQLkCBhozlv2tfs90X5CI/Gs7zj3W6yTsPL8ES9kkqjKh9iwLJkDQbSmZNpPLv
         RkDOiDVBzFOBN7f2DWutl/757ig3/smDTusOtJ0ogOVayqIKQf03FO221+RCzKz0RL1M
         lIePHojAzGK+lkneSQi3IaBQCGycKs9Is3+G/9FX2LGDtYxarsXwe+NvcRF1w0eD8vc5
         57UiQ/6QoCU1He2HVP18Mkb6b7FyJI8E4/ztzOoiGFc69FJKJsZkoCUHCpldX1hGS5Bd
         +qciHnJn+5niJMe/hEyj2WRvIbyvqkFLZwU5jjNk7p7pJ3hoTwMcIaW/78Dt5d4afqBH
         z88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixC0u6OyfxUYrt6QPqUZ5rujN8BJlqxwPvY/3+nhmXw=;
        b=nUzueaPpxbEROuyPh9mNUs0avYlmlYXmkmotc0qDsLipakpdYiHcbhv1UDmPXi8pJq
         z33I7hmH5vswlBAL38c0hz2IZHPWnn5uH9gpwMHt4d/lRXzNQoJakwFjXxu8WgFdKAqq
         JcmA7BXU40iYippV/KsMBZY1lQMohXeZC0FMy1H5d24OZp5CrBt5yAWUfdn/MNaTovq5
         0/ZfEypKwZukH9xO25kywgQzedjJs+iSFIcTwyptrOBKy5hpyfzK3I7d22TYZdYNqMt7
         xl3s3ophK75uwS7j/ZrVsyXcJgZD5Gv4iSl3sTkkp/Ih1cAq72ohktdbULJe37n3M46g
         TYsQ==
X-Gm-Message-State: AOAM532VGflRLS+snzc1U1puhbocqclcebSZr0PGxVQ0XsVLeTmS2YxV
        Ij7R9EFLIDq4IDztza80lLmqGI2iTWFWtMFL8UcQUA==
X-Google-Smtp-Source: ABdhPJxl5FB4w+I/3B3Kt/0LDlsbAGvVIt8KjuVNjLyXl4970VrDg0GQ1NlTl543R7gFJlHkLyHKMWM5T6NkljfYu5Q=
X-Received: by 2002:a05:6512:348e:: with SMTP id v14mr4178858lfr.97.1605739375008;
 Wed, 18 Nov 2020 14:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20201026160518.9212-1-toiwoton@gmail.com> <20201117165455.GN29991@casper.infradead.org>
In-Reply-To: <20201117165455.GN29991@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 18 Nov 2020 23:42:28 +0100
Message-ID: <CAG48ez0LyOMnA4Khv9eV1_JpEJhjZy4jJYF=ze3Ha2vSNAfapw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mateusz Jurczyk <mjurczyk@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 5:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
> > Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> > enables full randomization of memory mappings created with mmap(NULL,
> > ...). With 2, the base of the VMA used for such mappings is random,
> > but the mappings are created in predictable places within the VMA and
> > in sequential order. With 3, new VMAs are created to fully randomize
> > the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> > even if not necessary.
>
> Is this worth it?
>
> https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/

Yeah, against local attacks (including from JavaScript), ASLR isn't
very robust; but it should still help against true remote attacks
(modulo crazyness like NetSpectre).

E.g. Mateusz Jurczyk's remote Samsung phone exploit via MMS messages
(https://googleprojectzero.blogspot.com/2020/08/mms-exploit-part-5-defeating-aslr-getting-rce.html)
would've probably been quite a bit harder to pull off if he hadn't
been able to rely on having all those memory mappings sandwiched
together.
