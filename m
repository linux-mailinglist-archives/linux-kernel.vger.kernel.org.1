Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB73F2B8CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgKSICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:02:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:39746 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgKSICy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:02:54 -0500
IronPort-SDR: vwyxxlJi7AqzKKGpk/v2wVoMQZxLx//kehW9xu/22weM62D8TRGnnVbFcD/KjCZMx6pq6VSigT
 gr9o3u+cGq4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="255959835"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="255959835"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 00:02:53 -0800
IronPort-SDR: YZIJXDj6Oc005giTLdXw/6wZC7V4AznSc3jfbXisgAILn9ikzw9e1hZAqFL3LjOh1ug57IEMYl
 OCv9qRKSdiWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="359862232"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2020 00:02:49 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC -V5] autonuma: Migrate on fault among multiple bound nodes
References: <20201118051952.39097-1-ying.huang@intel.com>
        <20201118095637.GC3306@suse.de> <878saxvpji.fsf@yhuang-dev.intel.com>
        <20201119075052.GF3306@suse.de>
Date:   Thu, 19 Nov 2020 16:02:48 +0800
In-Reply-To: <20201119075052.GF3306@suse.de> (Mel Gorman's message of "Thu, 19
        Nov 2020 07:50:52 +0000")
Message-ID: <874kllvknr.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Thu, Nov 19, 2020 at 02:17:21PM +0800, Huang, Ying wrote:
>> >> Various page placement optimization based on the NUMA balancing can be
>> >> done with these flags.  As the first step, in this patch, if the
>> >> memory of the application is bound to multiple nodes (MPOL_BIND), and
>> >> in the hint page fault handler the accessing node are in the policy
>> >> nodemask, the page will be tried to be migrated to the accessing node
>> >> to reduce the cross-node accessing.
>> >> 
>> >
>> > The patch still lacks supporting data. It really should have a basic
>> > benchmark of some sort serving as an example of how the policies should
>> > be set and a before/after comparison showing the throughput of MPOL_BIND
>> > accesses spanning 2 or more nodes is faster when numa balancing is enabled.
>> 
>> Sure.  Will add some basic benchmark data and usage example.
>> 
>
> Thanks
>
>> > A man page update should also be added clearly outlining when an
>> > application should consider using it with the linux-api people cc'd
>> > for review.
>> 
>> Yes.  Will Cc linux-api for review and will submit patches to
>> manpages.git after the API is finalized.
>> 
>
> Add the manpages patch to this series. While it is not merged through
> the kernel, it's important for review purposes.
>
>> > The main limitation is that if this requires application modification,
>> > it may never be used. For example, if an application uses openmp places
>> > that translates into bind then openmp needs knowledge of the flag.
>> > Similar limitations apply to MPI. This feature has a risk that no one
>> > uses it.
>> 
>> My plan is to add a new option to `numactl`
>> (https://github.com/numactl/numactl/), so users who want to enable NUMA
>> balancing within the constrains of NUMA binding can use that.  I can
>> reach some Openstack and Kubernate developers to check whether it's
>> possible to add the support to these software.  For other applications,
>> Yes, it may take long time for the new flag to be used.
>> 
>
> Patch for numactl should also be included to see what it looks like in
> practice. Document what happens if the flag does not exist in the
> running kernel.
>
> I know this is awkward, but it's an interface exposed to userspace and
> as it is expected that applications will exist that then try run on
> older kernels, it needs to be very up-front about what happens on older
> kernels. It would not be a complete surprise for openmp and openmpi
> packages to be updated on distributions with older kernels (either by
> source or via packaging) leading to surprises.

Sure.  I understand that we should be careful about the user space
interface.  I will send out a new version together with the man pages
and numactl patches with all your comments addressed.

Best Regards,
Huang, Ying
