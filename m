Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B962F0304
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbhAITET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:04:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbhAITES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:04:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 642B02399C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610219017;
        bh=ffd/mc0gPcQXGXWeFlO/46TTv2fQp5rKnaxPu7uNZzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DPsiQFZx04z7n/fUiAdVs5KhMDbhVOH4AU4tC/3vuXSO+hjfEnW7/lffN2CQA/aj6
         U2wrtDFiQYdBOR3VyxV2tEeweZOBAfLzb5uAAL0755E5snjwlUSfqz4WkH009jT03R
         oRkW3T1noC5SkFpd7X5wJXYUxErnc7H+PRF3IZoEN6rinqdqRXNMv6bhIQ3wPgdxo2
         plXR1Bh2/9Z7hFu6dgBKOstb3DhlqRwvHPbNehNnSSnyitzausOUSvaYX+5IshHKvn
         5+8PdmLz7IfLvNOpf+LBucWKSHLavrnLx3QPKmPMlST4n7klQekRENSn0fP6qeh2np
         m1U/Jax+O5f2w==
Received: by mail-ed1-f50.google.com with SMTP id c7so14617552edv.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 11:03:37 -0800 (PST)
X-Gm-Message-State: AOAM530RS1gAYNJWmC7mjqdMcjjWbb/3FdePaOIUwD/sdbacL5JtElLV
        3drxtIxBFIA6i902qh7M4YZRJfnRq/Vbo5V9i/82BA==
X-Google-Smtp-Source: ABdhPJwsq6GDZo5Zn1wq6qDmwed3/Pt+DcGHGJDY8hq+M3V+c1E/x6HkYd9aroaG51NQeFJ9ynfeSSo4NPRGqloUweA=
X-Received: by 2002:a05:6402:229b:: with SMTP id cw27mr9132586edb.23.1610219015935;
 Sat, 09 Jan 2021 11:03:35 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com> <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com> <20210108181945.GF504133@ziepe.ca>
 <CALCETrVWGZ5MkN6S+o_h5isOHKVpjwSz-jyXSsp9VJjVOYOyyg@mail.gmail.com> <X/jr8QfeolQwn39f@redhat.com>
In-Reply-To: <X/jr8QfeolQwn39f@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 9 Jan 2021 11:03:23 -0800
X-Gmail-Original-Message-ID: <CALCETrWbmgyHR_d+FxKYpWYCc2XwZ8V8DNt_5bBL08Mi+1-_Uw@mail.gmail.com>
Message-ID: <CALCETrWbmgyHR_d+FxKYpWYCc2XwZ8V8DNt_5bBL08Mi+1-_Uw@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 8, 2021, at 3:34 PM, Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> =EF=BB=BFOn Fri, Jan 08, 2021 at 10:31:24AM -0800, Andy Lutomirski wrote:
>> Can we just remove vmsplice() support?  We could make it do a normal
>
>> copy, thereby getting rid of a fair amount of nastiness and potential
>> attacks.  Even ignoring issues relating to the length of time that the
>> vmsplice reference is alive, we also have whatever problems could be
>> caused by a malicious or misguided user vmsplice()ing some memory and
>> then modifying it.
>
> Sorry to ask but I'm curious, what also goes wrong if the user
> modifies memory under GUP pin from vmsplice? That's not obvious to
> see.

It breaks the otherwise true rule that the data in pipe buffers is
immutable.  Even just quoting the manpage:

       SPLICE_F_GIFT
              The user pages are a gift to the kernel.   The  application  =
may
              not  modify  this  memory ever, otherwise the page cache and =
on-
              disk data may differ.

That's no good.

I can also imagine use cases in which modified vmsplice() pages that
end up in various parts of the network stack could be problematic.
For example, if you can arrange for TCP or, worse, TLS to transmit
data and then retransmit modified data, you might get odd results.  In
the latter case, some security properties of TLS might be broken.

--Andy
