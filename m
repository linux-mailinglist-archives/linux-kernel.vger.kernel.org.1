Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17E2F8676
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbhAOURM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAOURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:17:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86BCC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:16:29 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u21so11770139lja.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySs7CNTOqN5GXMFt8JleozKLbcnnMYl8h0GybHe3ovo=;
        b=VlpCFPXBTVU5sv30ixD//eShTT4irKo27rhhyZGhIUsqmoxF6jwWVu3Quqs689I6zq
         AHsvmwosR39IZhN5Eb64huoTv/7f1b7rIr7ogsXWFqkSAtrtra6wKPFDL6OixkbiQyOL
         tz6ewYTX/eHAIBfWDy9YfcGq/ZxOFqTRMfA7TIhhouFbfaNN8gSJnq1BPNtLUwkdGfVC
         zKQn3z03aTQxD0M2gvdoU+OMjzL0Zw1RGwpVkKhlpRQ8F7yPXZEv3gkHy0YsIBBmw1UO
         6eixhRzN2DUNoCHBBB0xIWIwl8uN/v1ZbP8Pn9IfkMZYMnAfzmIYZEvL6nQEv/s8LYPr
         OXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySs7CNTOqN5GXMFt8JleozKLbcnnMYl8h0GybHe3ovo=;
        b=bEoLH8ktiP7DjiOMj6cc82MGhijhacWvpZhAxR+zqTkCgINcGbB10MJ40iaoDtadD3
         rLMzrExxhB0DvSLK4R6kGQxjwSHmlVVTRum52SWfDK/lj9W8OWEHg6sUzpYtxgwrOpb2
         Lmpi4vEHJ+lm2bNk4gtJ1Gq9bbE5XahlabS05MhgH8AweFOonzv98x03Bn7axcGYbys6
         CC+6zzjGqsCbrkzMNjlcaf/GYhXGwYHUoV0+Rtnj6QPIdtAboj1MdGOposDUGC7lsJwB
         rTNi36fRFb0bQkbYOs68svwkgZW34BMhrG4ESWTLwg+pe3LIhVDnr5aGDymqi13Gq9VB
         JYjg==
X-Gm-Message-State: AOAM532L9ROHZCYxPqy9ext9ao/6WzibY84P+p2JKZsYHHD6/tHXbw1e
        eukHKQgnGB8FTMeBS3ggHkx1VuuxLzLt3w4npBh1Jw==
X-Google-Smtp-Source: ABdhPJxDasIJIa/cY9hSw0yawfYbZ0GYp/23phEahsfz3evcWfJnDGxLtBqc+qw6GzB3pScGLudSyHgnR8FGw6dwkZM=
X-Received: by 2002:a2e:9d87:: with SMTP id c7mr5897472ljj.43.1610741788004;
 Fri, 15 Jan 2021 12:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20210115183543.15097-1-vbabka@suse.cz>
In-Reply-To: <20210115183543.15097-1-vbabka@suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Jan 2021 21:16:01 +0100
Message-ID: <CAG48ez0NvKYdNX6H_jbe1p5KV5-O6-i5K1JCBM6GHcTC5HDFRg@mail.gmail.com>
Subject: Re: [PATCH] mm, slub: splice cpu and page freelists in deactivate_slab()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 7:35 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> In deactivate_slab() we currently move all but one objects on the cpu freelist
> to the page freelist one by one using the costly cmpxchg_double() operation.
> Then we unfreeze the page while moving the last object on page freelist, with
> a final cmpxchg_double().
>
> This can be optimized to avoid the cmpxchg_double() per object. Just count the
> objects on cpu freelist (to adjust page->inuse properly) and also remember the
> last object in the chain. Then splice page->freelist to the last object and
> effectively add the whole cpu freelist to page->freelist while unfreezing the
> page, with a single cmpxchg_double().

This might have some more (good) effects, although these might well be
too minuscule to notice:

 - The old code inverted the direction of the freelist, while the new
code preserves the direction.
 - We're no longer dirtying the cachelines of objects in the middle of
the freelist.

In the current code it probably doesn't really matter, since I think
we basically only take this path when handling NUMA mismatches,
PFMEMALLOC stuff, racing new_slab(), and flush_slab() for handling
flushing IPIs? But yeah, if we want to start automatically sending
flush IPIs, it might be a good idea, given that the next accesses to
the page will probably come from a different CPU (unless the page is
entirely unused, in which case it may be freed to the page allocator's
percpu list) and we don't want to create unnecessary cache/memory
traffic. (And it's a good cleanup regardless, I think.)

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Jann Horn <jannh@google.com>

[...]
>         /*
> -        * Stage two: Ensure that the page is unfrozen while the
> -        * list presence reflects the actual number of objects
> -        * during unfreeze.
> +        * Stage two: Unfreeze the page while splicing the per-cpu
> +        * freelist to the head of page's freelist.
> +        *
> +        * Ensure that the page is unfrozen while the list presence
> +        * reflects the actual number of objects during unfreeze.

(my computer complains about trailing whitespace here)

>          *
>          * We setup the list membership and then perform a cmpxchg
>          * with the count. If there is a mismatch then the page
