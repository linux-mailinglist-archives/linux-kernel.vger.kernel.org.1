Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CCC271B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIUHAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:00:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgIUHAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:00:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600671607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0GQipOfypdE9JtI0inT1hN7YqT/TbCj8zbpEfuyDTzU=;
        b=lZsUkeMva4pAbg6wMD0kGuuSfoUDYqF8lfhQABzhhiatSoasHpHSpK9PW0lCTp5Dli821j
        dpbHSRNyIlWvPU0dmc4nSkDfeQXvIly6zNvkPxuq80piV8Ov2U3MCk4TILJWugSVAyl58L
        fNpQZtxPR22fPt96DeG8GT9qjEF8UwM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17D11AF17;
        Mon, 21 Sep 2020 07:00:43 +0000 (UTC)
Date:   Mon, 21 Sep 2020 09:00:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
Message-ID: <20200921070006.GA12990@dhcp22.suse.cz>
References: <20200914143312.GU16999@dhcp22.suse.cz>
 <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
 <20200915081832.GA4649@dhcp22.suse.cz>
 <53dd1e2c-f07e-ee5b-51a1-0ef8adb53926@linux.microsoft.com>
 <20200916065306.GB18998@dhcp22.suse.cz>
 <32b73685-48f2-b6dd-f000-8ea52cfee70a@linux.microsoft.com>
 <20200917121213.GC29887@dhcp22.suse.cz>
 <7eddcc58-f65f-0be9-60e8-2de013365909@linux.microsoft.com>
 <20200918054513.GA28827@dhcp22.suse.cz>
 <2bd9ebf5-f6b7-1a2a-be61-9d4af8210cce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd9ebf5-f6b7-1a2a-be61-9d4af8210cce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-09-20 08:32:13, Vijay Balakrishna wrote:
> 
> 
> On 9/17/2020 10:45 PM, Michal Hocko wrote:
> > On Thu 17-09-20 11:03:56, Vijay Balakrishna wrote:
> > [...]
> > > > > The auto tuned value is incorrect post hotplug memory operation, in our use
> > > > > case memoy hot add occurs very early during boot.
> > > > Define incorrect. What are the actual values? Have you tried to increase
> > > > the value manually after the hotplug?
> > > 
> > > In our case SoC with 8GB memory, system tuned min_free_kbytes
> > > - first to 22528
> > > - we perform memory hot add very early in boot
> > 
> > What was the original and after-the-hotplug size of memory and layout?
> > I suspect that all the hotplugged memory is in Movable zone, right?
> 
> Yes, added ~1.92GB as Movable type, booting with 6GB at start.
> 
> > 
> > > - now min_free_kbytes is 8703
> > > 
> > > Before looking at code, first I manually restored min_free_kbytes soon after
> > > boot, reran stress and didn't notice symptoms I mentioned in change log.
> > 
> > This is really surprising and I strongly suspect that an earlier reclaim
> > just changed the timing enough so that workload has spread the memory
> > prpessure over a longer time and that might have been enough to recycle
> > some of the unreclaimable memory due to its natural life time. But this
> > is a pure speculation. Much more data would be needed to analyze this.
> > 
> > In any case your stress test is oveprovisioning your Normal zone and
> > increased min_free_kbytes just papers over the sizing problem.
> > 
> 
> It is a synthetic workload, likely not sized I need to check.  I feel having
> higher min_free_kbytes made GFP_ATOMIC allocations not to fail.

Yes a higher min_free_kbytes will help GFP_ATOMIC. But only to some
degree. But nobody should depend on an atomic allocation for
correctness. It is just way too easy to fail under a higher memory
pressure.

> I have seen
> NETDEV WATCHDOG timeout with stacktrace trying to allocate memory, looping
> in net rx receive path.

You should talk to net folks.
-- 
Michal Hocko
SUSE Labs
