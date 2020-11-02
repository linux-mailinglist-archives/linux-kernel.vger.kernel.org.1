Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D042A36C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKBWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgKBWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:45:13 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA7C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 14:45:13 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id a71so10653518edf.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHmrWcB28t+p1qKGTaL2HwJFTWqvAXTmNpjEsdlRDSE=;
        b=gGhY1uNSf4FP1azS+0gtexs5ubkXNa6Y+X7/tw2Rv6kI7Jb4bqOpZSey7J8MCytmWU
         Dzx3AACL1k96LPYIlaBioCuTT67IXwmj9ctOIIngGob1aBPlGWw4qfHho8eVCygiy7NI
         QTwEz2+eUWEYh8NsUyFUf0cKZQzyyiQI0IaLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHmrWcB28t+p1qKGTaL2HwJFTWqvAXTmNpjEsdlRDSE=;
        b=qImAlT+0cNoeapNKhiNmKCqTuF+kkTsoiCjtOM+8DCMfkv7qt6fhdryP1i7sRijx0L
         UC08sf5dM/LGKXsgXoX06VOzmr/W9Io67uvRHJR/AEbP/wr/04u2pLb8uowU/hSn1WZ1
         QX7wsE4g5pqc12do9QASgVL61F93DQEf9FADglDXzSnoOYa3i3CbrCv9q3KkOgPvlIDC
         LGNOUp4gltaatqEaI3k/cglo3GiVihOZDnBYskBrxe3rhDuDy5by/6WT70LULiorAu3R
         zaBMxhOW75vT45KyvlfSK0P94ZiCX12dTNBOdPY2QD6uTIXLRJIKqpHRVJIhlMLL6G88
         NbkQ==
X-Gm-Message-State: AOAM53066JzBPOpAlOOia+idKr1P+Pb7a0v+BgBLgdampSR/t5NRjTCz
        zg9jA+V6rtjHxMpKneIHQXAv5fsVwLCdbg==
X-Google-Smtp-Source: ABdhPJxrp3nAhnFifvX6QZIkQJth+ZpIUXgwydDs55NlFTNtSf6BXM0cVvfaW1E/oKnO62kyn8fZxA==
X-Received: by 2002:a50:fb18:: with SMTP id d24mr19400960edq.43.1604357111263;
        Mon, 02 Nov 2020 14:45:11 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id mc2sm3886316ejb.1.2020.11.02.14.45.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 14:45:11 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id a71so10653442edf.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 14:45:10 -0800 (PST)
X-Received: by 2002:ac2:52ad:: with SMTP id r13mr6025281lfm.534.1604356805454;
 Mon, 02 Nov 2020 14:40:05 -0800 (PST)
MIME-Version: 1.0
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com> <20201102221945.GA48454@lx-t490>
In-Reply-To: <20201102221945.GA48454@lx-t490>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Nov 2020 14:39:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2jtBhfgpxCkgXcyOPn3YFFWeJ-vHsppocBjdFQ2F6Og@mail.gmail.com>
Message-ID: <CAHk-=wj2jtBhfgpxCkgXcyOPn3YFFWeJ-vHsppocBjdFQ2F6Og@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a seqcount between gup_fast and copy_page_range()
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 2:19 PM Ahmed S. Darwish <a.darwish@linutronix.de> wrote:
>
> Disabling preemption for seqcount_t write-side critical sections was
> never a new requirement. It has always been this way, for the reasons
> explained at Documentation/locking/seqlock.rst, "Introduction" section.

Note that that is only true if you spin on the reading side (either of
the two kinds of spinning: (a) spinning to wait for it to become even,
or (b) repeating if they don't match)

Which this code doesn't do, it just fails.

I'm not sure how to perhaps document that.

             Linus
