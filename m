Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B8266523
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIKQyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgIKQwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:52:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FC5C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:52:38 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so10736758edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymUunqCLw2vPuQ1VbXcUDi5LPgcqHOLwtMhV+h1hP00=;
        b=LzixW8IE64pueJHPc4pkVfB4hu8uL7V9KR6+6qOQDiBrSui1M4vSI9xeqysgklBESL
         0IQ4jxvW89dAuyt0txhLnLuupNLcl3TzUTNbKM8yk1mUHFyRH5GgOM7DPBaXlmnovHXl
         RwxBgeTE5qnMUevVAeinQ8lEe8Rzs7ehh51xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymUunqCLw2vPuQ1VbXcUDi5LPgcqHOLwtMhV+h1hP00=;
        b=mIZR6go7yWwuAPRtew6AIv+3tNih3WJXyNfenJ3dvTf4rGZZcwGamxJIgEDOQE9EV7
         Z1Szc3lgvzlF1+ZMEcY1Rj91fC40/dnpAmfEWokkMiXXhJt6BKE5l6jfwt60LYNpJ2zT
         9PDCeVTuhxCRi3JCu+cZKFP0IKi9lOcMYh2z8KXoxHtj/nla72CJLM9rqyiclzY5auEG
         leKCP8B3PfLHc+1ccER++8GToxo7JEyDFjOAfK+DPZ1d72vS7ldNKE8tE33mJODZYBbV
         dTunaMWFcILJiiDSs2jAZEYPZMhKCuePUd+ZgfEHDYNfvkZEJNRbjUzyvqXZyfB6xjFj
         WbvA==
X-Gm-Message-State: AOAM533g9G6zJFqN+yP65u7YAfji6YNs0uToyMjLB1qWUbzNNcZNK0Tj
        vr3Gt1KWHW2y/CwzX5zpsLmVT/YI+atbQg==
X-Google-Smtp-Source: ABdhPJzIschmatwsKv7WibHbeyrPClZkmL6rD7YNx8Dk6wtgMo4xngHPke2CwLhqTcgGofX+c5SQ4A==
X-Received: by 2002:a50:ed94:: with SMTP id h20mr3111973edr.184.1599843156568;
        Fri, 11 Sep 2020 09:52:36 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id z21sm1928786eja.72.2020.09.11.09.52.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 09:52:36 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id a17so12149320wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:52:36 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr585120lfg.344.1599842749970;
 Fri, 11 Sep 2020 09:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com> <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca> <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
 <20200910221116.GQ87483@ziepe.ca> <20200911121955.GA10250@oc3871087118.ibm.com>
In-Reply-To: <20200911121955.GA10250@oc3871087118.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Sep 2020 09:45:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiEUD_XvNnXysYsKiT4B3SajWbZ4VKY3jYk-17EEaaiA@mail.gmail.com>
Message-ID: <CAHk-=wiiEUD_XvNnXysYsKiT4B3SajWbZ4VKY3jYk-17EEaaiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 5:20 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> What if the entry is still pud_present, but got remapped after
> READ_ONCE(*pudp)? IOW, it is still valid, but points elsewhere?

That can't happen.

The GUP walk doesn't hold any locks, but it *is* done with interrupts
disabled, and anybody who is modifying the page tables needs to do the
TLB flush, and/or RCU-free them.

The interrupt disable means that on architectures where the TLB flush
involves an IPI, it will be delayed until afterwards, but it also acts
as a big RCU read lock hammer.

So the page tables can get modified under us, but the old pages won't
be released and re-used.

                Linus
