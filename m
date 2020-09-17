Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDDE26E360
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIQSMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIQSLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:11:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:11:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w11so3231039lfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvhYrXTQ7P1PpPJneriFY/N4fH6cu5PCNfejoxCMfjU=;
        b=ebZpe94emC58OChvJb6ZM/Lfv6J4RQjpddoqdFXFgpn5nQwns+cim1TIIPoMi913bU
         pPqAGC9UjlAo4pGFpVTz9MAzxmkQYqgUthKSwOP5an1HSaD/lIhSFVjOxv+pKuMqxBXu
         QPJtWnomu+ikDHtTtN2WJd+Q8J1NFpOyixo9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvhYrXTQ7P1PpPJneriFY/N4fH6cu5PCNfejoxCMfjU=;
        b=uIszgT36v3optH1JGlz88O4DfpYYAV56b89G+/mI7rsQFVVYaDu/ScSvBlYNSv+3D1
         lYBJeA9CFHOkhRIedzhcXDiZ7fBOCNA/t2IC8DoYRynsabXpd0bA9diuj900MfrAdBRj
         erf6foIg9CH9j5HtsB2wf3SUueJ/XacjWFbPfRh5/Kix3wZ2Ydjxw+GP8xCQX8I4zLED
         F6bXfvT682IZwoWzr2qcX6PZWIY+sItj34T1DcMm1WBqq7Pu1nUIirFlqBo2JdIL6paK
         /AcWVdkx9OnqumlqZLvv1nwMEFJ1wXIa+5p6+JJ/NeIkRZ6yH/uMfJn4oVIrLcDwYpu7
         rigw==
X-Gm-Message-State: AOAM532e0H8J122mrFa4ACwiyrAgrdib6U2TbaU4FBkNhIX6M6iZaJW1
        8ZbM9gfnognoxGsAzrfXc2eLdS/IbeYD1w==
X-Google-Smtp-Source: ABdhPJwj8c5z+ztHWsGSQ4jMp7Ca7DZxcQrXzsPyAbppU06WXiYlbr8wAEn/A0TdJO950oPiQfi/CQ==
X-Received: by 2002:a05:6512:31c4:: with SMTP id j4mr8972709lfe.323.1600366289214;
        Thu, 17 Sep 2020 11:11:29 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 73sm58009lff.125.2020.09.17.11.11.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:11:23 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id z19so3219894lfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:11:23 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr8604753lfr.352.1600366282941;
 Thu, 17 Sep 2020 11:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200915145040.GA2949@xz-x1> <20200915160553.GJ1221970@ziepe.ca>
 <20200915182933.GM1221970@ziepe.ca> <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca> <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca> <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca> <20200916184619.GB40154@xz-x1> <20200917112538.GD8409@ziepe.ca>
In-Reply-To: <20200917112538.GD8409@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 11:11:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
Message-ID: <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I botched the last version of the patch, here is something a bit
> better.

So I'd like to understand why this problem happens.

Myt argument to Hugh a few weeks ago was that page pinning should take
care of all this:

 (a) if the pinner is going to change the page, it will have to get
the pin with FOLL_WRITE in addition to FOLL_PIN

 (b) that means it will do the COW and mark the page writable and dirty

 (c) the whole _point_ of the FOLL_PIN is that subsequent operations
shouldn't make it non-writable any more (ie it can't be unmapped, and
we should synchronize on fork etc)

So I get the strong feeling that this whole approach to "fix" COW is
really papering over the real problem.

To me, the whole point of pinning is to avoid issues like this. If it
didn't fix this issue, then why did we go to all the effort of
treating pinned pages differently?

Your patch may avoid the problem, but I think it implies things are
horribly horribly broken in pinning land.

I also note that the _only_ user of page_maybe_dma_pinned() right now
is a debug check in gup_benchmark. I think your patch may _work_, and
I think that thanks to page_maybe_dma_pinned() it might even avoid the
horrible case, but I feel we should just truly fix pinning to be
meaningful instead.

IOW, in addition to keeping the page mapped, it should keep the page writable.

Why isn't it?

                     Linus
