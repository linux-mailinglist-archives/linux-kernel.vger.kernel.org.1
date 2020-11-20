Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1B2BA065
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgKTC22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:28:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:43320 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgKTC22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:28:28 -0500
IronPort-SDR: 6GrYfy0T4dWbtDZL+2IUp7nH8E0IPY18BQ5Iya/teDHSIWciuwqjBEdywGNpm9HT09hTh0u+Wf
 ZH4o2A7EjOwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="233020669"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="233020669"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:28:27 -0800
IronPort-SDR: LYLZFbIpxeWq8Zh281iXmWRS3BKvfgEYmEAWRrj5EfIgFBr+KVuRyqJ3pf+1qOelsAC8i1m8Ak
 ROlsVR4Oh4cA==
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="545268237"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:28:18 -0800
Date:   Fri, 20 Nov 2020 10:42:35 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        feng tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@intel.com>,
        guobing.chen@intel.com, ming.a.chen@intel.com, frank.du@intel.com,
        Shuhua.Fan@intel.com, wangyang.guo@intel.com,
        Wenhuan.Huang@intel.com, jessica.ji@intel.com, shan.kang@intel.com,
        guangli.li@intel.com, tiejun.li@intel.com, yu.ma@intel.com,
        dapeng1.mi@intel.com, jiebin.sun@intel.com, gengxin.xie@intel.com,
        fan.zhao@intel.com, philip.li@intel.com
Subject: Re: [mm/gup] 47e29d32af: phoronix-test-suite.npb.FT.A.total_mop_s
 -45.0% regression
Message-ID: <20201120024235.GA4755@xsang-OptiPlex-9020>
References: <20201117024825.GA8169@xsang-OptiPlex-9020>
 <24d9d093-5b7a-9aee-8d61-59c0007a9269@nvidia.com>
 <20201118134952.GE1981@quack2.suse.cz>
 <CAPcyv4g=MFAojCeCST+sF22A+2cetVMFmQuDtu7arEM+0a+Ebw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g=MFAojCeCST+sF22A+2cetVMFmQuDtu7arEM+0a+Ebw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:17:27AM -0800, Dan Williams wrote:
> On Wed, Nov 18, 2020 at 5:51 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 16-11-20 19:35:31, John Hubbard wrote:
> > >
> > > On 11/16/20 6:48 PM, kernel test robot wrote:
> > > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed a -45.0% regression of phoronix-test-suite.npb.FT.A.total_mop_s due to commit:
> > > >
> > >
> > > That's a huge slowdown...
> > >
> > > >
> > > > commit: 47e29d32afba11b13efb51f03154a8cf22fb4360 ("mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > ...but that commit happened in April, 2020. Surely if this were a serious
> > > issue we would have some other indication...is this worth following up
> > > on?? I'm inclined to ignore it, honestly.
> >
> > Why this was detected so late is a fair question although it doesn't quite
> > invalidate the report...
> 
> I don't know what specifically happened in this case, perhaps someone
> from the lkp team can comment? 

- some extra phoronix test suites are enabled/fixed gradually so we will have
better coverage
- we scan kernel releases within the year to baseline the performance, it may
trigger bisection if one release has regressed and not recovered.

With this continuous effort, 0-day ci can detect the changes on mainline.

> However, the myth / contention that
> "surely someone else would have noticed by now" is why the lkp project
> was launched. Kernels regressed without much complaint and it wasn't
> until much later in the process, around the time enterprise distros
> rebased to new kernels, did end users start filing performance loss
> regression reports. Given -stable kernel releases, 6-7 months is still
> faster than many end user upgrade cycles to new kernel baselines.
