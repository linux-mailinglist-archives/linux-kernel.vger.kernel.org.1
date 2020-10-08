Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D591287B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbgJHReR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:34:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11966 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731239AbgJHReP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:34:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098HWvIg146981;
        Thu, 8 Oct 2020 13:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=09MNPVb2/KqUtXvd9/dCZR1Z3CPKTq8w8DFTpsm+TYM=;
 b=kzHX2l6mPoQWf1XhMI9u6mQgmFOQjoO+CH5pk6/4C3l9YHHjWX0eUlMI8AKNv9IcE/o0
 j+i6lpGyyLPJlnS0eRaBUO+7OjAix24cpKzUbpNoGZqtUmLlyTBIYzvGDLKNbGW4ySqt
 zPAHM1BdUtd198Naa39Hkd0OfGLXlPdAxRP5HPvwo4WWyj/MUNjmIT8gErtfkRXDFUUn
 L0Mq6jeREG0+apyzhTMIxwz3/PFzSFMnysyZN4cbL0wbGpG6Gc9FruUFScE58vVd1f/v
 gYpu4KyEe3I3mrkRFpKq2WPRzI3BRjk2Y1i274FikOmqtSoVsK4PrSUYn93wgbZiw6sA mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3426tw8u6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:33:06 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 098HX5x3148011;
        Thu, 8 Oct 2020 13:33:05 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3426tw8tm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 13:33:04 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 098HN7wc014873;
        Thu, 8 Oct 2020 17:32:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh5jx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 17:32:15 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 098HWDXF27394474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 17:32:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D4B111C054;
        Thu,  8 Oct 2020 17:32:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DD4011C050;
        Thu,  8 Oct 2020 17:32:10 +0000 (GMT)
Received: from [9.79.223.22] (unknown [9.79.223.22])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Oct 2020 17:32:09 +0000 (GMT)
Subject: Re: [RFC PATCH] mm: Fetch the dirty bit before we reset the pte
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>
References: <20201008092627.399131-1-aneesh.kumar@linux.ibm.com>
 <CAHk-=whwY0WT046fqM-zdHu9vamUjgkvmd36gCd4qSaeYy98nA@mail.gmail.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <2de084c8-9497-7877-56b3-bf1efc615e2e@linux.ibm.com>
Date:   Thu, 8 Oct 2020 23:02:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whwY0WT046fqM-zdHu9vamUjgkvmd36gCd4qSaeYy98nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_11:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 10:32 PM, Linus Torvalds wrote:
> On Thu, Oct 8, 2020 at 2:27 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> In copy_present_page, after we mark the pte non-writable, we should
>> check for previous dirty bit updates and make sure we don't lose the dirty
>> bit on reset.
> 
> No, we'll just remove that entirely.
> 
> Do you have a test-case that shows a problem? I have a patch that I
> was going to delay until 5.10 because I didn't think it mattered in
> practice..
> 

Unfortunately, I don't have a test case. That was observed by code 
inspection while I was fixing syzkaller report.

> The second part of this patch would be to add a sequence count
> protection to fast-GUP pinning, so that GUP and fork() couldn't race,
> but I haven't written that part.
> 
> Here's the first patch anyway. If you actually have a test-case where
> this matters, I guess I need to apply it now..
> 
>                     Linus
> 


-aneesh
