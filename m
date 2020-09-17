Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9C26E5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgIQT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgIQT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:57:59 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494DC0611C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:52:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z19so3529986lfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32bcgpldYXbmLkD9PAPTV/r5I9yvArjUAJrUez/8fCw=;
        b=VOlzEfJuZB9Z+OwJNOchIJXDkd0bTa9i+wPMaYSxT6D0dAH/K7Ga73jt3/YtjGTVK4
         sVlY9P9deW7WIX2Nd152ey3/qPcCEHpblJw+UwDlDNRH2yhqCE0SHAuB/jZEQ2s1KDp6
         q34MhREhlKcWU3KC+0AmTV4BHtmSJ7oVUjShk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32bcgpldYXbmLkD9PAPTV/r5I9yvArjUAJrUez/8fCw=;
        b=bcqsVUDeucNcg4i4g/M3cVB1Q0V2Fwj8nTgi2Fi0APLbrWJ7Ru50ys99kJh1aolKOW
         Qt8UX79acUNP4mmtemIl+Xde0qJQMj2Ks5XE4sY+gYNa66Xhdhlc1Mc3nEWtq9uV42Y8
         cQ/rItdlEqT+OOk8zKGc5mO440xuen3QmqksOQdHRNobEwoosi/UR/QykGXW+q4gbX5r
         xopXGvXjS19ds9+seAjjmw3U7Rr3p/tRPRf0Ya6RX5OtUwMyWi00dHMZbDvfgGGcrU43
         59YwcpesMHNdawXaRw5c30vu42vAegAFlxXJ4ZHzQ/pea/WfQTZtw4Uf/b6J6+GnDCBI
         09BA==
X-Gm-Message-State: AOAM533uqLYBPitmQBiJRWgNWBzFHZEvCSsGvXY41IX8hX/pUgqPuvg3
        r5qGFJCQ7QsvR675VJjOkFIdeb9zp6ttyg==
X-Google-Smtp-Source: ABdhPJwzNTnS8fum/nyuSmL1+gfqzodnpyq4+OQHsUKu7BrcuPEp4bykjqj4s46kq2G/sWg1OMeJtg==
X-Received: by 2002:a19:4284:: with SMTP id p126mr9217957lfa.393.1600372327219;
        Thu, 17 Sep 2020 12:52:07 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f2sm105525lfd.103.2020.09.17.12.52.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 12:52:06 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y11so3521817lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:52:06 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr9365158lfa.148.1600372325687;
 Thu, 17 Sep 2020 12:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200915182933.GM1221970@ziepe.ca> <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca> <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca> <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca> <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca> <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
In-Reply-To: <20200917193824.GL8409@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 12:51:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
Message-ID: <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
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

On Thu, Sep 17, 2020 at 12:38 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Looking for awhile, this now looks reasonable and
> doable. page_maybe_dma_pinned() was created for exactly this kind of
> case.
>
> I've attached a dumb sketch for the pte level (surely wrong! I have
> never looked at this part of the mm before!) at the end of this
> message.

This looks conceptually fine to me.

But as mentioned, I think I'd be even happier if we added a "thsi vma
has seen a page pin event" flag to the vma flags, and didn't rely
_just_ on the page_maybe_dma_pinned() check, which migth be triggered
by those fork-happy loads.

Side note: I wonder if that COW mapping check could be entirely within
that vm_normal_page() path.

Because how could a non-normal page be a COW page and not already
write-protected?

But that's a separate issue, it's just how your patch makes that odd
case more obvious.

            Linus
