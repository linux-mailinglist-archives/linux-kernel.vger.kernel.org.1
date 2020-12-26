Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3382E2F20
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 22:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgLZVEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 16:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLZVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 16:04:47 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653BC061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:04:07 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id f132so7733460oib.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ug2cC4COVPLC8mUYk/AU6N3XeMv07OZAJCLKe97wdjM=;
        b=Avq6Xe+8Li3coUSLxoaL0P41sPCfY0qsbLYDU/E+jNxRN0wRmjmQb+27bds/F8cNJn
         4gLjDmqbdC3jGuDAFanZlmbz3MoqdumM/dwLw8SRD1ngOrNtArDeSKVPkQoXK9FvhpQh
         Vlb1MvYWxq6Log5f9ewU/mwTWCWiyL1Dmpw9CGbv83WECKFdCZL5U5wMk1hlXbuiuX+e
         OQG68rW7XqQuYjDTSxPFW9E5LJMQ04VCzigc6rS8hO8nq7Bz5dzOw2OF++xdy3BArH4Y
         1eQjW0XL5KSaIUUEjcgyDPU2rs48dZA89dIyuF9XWu+xGxaN00ZGO+tGwx1fQbVmufiY
         aLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ug2cC4COVPLC8mUYk/AU6N3XeMv07OZAJCLKe97wdjM=;
        b=U/zLZal9OcirY8K+i69ARmuzIewxR7tCa4xbzoA9VQzJg6wuLUfdc00Vl1L5tulvRy
         OzfnZ0nnNE6gdbaz+zSG/8c16j4WeLaMlJAbrpE1Dh3UxTxM+nK2F6j2hlVQfImx8UHm
         LheYqnz8oCRic3fzQJ9x0NO7CjVbpIBK+HQi2Qm9x/EWv4KQJPHBpE+vF7fHpFijEhy8
         u28U3Go4Vv2d4BEMA7AtaZIOPSn2udz8NfEbjjLTIHvHziMPnH9IwIGkeRz7MxaSWQoi
         dduovcEXAtbqHCuIUpy8c9Jp22ENtZPR9G/NdgFUU/yihu9P4IibVJB8ChqpXieF2vP8
         ovLA==
X-Gm-Message-State: AOAM5338W/Q450W1QW5ZuzqIENXq1Wm9Kg6xhmf+eSQePRhH+MtCukXN
        F2B+0i76JdkYM24/pVoy3j2auQ==
X-Google-Smtp-Source: ABdhPJzWaV98BaCLOJggQeAevV7nlr+09PfWrr1zgmfPuaYmXZdbcc/YpfIPPieQfFhIyOWMZBmTug==
X-Received: by 2002:aca:fc03:: with SMTP id a3mr8356823oii.145.1609016646405;
        Sat, 26 Dec 2020 13:04:06 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y65sm7683123oie.39.2020.12.26.13.04.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 26 Dec 2020 13:04:05 -0800 (PST)
Date:   Sat, 26 Dec 2020 13:03:53 -0800 (PST)
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
In-Reply-To: <20201226204335.dikqkrkezqet6oqf@box>
Message-ID: <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
References: <20201217105409.2gacwgg7rco2ft3m@box> <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com> <20201218110400.yve45r3zsv7qgfa3@box> <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com> <20201219124103.w6isern3ywc7xbur@box>
 <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com> <20201222100047.p5zdb4ghagncq2oe@box> <alpine.LSU.2.11.2012231905300.5723@eggly.anvils> <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
 <20201226204335.dikqkrkezqet6oqf@box>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Dec 2020, Kirill A. Shutemov wrote:
> On Sat, Dec 26, 2020 at 09:57:13AM -0800, Linus Torvalds wrote:
> > Because not only does that get rid of the "if (page)" test, I think it
> > would make things a bit clearer. When I read the patch first, the
> > initial "next_page()" call confused me.
> 
> Agreed. Here we go:
> 
> From d12dea4abe94dbc24b7945329b191ad7d29e213a Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Sat, 19 Dec 2020 15:19:23 +0300
> Subject: [PATCH] mm: Cleanup faultaround and finish_fault() codepaths
> 
> alloc_set_pte() has two users with different requirements: in the
> faultaround code, it called from an atomic context and PTE page table
> has to be preallocated. finish_fault() can sleep and allocate page table
> as needed.
> 
> PTL locking rules are also strange, hard to follow and overkill for
> finish_fault().
> 
> Let's untangle the mess. alloc_set_pte() has gone now. All locking is
> explicit.
> 
> The price is some code duplication to handle huge pages in faultaround
> path, but it should be fine, having overall improvement in readability.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Hold on. I guess this one will suffer from the same bug as the previous.
I was about to report back, after satisfactory overnight testing of that
version - provided that one big little bug is fixed:

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2919,7 +2919,7 @@ static bool filemap_map_pmd(struct vm_fa
 
 	if (pmd_none(*vmf->pmd) &&
 	    PageTransHuge(page) &&
-	    do_set_pmd(vmf, page)) {
+	    do_set_pmd(vmf, page) == 0) {
 		unlock_page(page);
 		return true;
 	}

(Yes, you can write that as !do_set_pmd(vmf, page), and maybe I'm odd,
but even though it's very common, I have a personal aversion to using
"!' on a positive-sounding function that returns 0 for success.)

I'll give the new patch a try now, but with that fix added in. Without it,
I got "Bad page" on compound_mapcount on file THP pages - but I run with
a BUG() inside of bad_page() so I cannot miss them: I did not look to see
what the eventual crash or page leak would look like without that.

Hugh
