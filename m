Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF4D2E6B25
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgL1W4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgL1WGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 17:06:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D097EC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 14:05:50 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b26so26892190lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 14:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=45Sdgq0CvgKJkbdvj9B0AvWNpX2stNzecfKpH4b08Jg=;
        b=oAmJY6msYX1EpCEynkntpDs7jp9Oc6Cr7Uy+4IUlBAbzp3PzdkgwMrT3sW/O61d5UT
         WL6UP77ndWZiZh1lQC9+5Y4pyR+zx+HTiBI+/vgnbpJ68W3+TuBJ32AwIfScBZLJ5iin
         QceIKle+JBIuBv4A4PNh+5vsox0fTRco2EuxqVfVJ8LKCjeQpmZSus9EY+vRuSCU+rxL
         2lqUTb3JF7AV8EVnVFf+qyHOsk4PHT+vUkyKAhoj25HiYehljSFGMpLeVdhBcv4I6wp8
         hZ66dOubRcc2xyegz9Kd8S8GKX6e4d7kEgf9EwyysSaI8OtBm4lHRg3ZxoHxo0VUbSik
         D9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45Sdgq0CvgKJkbdvj9B0AvWNpX2stNzecfKpH4b08Jg=;
        b=lp8M3BSB65HD5KMv55DwzXn1y8g4fnP1GzmK6GYPr8ZOvFitWSCfPipK2C+vHv1jX2
         4z6ylC4zkyGRXx19wd4WwXohqjeVTDO+WBp2VjsBk3CTCGelUU0qHqzfVG6Twxx4dxkY
         U9WXpCfz1iyZfsQIJAzIDlPc6ry8oEUjLIomr2bAVd5bhAJ86+0qSRGy0/WS/YjbF/Gm
         tnZyho0GRSZpOWBLIJqlOyRriB2fNaQSljqCcaaq+dLFUGgvpSnCr3ldNGr0cpu9donz
         siOLHRD5JSsvnKdT1G26XaN4J6PX8asSaChQCdSGwX/ZPNZnvdSRMO3egCDV+9OQAsLS
         CgFA==
X-Gm-Message-State: AOAM530P230USI0iOrmy/M5qbjAv3TmZBb2/CnzoCL6W0KxU26fj7/zY
        XGBlghrgNGUgn4A4fKyV8umPGw==
X-Google-Smtp-Source: ABdhPJyEJGC2U7ia1xM2nzW0J4rVQGFTB1NrQKckztfI4yAFTmBNyMtDPQHGY76jNfz9uKdGzvS/Xw==
X-Received: by 2002:a2e:81cb:: with SMTP id s11mr22732457ljg.377.1609193149174;
        Mon, 28 Dec 2020 14:05:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s1sm30141ljs.0.2020.12.28.14.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 14:05:48 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7B45E100F3B; Tue, 29 Dec 2020 01:05:48 +0300 (+03)
Date:   Tue, 29 Dec 2020 01:05:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
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
Message-ID: <20201228220548.57hl32mmrvvefj6q@box>
References: <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box>
 <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils>
 <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box>
 <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
 <alpine.LSU.2.11.2012272233170.24487@eggly.anvils>
 <20201228125352.phnj2x2ci3kwfld5@box>
 <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 10:47:36AM -0800, Linus Torvalds wrote:
> On Mon, Dec 28, 2020 at 4:53 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > So far I only found one more pin leak and always-true check. I don't see
> > how can it lead to crash or corruption. Keep looking.
> 
> Well, I noticed that the nommu.c version of filemap_map_pages() needs
> fixing, but that's obviously not the case Hugh sees.
> 
> No,m I think the problem is the
> 
>         pte_unmap_unlock(vmf->pte, vmf->ptl);
> 
> at the end of filemap_map_pages().
> 
> Why?
> 
> Because we've been updating vmf->pte as we go along:
> 
>                 vmf->pte += xas.xa_index - last_pgoff;
> 
> and I think that by the time we get to that "pte_unmap_unlock()",
> vmf->pte potentially points to past the edge of the page directory.

Well, if it's true we have bigger problem: we set up an pte entry without
relevant PTL.

But I *think* we should be fine here: do_fault_around() limits start_pgoff
and end_pgoff to stay within the page table.

It made mw looking at the code around pte_unmap_unlock() and I think that
the bug is that we have to reset vmf->address and NULLify vmf->pte once we
are done with faultaround:

diff --git a/mm/memory.c b/mm/memory.c
index 829f5056dd1c..405f5c73ce3e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3794,6 +3794,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	update_mmu_tlb(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	vmf->address = address;
+	vmf->pte = NULL;
 	return ret;
 }
 
-- 
 Kirill A. Shutemov
