Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64A12D212A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgLHCwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:52:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgLHCwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:52:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B82nreB098678;
        Tue, 8 Dec 2020 02:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=iT75PEr74+22T8OxtC1oHxs5BBlW6iP/VhqAfwjey4U=;
 b=KTWKv6gq1d6evY6A5bLK9N7H+MIOhHRKLW3Sylcxd8sIgMU6jWRhGvGFkcLbk6SpWfST
 aYO/NU/FyagY88KAyA4zqCeOdWXYeVud6wJVXzQtoigLxzUOWInpQ/lHltiWw415LLOZ
 ysx3AOFrx2wXO5josSk/O7qE58jXPSDIrHyidQtP9LH9IKUnukrQpywGTigWCtxM6mEr
 1X3sWuUCSfkFNaEl2swshhWOhxhKb4EEQcaKCfFDFEEXxVolCp41p/JM+k90XKnZfntA
 UMsTPH0Vx80NHbH3LyjE1G/YqmBQKmNOOlvHA0pwl9WqNWGZpQxOXRlETluorNew+X7X eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3581mqrgu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 02:51:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B82kSjN090694;
        Tue, 8 Dec 2020 02:48:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 358m3x4ek1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 02:48:59 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B82mskI003262;
        Tue, 8 Dec 2020 02:48:54 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 18:48:53 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
In-Reply-To: <20201204205233.GF5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca> <87360lnxph.fsf@oracle.com>
 <20201204205233.GF5487@ziepe.ca>
Date:   Mon, 07 Dec 2020 21:48:48 -0500
Message-ID: <87k0ttrp0v.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gunthorpe <jgg@ziepe.ca> writes:
> On Fri, Dec 04, 2020 at 03:05:46PM -0500, Daniel Jordan wrote:
>> Well Alex can correct me, but I went digging and a comment from the
>> first type1 vfio commit says the iommu API didn't promise to unmap
>> subpages of previous mappings, so doing page at a time gave flexibility
>> at the cost of inefficiency.
>
> iommu restrictions are not related to with gup. vfio needs to get the
> page list from the page tables as efficiently as possible, then you
> break it up into what you want to feed into the IOMMU how the iommu
> wants.
>
> vfio must maintain a page list to call unpin_user_pages() anyhow, so

It does in some cases but not others, namely the expensive
VFIO_IOMMU_MAP_DMA/UNMAP_DMA path where the iommu page tables are used
to find the pfns when unpinning.

I don't see why vfio couldn't do as you say, though, and the worst case
memory overhead of using scatterlist to remember the pfns of a 300g VM
backed by huge but physically discontiguous pages is only a few meg, not
bad at all.

> it makes alot of sense to assemble the page list up front, then do the
> iommu, instead of trying to do both things page at a time.
>
> It would be smart to rebuild vfio to use scatter lists to store the
> page list and then break the sgl into pages for iommu
> configuration. SGLs will consume alot less memory for the usual case
> of THPs backing the VFIO registrations.
>
> ib_umem_get() has some example of how to code this, I've been thinking
> we could make this some common API, and it could be further optimized.

Agreed, great suggestions, both above and in the rest of your response.

>> Yesterday I tried optimizing vfio to skip gup calls for tail pages after
>> Matthew pointed out this same issue to me by coincidence last week.
>
> Please don't just hack up vfio like this.

Yeah, you've cured me of that idea.  I'll see where I get experimenting
with some of this stuff.
