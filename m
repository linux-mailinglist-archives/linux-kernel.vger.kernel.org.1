Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E6C2A895D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgKEV7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:59:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732390AbgKEV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:59:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5LtjMu022290;
        Thu, 5 Nov 2020 21:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=g+fL9IqGuXmwtbifkXrIAHV/u1Is0GbR3IjP9o5bNIM=;
 b=HHrX3w8+3Xju5Z+nXPmUO6bLlngSjtCht0QQCD+9sq8uo65sq2Fmu6mMmhg0rc/6w/7G
 8YW3airQr/ZjExqAp87jNmeiHRZQHAC1QA4Ac95F7dvlBhkd/cLtkqbFW0+5fkqwZ+9P
 pVS0el2o7ZcE2AZFDAOfPquBIeBDmxVZGLj1LHFKJRK2Ue9OWlMFl0+Go0s0mWhHmXHs
 RW/w3zVdgsLtKqGfESs5pqdoYbKbpqVb/wsIkvTXMJYPpGxbCYJuxLOWowFpvpfCDo1V
 cT4MQWtJlkVsiEXjnonHNLgPMnbNrgJ0aOXF0QLrZLeZGbt/VscdQVFdaM724Chji8I6 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34hhw2xbsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 05 Nov 2020 21:59:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A5LtqD1092454;
        Thu, 5 Nov 2020 21:59:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34hvs1bk3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Nov 2020 21:59:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A5LxQwX026988;
        Thu, 5 Nov 2020 21:59:26 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Nov 2020 13:59:26 -0800
Subject: Re: [PATCH 0/4] hugetlbfs: use hinode_rwsem for pmd sharing
 synchronization
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20201026233150.371577-1-mike.kravetz@oracle.com>
 <20201103002841.273161-1-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7374a8cc-ab8d-ad25-2b8b-2451ba8f7131@oracle.com>
Date:   Thu, 5 Nov 2020 13:59:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201103002841.273161-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 4:28 PM, Mike Kravetz wrote:
> The RFC series reverted all patches where i_mmap_rwsem was used for
> pmd sharing synchronization, and then added code to use hinode_rwsem.
> This series ends up with the same code in the end, but is structured
> as follows:
> 
> - Revert the page fault/truncation race patch which depends on i_mmap_rwsem
>   always being taken in page fault path.
> - Add hinode_rwsem to hugetlbfs specific inode and supporting routines.
> - Convert code from using i_mmap_rwsem for pmd sharing synchronization
>   to using hinode_rwsem.
> - Add code to more robustly deal with page fault/truncation races.
> 
> My hope is that this will be easier to review.

My apologies.  Please do not spend any time on this patch series and it
certainly is not something to be sent to stable.

I have created a patch to address the BUG and propose that for stable [1].

After further thought, the approach in this series also has lock ordering
issues.  Here is a simple summary of the problem.

With pmd sharing, the pte pointer returned by huge_pte_alloc is not
guaranteed to be valid.  This is because another thread could have made
a call to huge_pmd_unshare and 'unshared' the pmd page containing the
pte pointer.

The current i_mmap_rwsem locking and the inode locking proposed in this
series acquire the semaphore in read mode before calling huge_pte_alloc.
Code continues to hold the semaphore until finished with the pte pointer.
Callers of huge_pmd_unshare hold the semaphore in write mode.  Thus, the
semaphore prevents the race.

The problem with this type of approach is lock ordering.  The semaphore is
acquired in read mode during page fault processing.  The first thing this
code does is 'allocate' a pte with huge_pte_alloc.  It will then, find or
allocate a page and lock it.  Finally, it will lock the page table to update
the pte.  Two instances where we may need to take the semaphore in write
mode are page migration and memory failure.  In these cases, the first thing
we need to do is lock the page.  Only after locking the page can we locate
the semaphore which needs to be acquired in write mode.  Hence we end up with
a classic cause for ABBA deadlocks.

I'm starting to think that adding more synchronization is not the best way
to approach this issue.  Rather, we should always validate pte pointers after
acquiring the page table lock.  At the lowest level, pmd sharing is
synchronized by the page table lock.  We already do some validation of the
pte after acquiring the page table lock.  For example, checking if
huge_pte_none() is still true.  Before even checking for none, we would need
to lookup the pte again (huge_pte_offset) and compare to the pte we previously
acquired.  If they are not the same, then we would need to backout and retry.

Unless someone has another suggestion, I'll start exploring this approach.

[1] https://lore.kernel.org/linux-mm/20201105195058.78401-1-mike.kravetz@oracle.com/
-- 
Mike Kravetz
