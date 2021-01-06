Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD072EC2D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhAFR5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAFR5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:57:12 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4A3C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 09:56:32 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id 14so2756702ilq.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 09:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvWIKPZGlYigpWr94sywgD4jTLiK4vzzsU8HmQXvkug=;
        b=j0hqyWfM5XYbxpF7FBleHHXI+LeK/SewK8LfagxRd/qqn2OdAsV6G66XXvjYbNJHQ+
         Hk3cqlv1zIlvpkabaD018ZtbgVhXFTOBL6fohVKBk/6vlSwzii1N8Jmr+YKSD57rodT0
         wJnM3WnCiTsxfSZCHjYlr1ayFtPoJGC1ESRE8pd2QXFae48ZzEiB53EM3BInlNzTJUPu
         ev3PGtJhHOzm9hTFxl8Pspy+aTHzDosnNfW/VRkW9M1qNGBztmv0GPTU6TqMG09vEl2I
         TmJAiyrJkM3k4Hp/fASFi3mcrhwXX4P6SiOQ6TXr6v6GHH58cTisTuLW72BD9yIx7/ep
         rycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvWIKPZGlYigpWr94sywgD4jTLiK4vzzsU8HmQXvkug=;
        b=l/nps6sQbJdt3ptgEh5pwW6+uxIUg/N2q8mLLeHkeOU+5up36H9G70JESdhrj7YS7P
         /IZn1uLpiOxvn5NcZPh/5lO126ai6Sh4kYXru7W7HXJRikWS0/9/qN53bUBITsOtHgNx
         tIltREHLfzU985/B7XFJ0RVQhkmzbT9bLb/MD8cuLC4903AVfb4ar8eiWRY2Y+U6DHfG
         8rPfGwiIX2hHUaWaIyFRbzPYQI0aaG0MQk18zIkpyXbLBPIyi7ud/w2MaxzplMQFcllL
         R7caut5rRBQT/IA8xVEhKT8J6TCADDuEa1SE0LP8h49JzSc4e5t7lGS7SAQnjmUr3glU
         LuvA==
X-Gm-Message-State: AOAM5333McHouDE4V8QNX9UGcTcPJCIdDppGFHZoMJepW60QgY0ASn+Q
        6Dy1YL0jnmDERx8/kn2fucGZlb4rF/GZczkBJ9jjJg==
X-Google-Smtp-Source: ABdhPJxMkuu520zuOD7rJ7AhrtKjRGtkEMJhj2Y0NRSNQ8o1miWg5cb+BK6jRN1C8MUKmJ2BYL0G1SoRJPncUaJv5zI=
X-Received: by 2002:a05:6e02:c32:: with SMTP id q18mr5299219ilg.203.1609955791817;
 Wed, 06 Jan 2021 09:56:31 -0800 (PST)
MIME-Version: 1.0
References: <20210105233136.2140335-1-bgardon@google.com> <20210105233136.2140335-2-bgardon@google.com>
 <CANgfPd8TXa3GG4mQ7MD0wBrUOTdRDeR0z50uDmbcR88rQMn5FQ@mail.gmail.com>
 <e94e674e-1775-3c67-97f0-8c61e1add554@oracle.com> <CANgfPd-QPUwigK5um8DWQ5Y_M+JGRie_N_vkYtZdNE1WQbn3mA@mail.gmail.com>
 <4471c5e6-16a1-65c4-aa59-185091a2ebbc@oracle.com>
In-Reply-To: <4471c5e6-16a1-65c4-aa59-185091a2ebbc@oracle.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 6 Jan 2021 09:56:20 -0800
Message-ID: <CANgfPd_jJmFT_ZLW9M0=AMP8fH9JnA2Jm1aymOwPBfnbL6odSw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kvm: x86/mmu: Ensure TDP MMU roots are freed after yield
To:     "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Leo Hou <leohou1402@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 9:37 AM Maciej S. Szmigiero
<maciej.szmigiero@oracle.com> wrote:
>
> On 06.01.2021 18:28, Ben Gardon wrote:
> > On Wed, Jan 6, 2021 at 1:26 AM Maciej S. Szmigiero
> > <maciej.szmigiero@oracle.com> wrote:
> >>
> >> Thanks for looking at it Ben.
> >>
> >> On 06.01.2021 00:38, Ben Gardon wrote:
> >> (..)
> >>>
> >>> +Sean Christopherson, for whom I used a stale email address.
> >>> .
> >>> I tested this series by running kvm-unit-tests on an Intel Skylake
> >>> machine. It did not introduce any new failures. I also ran the
> >>> set_memory_region_test
> >>
> >> It's "memslot_move_test" that is crashing the kernel - a memslot
> >> move test based on "set_memory_region_test".
> >
> > I apologize if I'm being very dense, but I can't find this test
> > anywhere.
>
> No problem, the reproducer is available here:
> https://gist.github.com/maciejsszmigiero/890218151c242d99f63ea0825334c6c0
> as I stated in my original report.

Ah, that makes sense now. I didn't realize there were more files below
the .config. I added your test and can now reproduce the issue!

>
> > Is this something you have in-house but haven't upstreamed
> > or just the test_move_memory_region(); testcase from
> > set_memory_region_test? I have a similar memslot-moving-stress-test in
> > the pipeline I need to send out, but I didn't think such a test
> > existed yet and my test hadn't caught this issue.
>
> The reproducer at that GitHub link is taken from my KVM memslot
> test mini-set, itself based on set_memory_region_test.c from
> KVM selftests.
> The full mini-set will be posted as soon as I finish it :)

Awesome, thank you for writing this test!

>
> Thanks,
> Maciej
