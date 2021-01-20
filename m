Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B772FCC4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbhATIDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:03:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbhATIAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:00:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611129587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bqvjZ50v29HmtLhc+2U4jR1bd9+Pi19Rjou3HoGdKRY=;
        b=hFVv24LAyLfG6vPl6Kx1VUgKwoby0rNYYRkRhxjZNGIpwKV2DlWWf8rCbOc9A7evO/Hf5K
        k+mmaoZ/KB9jamXK5ubkjsXraYTkYW3iL9DyTk6Pxn0xnEOTU06xOsIK+3i3/gNcE+6Snx
        zX/Hio0Qv+38wVg/Kbmazy7iezsV6eo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FB9DACE1;
        Wed, 20 Jan 2021 07:59:47 +0000 (UTC)
Date:   Wed, 20 Jan 2021 08:59:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swap: Check nrexceptional of swap cache before being
 freed
Message-ID: <20210120075946.GD9371@dhcp22.suse.cz>
References: <20210120072711.209099-1-ying.huang@intel.com>
 <20210120074652.GA9371@dhcp22.suse.cz>
 <87v9bst55v.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9bst55v.fsf@yhuang-dev.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-01-21 15:54:04, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Wed 20-01-21 15:27:11, Huang Ying wrote:
> >> To catch the error in updating the swap cache shadow entries or their count.
> >
> > What is the error?
> 
> There's no error in the current code.  But we will change the related
> code in the future.  So this checking will help us to prevent error in
> the future.  I will change the patch description to make it more clear.
> 
> > Can it happens in the real life? Why do we need this
> > patch? Is crashing the kernel the right way to handle the situation?
> 
> Emm... The mistake to update swap shadow entries will hurt performance,
> but will not trigger functionality bug.  So it may be better to use
> VM_WARN_ON_ONCE().

Yes a warning is much more appropriate approach. The question is whether
a test like this is really necessary. But I will leave that to others to
decide. It was really the bug on that hit my eyes.

-- 
Michal Hocko
SUSE Labs
