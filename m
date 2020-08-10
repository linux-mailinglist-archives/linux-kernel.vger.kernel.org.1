Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29272413AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHJXT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 19:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHJXT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:19:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:19:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so11424719ljn.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ah+VgQKs3kGLd4LAiDMSL98AvAsoBiO7tyrewnreXwk=;
        b=esYya08x10kt09r0pEU6JYyN4Jrr4Dl28/5LaoSkW4HUwhcTM5CJAEWFZupbTAmaQ1
         ZZKmXj+7iSZT6wXP76iylAVzzkhrCCKw/iBUjX/3mPKvlEBsz5hnZTCSvWHXVl0iscb1
         aKLPgRFTDyRDP9spyUQc4L/EJcBVTMGXgMItM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ah+VgQKs3kGLd4LAiDMSL98AvAsoBiO7tyrewnreXwk=;
        b=q5krASVIxyigDs7kqYzGhNEamC5TFskhzzJawJzrJldA47hGaNveO6egiWKK79Vu+T
         jVRvzAHq+Wg4FOVPeUinkFRJoP8EV3OwA+k06Bwhw7yo5HeEzO/P9cW9ZSriSNYHp33V
         5owWcGQV/BEw4wT5qbHnW/6Fa9+/KN4MqeZ7Vbi4b8hVi0I50NQJzyte3YMKO9v5KvQa
         6mmGOoWXmCK8Iaw30N+079Rwwd3c3FxIw7gelMq2cE9jMNQil8LJIQsFgJFDf1Z+apPl
         7IXesAdvnOhhPT0RAQ+hLOoFQldwg6R/ukpSn5+SAVfo79cmA/KVFci90jAm8DyJk9OY
         Q6cw==
X-Gm-Message-State: AOAM531B3fuuRpk2/nCJPJ5Lhjni/5YXSLtE09ds9L5PRPHcq12itPDp
        vJrCfM8/rULrzrp5VwLPlogtdBacEI8=
X-Google-Smtp-Source: ABdhPJyUyKL8cu+EArN3jistdWoRnOIxjSXO1Pqh94r6R7jkkc6Dusw7U0u4ENEfXeThJpvaMb0XeA==
X-Received: by 2002:a2e:b306:: with SMTP id o6mr1458000lja.361.1597101566517;
        Mon, 10 Aug 2020 16:19:26 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id r11sm9672263lji.104.2020.08.10.16.19.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 16:19:24 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id w14so11467423ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:19:24 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr1446926ljk.421.1597101563687;
 Mon, 10 Aug 2020 16:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200810145701.129228-1-peterx@redhat.com> <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
 <20200810191520.GA132381@xz-x1> <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
 <20200810215734.GB132381@xz-x1>
In-Reply-To: <20200810215734.GB132381@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Aug 2020 16:19:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whng9zK-GMM+UHsTptF=mgH164Zt_Gok3ohbcWaYee71Q@mail.gmail.com>
Message-ID: <CAHk-=whng9zK-GMM+UHsTptF=mgH164Zt_Gok3ohbcWaYee71Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 2:57 PM Peter Xu <peterx@redhat.com> wrote:
>
> Yeah, that's why I totally agree we need to do enforced COW even for a read gup
> as long as the page can be further referenced (GET|PIN).  However frankly
> speaking I didn't follow the rest on what's wrong with "Userfaultfd-wp should
> not care about this because it's not a write operation" that I mentiond.  Is
> that the major part of the objection?

You didn't _explain_ why it's ok.

You said "it's only reading".

And I told you why "only reading" is not an argument against COW.

So my objection is that you haven't actually explained why it's ok for
userfaultfd-wp.

I can easily believe that it is, but my whole point is that this is
subtle, and it needs documentation and explanation.

That's also why I think the bit should be the other way: the people
who need to explain are the ones that disable COW, and the reversed
bit would mark that case.

The people who are ok with COW don't need to explain anything, and for
the same reason I think they shouldn't need to add that
FAULT_FLAG_BREAK_COW.

See what my argument is? It's entirely about documenting the special case.

               Linus
