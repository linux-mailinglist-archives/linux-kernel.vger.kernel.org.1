Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5567B2F2175
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbhAKVEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbhAKVEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:04:24 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4610DC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:03:44 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id k7so89110ooa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=D0WsNvRmpBji920/NLXuSxF1voxQjixvAcc1ep1K53k=;
        b=azspcaalHcJMxoaJcLWKEOOfP9+fKM96I9nb8n17Oyh+Crzg0pdbuIsZZvB+Q2Z/IX
         4G3Zvp44mQsXJU3/HYukyexeX7/RUsYb9oep6Tq0gCIgXbTAuA0avhZyL9KiGlPetOJF
         Gio4Oy6UjAInYNrXZSMxyueSj9+5bt65Yz8uhx0OPnlkBr02eV+EWpf3xyS5aG3+Ckce
         x/HAhHilGocjsnPlAjb8NybRMrtww45Nigd5iA3berXAGFsc8aakB4x2ELNR4+A3AIsm
         tNODDrV83uvQRGqXIdmsIyLQt+RVp5iovLIQIcqF51+J7AsPWFcez4s/ApMqPJFIUX2L
         UHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=D0WsNvRmpBji920/NLXuSxF1voxQjixvAcc1ep1K53k=;
        b=ghTT55lUFD27dzTo2ygLkbaSh+WqctZpwcMHPU3L1uOQbvLy7XwJCmo/AUAzLDlY7g
         W8sZh8YE4Hp56ie4RDJcOTpcJcx2CKSqYb+YPqbGzyW4v76nIY3jcSchnLQ1BSpLQUEJ
         YJQlTtQG+O4FUrkRGDCaE7QPPP2fUGk1K3C9GxLajORjfdiYLBbXyx+hRfYdjIl05gdc
         GHv5hrzkVpcJpTnjxabmJG2zSHWb3S53woNgpJe5o8q91r27TcotFeZJJLG0sigJKcIP
         qZjGwsPsYhFsWIps8VQv7cvtqdFGAI0lR7VDBwt2W4Ej5mYKrAVoY6oU9chUBy4kHQnj
         JqcQ==
X-Gm-Message-State: AOAM530egKyuasEJsYm17MwdSIr2z3ESTlu7WgE6+ioiJNezWS+cUo6H
        qgKIYqrsx0s4lZWNSL8poan/36jEtQ8wdQ==
X-Google-Smtp-Source: ABdhPJwoPOIOzFsA8HrKwq8BkpXKz4xbBOGnDZj5hWPQPvkz6AthHRvqF/O25zKJWn4ePNr5WUYCOg==
X-Received: by 2002:a4a:e1c1:: with SMTP id n1mr748612oot.36.1610399023421;
        Mon, 11 Jan 2021 13:03:43 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y10sm197210ota.42.2021.01.11.13.03.42
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 11 Jan 2021 13:03:42 -0800 (PST)
Date:   Mon, 11 Jan 2021 13:03:29 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Will Deacon <will@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
In-Reply-To: <20210111133007.GA7642@willie-the-truck>
Message-ID: <alpine.LSU.2.11.2101111254390.2227@eggly.anvils>
References: <20210108171517.5290-1-will@kernel.org> <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com> <20210111133007.GA7642@willie-the-truck>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021, Will Deacon wrote:
> On Fri, Jan 08, 2021 at 11:34:08AM -0800, Linus Torvalds wrote:
> > On Fri, Jan 8, 2021 at 9:15 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > The big difference in this version is that I have reworked it based on
> > > Kirill's patch which he posted as a follow-up to the original. However,
> > > I can't tell where we've landed on that -- Linus seemed to like it, but
> > > Hugh was less enthusiastic.
> > 
> > Yeah, I like it, but I have to admit that it had a disturbingly high
> > number of small details wrong for several versions. I hope you picked
> > up the final version of the code.
> 
> I picked the version from here:
> 
>   https://lore.kernel.org/r/20201229132819.najtavneutnf7ajp@box
> 
> and actually, I just noticed that willy spotted a typo in a comment, so
> I'll fix that locally as well as adding the above to a 'Link:' tag for
> reference.
> 
> > At the same time, I do think that the "disturbingly high number of
> > issues" was primarily exactly _because_ the old code was so
> > incomprehensible, and I think the end result is much cleaner, so I
> > still like it.

Just to report that I gave this v2 set a spin on a few (x86_64 and i386)
machines, and found nothing objectionable this time around.

And the things that I'm unenthusiastic about are exactly those details
that you and Kirill and Linus find unsatisfactory, but awkward to
eliminate: expect no new insights from me!

Hugh
