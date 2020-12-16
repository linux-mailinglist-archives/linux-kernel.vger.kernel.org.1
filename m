Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F421C2DB805
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgLPAzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPAzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:55:37 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA746C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:54:56 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id t8so22367947iov.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ZtJqbgGcAblNJKpwbS3K6/u1SXDXbpWZAiwdGSMCSg=;
        b=Xy2Mg3RLj4cox03P2zL9aaeEiQo4rPz366y9A1Uw1sVBWPdsCfaE9XzzcbV2qqiWHl
         DgL3h7ocEauz5GltUn1Gxnz+EFdB2Bi6vdBhnE5bJqUwZOYA9wgAXM0zP9RoLXN9t3T1
         udYKALRDu3PAkUK/6RMUtSUF4IyjKN7pCADFvKfofTHnONSFrDvzkyW62Lpd3g1cQDSB
         dqCAiMfsK134v0EnTGYCmirzbW1gb+vNGV7jU/Y+N8u0M0pYZXQIK7mttoWUTPGVGdsy
         s40vgWLX+byl2IVeXCYfTjjHmIHU3RTiCtWTb2cmn90SUt2E4LRwsTk4nMFEOgDZVfa+
         xRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ZtJqbgGcAblNJKpwbS3K6/u1SXDXbpWZAiwdGSMCSg=;
        b=jmfksRGkam4H2+jqRtrbPDWWvcobuwT4tpZZBqWOzwk/6uOcivnYq21p6p7Wx0fQJo
         hflSdD1AmBBVC8PHU8FFXJJh72IM5t8L+3zn9mHCRekm3+MTwmlVx/WwwkR/3sQXfhgg
         xmL+lQASRz+HKkUvp25AElXbrQDwiWIPvi7WTszmPEzBRsV9zL2M2OueKCNWohobglgt
         Pm7VEWMfMpdzCzne/LJcPrN7kVxQ4lJYx+atcAGGcpdcJ8aWup1sT2x7yxrU3jvtnw7p
         euk+EuGtujBAAEZPJJqy37mZKXe27AIYuiP15T0gT4HNuIAaLwMvZFVyahdoSMcUzUve
         viRg==
X-Gm-Message-State: AOAM533FJPXmfqy2zjDojpsJQuVpgJOjtyKSlRm4OZoobhrY1iOfemyx
        SsPMYoOic5N5+bqDISjlJnTCRQ==
X-Google-Smtp-Source: ABdhPJyP8I7tgzzXbJLVToXhgBExxn8NrvHnma47sZvIFSUx0ZUEqxZQBxv8iGUm9mCUG4Is4z4gvg==
X-Received: by 2002:a02:3907:: with SMTP id l7mr42148584jaa.0.1608080096185;
        Tue, 15 Dec 2020 16:54:56 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id 12sm119037ily.42.2020.12.15.16.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 16:54:55 -0800 (PST)
Date:   Tue, 15 Dec 2020 17:54:51 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] mm: VM_BUG_ON lru page flags
Message-ID: <X9la29qelClATtpP@google.com>
References: <20201207220949.830352-1-yuzhao@google.com>
 <20201207220949.830352-8-yuzhao@google.com>
 <20201207222429.GC7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207222429.GC7338@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:24:29PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 07, 2020 at 03:09:45PM -0700, Yu Zhao wrote:
> > Move scattered VM_BUG_ONs to two essential places that cover all
> > lru list additions and deletions.
> 
> I'd like to see these converted into VM_BUG_ON_PGFLAGS so you have
> to take that extra CONFIG step to enable checking them.

Right. I'll make sure it won't slip my mind again in v2.
