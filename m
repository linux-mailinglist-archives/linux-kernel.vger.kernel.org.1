Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EA2C5CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405279AbgKZTop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 14:44:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404817AbgKZTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:44:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQJWDHs053867;
        Thu, 26 Nov 2020 14:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=k/m6V5N+h4BhWiV5k+PX3XPFR5YAIshVlQ2vREx5FiI=;
 b=mBw4mpILpQjiz6L53h9J7NnQ4UqorK4GV3o5qVtO/yHD5TczsnaBna0GTW7XxW88r49r
 NkeOV+zygiiGbog1EtwUJcS2NORak23lJdtKJY+O3poAr8np8lLFmtoqEK/ZcgFpHYHl
 SasdusOEgWduRDw78kWsB/eseeKXXqOWl4n3ScAylkgakKO9+fiy4DJptL8hQI/nd+T2
 ZZWRP5ScCaUgyDTksIUfBPMhGf0pTTwsISoSCH2xxoQ3R3+JmT14Ro9atxEJ5WI/7++/
 427fwJcxlKrux2X4ls8yMDvQiiYiMSxqai6rlgsJQKaTd9cu6xc2N+HfZ1xZ8Q4v9cG7 ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 352ft149uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 14:44:35 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AQJiZgj095455;
        Thu, 26 Nov 2020 14:44:35 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 352ft149u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 14:44:35 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQJYcG7000565;
        Thu, 26 Nov 2020 19:44:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 352drkg572-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 19:44:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQJiVIP4719340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 19:44:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34ADD42041;
        Thu, 26 Nov 2020 19:44:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D024B4203F;
        Thu, 26 Nov 2020 19:44:28 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Nov 2020 19:44:28 +0000 (GMT)
Date:   Thu, 26 Nov 2020 21:44:26 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201126194426.GU123287@linux.ibm.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <X7/0CmrPwjq9LDUj@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7/0CmrPwjq9LDUj@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_08:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 01:29:30PM -0500, Andrea Arcangeli wrote:
> On Thu, Nov 26, 2020 at 11:36:02AM +0200, Mike Rapoport wrote:
> > memory.reserved cannot be calculated automatically. It represents all
> > the memory allocations made before page allocator is up. And as
> > memblock_reserve() is the most basic to allocate memory early at boot we
> > cannot really delete it ;-)
> 
> Well this explanation totally covers "memory allocated early at
> boot" that overlaps with memblock.memory.
> 
> Does the E820_TYPE_SOFT_RESERVED range added to memblock.reserve
> define as "memory allocated early at boot"?
> 
> Does it overlap ranges added with any RAM added to memblock.memory?
> 
> 		if (entry->type == E820_TYPE_SOFT_RESERVED)
> 			memblock_reserve(entry->addr, entry->size);
> 
> 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> 			continue;
> 
> 		memblock_add(entry->addr, entry->size);
> 
> To me the above looks it's being used for something completely
> different than from reserving "memory allocated early at boot".
> 
> Why there is no warning at boot if there's no overlap between
> memblock.resereve and memblock.memory?

> My question about memblock.reserve is really about the non overlapping
> ranges: why are ranges non overlapping with memblock.memory regions,
> added to memblock.reserve, and why aren't those calculated
> automatically as reverse of memblock.memory?

Once there was this comment in arch/x86/kernel/e820.c:

	/*
	 * all !E820_TYPE_RAM ranges (including gap ranges) are put
	 * into memblock.reserved to make sure that struct pages in
	 * such regions are not left uninitialized after bootup.
	 */

I presume there were struct pages that corresponded to some unusable
memory and they were not initilized, so the solution was to add them to
memblock.reserved.

> It's easy to see that when memblock.reserve overlaps fully, it makes
> perfect sense and it has to stay for it. I was really only thinking at
> the usage like above of memblock_reserve that looks like it should be
> turned into a noop and deleted.

TBH, the whole interaction between e820 and memblock keeps me puzzled
and I can only make educated guesses why some ranges here are
memblock_reserve()'d and some memblock_add()ed.

I think what should be there is that e820 entries that are essentially
RAM, used by BIOS or not, should be listed in memblock.memory. Then
using memblock_reserve() for parts that BIOS claimed for itself would
have the same semantics as for memory allocated by kernel.

I.e. if there is a DIMM from 0 to, say 512M, memblock.memory will have a
range [0, 512M]. And areas such as 0x000-0xfff, 0x9d000-0x9ffff will be
in memblock.reserved.

Than in page_alloc.c we'll know that we have a physical memory bank from
0 to 512M but there are some ranges that we cannot use.

I suggested it back then when the issue with compaction was reported at
the first time, but Baoquan mentioned that there are systems that cannot
even tolerate having BIOS reserved areas in the page tables and I didn't
continue to pursue this.

Now I'm thinking to resurrect this patch with some additions so that
init_mem_mapping could skip such regions.

[1] https://lore.kernel.org/lkml/20200528090731.GI20045@MiWiFi-R3L-srv/#t


> Thanks,
> Andrea
> 

-- 
Sincerely yours,
Mike.
