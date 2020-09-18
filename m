Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E5A26F571
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIRFpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:45:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:34978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIRFpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:45:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600407914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtgJb5DOSfFArBP5h7rhRhAb+SSCe85VA5Xwta08aZQ=;
        b=NjiVvGH3nPC2P7dzYLPH7KdE+uECzWnMRkusn29gMNtXOUdrIzIjuFuhr+VXVGnrioQB9N
        xQX0A05P1ofLUXUiFsi+L9bZAiJ6jRkC7HxLkdFDAsXaE/ZYV1mm3/ddWLpqNtdy2G/CQM
        ldO1YaQFqQ9C4KByXaMxtdSn81p9rfimUmV5mLYDbNdHbTjo891ynzBhXJBeADavs4FWVy
        zBcNmAzQ2qSAaAIPrheNL6qUIiIo5JOVLcAnKQo6wNwUry9YzBUWoGnqM/cJAfkoFVlmfJ
        o/18zEwnZ70LUDjeRgOS/EPu0Kaov1dcKHdjojBP7NhHzPeBzxDLrgXshaI0PQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D042AACC8;
        Fri, 18 Sep 2020 05:45:48 +0000 (UTC)
Date:   Fri, 18 Sep 2020 07:45:13 +0200
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
Message-ID: <20200918054513.GA28827@dhcp22.suse.cz>
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200914143312.GU16999@dhcp22.suse.cz>
 <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
 <20200915081832.GA4649@dhcp22.suse.cz>
 <53dd1e2c-f07e-ee5b-51a1-0ef8adb53926@linux.microsoft.com>
 <20200916065306.GB18998@dhcp22.suse.cz>
 <32b73685-48f2-b6dd-f000-8ea52cfee70a@linux.microsoft.com>
 <20200917121213.GC29887@dhcp22.suse.cz>
 <7eddcc58-f65f-0be9-60e8-2de013365909@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eddcc58-f65f-0be9-60e8-2de013365909@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-09-20 11:03:56, Vijay Balakrishna wrote:
[...]
> > > The auto tuned value is incorrect post hotplug memory operation, in our use
> > > case memoy hot add occurs very early during boot.
> > Define incorrect. What are the actual values? Have you tried to increase
> > the value manually after the hotplug?
> 
> In our case SoC with 8GB memory, system tuned min_free_kbytes
> - first to 22528
> - we perform memory hot add very early in boot

What was the original and after-the-hotplug size of memory and layout?
I suspect that all the hotplugged memory is in Movable zone, right?

> - now min_free_kbytes is 8703
> 
> Before looking at code, first I manually restored min_free_kbytes soon after
> boot, reran stress and didn't notice symptoms I mentioned in change log.

This is really surprising and I strongly suspect that an earlier reclaim
just changed the timing enough so that workload has spread the memory
prpessure over a longer time and that might have been enough to recycle
some of the unreclaimable memory due to its natural life time. But this
is a pure speculation. Much more data would be needed to analyze this.

In any case your stress test is oveprovisioning your Normal zone and
increased min_free_kbytes just papers over the sizing problem.
-- 
Michal Hocko
SUSE Labs
