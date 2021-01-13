Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4042F41FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbhAMCoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbhAMCoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:44:18 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9557C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:43:37 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id n8so871881ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3tovUNebVBqHYYgXcIOq46Z2/klSN5vOx1yoh735kU=;
        b=QAaSJkf8F8mhoT7ZED6SP0E85gkAUCHQnHtc+4RuECGaQMi5xzzzxQxQ0t5dUNsByp
         dyR0V1ZYxfPMUSKf8swLBXg1ar2NOk19ssjieWnvNPLDXb0uIEf+0GA+gqNUSnr+C7HP
         /d8xA7pSS6lEq1tHDU2OqWlkja0fwX376MthA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3tovUNebVBqHYYgXcIOq46Z2/klSN5vOx1yoh735kU=;
        b=MS6P+yeyQWLx6bpOzLyAjxdFUODJ+uw4KJ5Dk579b5lW2Iacvcz0p8IccY1WIWV/0o
         wkdJFhp9PjfyHx9jWc7Ch6UV7Q4wmlLUdk/j7z+4YoHjladgCGxO18JxFOcsNC2tc8nQ
         zH7u2NuQJroFdhmUWT8gBE88agFKEWYqUUtaVx55nrj3gyAo11Y+4z7xVFvPrizyDcgT
         An6DnhDPCKtoV5gGRzxhS1664YK6VGO1mqFCJMLhG50CZj1t4MKQ7x3LqKRCQERnAirE
         B7u7SvTKiKcDCpuoZ7pt1LhASj9RdrrdHlaF6f9QatPG+2f0ww20JFhFwjvdzXLj+UwB
         Dbgw==
X-Gm-Message-State: AOAM533/tEPXpzbTuco/nOJz5yVLgJUpcaWvun1Rc3twcqoK74aox18W
        Rqe1c+ddh5OZWCGRtfZ/uhm8ObpqUYowkQ==
X-Google-Smtp-Source: ABdhPJwxdQ+Xtcs6RNQ9uN9498oS8TK4zg8327xLZ+c/4SGqMYmtlYDrs6bClKhJIRzRjLsgkDdNBA==
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr1007944ljo.58.1610505815658;
        Tue, 12 Jan 2021 18:43:35 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f9sm55446lft.114.2021.01.12.18.43.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 18:43:34 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id u21so893050lja.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:43:34 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr936040ljj.465.1610505813763;
 Tue, 12 Jan 2021 18:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com> <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com> <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
 <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com> <20210113021619.GL35215@casper.infradead.org>
In-Reply-To: <20210113021619.GL35215@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jan 2021 18:43:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxDS7DHHN=ZHCUskXu3A2h3Z5F427kTJqvc5P_8x8ecw@mail.gmail.com>
Message-ID: <CAHk-=whxDS7DHHN=ZHCUskXu3A2h3Z5F427kTJqvc5P_8x8ecw@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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

On Tue, Jan 12, 2021 at 6:16 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> The thing about the speculative page cache references is that they can
> temporarily bump a refcount on a page which _used_ to be in the page
> cache and has now been reallocated as some other kind of page.

Right you are. Yeah, scratch the "we could make it absolute on 1", and
we do need the PIN count elevation.

           Linus
