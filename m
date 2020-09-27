Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0427A24B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgI0SQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgI0SQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 14:16:56 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69BBC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 11:16:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so8520736lfj.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=797OM3T7rQIjzBdDITGh5Pq4vHALZju8suVPvtIgEOY=;
        b=eVuX7Xaef7re4SeKM4iOgRTBQBkOaTHR2bT2XyBBKlQqaSenhTQ+Y6rW5rya3V9/M9
         yPTNt744J1/Z4dQGIkSYhBpafc3alaMGNmJL5Ci94CEyPoD3xJ9LaIYl7Y4PZpDcG4UJ
         pD8/gkQwEAwJJvIQbcIq39e8W4mziVUDX+RIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=797OM3T7rQIjzBdDITGh5Pq4vHALZju8suVPvtIgEOY=;
        b=Dr/g71IBOoO2erOOFQn/HFyuSnpQ0sJxRQ/WXDh20PZhvQszL/VVQbdOXwdmrQqvwi
         3hW3ZfJNZ30Uw1NTQtmauKqEMLoCOL03pKgCXSCw8x59Jk7n3HF26c+sl72UBpsIZZl4
         pUHH4Wj/zDEZvV2bzC4yvNMpQnOmiYTF53tBfC/lRodjEDqxwaMOXW7XnAfAUclC/6fk
         vQAcAWp1BPGKu1PRWnL01MxLx60fNeL4oPZwj7CW6J44A7ce0vPNPb/7oj8CJYL26Fcm
         kUsHPQLPgLl/41siX0X0kRVL4lhB2yWVsOhVC+Qg2blSFWulip7FSHdTQVtc5j3N3rAp
         abfQ==
X-Gm-Message-State: AOAM531C2V3fZjIEIQ/DWH78e94BpKR/+P/zD5vuj6rTYjLPpdTftRee
        NtlKthqsLcMQZkwlpIcE8bAQD0eWbS6u6w==
X-Google-Smtp-Source: ABdhPJzCA8J7LmL0AEle+wemQHckvgtiM0fEkE9q+V3LjJeWl1NLkZ/7ntE8DQbikprtweieg+D/VQ==
X-Received: by 2002:ac2:4648:: with SMTP id s8mr2604524lfo.280.1601230613843;
        Sun, 27 Sep 2020 11:16:53 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q22sm2584590lfp.40.2020.09.27.11.16.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 11:16:51 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id u4so6465064ljd.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 11:16:50 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr3745551ljp.314.1601230610424;
 Sun, 27 Sep 2020 11:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200924175531.GH79898@xz-x1> <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1> <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1> <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca> <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com> <20200927062337.GE2280698@unreal>
In-Reply-To: <20200927062337.GE2280698@unreal>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Sep 2020 11:16:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
Message-ID: <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
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

On Sat, Sep 26, 2020 at 11:24 PM Leon Romanovsky <leonro@nvidia.com> wrote:
>
> We won't be able to test the series till Tuesday due to religious holidays.

That's fine. I've merged the series up, and it will be in rc7 later
today, and with an rc8 next week we'll have two weeks to find any
issues.

I did edit Peter's patch 3/4 quite a bit:

 - remove the pte_mkyoung(), because there's no _access_ at fork()
time (so it's very different in that respect to the fault case)

 - added the lru_cache_add_inactive_or_unevictable() call that I think
is needed and Peter's patch was missing

 - split up the "copy page" into its own function kind of like I had
done for my minimal patch

 - changed the comments around a bit (mostly due to that split-up
changing some of the flow)

but it should be otherwise the same and I think Peter will still
recognize it as his patch (and I left it with his authorship and
sign-off).

Anyway, it's merged locally in my tree, I'll do some local testing
(and I have a few other pull requests), but I'll push out the end
result soonish assuming nothing shows up (and considering that I don't
have any pinning loads, I seriously doubt it will, since I won't see
any of the interesting cases).

So if we can get the actual rdma cases tested early next week, we'll
be in good shape, I think.

Btw, I'm not convinced about the whole "turn the pte read-only and
then back". If the fork races with another thread doing a pinning
fast-GUP on another CPU, there are memory ordering issues etc too.
That's not necessarily visible on x86 (the "turn read-only being a
locked op will force serialization), but it all looks dodgy as heck.

I'm also not convinced we really want to support that kind of insane
racy load, but whatever. I left the code in place, but it's something
where we might want to rethink things.

              Linus
