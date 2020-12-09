Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C292D49BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgLITFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbgLITFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:05:14 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E974DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 11:04:33 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so4580854lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3/iD6BpU9NwnI1wlGLlC1tle+7JV89Hx5+q3b5LN54=;
        b=EYN3ZZKwWVNMwBm8x9JOGa9EihlumcROW9WrixT7kWiz0koOnKoAiHMcys1QHob10q
         F9FijxEJ+1etvVO7Jx91vMKUQLhPYYQGGJRibfG8iRO3mhY7Dg4YruAM9ThMqlJDWydA
         bPjD/apL42XuTa7gN8I86JwOtsZ4oyipVPTYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3/iD6BpU9NwnI1wlGLlC1tle+7JV89Hx5+q3b5LN54=;
        b=XB7nme4ad4/FVEdEZqg/kxUyIrGCIk97GFTTCf2tbUK/HznauwPizU5pgrfApbmohh
         kHhm6TMI0phVZ913GA8nB5KTn/ydFFRHpwBOzrMGt2KE9FFv9Tz7giprpdYzYt8yZZn+
         VVWbwWGZoDEdio/5hCw2IOAaXt95JKH0fJRdMOSKu8czTWJJboMW/jq3ROVEOwqvK7YT
         C+8q4psq3cU29Tfy4aJyTI3eJKku4UvO2/0c8Atd2klRpTMRWOAWCQP2Xtv1iuKeHarv
         MJn8XYg1iEGygFkuDMlMndh6bPSHHDpUS1dhYqTqh0ybSq5eOUrTZrpKHxyQA05ywlXB
         x3Cw==
X-Gm-Message-State: AOAM530qpp7FGnr/LLF5Z3B0geh3rrkN3tVeJr3///RKp80jf1ruviVw
        ixB3ryVvOO/2vWBPl/5ZGyspbFUiOiQ5/Q==
X-Google-Smtp-Source: ABdhPJz+dwRz4oHOZhIabMZC5d/1QXC0TPsJmM0B2b8O6ZlgsCyIMxWCsvNdaVcLCATyxbtSwxIVzQ==
X-Received: by 2002:a05:6512:3586:: with SMTP id m6mr808431lfr.318.1607540671596;
        Wed, 09 Dec 2020 11:04:31 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a15sm260333lfg.27.2020.12.09.11.04.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 11:04:30 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id a9so4620210lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:04:30 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr1395245lfi.377.1607540669881;
 Wed, 09 Dec 2020 11:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20201209163950.8494-1-will@kernel.org> <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com> <20201209184049.GA8778@willie-the-truck>
In-Reply-To: <20201209184049.GA8778@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 11:04:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
Message-ID: <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 10:40 AM Will Deacon <will@kernel.org> wrote:
>
> > And yes, that probably means that you need to change "alloc_set_pte()"
> > to actually pass in the real address, and leave "vmf->address" alone -
> > so that it can know which ones are prefaulted and which one is real,
> > but that sounds like a good idea anyway.
>
> Right, I deliberately avoided that based on the feedback from Jan on an
> older version [1], but I can certainly look at it again.

Side note: I absolutely detest alloc_set_pte() in general, and it
would be very good to try to just change the rules of that function
entirely.

The alloc_set_pte() function is written to be some generic "iterate
over ptes setting them'" function, but it has exactly two users, and
none of those users really want the semantics it gives them, I feel.
And the semantics that alloc_set_pte() does have actually *hurts*
them.

In particular, it made it a nightmare to read what do_fault_around()
does: it does that odd

        if (pmd_none(*vmf->pmd)) {
                vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);

and then it calls ->map_pages() (which is always filemap_map_pages(),
except for xfs, where it is also always filemap_map_pages but it takes
a lock first).

And it did that prealloc_pte, because that's what alloc_set_pte()
needs to be atomic - and it needs to be atomic because it's all done
under the RCU lock.

So essentially, the _major_ user of alloc_set_pte() requires atomicity
- but that's not at all obvious when you actually read alloc_set_pte()
itself, and in fact when you read it, you see that

        if (!vmf->pte) {
                ret = pte_alloc_one_map(vmf);

which can block. Except it won't block if we have vmf->prealloc_pte,
because then it will just take that instead.

In other words, ALL THAT IS COMPLETE GARBAGE. And it's written to be
as obtuse as humanly possible, and there is no way in hell anybody
understands it by just looking at the code - you have to follow all
these odd quirks back to see what's going on.

So it would be much better to get rid of alloc_set_pte() entirely, and
move the allocation and the pte locking into the caller, and just
clean it up (because it turns out the callers have their own models
for allocation anyway). And then each of the callers would be a lot
more understandable, instead of having this insanely subtle "I need to
be atomic, so I will pre-allocate in one place, and then take the RCU
lock in another place, in order to call a _third_ place that is only
atomic because of that first step".

The other user of alloc_set_pte() is "finish_fault()", and honestly,
that's what alloc_set_pte() was written for, and why alloc_set_pte()
does all those things that filemap_map_pages() doesn't even want.

But while that other user does want what alloc_set_pte() does, there's
no downside to just moving those things into the caller. It would once
again just clarify things to make the allocation and the setting be
separate operations - even in that place where it doesn't have the
same kind of very subtle behavior with pre-allocation and atomicity.

I think the problem with alloc_set_pte() is hat it has had many
different people working on it over the years, and Kirill massaged
that old use to fit the new pre-alloc use. Before the pre-faulting, I
think both cases were much closer to each other.

So I'm not really blaming anybody here, but the ugly and very
hard-to-follow rules seem to come from historical behavior that was
massaged over time to "just work" rather than have that function be
made more logical.

Kirill - I think you know this code best. Would you be willing to look
at splitting out that "allocate and map" from alloc_set_pte() and into
the callers?

At that point, I think the current very special and odd
do_fault_around() pre-allocation could be made into just a _regular_
"allocate the pmd if it doesn't exist". And then the pte locking could
be moved into filemap_map_pages(), and suddenly the semantics and
rules around all that would be a whole lot more obvious.

Pretty please?

              Linus
