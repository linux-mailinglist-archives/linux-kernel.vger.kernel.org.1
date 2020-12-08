Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D972D20D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgLHC3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:29:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:29:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B82PFhO175146;
        Tue, 8 Dec 2020 02:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=NWKyHUi7PYTSOlwujvcie0KSCx6tBO6Zs/Me8zeBfwo=;
 b=SqljVh79ZJ7JIofga3LSjYd6IlNV7jnTrcUJHU5zUO3RA5Si9GVMj8fMeL+2rv00S+DP
 WB9EGT43pi3z8uk2PBXpZNy9bT4NpCf6hYT7ccIpKSiA9xgptpiJZ3B4NhvAmMmBlbRO
 UqlueZsNeej8zQ32WLE7/12hGYFUIB5unH86wajP3VwHGqjb9RW+/+1R4Ul1e9Ye6Ip7
 rD0Iac24aDDSFsQb/ggvCXfWmgF7fPMltgxAM5oH48cRqjmK1R46abT0rw41Gg1toAzq
 vU4gvFQkgpyC2mC3DcPBJXf8mjhaUknHJgOOXqs5a5IhpQJ6qZAi3uSa7giA3zdgEdL+ iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35825m0gk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 02:27:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B82OkZ4078161;
        Tue, 8 Dec 2020 02:27:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 358ksmy0fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 02:27:31 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B82RQfx029524;
        Tue, 8 Dec 2020 02:27:26 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 18:27:25 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
In-Reply-To: <CA+CK2bARYtSgkZTtMMFGB9kT4QZ_RgASW2wQ0Ro5_TXPddSung@mail.gmail.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca> <87360lnxph.fsf@oracle.com>
 <CA+CK2bARYtSgkZTtMMFGB9kT4QZ_RgASW2wQ0Ro5_TXPddSung@mail.gmail.com>
Date:   Mon, 07 Dec 2020 21:27:20 -0500
Message-ID: <87zh2phw1j.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Tatashin <pasha.tatashin@soleen.com> writes:

> On Fri, Dec 4, 2020 at 3:06 PM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>>
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>
>> > On Wed, Dec 02, 2020 at 08:34:32PM -0500, Pavel Tatashin wrote:
>> >> What I meant is the users of the interface do it incrementally not in
>> >> large chunks. For example:
>> >>
>> >> vfio_pin_pages_remote
>> >>    vaddr_get_pfn
>> >>         ret = pin_user_pages_remote(mm, vaddr, 1, flags |
>> >> FOLL_LONGTERM, page, NULL, NULL);
>> >> 1 -> pin only one pages at a time
>> >
>> > I don't know why vfio does this, it is why it so ridiculously slow at
>> > least.
>>
>> Well Alex can correct me, but I went digging and a comment from the
>> first type1 vfio commit says the iommu API didn't promise to unmap
>> subpages of previous mappings, so doing page at a time gave flexibility
>> at the cost of inefficiency.
>>
>> Then 166fd7d94afd allowed the iommu to use larger pages in vfio, but
>> vfio kept pinning pages at a time.  I couldn't find an explanation for
>> why that stayed the same.
>>
>> Yesterday I tried optimizing vfio to skip gup calls for tail pages after
>> Matthew pointed out this same issue to me by coincidence last week.
>> Currently debugging, but if there's a fundamental reason this won't work
>> on the vfio side, it'd be nice to know.
>
> Hi Daniel,
>
> I do not think there are any fundamental reasons why it won't work. I
> have also thinking increasing VFIO chunking for a different reason:
>
> If a client touches pages before doing a VFIO DMA map, those pages
> might be huge, and pinning a small page at a time and migrating a
> small page at a time can break-up the huge pages. So, it is not only
> inefficient to pin, but it can also inadvertently slow down the
> runtime.

Hi Pasha,

I see, and I'm curious, do you experience this case where a user has
touched the pages before doing a VFIO DMA map, and if so where?

The usual situation on my side is that the pages are faulted in during
pinning.

Daniel
