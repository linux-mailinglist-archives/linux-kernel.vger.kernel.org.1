Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048E62A2362
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 04:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgKBDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 22:13:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:19556 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbgKBDNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 22:13:04 -0500
IronPort-SDR: hOKMxn9GTPic22mnSb5+7JlR16HtmNFRJyb+m9RmRKmmjf+VQ6YFxqiTEFrpv3wOuXVgzAY45b
 /nXD2jcYxTMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="230460994"
X-IronPort-AV: E=Sophos;i="5.77,443,1596524400"; 
   d="scan'208";a="230460994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 19:13:03 -0800
IronPort-SDR: 5gX2M2wQ2E/bMzor+MzEme7Qe5OW7FA2S/TTu3wMiM4yQE9k3eCC34yEhWKpkRYPkAUyBn5asV
 UggHdcEoC/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,443,1596524400"; 
   d="scan'208";a="352595676"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2020 19:13:00 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH -V2 1/2] mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
References: <20201028023411.15045-1-ying.huang@intel.com>
        <20201028023411.15045-2-ying.huang@intel.com>
        <20201029090421.GC17500@dhcp22.suse.cz>
        <87h7qcxjew.fsf@yhuang-dev.intel.com>
        <20201030082517.GD1478@dhcp22.suse.cz>
Date:   Mon, 02 Nov 2020 11:12:59 +0800
In-Reply-To: <20201030082517.GD1478@dhcp22.suse.cz> (Michal Hocko's message of
        "Fri, 30 Oct 2020 09:25:17 +0100")
Message-ID: <87d00wxxhg.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Fri 30-10-20 15:27:51, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Wed 28-10-20 10:34:10, Huang Ying wrote:
>> >> To follow code-of-conduct better.
>> >
>> > This is changing a user visible interface and any userspace which refers
>> > to the existing name will fail to compile unless I am missing something.
>> 
>> Although these flags are put in uapi, I found these flags are actually
>> internal flags used in "flags" field of struct mempolicy, they are never
>> used as flags for any user space API.  I guess they are placed in uapi
>> header file to guarantee they aren't conflict with MPOL_MODE_FLAGS.
>
> You are right. I have missed that. The comment in the header even explains
> that. Anyway the placement is rather unusual and I think that those
> flags do not belong there.
>  
>> > Have you checked how many applications would be affected?
>> 
>> Based on above analysis, I think there is no application that will be
>> affected.
>> 
>> > Btw I find "follow CoC better" a very weak argument without further
>> > explanation.
>> 
>> That is the only reason for the patch.  If nobody thinks the change is
>> necessary, I can just drop the patch.
>
> Well, to be honest I do not see any problem with the naming.

This is a capitalized words and prefixed, so most people think it's OK.
And in PATCH 2/2, there's a newly added label,

mopron:

Which may become

moron:

some people think that we'd better to change it.  And to make the wording
consistent, the constant is changed too.

Best Regards,
Huang, Ying
