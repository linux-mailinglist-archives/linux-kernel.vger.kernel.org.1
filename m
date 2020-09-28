Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9839927B58D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgI1Tm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgI1Tm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:42:27 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:42:26 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so3077278edk.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkMJ9vgT72YsSMnKCcPYU1IIxIP9bXClnVqgMshREjw=;
        b=W4DgUE7iQ15VMtJKxlGaWgeXDPLdMBzay4aRO5K22JIpWg4LUrshY7AhiCK83/HxRr
         iv7IIBGBbCzs7J4C7D70277ARK/Tuz/MkxOsngSzwOD1/6iLfOBrHNX2r0CvjKZbSAAZ
         rb6irsX1QD/b9RVofDrB/GIxk+JxPez+1Wxkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkMJ9vgT72YsSMnKCcPYU1IIxIP9bXClnVqgMshREjw=;
        b=qFAJGzAj2PnENpVn5+0+d0lrUSpDkq/AAmJe8OLeE0gkkWW1N7x0BSjXU1LgxhwmAm
         zwXnkgMfx0pI0lsPxV9LoSj0M4qaJxw86zMNcJSbrP62yILSMIJZGWWgLygFsHetbSvl
         5NtSkZdNlOmuJm6M7VXhTCQhtM/rRMQk33MfdOkm9hDe9BzBmp/67yglvIdbh3S7f9gO
         nMIWc77hU9BgZdQwfZn5FBGcbi6au75ox1cgpVO9O94814qmIPgon6wNP3T2DQkv71a9
         P9IgXmrnvDu+RYhZ/K21P9kaU4qqbVUhtowCYQulO5VHbcRcqYT6dyCDRq671yn/42lq
         tSnw==
X-Gm-Message-State: AOAM533VHxJVqYbI8pyna4019tCp+045EUHE2A3VSZzH/H5L4oADSVzT
        8GZeXUmMgVLICnSApOKeUVVEOjgrK+XlAA==
X-Google-Smtp-Source: ABdhPJysN5Z6NA1r7LDNrVs5MXMSc8OOFWoCC0AwklAsurHL2s00XejwDJOgE2r44uvVTUEmA0M1MQ==
X-Received: by 2002:a50:ab59:: with SMTP id t25mr3437373edc.364.1601322145416;
        Mon, 28 Sep 2020 12:42:25 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id ef3sm2314155ejb.114.2020.09.28.12.42.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 12:42:25 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id gx22so10616580ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:42:25 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr43230ljp.314.1601321800700;
 Mon, 28 Sep 2020 12:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200926004136.GJ9916@ziepe.ca> <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal> <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca> <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1> <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
 <20200928183928.GR9916@ziepe.ca>
In-Reply-To: <20200928183928.GR9916@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Sep 2020 12:36:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgu+6Cx_=U1Vh4Fzm97JA1k76fS905uEAVK-2eJ_1KukQ@mail.gmail.com>
Message-ID: <CAHk-=wgu+6Cx_=U1Vh4Fzm97JA1k76fS905uEAVK-2eJ_1KukQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> All of gup_fast and copy_mm could be wrappered in a seq count so that
> gup_fast always goes to the slow path if fork is concurrent.
>
> That doesn't sound too expensive and avoids all the problems you
> pointed with the WP scheme.

Ok, I'll start by just removing the "write protect early trick". It
really doesn't work reliably anyway due to memory ordering, and while
I think the dirty bit is ok (and we could probably also set it
unconditionally to make _sure_ it's not dropped like Peter says) it
just makes me convinced it's the wrong approach.

Fixing it at a per-pte level is too expensive, and yeah, if we really
really care about the fork consistency, the sequence count approach
should be much simpler and more obvious.

So I'll do the pte wrprotect/restore removal. Anybody willing to do
and test the sequence count approach?

            Linus
