Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF00C2EF788
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbhAHSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbhAHSjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:39:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91CC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:38:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s26so25176738lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICXv7r9tS6OnWdFplsRRr1nw62sR7HCP2UfTw3I7zBA=;
        b=dj/GGvKX+wRhXGlTXy+NoQVbe9htPaa32IMewc/zw2qddtEmoc+ptGXxaxA4nADn10
         4958RF03MOEVqneSyMQcauJTehztktCIWwuw2XG26sQYjPOVT0Y14YmuED9xIx3vvIty
         FFlQQqbhp2rFxeTzU14Rb155846i72ENdlln4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICXv7r9tS6OnWdFplsRRr1nw62sR7HCP2UfTw3I7zBA=;
        b=SLhDmizzz2J/WErUZFrfaAaeFsoyhvX7VG9CvQwnGfoRmAHPSI5us/CSpc7WdTdCTB
         jDg8cPExBj06Wiek9Zci/jhCPxy4OPhzMd6AIp/YHI8lXUk81OfuVOatv44NDmR0JtrM
         BNMt7Q8d5iQSwNOW36mbQjjQ5/VBetP1732B0nIQuwQIRNer0r9NVaDfOzJGHkoL8+P2
         ToB/1MUAn6cyBr166IMyawIgBRWN206Ct23rFA8MpUWZBGXB8nPeLrBZS8CaNx6bgYcT
         Spwq7/fQNu+Eqrv5jr0fpFvGdSey7khKGrBOnfYvfSePaviWmU6QLaPfmCA+hOqWsRnb
         Nwaw==
X-Gm-Message-State: AOAM532MF0bSeguqz+7yX9g4pnQEyfiVIqCB3W4DGGau9fv/eBcUUw0S
        GGJhiVGCCB3mfVq5SC+VotVW7mYH7mVrVA==
X-Google-Smtp-Source: ABdhPJynchDVRBJ2MGXha1sjPqk+OsiyaF0ZQe1GJuzs+hJjmHTVPfgFKvEwi/BU5Pf0eMLfKbKEqQ==
X-Received: by 2002:a05:651c:211d:: with SMTP id a29mr2117228ljq.487.1610131107236;
        Fri, 08 Jan 2021 10:38:27 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id k8sm2106959lfk.187.2021.01.08.10.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 10:38:26 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id m25so25100345lfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:38:26 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr2009336lfg.40.1610131106007;
 Fri, 08 Jan 2021 10:38:26 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com> <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com> <20210108181945.GF504133@ziepe.ca> <CALCETrVWGZ5MkN6S+o_h5isOHKVpjwSz-jyXSsp9VJjVOYOyyg@mail.gmail.com>
In-Reply-To: <CALCETrVWGZ5MkN6S+o_h5isOHKVpjwSz-jyXSsp9VJjVOYOyyg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 10:38:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaYFkHogsOohx6WPY+kC1061OtiPL1qv=1w-ovKiSpcQ@mail.gmail.com>
Message-ID: <CAHk-=wiaYFkHogsOohx6WPY+kC1061OtiPL1qv=1w-ovKiSpcQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 10:31 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Can we just remove vmsplice() support?  We could make it do a normal
> copy, thereby getting rid of a fair amount of nastiness and potential
> attacks.  Even ignoring issues relating to the length of time that the
> vmsplice reference is alive, we also have whatever problems could be
> caused by a malicious or misguided user vmsplice()ing some memory and
> then modifying it.

Well, that "misguided user" is kind of the point, originally. That's
what zero-copying is all about.

But we could certainly remove it in favor of copying, because
zero-copy has seldom really been a huge advantage in practice outside
of benchmarks.

That said, I continue to not buy into Andrea's argument that
page_count() is wrong.

Instead, the argument is:

 (1) COW can never happen "too much": the definition of a private
mapping is that you have your own copy of the data.

 (2) the one counter case I feel is valid is page pinning when used
for a special "pseudo-shared memory" thing and that's basically what
FOLL_GUP does.

So _regardless_ of any vmsplice issues, I actually think that those
two basic rules should be our guiding principle.

And the corollary to (2) is that COW must absolutely NEVER re-use too
little. And that _was_ the bug with vmsplice, in that it allowed
re-use that it shouldn't have.

           Linus
