Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A2A2C497F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgKYVEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:04:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728622AbgKYVEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:04:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APL2TNo003301;
        Wed, 25 Nov 2020 16:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sy/ZQzr8x3n93eziZ9EheOK1LOAyh8IWJnZiQJqqAs8=;
 b=CBHDZYZ3/EDiMWKoW6nta7993XgKZtfXMJ3hJLXXmj8aEPWTpQ7C+1zD2FKaSGfo/ZJc
 Vha7knirueFs4QLFfYaI2BAsbMn8vhQ5e3kRXNKb8tKlW3D97dRM6Bt2mLuArdNXVXAu
 MSB0AAzIvBe1fAPJg4R9Ya52Nl4k4NA1sCu8IP/fIa0mY+B4Cp5x/dPjx+T6FjuLPtiq
 SsU1KYonswiD+ksPgZWMyTVD/u0GgkZfGvMNKNaBDX0PsnZB+rVWLXPUo/StgWlySAll
 3CKJuDZmiXdof/XNQ7tluPxyK81Hi7SCVQCNXKbcmiltjh5mkrIXqBD5IcGrAxevhp4W pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 351ry9u7xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 16:04:24 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0APL3W0i009246;
        Wed, 25 Nov 2020 16:04:23 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 351ry9u7x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 16:04:23 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0APL3NSc023891;
        Wed, 25 Nov 2020 21:04:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 351pca077n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 21:04:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0APL4JZN9175800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 21:04:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9344C42047;
        Wed, 25 Nov 2020 21:04:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF7264204B;
        Wed, 25 Nov 2020 21:04:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Nov 2020 21:04:17 +0000 (GMT)
Date:   Wed, 25 Nov 2020 23:04:14 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201125210414.GO123287@linux.ibm.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_12:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 08:27:21PM +0100, David Hildenbrand wrote:
> On 25.11.20 19:28, Andrea Arcangeli wrote:
> > On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
> >
> > What would need to call pfn_zone in between first and second stage?
> > 
> > If something calls pfn_zone in between first and second stage isn't it
> > a feature if it crashes the kernel at boot?
> > 
> > Note: I suggested 0xff kernel crashing "until the second stage comes
> > around" during meminit at boot, not permanently.
> 
> Yes, then it makes sense - if we're able to come up with a way to
> initialize any memmap we might have - including actual memory holes that
> have a memmap.
> 
> > 
> > 		/*
> > 		 * Use a fake node/zone (0) for now. Some of these pages
> > 		 * (in memblock.reserved but not in memblock.memory) will
> > 		 * get re-initialized via reserve_bootmem_region() later.
> > 		 */
> > 
> > Specifically I relied on the comment "get re-initialized via
> > reserve_bootmem_region() later".
> 
> Yes, but there is a "Some of these" :)
> 
> Boot a VM with "-M 4000" and observe the memmap in the last section -
> they won't get initialized a second time.
> 
> > 
> > I assumed the second stage overwrites the 0,0 to the real zoneid/nid
> > value, which is clearly not happening, hence it'd be preferable to get
> > a crash at boot reliably.
> > 
> > Now I have CONFIG_DEFERRED_STRUCT_PAGE_INIT=n so the second stage
> > calling init_reserved_page(start_pfn) won't do much with
> > CONFIG_DEFERRED_STRUCT_PAGE_INIT=n but I already tried to enable
> > CONFIG_DEFERRED_STRUCT_PAGE_INIT=y yesterday and it didn't help, the
> > page->flags were still wrong for reserved pages in the "Unknown E820
> > type" region.

I think the very root cause is how e820__memblock_setup() registers
memory with memblock:

		if (entry->type == E820_TYPE_SOFT_RESERVED)
			memblock_reserve(entry->addr, entry->size);

		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
			continue;

		memblock_add(entry->addr, entry->size);

From that point the system has inconsistent view of RAM in both
memblock.memory and memblock.reserved and, which is then translated to
memmap etc.

Unfortunately, simply adding all RAM to memblock is not possible as
there are systems that for them "the addresses listed in the reserved
range must never be accessed, or (as we discovered) even be reachable by
an active page table entry" [1].

[1] https://lore.kernel.org/lkml/20200528151510.GA6154@raspberrypi/

-- 
Sincerely yours,
Mike.
