Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62091299F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436732AbgJ0AU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:20:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45654 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441040AbgJ0AUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:20:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id r127so14787660lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pq1ZiLJCFcmgBv0JcKGMbgbJxC9bbLjRkNwBgcJh0Q=;
        b=Kka79kbJMSIegb0otW5XpEZGBA5SvJVApuOIDNwAYEJudE5IEDU8uS9xOVp8VPCJd7
         b6SXjLkGUDOsdUxN6GxdMaer4vbcu+m0lMCl4yUVEtnWOLc2Gy49/vh4f/10qgVdNAuy
         U7v/pMBYIdx1aSuJTLPA4PxgXktFn6T53RTT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pq1ZiLJCFcmgBv0JcKGMbgbJxC9bbLjRkNwBgcJh0Q=;
        b=cuZY/fELqiGk1pW4g367wK/+/XvbPXOC0L9qgFtaPFlEWc6ims1kcbLVBV033erMGd
         tZYpG7zB/YdlHjaim8nOTzQHmgrw3IuT0wrgykauEQ6x7oACXq99kkXtoNUOoZrJaXhl
         BUqWw8IIBVK7BGBJaHP+sjC5lh6Rw8Y6wCefQsi5Y9+wyfGnn/IzgMcbfG0rE0iJ9ALK
         93ihoXtB8xLNdY/3shdk57vhC7U5G/B5dddxvtxRlLlrx+/8C3OME+8LjkFAfUdTBPMM
         xzH/cioR8FtN41O4UzEIwMmv+TGwiMu7DtDe8kje4ma/o2rxJcDpg6kl8+AaTYxNDlCh
         pLEg==
X-Gm-Message-State: AOAM531pZ9MKt//qrWm0LVlJhuIyrJXFdgmg0dWf3bHNuXoYDlpkme9e
        T3RUnGROCrynSg4coK08rqU1MVkX2W92wg==
X-Google-Smtp-Source: ABdhPJz6IOKPnwkUBuYBkLwzgyyU+qPT+xUyUZPuiBpv4NrNNNk0d9bszEoPtv+Ai79mMaDSd7D7LQ==
X-Received: by 2002:a19:a12:: with SMTP id 18mr6695272lfk.345.1603758009977;
        Mon, 26 Oct 2020 17:20:09 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id v70sm1199981lfa.93.2020.10.26.17.20.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 17:20:09 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id i2so12627062ljg.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:20:09 -0700 (PDT)
X-Received: by 2002:a19:cbcb:: with SMTP id b194mr6627878lfg.133.1603757691217;
 Mon, 26 Oct 2020 17:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <2-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
 <a9f05c88-acdb-7b48-6f54-4c973a87aaeb@nvidia.com> <32a38d92-6ecc-243b-77be-8f1ea0792334@nvidia.com>
 <20201026234952.GD1523783@nvidia.com>
In-Reply-To: <20201026234952.GD1523783@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Oct 2020 17:14:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEL2B-PSGzhQxyC3VR1XpUee6nKw6YiJG6w7hRL1f9Lg@mail.gmail.com>
Message-ID: <CAHk-=whEL2B-PSGzhQxyC3VR1XpUee6nKw6YiJG6w7hRL1f9Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: prevent gup_fast from racing with COW during fork
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 4:50 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Right, it isn't a "seqcount" because the read side doesn't spin.

Not all readers spin for seqcount either.

Sure, it's the *common* case, but look at name resolution - it will
basically fail on a seqcount failure in RCU mode, and go to the "slow
and safe" version:

                if (unlikely(read_seqcount_retry(&d->d_seq, nd->seq)))
                        return -ECHILD;

Exactly like gup_fast vs fork, in fact.

So no, you don't need to retry for seqcount failures, doing

     seq = seqcount_begin(..);
     ... optimistic fast case ...
     if (!read_seqcount_retry(.., seq))
          return 0; // success
       .. do slow case ...

is valid and happens.

              Linus
