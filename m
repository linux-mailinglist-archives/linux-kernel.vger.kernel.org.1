Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4435328800B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 03:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgJIBfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 21:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJIBfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 21:35:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0AC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 18:35:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so5872072pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 18:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9zZePxv1+ayzDeRnmmneH5yJgguBhYNYuZPZ3ryB+aY=;
        b=OlU1oasSdq2JHGNSbvBEe2LNN/ZY3bfSNgkbsIpJQP5mL42tno8ZPR4A7oc0AELxAs
         mf7khMvAXcvIYWlm8MDYaxEvk1f9Fw18WqGLx3h9fijdqzXK1nfaH+5jTkQuvH7eJHtd
         bksuSzC901/tTuvI5ZVxdKT0opmMxQHVHHQ66EDk5a+HingLIXvMZGgPgvxZWX+8y7BT
         ew/H/8odV/o6SXNc3aQUFDx/oG9sdbetPEtWe0/ceqV3QIbOifMhZc0R9k1jk9mPY2f+
         aCU5LY8VWY8X7wNj26XsDH6P/W6ri00hVXlit9I+2PhKmGE6ojB9O7UbOtaf/VYW6ce/
         kXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9zZePxv1+ayzDeRnmmneH5yJgguBhYNYuZPZ3ryB+aY=;
        b=IlqkNcVa1c9AEYpb8dcf00o5CpOchVVX6taRzn26Zh9e4EDyY34tfIUIAV2EVg8JiN
         f4SJTEwprXWFcnQcFSG5axRFj+x4bKKrC/eFQZCiETsAzgUoMDavS2q4p04CwjFteRbS
         tBr+vqtoe5pzyYD/cVnKmixFy9pWEyYKyTuursB6gch4wpzqAkNXfPnwQvXU+zMcV1xh
         JqnjmkVfxeGt+ZbxLUVVJv2eaL2lHQS63t+blS1flyRGaU6KLO4/G31RhEEJNOWBtXem
         V3JeksNz4oF08H6VnqnwduBT2rqxccqT4s5dggch44yWe69J3qSSJMWn9Bvl5RqfpS52
         na5A==
X-Gm-Message-State: AOAM530ZJgRssI9o2HMwZ1jU+ynulgzymMa21N+SCmgabhKLBqXKnwTx
        BzqVi2yorJvrMSVGtgf81W0=
X-Google-Smtp-Source: ABdhPJwoxvQFMmIFCUXhVinnrWxfYcLbTUVLlmTrPwZniYMJGUfPt8z22uZXVXXeAsxzVofzj2oTZA==
X-Received: by 2002:a63:5c5f:: with SMTP id n31mr1312474pgm.397.1602207335265;
        Thu, 08 Oct 2020 18:35:35 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id j8sm8733508pfr.121.2020.10.08.18.35.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 18:35:34 -0700 (PDT)
Date:   Fri, 9 Oct 2020 10:35:12 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Hari Bathini <hbathini@linux.ibm.com>, kernel-team@lge.com,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Huang Rui <ray.huang@amd.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC][PATCH] kexec: Teach indirect pages how to live in high
 memory
Message-ID: <20201009013500.GA26932@js1304-desktop>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com>
 <87h7wzvjko.fsf@x220.int.ebiederm.org>
 <CAAmzW4MrD75+Prw=fQ=d5uXKgGy3urBwmxnNtoNsw5M1m9xjYQ@mail.gmail.com>
 <87ftcfpzjn.fsf@x220.int.ebiederm.org>
 <87368fmkel.fsf_-_@x220.int.ebiederm.org>
 <54a53bfe-6929-2790-9b1d-943e9f47cd62@linux.ibm.com>
 <87sggekyzv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sggekyzv.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 01:39:16PM -0500, Eric W. Biederman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
> > On 05/05/20 3:29 am, Eric W. Biederman wrote:
> >> 
> >> Recently a patch was proposed to kimage_alloc_page to slightly alter
> >> the logic of how pages allocated with incompatible flags were
> >> detected.  The logic was being altered because the semantics of the
> >> page alloctor were changing yet again.
> >> 
> >> Looking at that case I realized that there is no reason for it to even
> >> exist.  Either the indirect page allocations and the source page
> >> allocations could be separated out, or I could do as I am doing now
> >> and simply teach the indirect pages to live in high memory.
> >> 
> >> This patch replaced pointers of type kimage_entry_t * with a new type
> >> kimage_entry_pos_t.  This new type holds the physical address of the
> >> indirect page and the offset within that page of the next indirect
> >> entry to write.  A special constant KIMAGE_ENTRY_POS_INVALID is added
> >> that kimage_image_pos_t variables that don't currently have a valid
> >> may be set to.
> >> 
> >> Two new functions kimage_read_entry and kimage_write_entry have been
> >> provided to write entries in way that works if they live in high
> >> memory.
> >> 
> >> The now unnecessary checks to see if a destination entry is non-zero
> >> and to increment it if so have been removed.  For safety new indrect
> >> pages are now cleared so we have a guarantee everything that has not
> >> been used yet is zero.  Along with this writing an extra trailing 0
> >> entry has been removed, as it is known all trailing entries are now 0.
> >> 
> >> With highmem support implemented for indirect pages
> >> kimage_image_alloc_page has been updated to always allocate
> >> GFP_HIGHUSER pages, and handling of pages with different
> >> gfp flags has been removed.
> >> 
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > Eric, the patch failed with data access exception on ppc64. Using the below patch on top
> > got me going...
> 
> Doh!  Somehow I thought I had put that logic or something equivalent
> into kimage_write_entry and it appears I did not.  I will see if I can
> respin the patch.
> 
> Thank you very much for testing.

Hello, Eric.

It seems that this patch isn't upstreamed.
Could you respin the patch?
I've tested this one on x86_32 (highmem enabled) and it works well.

Thanks.
