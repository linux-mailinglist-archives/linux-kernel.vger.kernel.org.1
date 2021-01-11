Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EA32F1F24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404086AbhAKTWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391022AbhAKTVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DAC0617BC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m25so1119912lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuYMAUtCWmYJ++DX8IPtB8qketeodafT0GlTpxIamMM=;
        b=dtKHegwF45Wek/elGqYJZI7jetDQ65SX9gUGgih3Jo/DonYqL1thaNxEGTkkI1Aee9
         Mwa5m+3Mn3ZSCSpM1xgh45gwwD6oNir5EEBwrEx3yzagNgE+DVv4Wgi6HyoEqtUJVury
         76e16Kp1cz5Y37THwADpjULOnpo8ffddRW5f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuYMAUtCWmYJ++DX8IPtB8qketeodafT0GlTpxIamMM=;
        b=MGdA28myOXrebLAMhMxHH5M9z977rZ2x25JD8JXTFJUpnR9JwzpTzlvsA+xnh2kCXU
         CouSPHCknaarJA4597OzCnL3iTCQ3FbmqGYoocf2B9x2owmAf1mLo7R67UHIBfUJB8SU
         Cq0XiK/KSauA1PhZqV2gjY8QTBymuDOCuysYhG6jTJbbHHxGSt+QHiuuxplmxLypFxrf
         5gpX5ebzlBzuKiz/nntDST/SBLQO4BVNP8Q8aZQcr2xtwOF+gu2pby3dE3lZvE5t58VF
         gmjUQ57Ym1Zs8J/jSSCnakHaJLzGw+NbVIh+esvaqMhnZz3kxY4BeL2uYMzVFZdxhS1+
         f5sw==
X-Gm-Message-State: AOAM5315fxx/mg1mwr6D/7xjIpXhE01Rw2qDAFlLthC/Kkfa1jR9ligW
        e++JlihCXmY3YHadR+0f+AHAu7VgW0Zw4Q==
X-Google-Smtp-Source: ABdhPJx3gkhhRx3zDLh/z85MDJAvBR7oOLxgwpGAaHZSfHNtD1VhGU85wdEk/ogH32N/D9KuSIXrBg==
X-Received: by 2002:ac2:4d4a:: with SMTP id 10mr422285lfp.556.1610392791151;
        Mon, 11 Jan 2021 11:19:51 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id p4sm82243lfc.214.2021.01.11.11.19.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:19:50 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id m12so1161756lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:49 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr426031lfc.421.1610392789412;
 Mon, 11 Jan 2021 11:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com> <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com> <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
In-Reply-To: <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jan 2021 11:19:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
Message-ID: <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 11:27 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> There is at least one way to improve this part of it--maybe.

It's problematic..

> IMHO, a lot of the bits in page _refcount are still being wasted (even
> after GUP_PIN_COUNTING_BIAS overloading), because it's unlikely that
> there are many callers of gup/pup per page.

It may be unlikely under real loads.

But we've actually had overflow issues on this because rather than
real loads you can do attack loads (ie "lots of processes, lots of
pipe file descriptors, lots of vmsplice() operations on the same
page".

We had to literally add that conditional "try_get_page()" that
protects against overflow..

           Linus
