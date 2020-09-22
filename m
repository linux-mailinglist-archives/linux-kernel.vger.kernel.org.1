Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E251B273F33
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIVKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:07:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:43616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIVKHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:07:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600769227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJcev0KH0kDxKMs7n4Aga90c3i9CO0R3TV3nnggFYx8=;
        b=IbJCsazj1TR7HAe1Lm3x7g1wcML0kjpZ50jrG1+pf9/FiZ7TQwefz293FPgbGE3WF8L/aR
        oFWBmZxYtQ5VxHBu/BASom2K64GkHXuVn3jlarXv/A659gEHQBZt0ZVFIot5nMRjeYmxUM
        T7bd+0LNxOiWHPEcIY9umhMZNlcoM2A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76147B4FB;
        Tue, 22 Sep 2020 10:07:43 +0000 (UTC)
Date:   Tue, 22 Sep 2020 12:07:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v4] mm: khugepaged: avoid overriding min_free_kbytes set by user
Message-ID: <20200922100702.GX12990@dhcp22.suse.cz>
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
 <20200917092805.GA29887@dhcp22.suse.cz>
 <21c4788c-2516-2e47-5885-486c352c2b6e@linux.microsoft.com>
 <20200917175217.GD29887@dhcp22.suse.cz>
 <f2231b44-6d14-fb63-43cd-43aaad02bef1@linux.microsoft.com>
 <20200918055637.GB28827@dhcp22.suse.cz>
 <e4eb32bb-f905-d15b-8596-13bf387b9f57@linux.microsoft.com>
 <20200922070726.dlw24lf3wd3p2ias@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922070726.dlw24lf3wd3p2ias@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 10:07:26, Kirill A. Shutemov wrote:
> On Mon, Sep 21, 2020 at 12:07:23PM -0700, Vijay Balakrishna wrote:
> > > 
> > > I would recommend reposting the patch which adds heuristic for THP (if
> > > THP is enabled) into the hotplug path, arguing with the consistency and
> > > surprising results when adding memory decreases the value.
> > 
> > I hope my reposted patch
> > ([v3 1/2] mm: khugepaged: recalculate min_free_kbytes after memory hotplug
> > as expected by khugepaged)
> > change log is ok:
> > 
> > When memory is hotplug added or removed the min_free_kbytes must be
> > recalculated based on what is expected by khugepaged.  Currently
> > after hotplug, min_free_kbytes will be set to a lower default and higher
> > default set when THP enabled is lost.  This change restores min_free_kbytes
> > as expected for THP consumers.
> 
> Any scenario when hotremove would result in changing min_free_kbytes?

init_per_zone_wmark_min is called from both online and offline path. But
I believe the problem is not in the offlining path. A decrease wrt
previous auto tuned value is to be expected. The primary problem is that
the hotadding memory after boot (without any user configured value) will
decrease the value effectively because khugepaged tuning
(set_recommended_min_free_kbytes) is not called.

-- 
Michal Hocko
SUSE Labs
