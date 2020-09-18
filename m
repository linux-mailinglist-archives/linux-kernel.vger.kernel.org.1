Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875F82707C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgIRVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:07:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447AEC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:07:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y17so7567146lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxtbCThgxVa45d8lwoZdOST6U19+8PapeOdnxsf30mE=;
        b=Aeps+abbSb6m7OScrhyrKQIBoDCeK+uzMrv3p7Vi8SJ/tda0vxPKmQPaOM4yNIEufz
         8DkpaRbmCzpsE1w2i3cUoaPaMb/XdqKl6aUzuP4YN1olvJC/m4GdtmBzz4kr19naytiB
         dlWxRm+0+lXXCrm1ySrIDJpp+J+NIirt0APGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxtbCThgxVa45d8lwoZdOST6U19+8PapeOdnxsf30mE=;
        b=MKSpw/1HCfent1+e0SlW2lEF83fElWiPIQidVnFoaUlRbkKkJq1hl3334dF3rd7fNy
         x5bL1DwDCyl16AfSN+SIoQVsoFYJc3u+Q3jo6wAF4Jk6utYi5us/Uq0ybmm6vr1rwb+7
         PHDnt819vsanViwDcGT0V4FPTpi+i9FlB5Aga2b70JV/3WJS2G4g6JnwsEwDXfcbNhiz
         E7p9MCICqn2XXfMIHZI7igFh+V0WMIdyw1BaysFeuvK+RBGDqqOxOQLNE5dWXqV+bUnL
         vPi+/FmHbM466+UObUOwT7HDPbn/F5s2hnwWY0TDHW4p2aG9ZRHq3jCbne0tAhcGTxXP
         FjWQ==
X-Gm-Message-State: AOAM533qXGj3K58L7L5+c0ifSF+kRss1WFiM2DGVeXRpGEuUcaIkI/80
        X2/GdcaUEvtT8xGf+yWeww2ukYb7m9Fodg==
X-Google-Smtp-Source: ABdhPJzc9LZ2hJ9pXDtuu+5kP/LiqHodE5dKDz15ft7K8qM8X7y8RTSpNSnl68qbIAsaeQUhOqedpg==
X-Received: by 2002:a19:4c87:: with SMTP id z129mr12260630lfa.189.1600463242422;
        Fri, 18 Sep 2020 14:07:22 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 140sm819638lfj.146.2020.09.18.14.07.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 14:07:22 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id r24so6187302ljm.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 14:07:22 -0700 (PDT)
X-Received: by 2002:a19:8907:: with SMTP id l7mr11107210lfd.105.1600462797703;
 Fri, 18 Sep 2020 13:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200915232238.GO1221970@ziepe.ca> <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca> <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca> <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca> <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1> <20200918173240.GY8409@ziepe.ca> <20200918204048.GC5962@xz-x1>
In-Reply-To: <20200918204048.GC5962@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 13:59:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiF03A3X0FoE68yXWDqO19ofgXq=21kWcRAe5+uN-WHXw@mail.gmail.com>
Message-ID: <CAHk-=wiF03A3X0FoE68yXWDqO19ofgXq=21kWcRAe5+uN-WHXw@mail.gmail.com>
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

On Fri, Sep 18, 2020 at 1:41 PM Peter Xu <peterx@redhat.com> wrote:
>
> What would be the result if we simply use GFP_ATOMIC?  Would there be too many
> pages to allocate in bulk for ATOMIC?

It's very easy to run out of memory with GFP_ATOMIC, and also cause
various nasty issues with networking (ie when you've depleted atomic
memory, networking starts losing packets etc).

So yeah, this code should not use GFP_ATOMIC, I think it just needs to
drop and re-take the paeg table lock.

Which is easy enough to do: returning a zero 'entry.val' already does
that for other reasons, there's nothing magical about holding the lock
here, there's no larger page table lock requirement.

The main annoyance is that I think it means that copy_pte_range()
would also have to have a special "preallocation page" thing for this
case, so that it can drop the lock, do the allocation, and then take
the lock again and return 0 (to repeat - now with the preallocation
filled).

Honestly, if we had a completely *reliable* sign of "this page is
pinned", then I think the much nicer option would be to just say
"pinned pages will not be copied at all". Kind of an implicit
VM_DONTCOPY.

(Or we'd do the reverse, and say "pinned pages stay pinned even in the child").

But that's not an option when the pinning test is a "maybe". Oh well.

             Linus
