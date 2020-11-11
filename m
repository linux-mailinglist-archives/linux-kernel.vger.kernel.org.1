Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422812AF225
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKKN3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:29:16 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55384 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:29:16 -0500
Received: by mail-pj1-f67.google.com with SMTP id r9so703312pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dyqXpSq/ETs0u8CiBbSX7eqpqfckYmI3158TguRAUWc=;
        b=oe15BqSjSbACDdDgh8AAI7TAkWGQJB9b+F6ALYtL2EOG4axZbS9Bj36zkPElTTOXvE
         2a/iRdXdKNcgHhmG0ro8FsWR/mmICyuZ1bG1FUhoL3F1/T6UZQ01isRkzcHtdJIkgWoC
         4SeXgdBLpLyBbbG68McQXQZ72nFkxVyec3DpF3NmVi/WFdzGHP2LeY2YfwMLbaQlKJ7P
         5+SAAvNf6qCPFP/jKUtF6kwg9wHIRfU7M4FlRIDM9s0jhtd/2IytygybGQndp5rkdO9r
         i1UWb9mnkUsMlSulLDeqYDKIZlX5hKOlXozt7C3KKLSuAfwwa+PzfuI8w1z5wUIvEyXL
         AApA==
X-Gm-Message-State: AOAM5332WRlzveOufH0S0JKl+7dRFcVIwgK5rm/4HYRo/oJkoIRbo2v0
        MTUlEPY59xxrsW0xqmd1zUI8QGs+EyxFSA==
X-Google-Smtp-Source: ABdhPJyfd0cBH2MaHyAteGa8ksz4vab+NNOANeRNJhS/98ux3YIGeOhmKgAAF7GpnmTVH9AJEN0irQ==
X-Received: by 2002:a17:902:c142:b029:d6:ac10:6d25 with SMTP id 2-20020a170902c142b02900d6ac106d25mr21664187plj.37.1605101354112;
        Wed, 11 Nov 2020 05:29:14 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f17sm2909335pfk.70.2020.11.11.05.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:29:12 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 060B840715; Wed, 11 Nov 2020 13:29:11 +0000 (UTC)
Date:   Wed, 11 Nov 2020 13:29:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] mm, page_poison: use static key more efficiently
Message-ID: <20201111132911.GG4332@42.do-not-panic.com>
References: <20201026173358.14704-1-vbabka@suse.cz>
 <20201026173358.14704-3-vbabka@suse.cz>
 <20201030162743.GA17058@42.do-not-panic.com>
 <23a693bd-49cb-99a3-8691-afc74050887b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a693bd-49cb-99a3-8691-afc74050887b@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:56:48PM +0100, Vlastimil Babka wrote:
> On 10/30/20 5:27 PM, Luis Chamberlain wrote:
> > On Mon, Oct 26, 2020 at 06:33:57PM +0100, Vlastimil Babka wrote:
> > > Commit 11c9c7edae06 ("mm/page_poison.c: replace bool variable with static key")
> > > changed page_poisoning_enabled() to a static key check. However, the function
> > > is not inlined, so each check still involves a function call with overhead not
> > > eliminated when page poisoning is disabled.
> > > 
> > > Analogically to how debug_pagealloc is handled, this patch converts
> > > page_poisoning_enabled() back to boolean check, and introduces
> > > page_poisoning_enabled_static() for fast paths. Both functions are inlined.
> > > 
> > > Also optimize the check that enables page poisoning instead of debug_pagealloc
> > > for architectures without proper debug_pagealloc support. Move the check to
> > > init_mem_debugging() to enable a single static key instead of having two
> > > static branches in page_poisoning_enabled_static().
> > > 
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > <sad trombone>
> > 
> > This patchset causes a regression x86_64 as a guest. I was able
> > to bisect this on the following linux-next tags:
> > 
> > next-20201015 OK
> > next-20201023 OK
> > next-20201026 OK
> > next-20201027 BAD
> > next-20201028 BAD
> > 
> > Bisection inside next-20201027 lands me on:
> > 
> > "mm, page_alloc: do not rely on the order of page_poison and init_on_alloc/free parameters"
> 
> CC peterz.
> 
> I wonder if it's because I converted some static keys to _RO
> DEFINE_STATIC_KEY_FALSE_RO(init_on_alloc);.
> ...
> DEFINE_STATIC_KEY_FALSE_RO(init_on_free);

This was along the lines of what I suspected but I didn't have time
to provide an alternative.

> I thought it was ok since we only enable them during init. But maybe it's
> incompatible with use by modules? Not that I immediately see how
> drm_kms_helper(E+) uses them.

I can reproduce easily so happy to test alterantive patchsets!

> Andrew, I'm fine if you drop the patchset for now. I fear the next version
> would be tedious to integrate in form of -fix-fix patches anyway...

Thanks for this, I confirm next-20201111 boots fine now on kdevops.

  Luis
