Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0932D1E67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgLGXf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGXf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:35:28 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383AC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 15:34:47 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ce23so18239195ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 15:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQn63EZOge/5u1O/zNYXVy9jWmczpwAodhP6G+HhrVU=;
        b=jeKo0g5j8gN4DEjE1aP2Z3RxD4Z8Ti4/W6nfcus+ybjPJw/Hcim9xy6YDaReHy+a0U
         4p4YnHZCHpTjyCSDmP8zNjiCM29dFmsd+k5ToTTnI4dzuSDlHOIO3/Cb2pDuCGi7c0w0
         lw+VwjuHL68EDXS5o40RPzwvwQn2cxw6a8Q2Rgs7ApmqyZi2gLEsilYdE0P+Dv5TnA2f
         1obtLxrhRxgRFiIiahpyBhfX4uu5QLNQNAB2w6pNBFuAUvZkwUPLtuHC2r62PC9U8UzB
         gQ6IDVmxnXeye5t+35Ly8YNDeoVFzu0jiAg9wG8D1Ym4cnuryeECwcgIDmDfb7R2hb7E
         GJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQn63EZOge/5u1O/zNYXVy9jWmczpwAodhP6G+HhrVU=;
        b=ga/jbZ4rFZZn9NMOqmB+79EM7bCbALKMYk9sn0o/3PGGRSlIuQED462ZXQIO9GqBKL
         NbUIoT7cdktnNkt+tW3yeclK2iRqQgxsH36ZvT/kljW1yKIfBqfo5XKIUy6o+/9Qv1uc
         7Gr62NctlMfeNaoMFaZUtu6IxhMKeIFfGXqCsn+XQyGrIvjkGpzCF9B3JHhYTF6FOIxf
         Cd6TzIQL1RZJhUyeSP+kRYeLgkdac5wGOpwBG/6Tq9Amyazl0Cvy5mkWJGh7EsgwIV3P
         2kDupJ/R1ne4Bc2QZI6F+pfEYM7vhfU9C91xZ2dmXcR9jAchw1CR/4NgB4WsQU1o1W41
         3luw==
X-Gm-Message-State: AOAM530EokaI8EQZXeHjWljQON7XEFBZBd5sHbGlGOSeN9GR4KiObx1F
        7uXmrqBRMWSL1S4Qf3hgrLCuUnz1cYgQCzkfIIUXSg==
X-Google-Smtp-Source: ABdhPJwtDWGIn9y4uZwDu0nJvWG+uG9TLnwXhaQxgiDb2wu16RgtjNOa1ODvOYd09Mye5ssRlwgTG2PqZG4KNaG6z5g=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr20172741ejb.264.1607384086382;
 Mon, 07 Dec 2020 15:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20201207225703.2033611-1-ira.weiny@intel.com> <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org>
In-Reply-To: <20201207232649.GD7338@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Dec 2020 15:34:44 -0800
Message-ID: <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 3:27 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> > +                            struct page *src_page, size_t src_off,
> > +                            size_t len)
> > +{
> > +     char *dst = kmap_local_page(dst_page);
> > +     char *src = kmap_local_page(src_page);
>
> I appreciate you've only moved these, but please add:
>
>         BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);

I imagine it's not outside the realm of possibility that some driver
on CONFIG_HIGHMEM=n is violating this assumption and getting away with
it because kmap_atomic() of contiguous pages "just works (TM)".
Shouldn't this WARN rather than BUG so that the user can report the
buggy driver and not have a dead system?
