Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C52C523A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbgKZKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:44:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731271AbgKZKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:44:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQAWFSD103024;
        Thu, 26 Nov 2020 05:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hdR+ae0kP4ATe3PbLi6XSYSCpaYF/SUoeIXoly5akqA=;
 b=LwdbjDF9kf33IKR3Q+jniJLc8d3nYVFlKaQ9ul4VcjBeSxjNOA77zBXK0AOMh6eTzz8Q
 /DwYu+w9gYQxbdPDttEjlcP5qopSUkN6yHeEkkLE+xFgHZNisx398CF+GMcoJRTiIFtl
 DNKlgEdeCuDwuaEulysWQIoWgdml5CSF5M1LQZKpnfldkV2NhG+Z4nVgR34tn+gMRl9K
 9Fo9EdbPTf5PHrnqQ24avXWb6LCknIeXXIGGtwbe6Nl0Evqrl/eauXRypy/Zhuwsrv+j
 5XnGsHP/w0IkF0zDR/XP8A+Rqf3p3nQ6K+4ofEYAc4lrYjErmlmSuVbQ5JULz024Q96z Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352am6rd7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 05:44:01 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AQAWvKd104695;
        Thu, 26 Nov 2020 05:44:01 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352am6rd5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 05:44:00 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQAgI3U026939;
        Thu, 26 Nov 2020 10:43:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 34xth8aun6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 10:43:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQAhuZ840763678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 10:43:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A6DE5204E;
        Thu, 26 Nov 2020 10:43:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4C4A852051;
        Thu, 26 Nov 2020 10:43:55 +0000 (GMT)
Date:   Thu, 26 Nov 2020 12:43:53 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201126104353.GR123287@linux.ibm.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <X73s8fxDKPRD6wET@redhat.com>
 <X78jpOqo+IVq1Fn+@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X78jpOqo+IVq1Fn+@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_03:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=56 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:40:20PM -0500, Andrea Arcangeli wrote:
> On Wed, Nov 25, 2020 at 12:34:41AM -0500, Andrea Arcangeli wrote:
> 
> Summary: both old code (missing PG_reserved) and the current code
> (leaving the page struct uninitialized and with wrong nodeid/nid) look
> wrong.
> 
> Overall this brings more questions:
> 
> - why memblock.reserved exists and isn't automatically calculated as
>   inversion of memblock.memory? (or if you prefer: why is the above
>   call to memblock_reserve needed to initialize the memory holes?)

memblock.reserved represents memory areas that were allocated before
page allocator is up. This could be memory reported by firmware as
resrved, kernel image, initrd, and any memory kernel allocates before
page allocator is ready.

> - why there's no initialization of the memblock.reserved regions given
>   they exists, was it just an oversight? (this one is fixed by Mike's
>   patch, although I wish it was possible to drop the function
>   memblock_reserve instead)

It was an oversight when I posted
73a6e474cb376921a311786652782155eac2fdf0. I overlooked the fact that x86
does not consider memory allocated by firmware as memory and only parts
of it are considred reserved.

> - what can we do instead of setting the uninitialized nodeid/nid to
>   0,0 and to reliably detect at boot if some page structure within
>   zones (but ideally also outside the zone boundary for any pfn where
>   pfn_valid returns true) is left uninitialized, as it is happening
>   currently on the e820 type 20 range?

I think that we need to fix the e820 and memblock interaction at the
first place. The "non-RAM" holes reported as various types other than
E820_TYPE_RAM are actually seem to be "RAM that firmware grabbed for
itself", so they should be seen by the system as such, like in all other
architectures.
For the regions that cannot be mapped, like those on HPE UV (was it
SGI?) systems, we have MEMBLOCK_NOMAP exactly for that purpose.

Once this is done, we can straihgten logic around memmap intialization
in page_alloc, and I feel it will get simpler that today in the end.

> Thanks,
> Andrea

-- 
Sincerely yours,
Mike.
