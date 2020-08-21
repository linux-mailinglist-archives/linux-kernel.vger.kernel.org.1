Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D353924E0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgHUTnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:43:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FDAC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:43:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v12so3094594ljc.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqmMf8s/qw8dVmkIjWEKz4hGdQy13QWnrbeE3wlgAlU=;
        b=C6jruGU7XbdTD/cONqgTWdl5nfkxg4Siv9fW8Uhgr4NO+SmRJdhu7HWZRPm54zt2o+
         20HDheaQPalvgiMB4KRYdPqOBxh9avoWJdfixq4xwgGGimMuq/eA02dHooa9DKd3Ych8
         0M8zvhKhXJ6rBuzgU0YlRzYErgGqfBWqu+dEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqmMf8s/qw8dVmkIjWEKz4hGdQy13QWnrbeE3wlgAlU=;
        b=XUyzZURJwW/7GzACjH+mojlHL2/BFYI4qLEZNq42Zc9ZbTQ2t56SJRGSgS/+mXSavT
         XvJ3NGK27OjXs3IUqNWvxI/Q2YhKHawr9OgeGUEVEtMCSKlcJV3pwg12NmHbfRf4pmgI
         51gyotp/sqjJ6NYyjdk3fDVnj+feV2tQH/T0x5bJQCU4T3ucjqPG8/Aq22xLakqg+e1S
         M47pnncH+gnvgLr0XVBSAYA0s1sQyjxzCP6gfBjEeVumggvY3TgXTetaeOBB2SAX+RRo
         fA26gKdB4w+PoHzAfWznL2gKxwCQOsVyTvsD6798++yV4X9wX89GXa8lgtWWIf/xwZ3E
         3kCQ==
X-Gm-Message-State: AOAM533XQ87Cg6N425y962iwo31fnNqs2ajuU2l+phWgHjFqLakzEDkQ
        42jsjc3l6svoREv6CqzLNXcoy/Sh2HwEgA==
X-Google-Smtp-Source: ABdhPJzDJxDOQbCcLBFhJEb1ex4QTI3Xp6lIp0PjiwuHwSB7K8lBHQu4Ul9oBT7jc4ruxJe6IuKvnA==
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr2025312ljf.58.1598038993822;
        Fri, 21 Aug 2020 12:43:13 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id o23sm567193lfr.67.2020.08.21.12.43.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 12:43:13 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id j15so1469790lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:43:12 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr2080928lfo.31.1598038992293;
 Fri, 21 Aug 2020 12:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200811214255.GE6353@xz-x1> <CAHk-=wiVN-+P1vOCSMyfGwYQD3hF7A18OJyXgpiMwGDfMaU+8w@mail.gmail.com>
 <20200820215449.GB358043@xz-x1> <CAHk-=wjGzOjsfmX1Dc=yz6o_+62w4wcTVXX_hia9sHLfsCoxjg@mail.gmail.com>
 <20200821101333.GA3432@quack2.suse.cz> <CAHk-=whXfL5DtinS42dgtNu6i+xchK_VP+XLprQbu_og2J5Dkw@mail.gmail.com>
 <20200821154756.GC3432@quack2.suse.cz> <CAHk-=wj-pfzKf3JDe9fr4o_nKYXJXfuYAMFCajwhy0YYYri4Fw@mail.gmail.com>
 <20200821180848.GA11376@xz-x1> <CAHk-=wj3fY2dch7Ah-MLbJcfU3buoXgJnwc1zWFSjVujSd39GA@mail.gmail.com>
 <20200821193100.GA38249@xz-x1>
In-Reply-To: <20200821193100.GA38249@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 12:42:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0syDtNzt9jGyHRV0r1pVX5gkdJWdenwmvy=dq0AL5mA@mail.gmail.com>
Message-ID: <CAHk-=wh0syDtNzt9jGyHRV0r1pVX5gkdJWdenwmvy=dq0AL5mA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:31 PM Peter Xu <peterx@redhat.com> wrote:
>
> However, do we really want to revert the whole logic of
> 52d1e606ee73?  Asking because it still seems to be an improvement to me (after
> all we'll need to look after KSM pages here).  So it seems still good to keep.

Does anybody have numbers for it?

I'd rather simplify and get rid of the locking that has been
problematic, and then re-introduce limited cases with actual numbers.

Right now that commit has no real argument for it except for "do what
we do for swap cache". And since we're getting rid of the swap cache
special case, I'd say that commit 52d1e606ee73 argues for getting rid
of the KSM special case too.

Honestly, I'd expect that if KSM is effective, it's for pages that
really *are* shared. If you get a lot of "write fault on the last
copy" and that ends up being a problem, I think that says more about
the KSM issue than it says about the write fault..

               Linus
