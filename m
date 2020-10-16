Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768F128FD0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394346AbgJPD7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:59:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54710 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394339AbgJPD7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:59:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09G3xGCv159118;
        Fri, 16 Oct 2020 03:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HU4F9wuG1k3SPCqoyCP3TB8GXZKlahUWq31j/Ddhho0=;
 b=VZhh5HKybVleyvd/JnS8W3gCE8LdrNB5ahnAjuLrt4JGVdoI8XGL7I3Rrzx/nqoCid95
 yVPW+dkLRV26/s6+OZ1FuTcBJFqpG6KxOSZW69Hnn0Acy7qD8hV8B9S5sSruT6BXbk9g
 P5UI3QcwwCnsaJKiRjzi8KCQzwLCq6+gM0Jeuij/Sje5XHLOBvtK5KGgsgr8Y1LEZIwy
 OF5wMMFEEEbN7FdIiTeHSIQxWzUmDXgirqHrKhuPGhZbP/77MCvHzn2WBU5GO6IxpHBT
 /KF68n3fpe6OepcIHRRs0GgII044MnIpEm8Cq9JmrassVsP6XvQBP1/u6QFsOW1/adVL PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 346g8gn0m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Oct 2020 03:59:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09G3tmSd032246;
        Fri, 16 Oct 2020 03:59:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 343phrxj1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 03:59:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09G3xCT1010493;
        Fri, 16 Oct 2020 03:59:12 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 20:59:12 -0700
Subject: Re: [RFC PATCH 2/3] hugetlbfs: introduce hinode_rwsem for pmd sharing
 synchronization
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBICjloIDlj6Mg55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20201013231100.71013-1-mike.kravetz@oracle.com>
 <20201013231100.71013-3-mike.kravetz@oracle.com>
 <20201015230511.GA4325@hori.linux.bs1.fc.nec.co.jp>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6bcf16c6-0881-e5ae-b2c8-3f63a033b250@oracle.com>
Date:   Thu, 15 Oct 2020 20:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015230511.GA4325@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010160024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010160024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 4:05 PM, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Oct 13, 2020 at 04:10:59PM -0700, Mike Kravetz wrote:
>> Due to pmd sharing, the huge PTE pointer returned by huge_pte_alloc
>> may not be valid.  This can happen if a call to huge_pmd_unshare for
>> the same pmd is made in another thread.
>>
>> To address this issue, add a rw_semaphore (hinode_rwsem) to the hugetlbfs
>> inode.
>> - hinode_rwsem is taken in read mode before calling huge_pte_alloc, and
>>   held until finished with the returned pte pointer.
>> - hinode_rwsem is held in write mode whenever huge_pmd_unshare is called.
>>
>> In the locking hierarchy, hinode_rwsem must be taken before a page lock.
>>
>> In an effort to minimize performance impacts, hinode_rwsem is not taken
>> if the caller knows the target can not possibly be part of a shared pmd.
>> lockdep_assert calls are added to huge_pmd_share and huge_pmd_unshare to
>> help catch callers not using the proper locking.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Hi Mike,
> 
> I didn't find a problem on main idea of introducing hinode_rwsem, so
> I'm fine if the known problems are fixed.

Thank you for taking a look Naoya!

I have been trying to address these race issues for some time.  The issues
have been there since the pmd sharing code was introduced.  Fortunately,
it is not easy to hit the issue.  However, targeted test programs can cause
BUGs.

> I have one question. This patch seems to make sure that huge_pmd_unshare()
> are called under holding hinode_rwsem in write mode for some case. Some
> callers of try_to_unmap() seem not to hold it like shrink_page_list(),
> unmap_page(), which is OK because they never call try_to_unmap() for hugetlb
> pages.  And unmap_ref_private() doesn't takes hinode_rwsem either, and
> that's also OK because this function never handles pmd sharing case.  So
> what about unmap_single_vma()?  It seems that this generic function could
> reach huge_pmd_unshare() without hinode_rwsem, so what prevents the race here?
> (Maybe I might miss some assumption or condition over this race...)

You are not missing anything.  I mistakingly left out the locking code in
of unmap_single_vma().  If I would have run some tests with lockdep enabled,
the new lock checking code would have noticed.

> 
> I left a few other minor comments below ...

I will address the below issues in the next revision.

Thanks again for taking a look.
-- 
Mike Kravetz

> 
>> @@ -4424,6 +4442,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>  
>>  	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>>  	if (ptep) {
>> +		/*
>> +		 * Since we hold no locks, ptep could be stale.  That is
>> +		 * OK as we are only making decisions based on content and
>> +		 * not actually modifying content here.
>> +		 */
> 
> nice comment, thank you.
> 
>>  		entry = huge_ptep_get(ptep);
>>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
>>  			migration_entry_wait_huge(vma, mm, ptep);
>> @@ -4431,20 +4454,32 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>>  			return VM_FAULT_HWPOISON_LARGE |
>>  				VM_FAULT_SET_HINDEX(hstate_index(h));
>> -	} else {
>> -		ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
>> -		if (!ptep)
>> -			return VM_FAULT_OOM;
>>  	}
>>  
>> +	/*
>> +	 * Acquire hinode_sem before calling huge_pte_alloc and hold
> 
>                    hinode_rwsem?
> 
>> +	 * until finished with ptep.  This prevents huge_pmd_unshare from
>> +	 * being called elsewhere and making the ptep no longer valid.
>> +	 *
>> +	 * ptep could have already be assigned via huge_pte_offset.  That
>> +	 * is OK, as huge_pte_alloc will return the same value unless
>> +	 * something has changed.
>> +	 */
> 
> ... 
> 
>> @@ -278,10 +278,14 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>>  		BUG_ON(dst_addr >= dst_start + len);
>>  
>>  		/*
>> -		 * Serialize via hugetlb_fault_mutex
>> +		 * Serialize via hinode_rwsem hugetlb_fault_mutex.
>                                              ^ "and" here?
> 
>> +		 * hinode_rwsem ensures the dst_pte remains valid even
>> +		 * in the case of shared pmds.  fault mutex prevents
>> +		 * races with other faulting threads.
>>  		 */
>>  		idx = linear_page_index(dst_vma, dst_addr);
>>  		mapping = dst_vma->vm_file->f_mapping;
>> +		hinode_lock_read(mapping, dst_vma, dst_addr);
>>  		hash = hugetlb_fault_mutex_hash(mapping, idx);
>>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
> 
> 
> Thanks,
> Naoya Horiguchi
> 
