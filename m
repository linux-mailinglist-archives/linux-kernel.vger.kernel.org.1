Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E050326A0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgIOIWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:22:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgIOISv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:18:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2FFEB042;
        Tue, 15 Sep 2020 08:18:48 +0000 (UTC)
Date:   Tue, 15 Sep 2020 10:18:32 +0200
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
Message-ID: <20200915081832.GA4649@dhcp22.suse.cz>
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200914143312.GU16999@dhcp22.suse.cz>
 <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 09:57:02, Vijay Balakrishna wrote:
> 
> 
> On 9/14/2020 7:33 AM, Michal Hocko wrote:
> > On Thu 10-09-20 13:47:39, Vijay Balakrishna wrote:
> > > When memory is hotplug added or removed the min_free_kbytes must be
> > > recalculated based on what is expected by khugepaged.  Currently
> > > after hotplug, min_free_kbytes will be set to a lower default and higher
> > > default set when THP enabled is lost. This leaves the system with small
> > > min_free_kbytes which isn't suitable for systems especially with network
> > > intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
> > > soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
> > > kills.
> > 
> > Care to explain some more please? The whole point of increasing
> > min_free_kbytes for THP is to get a larger free memory with a hope that
> > huge pages will be more likely to appear. While this might help for
> > other users that need a high order pages it is definitely not the
> > primary reason behind it. Could you provide an example with some more
> > data?
> 
> Thanks Michal.  I haven't looked into THP as part of my investigation, so I
> cannot comment.
> 
> In our use case we are hotplug removing ~2GB of 8GB total (on our SoC)
> during normal reboot/shutdown.  This memory is hotplug hot-added as movable
> type via systemd late service during start-of-day.
> 
> In our stress test first we ran into HW WATCHDOG recovery, on enabling
> kernel watchdog we started seeing soft lockup hung task notices, failure
> symptons varied, where stack trace of hung tasks sometimes trying to
> allocate GFP_ATOMIC memory, looping in do_notify_resume, NETDEVICE WATCHDOG
> timeouts, OOM process kills etc.,  During investigation we reran stress test
> without hotplug use case.  Surprisingly this run didn't encounter the said
> problems.  This led to comparing what is different between the two runs,
> while looking at various globals, studying hotplug code I uncovered the
> issue of failing to restore min_free_kbytes.  In particular on our 8GB SoC
> min_free_kbytes went down to 8703 from 22528 after hotplug add.

Did you try to increase min_free_kbytes manually after hot remove? Btw.
I would consider oom killer invocation due to min_free_kbytes really
weird behavior. If anything the higher value would cause more memory
reclaim and potentially oom rather than smaller one.
-- 
Michal Hocko
SUSE Labs
