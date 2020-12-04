Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6392CF549
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgLDUHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:07:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47338 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:07:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4Jn5jc076980;
        Fri, 4 Dec 2020 20:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=QuZr977AjBYzbv+upnrOJsmyj3o07WB2T8vvWfzyq3E=;
 b=yUW1NLr55pB5u3wF/KjZKkRo7CjTpdkUIlkGHdwqHOgvKbCKgk/uou6QL+l2nHTqcIBh
 ZWNONdZ5G9/7o6dITR2ZiLfoBJp1KhJCww8N2iiI2PfXi1xlehsxXnRamvknMI3vTqTE
 +pMODnUvB2Ssr2m/rLwMzBc6d4Jxn8ufqHuevYeytVlsLgEc97Vv70HHghsOKfBx/CnZ
 OP4fiW52GSF8J1ZacpKckHhJ0c4hJtf5UzpAvHECjhSGHMT+l86hzeYYJ0+1URmI8Wei
 6b+YSan2lRiPsqbvhPrVyhA2kP56IidMslg/y6WnmYy33nbP/whnQJuQn9U0sN7SR4wA FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egm4wdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Dec 2020 20:05:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4JoREc083330;
        Fri, 4 Dec 2020 20:05:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3540ayjm1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Dec 2020 20:05:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B4K5sAe022512;
        Fri, 4 Dec 2020 20:05:55 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Dec 2020 12:05:51 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Alex Williamson <alex.williamson@redhat.com>
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
In-Reply-To: <20201203141729.GS5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca>
Date:   Fri, 04 Dec 2020 15:05:46 -0500
Message-ID: <87360lnxph.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9825 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9825 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012040114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Dec 02, 2020 at 08:34:32PM -0500, Pavel Tatashin wrote:
>> What I meant is the users of the interface do it incrementally not in
>> large chunks. For example:
>> 
>> vfio_pin_pages_remote
>>    vaddr_get_pfn
>>         ret = pin_user_pages_remote(mm, vaddr, 1, flags |
>> FOLL_LONGTERM, page, NULL, NULL);
>> 1 -> pin only one pages at a time
>
> I don't know why vfio does this, it is why it so ridiculously slow at
> least.

Well Alex can correct me, but I went digging and a comment from the
first type1 vfio commit says the iommu API didn't promise to unmap
subpages of previous mappings, so doing page at a time gave flexibility
at the cost of inefficiency.

Then 166fd7d94afd allowed the iommu to use larger pages in vfio, but
vfio kept pinning pages at a time.  I couldn't find an explanation for
why that stayed the same.

Yesterday I tried optimizing vfio to skip gup calls for tail pages after
Matthew pointed out this same issue to me by coincidence last week.
Currently debugging, but if there's a fundamental reason this won't work
on the vfio side, it'd be nice to know.
