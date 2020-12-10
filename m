Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794502D63EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392901AbgLJRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:45:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:37743 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392891AbgLJRpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:45:14 -0500
IronPort-SDR: KNNR2EFFxvgR5D0ULdn0YwrSEZFnu2mtbJSl6XaHkC6Gamuh4wSCaj/yb76OqQOOFwZxzwn0ah
 /hhXuOId4pXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="154109160"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="154109160"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:44:32 -0800
IronPort-SDR: g09TXIVfLUoyfcVyh7/KNNjhRNq8RoLBtET2ilGBuQ/qIAx5WtulmzIeiJNiZ4zUXea+34HOtt
 YhFUAwKTL0ig==
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="348897090"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:44:31 -0800
Date:   Thu, 10 Dec 2020 09:44:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] mm/gup: make __gup_longterm_locked common
Message-ID: <20201210174431.GT1563847@iweiny-DESK2.sc.intel.com>
References: <20201210004335.64634-1-pasha.tatashin@soleen.com>
 <20201210004335.64634-4-pasha.tatashin@soleen.com>
 <20201210040618.GR1563847@iweiny-DESK2.sc.intel.com>
 <CA+CK2bCVEnKKatQSxZcdcvNo+9rWNrGWXyLS3dnF-y7=5Ery7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCVEnKKatQSxZcdcvNo+9rWNrGWXyLS3dnF-y7=5Ery7g@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 08:30:03AM -0500, Pavel Tatashin wrote:
> On Wed, Dec 9, 2020 at 11:06 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Wed, Dec 09, 2020 at 07:43:30PM -0500, Pavel Tatashin wrote:
> > > __gup_longterm_locked() has CMA || FS_DAX version and a common stub
> > > version. In the preparation of prohibiting longterm pinning of pages from
> > > movable zone make the CMA || FS_DAX version common, and delete the stub
> > > version.
> >
> > I thought Jason sent a patch which got rid of this as well?
> 
> Yes, this series applies on the mainline so it can be easily tested.
> The next version, I will sync with linux-next.

Oh yea we wanted this to be back-portable correct?

If so, LGTM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Sorry for not keeping up,
Ira
