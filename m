Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D838D2A6D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbgKDSqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKDSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:46:51 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FCC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:46:50 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id gn41so13953973ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJ0JSJD7YhQrtyyxZarPnMZ/Oz0Aar8DucY8lFMMvvc=;
        b=SH4kivALZPyu6z8Te1ke0S4tmokB361FaCC0AzDfHKGoHsDC9uO+0aTOFZsLDwisKr
         pWKOHAviOTaTLQEOEvik45JL9KgUGyK7BJTfllyxetUS/K8q/MHYet9UNjFcYRYchZsF
         7yUEWICEhOTLfStxey617QMvYLuKg2c7ML7e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJ0JSJD7YhQrtyyxZarPnMZ/Oz0Aar8DucY8lFMMvvc=;
        b=hizUKIzonyKIaK69t9MAWXm9TutRyEyRykLPrLAinegomgWnkOPH6lcdhVC7dxiW04
         //SS4BvMIbcqCfW55m9CPnHQrhbYj1ySZ9yHLJit8EWpuy5ElI/9CNbLZYsMl5foVI/w
         9CFBxHrOusURm5QPLCJQ7hIJOL83SYnMVMxlR2KOxH7+dYwAQHSbmb6zFa58p9Z25yRb
         CSLhFCJFpOEgf4W/TX1X0idKik+e/Z8CaOO4N9YWwkNPeG0m7wUJbbs+kjLOshByiNmM
         6ymYlrliG7Sj+/QaQUkh7TDTQCKB5Mb8Z/9WNK4ZtpEoL0OBgcvx6eqMCKV32vHrATZg
         fBAw==
X-Gm-Message-State: AOAM5321RNHr/1PAEv6kmBG+piTv5y8UowUmsW8tCSLu9GZ3EANaev+t
        kn8WQUTkU/FeKbIhgI7lVTmA98qvQxm++Q==
X-Google-Smtp-Source: ABdhPJxXoADVJeenTJO6bK1ll7mULIV67ZJ0i2BM7ZnBKBLjBCx3xOFjiqY+uNAkx6X9p4qdwrkWkA==
X-Received: by 2002:a17:906:b312:: with SMTP id n18mr17168509ejz.353.1604515609239;
        Wed, 04 Nov 2020 10:46:49 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id t8sm1411586ejc.45.2020.11.04.10.46.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:46:49 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id p5so31246064ejj.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:46:48 -0800 (PST)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr10743770lji.102.1604515153445;
 Wed, 04 Nov 2020 10:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20201030225250.GB6357@xz-x1> <20201030235121.GQ2620339@nvidia.com>
 <20201103001712.GB52235@lx-t490> <20201103002532.GL2620339@nvidia.com>
 <20201103004133.GD52235@lx-t490> <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com>
 <20201103065225.GA63301@lx-t490> <CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com>
 <20201104013212.GA82153@lx-t490> <29e4f7f7-5774-7d8f-694b-75eb55ae1b2e@nvidia.com>
 <20201104031711.GA227990@lx-t490>
In-Reply-To: <20201104031711.GA227990@lx-t490>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Nov 2020 10:38:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com>
Message-ID: <CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during fork
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
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

On Tue, Nov 3, 2020 at 7:17 PM Ahmed S. Darwish <a.darwish@linutronix.de> wrote:
>
> Nonetheless, as you mentioned in the later (dropped) part of your
> message, I think do_ is better than __do_, so the final result will be:
>
>   do___read_seqcount_retry()
>   do_read_seqcount_retry()
>   do_raw_write_seqcount_begin()
>   do_raw_write_seqcount_end()
>   do_write_seqcount_begin()
>   ...
>
> and so on.

Looks reasonable to me.

And can you add a few comments to the magic type macros, so that it's
a lot more obvious what the end result was. I clearly wasn't able to
follow all the _Generic() cases from the seqcount_t to the final end
result. It's a really odd combination of subtle _GENERIC() macro and
token pasting to get from zeqcount_t to "false" in
__seqcount_lock_preemptible().

I can see it when I really look, but when looking at the actual use,
it's very non-obvious indeed.

                 Linus
