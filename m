Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2F62E10B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 01:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgLWACp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 19:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgLWACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 19:02:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657B8C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:02:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so35950338lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEZEPrvvOyHEjES0SNYK0E3ccD3hjt+5yzUBPutdjco=;
        b=XzU1oLdvDedHOW+AbIAexhPNODLtb//sgOl8JGShEdZKfQiV03IeRK19CKNwhm1tSD
         3VuLtulBFA2VZCgH/YCk2yh0TP8reIQNg1xGazs2NSnNy9cYZCmo8JHBsKff32EuoxG3
         QAAlrPIFglAKCoTl34p/7RmEHx235cSzHlqY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEZEPrvvOyHEjES0SNYK0E3ccD3hjt+5yzUBPutdjco=;
        b=Lc7Uhsb5lIB5iK2Lz6y3e8lqm6GucibDb8H0Mm2ElrHWEWczpzgXxGiBYyym9OnDSW
         iH9BnX1EnzgYOaeu+xzVMBsiFLG8EHXyBC3hiQiZiiPygKTd1mDbg0AfrZLjJgxWViqn
         00L+gRbdYtOMG2TbeMdzrD3YIxRUtSYcqdc//NuomJw1Qb/LsJoHodqhyWBgXQycUcmn
         6CntYiFTm8iYddaPImAlBuon51lNCOgrJqJZYZ+3sJCGqmyTBeJTL3UJR9nIzsJS8jG6
         kGIL2YGnlXG5hglO+ETe00VElu2/T11iST76MHuVajrwRgawvEaiCNfleGzVqH/kJQcH
         LkEQ==
X-Gm-Message-State: AOAM532ukjmnY8vVpNqhKjM6CEwAT2VAqZLPrj1oeS1cRESYO3I+9dXo
        o1RYbnnKS6g9tJhg8LqRcDQhUAK/BTvSgw==
X-Google-Smtp-Source: ABdhPJyLAMQWT2+mVQ2AgiXZ8HbLqWuxOVkBqcQR9a1ns1xH1wmipfA8nxhP3J8v8r0JMh4nsbKcIg==
X-Received: by 2002:ac2:4102:: with SMTP id b2mr4551056lfi.406.1608681723002;
        Tue, 22 Dec 2020 16:02:03 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w16sm2877940lfn.227.2020.12.22.16.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 16:02:02 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id h22so26489170lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:02:02 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr9361939lfd.201.1608681721989;
 Tue, 22 Dec 2020 16:02:01 -0800 (PST)
MIME-Version: 1.0
References: <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
 <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com> <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1> <CAHk-=wh-bG4thjXUekLtrCg8FRrdWjtT40ibXXLSm_hzQG8eOw@mail.gmail.com>
 <CALCETrV=8tY7h=aaudWBEn-MJnNkm2wz5qjH49SYqwkjYTpOaA@mail.gmail.com>
 <X+JJqK91plkBVisG@redhat.com> <X+JhwVX3s5mU9ZNx@google.com>
 <X+Js/dFbC5P7C3oO@redhat.com> <X+KDwu1PRQ93E2LK@google.com> <CAHk-=wiBWkgxLtwD7n01irD7hTQzuumtrqCkxxZx=6dbiGKUqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiBWkgxLtwD7n01irD7hTQzuumtrqCkxxZx=6dbiGKUqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Dec 2020 16:01:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjG7xx7Gsb=K0DteB1SPcKjus02zY2gFUoxMY5mm7tfsA@mail.gmail.com>
Message-ID: <CAHk-=wjG7xx7Gsb=K0DteB1SPcKjus02zY2gFUoxMY5mm7tfsA@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 3:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> See zap_pte_range() for an example of doing it right, even in the
> presence of complexities (ie that has an example of both flushing the
> TLB, and doing the actual "free the pages after flush", and it does
> the two cases separately).

The more I look at the mprotect code, the less I like it. We seem to
be much better about the TLB flushes in other places (looking at
mremap, for example). The mprotect code seems to be very laissez-faire
about the TLB flushing.

Does adding a TLB flush to before that

        pte_unmap_unlock(pte - 1, ptl);

fix things for you?

That's not the right fix - leaving a stale TLB entry around is fine if
the TLB entry is more strict wrt protections - but it might be worth
testing as a "does it at least close the problem" patch.

          Linus
