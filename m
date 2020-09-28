Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21527B1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1QRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgI1QRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:17:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAEDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:17:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so1999076lfj.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5eBmJYMQxsPiYEHTP+N8WE8e6PJy08LxGgxCCqvCfE=;
        b=euu6Fg5dxp3F/Hmc0ddCIZLWIH1whfjy65nYv8nVV1rquMCIwXYMajlID9wTtFxHK8
         Cbo31Xb/E1jD+y+fwC/r6bEh2Pcqn3AUPrCoY7pk9cqeYknrMe9RPns+LXDkxVQyg9vE
         0YpqeOnguRpHbqeC+u2A5oifieeXZWi4iQqs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5eBmJYMQxsPiYEHTP+N8WE8e6PJy08LxGgxCCqvCfE=;
        b=ptQxol5I6L1hQpMYDfRd57aTlA+MRp6Sg9Cu9hnG/mdGRhrN8+gB+/iGQdzq3W33Ng
         eQIdiFpkGmVCjQUsXheeGmqGRJ6MfhnmHdYtbUJzR+4bQsnpRvrIrPOOWEGKUm9OlDzJ
         S6m94Z//PUKtfJksPfy29DyvncsSwjr4PR962vJ3yxpDXyCzYX0IMQV2/4ergr8Ab/QJ
         icQiHf5wpxO9D8iXNercv74w+UEcoV+UtMRYC4mETxWwMbBn9kKUVPj2xlcnEwfjLwls
         RddHnGD9xThFJFAhE+/z3UEf9a2Lkypb7T/ub0VvGlh/ERFXXjhKs9g86rpD/BY9HrXT
         9G+A==
X-Gm-Message-State: AOAM533IwyIv3tTuwCZ8S06w/HwtrVZztCRpzsBnv1DIsWZ1tULwKAEf
        4DZlUbIDljAlyAbgIqsgETZG/WBR1U7IpQ==
X-Google-Smtp-Source: ABdhPJxOCnnOVytUd9bHI6K2fa//uw941IUthaxL6qn02VgrEWPYsPiursBky4HEbUEbMAXxNV3wgQ==
X-Received: by 2002:ac2:538c:: with SMTP id g12mr689581lfh.326.1601309848278;
        Mon, 28 Sep 2020 09:17:28 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x12sm130607ljd.130.2020.09.28.09.17.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 09:17:26 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 77so1998924lfj.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:17:26 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr687690lfa.148.1601309846019;
 Mon, 28 Sep 2020 09:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200924183953.GG9916@ziepe.ca> <20200924213010.GL79898@xz-x1>
 <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca> <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal> <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com> <20200928124937.GN9916@ziepe.ca>
In-Reply-To: <20200928124937.GN9916@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Sep 2020 09:17:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
Message-ID: <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@nvidia.com>, Peter Xu <peterx@redhat.com>,
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

On Mon, Sep 28, 2020 at 5:49 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Not seeing an obvious option besides adding a smp_mb() before
> page_maybe_dma_pinned() as Peter once suggested.

That is going to be prohibitively expensive - needing it for each pte
whether it's pinned or not.

I really think the better option is a "don't do that then". This has
_never_ worked before either except by pure luck.

I also doubt anybody does it. forking with threads is a bad idea to
begin with. Doing so while pinning pages even more so.

               Linus
