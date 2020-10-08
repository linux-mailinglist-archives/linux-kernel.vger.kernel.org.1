Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB8287A91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgJHRG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbgJHRG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:06:56 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F6AC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:06:55 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b1so3959651lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9iELUOUH2gSDZ+KGxu3KnkYY6SG+fTRDi1yjPRUUik=;
        b=PfQfZsaRVICKvNpGp8G6VluglndK7J962ZsTyDyp+zMzCpT9B3UMJ6Az1pLJiM3CdK
         tRPwiZiCoybF02TW+zofVU0z33pqqhrcdVmCdeOr/S4loUhaK/tr3d732BrwXy7lp/kE
         CrdZUBHPup88/Mbm0F9HHuMiDptpUy0ZlGqiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9iELUOUH2gSDZ+KGxu3KnkYY6SG+fTRDi1yjPRUUik=;
        b=kP8waJnOttGJqZnxeP+nIQUuo3OCnOJpEQbZ92Ic1kWnXGS3wd945nEu8AhPLbCmEk
         VYZNCtEqB9brxkkgY1LWMtD3/JzONqDWTrfNC0+gYxkJNvPcG1yIqA0nfUrRwK0ZbswA
         etmmjkXJN6QAu7giUdI2MmMkDNkDyihQbRn/SmjIQ324xkfp9JzDFq4B8zimEe7rcbCw
         1ACEnaM5j++MN1ROh9v/NYANP0TkcVjvbci3QP1Wqqf86CWzAGD+K5NIgdCsszGtZm1N
         fPKH08Toi4OMyDiV62w4KnNe7wPSD9ZRw2t2y9MMXdcQ+BbvJ4NTwQfrcv73Qz/cc1xv
         9Znw==
X-Gm-Message-State: AOAM530YZpb5czZFHmj7eOOi3A8t8ag38kNXL5Tzf93mSeydYP/BcNlO
        55f1qAbr5+P+RGALm4VnL1zrWi7izdwGww==
X-Google-Smtp-Source: ABdhPJwMTJqgHBWcsh99VUlSq5DhpP+DKVFWsyXAynVVKWffTSz26xqThH6RxSmGuqt5+YG/73+Pcg==
X-Received: by 2002:a19:8241:: with SMTP id e62mr1174271lfd.57.1602176813610;
        Thu, 08 Oct 2020 10:06:53 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id d7sm1049352ljg.140.2020.10.08.10.06.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 10:06:51 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m16so6558737ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:06:51 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr3514705ljj.102.1602176810912;
 Thu, 08 Oct 2020 10:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201008092627.399131-1-aneesh.kumar@linux.ibm.com> <CAHk-=whwY0WT046fqM-zdHu9vamUjgkvmd36gCd4qSaeYy98nA@mail.gmail.com>
In-Reply-To: <CAHk-=whwY0WT046fqM-zdHu9vamUjgkvmd36gCd4qSaeYy98nA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Oct 2020 10:06:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0q-_n_uEwgvjHNeVsj=j4Z+wY8_dYNwDPVrpfJi6wRA@mail.gmail.com>
Message-ID: <CAHk-=wj0q-_n_uEwgvjHNeVsj=j4Z+wY8_dYNwDPVrpfJi6wRA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Fetch the dirty bit before we reset the pte
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Just adding Leon to the participants ]

This patch (not attached again, Leon has seen it before) has been
tested for the last couple of weeks for the rdma case, so I have no
problems applying it now, just to keep everybody in the loop.

             Linus

On Thu, Oct 8, 2020 at 10:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 8, 2020 at 2:27 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> >
> > In copy_present_page, after we mark the pte non-writable, we should
> > check for previous dirty bit updates and make sure we don't lose the dirty
> > bit on reset.
>
> No, we'll just remove that entirely.
>
> Do you have a test-case that shows a problem? I have a patch that I
> was going to delay until 5.10 because I didn't think it mattered in
> practice..
>
> The second part of this patch would be to add a sequence count
> protection to fast-GUP pinning, so that GUP and fork() couldn't race,
> but I haven't written that part.
>
> Here's the first patch anyway. If you actually have a test-case where
> this matters, I guess I need to apply it now..
>
>                    Linus
