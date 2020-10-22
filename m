Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2312964AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369696AbgJVSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902394AbgJVSbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:31:14 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F27C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:31:14 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b11so1435853qvr.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aYlAeZhqKaRNyS3SekTyRKmiadvhR+J+xxu+zks2yzM=;
        b=SGBkvSKMMmJQMrZ01OSTFiEhpJ02DhOZA+Ue6BRyeAU09VrB/HGHe2qWivLDSvMnKf
         dpwvedVTZ8ugXE+Sxk+vXxXvpKgzliUd80cAArsrOhvQ/6GSTxG+sgnWD2rZkCq7iIoU
         LrihMPSo1xbc5+uZTVnJW+1Q+t4BXRyudrCuXtJSwxZpOKgNiPisU2lmU0R4YeLtsNvd
         bbX+c4K3VaqR/UkS8VW4xEmz1S1or0Nh50wv4Jwzpp8QLrWZwna/rO0KXRNQZOG44SfH
         LL+mNNZu3YUsMmHWQEUBSHXIs6tsId+QRKjF1U3qfgOMe/LfTc8NdjV5muvaqO9ovvZJ
         DaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aYlAeZhqKaRNyS3SekTyRKmiadvhR+J+xxu+zks2yzM=;
        b=YdqaRBSM2qfPXOih3ZjH26os52XP437n2/Ctc+uDdtxzwOlpfm7IlJKqzD/pPFNQwx
         u8R3zDYzDo8mYVLx9O2YyN5JUgSqq/AyJuh2KJuxf3FpIfwph3bUXhl6leZrI47Hf8nH
         0jyV/lfvV9DU0cg6q68MURruvSZMz0LXYjbuNlraWhBhIz9010Yv1pG3MwRVTQymskg9
         1xJJKIfD76ym5jcEVoK0cxhggjxa3oxxdngaj/6TDTr/581Zfb7qxgmwN7rYwZh73AcS
         IvIAa6uLWHqXjicGVZXaU+P3ETop72pvi3Ujvb6Rey1xIHIel2QxSrUk78GtgkdwokSS
         r3bg==
X-Gm-Message-State: AOAM531xSLTYsYNz8bJhNrRcjkh6TM4SAGkXzFE6BZfITnOKmvAToQCZ
        wY9JrcLc8WfsPrF/EoB9qruvEA==
X-Google-Smtp-Source: ABdhPJwU15HFbWZCdIdGyTOTI+H1tkJwZxga47ZMAwkEINW6Gi3wbOMcLkfkG4RdF3tZTnaieC4C5Q==
X-Received: by 2002:ad4:4eaf:: with SMTP id ed15mr3680745qvb.40.1603391473647;
        Thu, 22 Oct 2020 11:31:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c400])
        by smtp.gmail.com with ESMTPSA id r17sm1728530qtc.22.2020.10.22.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 11:31:12 -0700 (PDT)
Date:   Thu, 22 Oct 2020 14:29:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
Message-ID: <20201022182934.GA494712@cmpxchg.org>
References: <20201022151844.489337-1-hannes@cmpxchg.org>
 <db4f86f30726a1a33c868155b4c681ac25569179.camel@fb.com>
 <004fe66ee1d111ec006dd065b9bed5fdcfdaad01.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004fe66ee1d111ec006dd065b9bed5fdcfdaad01.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:57:55PM -0400, Rik van Riel wrote:
> On Thu, 2020-10-22 at 12:49 -0400, Rik van Riel wrote:
> > On Thu, 2020-10-22 at 11:18 -0400, Johannes Weiner wrote:
> > 
> > > index e80aa9d2db68..334ce608735c 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -204,9 +204,9 @@ static void unaccount_page_cache_page(struct
> > > address_space *mapping,
> > >  	if (PageSwapBacked(page)) {
> > >  		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
> > >  		if (PageTransHuge(page))
> > > -			__dec_node_page_state(page, NR_SHMEM_THPS);
> > > +			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
> > >  	} else if (PageTransHuge(page)) {
> > > -		__dec_node_page_state(page, NR_FILE_THPS);
> > > +		__dec_lruvec_page_state(page, NR_FILE_THPS);
> > >  		filemap_nr_thps_dec(mapping);
> > >  	}
> > 
> > This may be a dumb question, but does that mean the
> > NR_FILE_THPS number will no longer be visible in
> > /proc/vmstat or is there some magic I overlooked in
> > a cursory look of the code?
> 
> Never mind, I found it a few levels deep in
> __dec_lruvec_page_state.

No worries, it's a legit question.

lruvec is at the intersection of node and memcg, so I'm just moving
the accounting to a higher-granularity function that updates all
layers, including the node.

> Reviewed-by: Rik van Riel <riel@surriel.com>

Thanks!
