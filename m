Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61182EC483
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbhAFULB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbhAFULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609963774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YOrnA9VnDgH6pNnP7UKRM/V25n0w2/nGPxStTRfdjXU=;
        b=H/DFoGKf4m50XoBNNuvlkNUlby0Whk/f2tKo+HRe/Z5H2RrP8wnv4wLoALBxY81yOXDjVE
        +0pWodvwRDH4RCvQ2fdEkjvqqARnCBnEBv/F9SxPZhW5ziXpqLwerg9bBC7+WmhL5FNa5O
        EMysL6sXpdCOHPcAJp2p9jWJdAZHef8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-2hlsXVJfN_6r8-CzC9htEw-1; Wed, 06 Jan 2021 15:09:33 -0500
X-MC-Unique: 2hlsXVJfN_6r8-CzC9htEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B96061005504;
        Wed,  6 Jan 2021 20:09:31 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0BBA60875;
        Wed,  6 Jan 2021 20:09:30 +0000 (UTC)
Date:   Wed, 6 Jan 2021 15:09:30 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
Message-ID: <X/YY+mjpq15nmryI@redhat.com>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
 <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
 <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
 <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
 <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 06, 2021 at 11:46:20AM -0800, Andrew Morton wrote:
> On Tue, 5 Jan 2021 20:28:27 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> 
> > Alex, please consider why the authors of these lines (whom you
> > did not Cc) chose to write them without BUG_ON(): it has always
> > been preferred practice to use BUG_ON() on predicates, but not on
> > functionally effective statements (sorry, I've forgotten the proper
> > term: I'd say statements with side-effects, but here they are not
> > just side-effects: they are their main purpose).
> > 
> > We prefer not to hide those away inside BUG macros
> 
> Should we change that?  I find BUG_ON(something_which_shouldnt_fail())
> to be quite natural and readable.
> 
> As are things like the existing
> 
> BUG_ON(mmap_read_trylock(mm));
> BUG_ON(wb_domain_init(&global_wb_domain, GFP_KERNEL));
> 
> etc.
> 
> 
> No strong opinion here, but is current mostly-practice really
> useful?

I'd be surprised if the kernel can boot with BUG_ON() defined as "do
{}while(0)" so I guess it doesn't make any difference.

I've no strong opinion either, but personally my views matches Hugh's
views on this. I certainly tried to stick to that in the past since I
find it cleaner if a bugcheck just "checks" and can be deleted at any
time without sudden breakage.

Said that I also guess we're in the minority.

Thanks,
Andrea

