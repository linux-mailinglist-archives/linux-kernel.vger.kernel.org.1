Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061CB2C5D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgKZVDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:03:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62776 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729883AbgKZVDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:03:53 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQL1fhI036524;
        Thu, 26 Nov 2020 16:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WUm3QfNBoQBUDRZaGfULfk2RpE5wqxYar8ZJQW55jm8=;
 b=qz2LX8jaK22utu4gvcDS8QnB9hsR7uvMmmSKPMFLoPBdfnObdVGW5wIdcw4JmygLMJHA
 7lDH8QEy3OYrQmuGIxk86921nPfP3fdyd5tN8itSK0xrwEvGfC5LtknCTK1eBf0stKA+
 1KDnnynVdkhe+sQKSSUebk+3ZR7ocRpA76hYz4r9U54YAuLL6Ta4keS/Kotg3ys7hMfk
 UVSnegqFg/e5koTobXnbQCYUIOHE1MRh2vaxABLtqaTLQBhHxuQva3fe2+6ta/FLsjb8
 jLo2n5bI0TzXepcGkejRyCniPi7p9qCnxX6m0zALC5LXTbskbpsOXiYx/7liahY24gwB Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352hj2atg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 16:03:44 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AQL1hbk036588;
        Thu, 26 Nov 2020 16:03:43 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352hj2ater-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 16:03:43 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQL3ZWN004547;
        Thu, 26 Nov 2020 21:03:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 351pca0qtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 21:03:40 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQL3cPx57999712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 21:03:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1322A11C04A;
        Thu, 26 Nov 2020 21:03:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9689711C052;
        Thu, 26 Nov 2020 21:03:35 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Nov 2020 21:03:35 +0000 (GMT)
Date:   Thu, 26 Nov 2020 23:03:32 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201126210332.GV123287@linux.ibm.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <X7/0CmrPwjq9LDUj@redhat.com>
 <20201126194426.GU123287@linux.ibm.com>
 <X8AQSViIvYKyEOF6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8AQSViIvYKyEOF6@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_09:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=923 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:30:01PM -0500, Andrea Arcangeli wrote:
> On Thu, Nov 26, 2020 at 09:44:26PM +0200, Mike Rapoport wrote:
> > TBH, the whole interaction between e820 and memblock keeps me puzzled
> > and I can only make educated guesses why some ranges here are
> > memblock_reserve()'d and some memblock_add()ed.
> 
> The mixed usage in that interaction between memblock.reserve and
> memblock.memory where sometime it's used to reserve overlapping
> memblock.memory ranges (clearly ok), and sometimes is used on ranges
> with no overlap (not clear even why it's being called), is what makes
> the current code messy.
> 
> We're basically passing down the exact same information (inverted),
> through two different APIs, if there is no overlap.
> 
> > I think what should be there is that e820 entries that are essentially
> > RAM, used by BIOS or not, should be listed in memblock.memory. Then
> > using memblock_reserve() for parts that BIOS claimed for itself would
> > have the same semantics as for memory allocated by kernel.
> >
> > I.e. if there is a DIMM from 0 to, say 512M, memblock.memory will have a
> > range [0, 512M]. And areas such as 0x000-0xfff, 0x9d000-0x9ffff will be
> > in memblock.reserved.
> > 
> > Than in page_alloc.c we'll know that we have a physical memory bank from
> > 0 to 512M but there are some ranges that we cannot use.
> >
> > I suggested it back then when the issue with compaction was reported at
> > the first time, but Baoquan mentioned that there are systems that cannot
> > even tolerate having BIOS reserved areas in the page tables and I didn't
> > continue to pursue this.
> 
> That explains why we can't add the e820 non-RAM regions to
> memblock_add, what's not clear is why it should be required to call
> memblock_reserve on a region that has no overlap with any memblock_add.
> 
> Instead of the patch that adds a walk to the memblock.reserve and that
> requires adding even more memblock_reserve to e820__memblock_setup for
> type 20, we can add a walk for the memblock.memory holes and then we
> can remove the memblock_reserve for E820_TYPE_SOFT_RESERVED too.

This is more or less what I have done here:

https://lore.kernel.org/lkml/20201126174601.GT123287@linux.ibm.com/

just without the removal of the call to memblock_reserve() for
E820_TYPE_SOFT_RESERVED.


> Thanks,
> Andrea
> 

-- 
Sincerely yours,
Mike.
