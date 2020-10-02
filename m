Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5028112B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbgJBLZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:25:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:41304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387762AbgJBLZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:25:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601637917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qa0E0AqAlpJW8exV1CmKJIhcsK2Mdv4336ilHgw89b8=;
        b=UzfkfqfnuPCur8RZ5Ow5r0GwLHYtvnra2J2t0vwK6HEOqu5MGj1Ox1Bt3R2pShL/1JNj40
        CyjUUErSO0LuMGu5FNcUN9btCg7DGN2NyZg81tt7SYYuCCih8ArQRdeDAWW1sA2qnYJOrQ
        UXJ2JdDn9ejgN7lQdSIdgt0pTDpT9CY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17F18ABD1;
        Fri,  2 Oct 2020 11:25:17 +0000 (UTC)
Date:   Fri, 2 Oct 2020 13:25:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v5] mm: khugepaged: recalculate min_free_kbytes after memory
 hotplug as expected by khugepaged
Message-ID: <20201002112516.GD4555@dhcp22.suse.cz>
References: <1601398153-5517-1-git-send-email-vijayb@linux.microsoft.com>
 <2a380b84-4fee-fa4e-e862-8a8577961088@oracle.com>
 <8cdb105c-2b7b-1997-ed82-22f4bb25638c@linux.microsoft.com>
 <638ebb7a-72e3-a219-ee2b-55f1c028efad@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <638ebb7a-72e3-a219-ee2b-55f1c028efad@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-09-20 15:03:11, Mike Kravetz wrote:
> On 9/30/20 1:47 PM, Vijay Balakrishna wrote:
> > On 9/30/2020 11:20 AM, Mike Kravetz wrote:
> >> On 9/29/20 9:49 AM, Vijay Balakrishna wrote:
> >>
> >> Sorry for jumping in so late.  Should we use this as an opportunity to
> >> also fix up the messages logged when (re)calculating mfk?  They are wrong
> >> and could be quite confusing.
> > 
> > 
> > Sure.  Please share your thoughts regarding appropriate message.  Here is what I'm thinking
> > 
> > pr_warn("min_free_kbytes is not updated to %d because current value %d is preferred\n", new_min_free_kbytes, min_free_kbytes);
> > 
> > If above message is reasonable I can post a new revision (v6).
> 
> Just considering the below example,
> 
> >> For example consider the following sequence
> >> of operations and corresponding log messages produced.
> >>
> >> Freshly booted VM with 2 nodes and 8GB memory:
> >> # cat /proc/sys/vm/min_free_kbytes
> >> 90112
> >> # echo 90000 > /proc/sys/vm/min_free_kbytes
> >> # cat /proc/sys/vm/min_free_kbytes
> >> 90000
> >> # echo 0 > /sys/devices/system/node/node1/memory56/online
> >> [  135.099947] Offlined Pages 32768
> >> [  135.102362] min_free_kbytes is not updated to 11241 because user defined value 90000 is preferred
> 
> I am not sure if there is any value in printing the above line.  Especially
> in this context as it becomes obsolete with the printing of the next line.

The original intention was to make it explicit that auto-tuning is
influenced by the user provided configuration.

> >> [  135.109070] khugepaged: raising min_free_kbytes from 90000 to 90112 to help t
> >> ransparent hugepage allocations
> 
> IMO, the above line is the only one that should be output as a result of the
> recalculation.

Well, but khugepaged could be disabled and then the above might not get
printed. Sure the code could get reorganized and all that but is this
really worth that?

> I guess that brings up the question of 'should we continue to track the user
> defined value if we overwrite it?".  If we quit tracking it may help with the
> next message.

Auto tuning and user provided override is quite tricky to get sensible.
Especially in the case here. Admin has provided an override but has the
potential memory hotplug been considered? Or to make it even more
complicated, consider that the hotplug happens without admin involvement
- e.g. memory gets hotremoved due to HW problems. Is the admin provided
value still meaningful? To be honest I do not have a good answer and I
am not sure we should care all that much until we see practical
problems.
-- 
Michal Hocko
SUSE Labs
