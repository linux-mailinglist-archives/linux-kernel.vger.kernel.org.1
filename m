Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61B22E2FAE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 03:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgL0Cja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 21:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgL0Cj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 21:39:29 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69031C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 18:38:49 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w124so8202836oia.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 18:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jJLUg7udy/yoAaERlEvGNl0/n0O26KZQJfCUJLjM7zQ=;
        b=BRjGmLltzGMf2jWUN5xsCpSzdi6EpXYfatCEb929/2Xn5UPcu0gYjMe9ANxf9yOOfZ
         f/E9eBEBz6cpEpqtluCWLN1YOkR2Q81XGe0yV8vbNb4zrDxrbHo0VAE931AYb4pJubkw
         fwzNgmeJSvZuT2sCf1r8cdNPO2CyvMDKmsRIIefJaLp7/RNnWWYDzMLp571RlgmTo1vt
         h9irjn1Qk4Ss91gwxMT83gHdng7I732kI+xn6AQeWmlOk8Ay2EqPorNp3tFZBTxQba4k
         wh3iEtYASw8j3aFswTp2iCod/m42p0x8RoWEaaOEiXfvp/PFmiM1skpftTnf24x2X/rr
         WiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jJLUg7udy/yoAaERlEvGNl0/n0O26KZQJfCUJLjM7zQ=;
        b=baJqVzzpgTS/Y6i1jGivpm+2yIWxCXUe5xi4XEV+c/EDegxt5lhIj/uhaetXgr6xRZ
         fU7LZvw1qdrDy6/FnDVeOTpTrPe6eTFho+5pH+Gww8SyLLpnq85dE8Oq8koEnrb915gt
         8hk/lGQjpPsJRqsJWOeKCZ+AKnjMX0xgCvtEsEMFcXbODhuQq8RZREWxpIPU3USAPK8J
         OrlUAlHfxgG8Q0ZAlp4NJ3ZsvPHH81JCMBJp4VOX7B9QK99Kndrhpw0fZFK3DNAmdpGB
         NJLiAKx923fAzJ8dQZnF59I14nr+m/l9Y1AS7rdkJIoPo0nAyEnVmcLDQXEE9dRw99a/
         +t8A==
X-Gm-Message-State: AOAM5312uu0tHCilbvcb2hgUjomerI3o47uhX4ZkogtpZ6Cg33115RZz
        xQTL3G7qQ931vAjVAS6twq2JYw==
X-Google-Smtp-Source: ABdhPJx/Higt52PWNdsUcJjfQfMcKu/nHvTvHqVvMxioihu5iaRquA7/5/T5FqAWjEueNtQTRED/0w==
X-Received: by 2002:aca:1917:: with SMTP id l23mr8728631oii.64.1609036728582;
        Sat, 26 Dec 2020 18:38:48 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 8sm9109394otq.18.2020.12.26.18.38.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 26 Dec 2020 18:38:47 -0800 (PST)
Date:   Sat, 26 Dec 2020 18:38:32 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
In-Reply-To: <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2012261816520.1071@eggly.anvils>
References: <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com> <20201219124103.w6isern3ywc7xbur@box> <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com> <20201222100047.p5zdb4ghagncq2oe@box> <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com> <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils> <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Dec 2020, Hugh Dickins wrote:
> On Sun, 27 Dec 2020, Kirill A. Shutemov wrote:
> > 
> > Here's the fixup I have so far. It doesn't blow up immediately, but please
> > take a closer look. Who knows what stupid mistake I did this time. :/
> 
> It's been running fine on x86_64 for a couple of hours (but of course
> my testing is deficient, in not detecting the case Linus spotted).
> 
> But I just thought I'd try it on i386 (hadn't tried previous versions)
> and this has a new disappointment: crashes when booting, in the "check
> if the page fault is solved" in do_fault_around().  I imagine a highmem
> issue with kmap of the pte address, but I'm reporting now before looking
> into it further (but verified that current linux.git i386 boots up fine).

This patch (like its antecedents) moves the pte_unmap_unlock() from
after do_fault_around()'s "check if the page fault is solved" into
filemap_map_pages() itself (which apparently does not NULLify vmf->pte
after unmapping it, which is poor, but good for revealing this issue).
That looks cleaner, but of course there was a very good reason for its
original positioning.

Maybe you want to change the ->map_pages prototype, to pass down the
requested address too, so that it can report whether the requested
address was resolved or not.  Or it could be left to __do_fault(),
or even to a repeated fault; but those would be less efficient.

> 
> Maybe easily fixed: but does suggest this needs exposure in linux-next.
> 
> Hugh
