Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141412B7E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgKRNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:49:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:46762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbgKRNty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:49:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FABBAC90;
        Wed, 18 Nov 2020 13:49:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3D86C1E130B; Wed, 18 Nov 2020 14:49:52 +0100 (CET)
Date:   Wed, 18 Nov 2020 14:49:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, guobing.chen@intel.com,
        ming.a.chen@intel.com, frank.du@intel.com, Shuhua.Fan@intel.com,
        wangyang.guo@intel.com, Wenhuan.Huang@intel.com,
        jessica.ji@intel.com, shan.kang@intel.com, guangli.li@intel.com,
        tiejun.li@intel.com, yu.ma@intel.com, dapeng1.mi@intel.com,
        jiebin.sun@intel.com, gengxin.xie@intel.com, fan.zhao@intel.com
Subject: Re: [mm/gup] 47e29d32af: phoronix-test-suite.npb.FT.A.total_mop_s
 -45.0% regression
Message-ID: <20201118134952.GE1981@quack2.suse.cz>
References: <20201117024825.GA8169@xsang-OptiPlex-9020>
 <24d9d093-5b7a-9aee-8d61-59c0007a9269@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d9d093-5b7a-9aee-8d61-59c0007a9269@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-11-20 19:35:31, John Hubbard wrote:
> 
> On 11/16/20 6:48 PM, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed a -45.0% regression of phoronix-test-suite.npb.FT.A.total_mop_s due to commit:
> > 
> 
> That's a huge slowdown...
> 
> > 
> > commit: 47e29d32afba11b13efb51f03154a8cf22fb4360 ("mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> ...but that commit happened in April, 2020. Surely if this were a serious
> issue we would have some other indication...is this worth following up
> on?? I'm inclined to ignore it, honestly.

Why this was detected so late is a fair question although it doesn't quite
invalidate the report... The NPB benchmark appears to be a supercomputing
benchmark so concievably it could be heavily using THPs. The question is
why it would be a heavy user of pinning as well but even that is imaginable
considering that MPI is in use etc.

So maybe it is worth trying to reproduce this because heavy THP + pinning
users might be indeed rare and only those would show regressions in THP
pinning performance...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
