Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5B26E60C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIQUDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIQUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:02:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7FC06121F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:42:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v23so3094423ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxLIUHpb7xnWpU+m8IJS8VPZyzTWrFzKBqPCi9w1E2E=;
        b=D+14RVM0zPR8KrtBKFfH8B2x8b6Il9d8XMhdSNjcwtF6tW3YeoUcL9+8DydvwdOiS1
         pRfORF8k6PDjOF3f514UfZ6tX2NeuVFm4MbpcBj0HjzmK+IsnCqEG6U3oqJmff17FwYu
         vRTazCWJ7A3boom0FDbmYeTOc2PDTPCHDjXAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxLIUHpb7xnWpU+m8IJS8VPZyzTWrFzKBqPCi9w1E2E=;
        b=L3vfus3YnFfrizslKpw4UzwsmGMa8V5UvIGCM2fldKRRxFblba0kPmddkEQRJOvTXH
         ZbVUEHdOW7/wDl5/tENGJ6MQWqb3XEaExocVl5Hl9eP1yC2EUUvrL1SwJQUCS/DI0eWB
         sSqOZ0HGwmXrrDiEahMhCW41814yYv6lxcohDLe+vgMKQLgMwwZS16JWW3uOzh0tDp8B
         ErvNnUolR2Svv4G29RYAS33xqOZDCGl2Th9l/ZuKynrQJXWRddItHKRI6+xYox13t5QD
         A9zRrHoZTENqfdfd5GdIv97Wj2NsExij6ToOehkg8W1lV8nfrXS4YebfBdQW5CJ+y7FV
         Z2aA==
X-Gm-Message-State: AOAM531QopowefxNziS0RKo3/W5BUkcotJAO07DMyHELUJfdNgVxUgP4
        ay2tOpwqjtUFkF6OHqauwV+YEd9AMCi0ig==
X-Google-Smtp-Source: ABdhPJxAaXgmIp43iMdVjg76JWQHSi/5mv2hUiiMZOGy5zyiIrgUqTJ2lcd3fY+AhiCptPtuCWSBUA==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr10334003ljj.289.1600371749389;
        Thu, 17 Sep 2020 12:42:29 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w7sm98225lfr.158.2020.09.17.12.42.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 12:42:28 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s205so3059505lja.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:42:27 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr10057301ljc.371.1600371747357;
 Thu, 17 Sep 2020 12:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200915191346.GD2949@xz-x1> <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1> <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com> <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1> <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1> <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
In-Reply-To: <20200917190332.GB133226@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 12:42:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
Message-ID: <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
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

On Thu, Sep 17, 2020 at 12:03 PM Peter Xu <peterx@redhat.com> wrote:
>
> The fork() should be slightly slower though, since we'll need to copy the data
> for all the DMA buffers for each of the child processes, even if we should be
> pretty sure those processes won't use these pages at all.

I think that as long as we only trigger for pinned pages then that's
fine - and in fact I think we might want to add a WARN_ON_ONCE() or
something to it if we are sure enough about that page pinning.

Because the whole "do page pinning without MADV_DONTFORK and then fork
the area" is I feel a very very invalid load. It sure as hell isn't
something we should care about performance for, and in fact it is
something we should very well warn for exactly to let people know
"this process is doing bad things".

My main worry is that page_maybe_dma_pinned() not being exact. I'm not
entirely convinced whether it really is extremely rare or not.

I could well imagine some very fork-happy load having very elevated
page counts (exactly *because* it is fork-happy), and then the
performance thing might in fact be an issue.

That said, you really have to be *very* fork-happy for this to
trigger, with GUP_PIN_COUNTING_BIAS being 1024. Those kinds of
fork-happy loads very much used to exist, but I think anybody who
cares about performance will have long long since switched to
threading, not forking.

Do people fork a thousand children? Sure. Is it something we need to
worry about a lot? I don't know. I'm thinking ot the android zygote
disaster..

Is there possibly somethign else we can filter on than just
GUP_PIN_COUNTING_BIAS? Because it could be as simple as just marking
the vma itself and saying "this vma has had a page pinning event done
on it".

Because if we only start copying the page *iff* the vma is marked by
that "this vma had page pinning" _and_ the page count is bigger than
GUP_PIN_COUNTING_BIAS, than I think we can rest pretty easily knowing
that we aren't going to hit some regular old-fashioned UNIX server
cases with a lot of forks..

                       Linus
