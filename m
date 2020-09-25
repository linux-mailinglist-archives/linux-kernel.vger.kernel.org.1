Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F545278F79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgIYRSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIYRSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:18:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FEBC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:18:01 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so3657977lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+ANB8ObSSZ0LIy221HtUSCjieyuyM53ewN5x3+3DVE=;
        b=ViM6tNtjnjXKy+aig7vGCrWABYQxrnX2HtkZcN4CBEWw59xq/lePN1F/rj4bBZKD9U
         Ciyu/pPnZh+e6dHKrJngZsreQbcFBMQz0XY6cDFZ6Hru4Bqj/AL8F4fhKruS2mt+CqNQ
         pTRiIMYwAshLcNOYleRDc/4QZ26uCT/Hm942Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+ANB8ObSSZ0LIy221HtUSCjieyuyM53ewN5x3+3DVE=;
        b=lohgFH21Nc/fF21VihFkVffremXsBr46VTRkimiScFGfdUqVsHxHTPu8mp9CKxyqib
         KaHe605H/ErcGfSqlQ7lpn1O8xgFTiB4Xp3+bWRkL2XjHBWJ24qXydQxIcmWXYIk9/c1
         p8LdjckRhyQmw2GuLz3x5oQ+P14HCWyGICTav/7l8PzJrnZAoLGsZcnrvvN1LgeSldYD
         4SzXDI8fcQvvKgfqFx0Lx2OU/6rxirhbIxhk7qbvjYLrH6V98OqNGYFNlSA8IH3nRYyk
         4eGZLAEjuMCYTFq4MiZfxwaRX7f8Ig2tOJJuNjRX3+FIXP4Ki2VscQ1XEVBQp1/bLI+U
         oJNg==
X-Gm-Message-State: AOAM531sxGY0GzHv8SSwHwmkI7+leJ1IomT/V5AvR5Ia8wqF3KOkUmao
        GjiUhP6GLhwaHjmvDx9kb9NaO1EWyfYR5w==
X-Google-Smtp-Source: ABdhPJwnma7RIhduCht89lfhRxacLboqCBB8+mkK2rhki5MWAwQNHjFbbo2X6XTb63uMJ/BQWDGdtQ==
X-Received: by 2002:a19:418b:: with SMTP id o133mr1852389lfa.413.1601054278573;
        Fri, 25 Sep 2020 10:17:58 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u24sm2751406lfo.117.2020.09.25.10.17.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:17:53 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x69so3657585lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:17:52 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1832306lfg.344.1601054272350;
 Fri, 25 Sep 2020 10:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200915073303.GA754106@T590> <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590> <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590> <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590> <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu> <20200925073145.GC2388140@T590> <20200925161918.GD2388140@T590>
In-Reply-To: <20200925161918.GD2388140@T590>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 10:17:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
Message-ID: <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> git bisect shows the first bad commit:
>
>         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
>                 kmem_caches for all allocations
>
> And I have double checked that the above commit is really the first bad
> commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> is LIST_POISON1 (dead000000000100)',

Thet commit doesn't revert cleanly, but I think that's purely because
we'd also need to revert

  849504809f86 ("mm: memcg/slab: remove unused argument by charge_slab_page()")
  74d555bed5d0 ("mm: slab: rename (un)charge_slab_page() to
(un)account_slab_page()")

too.

Can you verify that a

    git revert 74d555bed5d0 849504809f86 10befea91b61

on top of current -git makes things work for you again?

I'm going to do an rc8 this release simply because we have another VM
issue that I hope to get fixed - but there we know what the problem
and the fix _is_, it just needs some care.

So if Roman (or somebody else) can see what's wrong and we can fix
this quickly, we don't need to go down the revert path, but ..

                  Linus
