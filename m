Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E7303AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404385AbhAZKtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:49:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbhAZCPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:15:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10Q2ESFD016642;
        Tue, 26 Jan 2021 02:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=noYZS5IhWF1Yvz+8TCxCdp6tJA05XzKyQU6VOHpJCdM=;
 b=RvA+7JayciI6VZgWSisfQcRsV3KI8etG0HuLDu0j64aj2u9glg3jdxp9MaYWxcyEsMfc
 NC6yqu4uLSoGGOdNEpfaV6rgtRlCecBHUHCZgzN7JViEtA5aHRjxL9W9KFGrmrtnX/sa
 E7mJPQDHr5/rPdvjxhNt7FviszPVIBz6/6nqdPPM13cRczv35K6o7XEE12KCJVfp702C
 iIK24Rgh7CSlxqmjHL9KEy0X43XXewGqmzdY7ePkmbYA1p6x/OD+m984p9fDKfpEu0xQ
 k2t2sA+Fe64zSHIfc38wbSBlJBQcpF+bTZorROW7hlutVmH9U8cclmysSfaiuXtTQfDq BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 368b7qr6r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 02:14:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10Q264Kx021646;
        Tue, 26 Jan 2021 02:14:27 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by userp3030.oracle.com with ESMTP id 368wqvugr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 02:14:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXoK2/TEmAYg2mZBadj2QOw74TIhivYHPQqToNQMtNxDxThqRU0Sh+5C7zN+xNjD1aGndNHYADrk3Rn1a4F0k0EVwy2pLFFRvL4emYOrBZxRyzwWN3lH2aGM5rXnozo3VLrxzuFaU69A0yn6LB7N6rY4J2PAwCP8cVEEvYtNTrUZixtSUyYw4jJb/fxTYsMTgvvI+RZSCb6NyPWwImcZtGcW7+a0Co9uLNVgjiB5omAwdEB16ZaR+htjKfz4l8IylFIBFm5qxwwcwNB6GkxU7tU2+U16gM6JJ+RgaxPHbqrwYfdSs29y67r/Jc6xzbg27vHYvQX4fWoJ/oLvT+l6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noYZS5IhWF1Yvz+8TCxCdp6tJA05XzKyQU6VOHpJCdM=;
 b=SZ1YcB/q9cwVq9dYW5WDt8PXMCz9hnHVfbC3Em7nfn88OwMGp3rH5kosMQVxKrMN9P2snmaUB2CU8GKePv4ozyBugM9ztsEfjNH2Mb4Im1YPeP7ds1qT2Xp59sjw1gLHYsPTMGZos24Dg8HL82paYysoBGEkypttyXgUBARxFMJBIhu2xkK8k7ChS7Xr1JYVEyYDIRywequtj4txy8FdnyT/YkjOcUW8SSKeOCXfVS7xn/erGkgSG4jXATxQMNoBKevmk6XQSgQ78NoYoPYiOXZEqgE6kZtcDHUJSkUNQGbjXIeYstpdekY5XIXIEwZ+16QdQPpe8XKNkeMO3+xHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noYZS5IhWF1Yvz+8TCxCdp6tJA05XzKyQU6VOHpJCdM=;
 b=S+nABf/k+Ddl7iLplPGxSzAmadLcHVi2422Nt8Btuf87LlqiDKVaWUmVmSL5SzgnIADz+Sej9CwgxLCe5IbJSk4aYErj5ZnGodhAst15IH2Q6Y3DbE8VnJWKHUMsd+GAwTfLUp7moMnm5N1JKdvYLbpESIx5yj49P3eyGPlW1mc=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 02:14:25 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 02:14:25 +0000
Subject: Re: [PATCH 1/2] mm/hugetlb: grab head page refcount once per group of
 subpages
To:     Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-2-joao.m.martins@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <17c414bd-4262-b2ba-ef5a-85cd86e21e4c@oracle.com>
Date:   Mon, 25 Jan 2021 18:14:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210125205744.10203-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1701CA0017.namprd17.prod.outlook.com
 (2603:10b6:301:14::27) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1701CA0017.namprd17.prod.outlook.com (2603:10b6:301:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Tue, 26 Jan 2021 02:14:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea80b24-7da4-4edb-00b6-08d8c1a01a07
X-MS-TrafficTypeDiagnostic: CO1PR10MB4516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45165E79625E0A6CF9887EAFE2BC9@CO1PR10MB4516.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tKBhl3Sni4MAF4zX7wiHzZClMkOI8+fAYyWp6z/bOcGeKoirj2Be60xr2ki7rIaL+mjvtEcN3wJXMm0IAGda7P9Ozk60ZYwizmsx6xUlt6apk+g5ExacVEXow12PKo7mVDLx0dCTsXTQVMZjvPc3l9ZYexAYT2feGIuaVFHumQSsQl6T6n6qKmFhP+MjKhB3Dg45zn/ABRWKh+sQm4YSH6gAxR/dSjoV5Qos/Dfc6fgDyuCOGaCVXVE6U3J/kOpvC2L4IbMg1QeKBRRY1c+IW0KML+Mq8gjoynqP7PZ55p6mXv0JEiMndGMNF84zfe7itIbd/CAfVjarnyMgaVZVoiMDWwo3WkpbTB2M/WyZDjx6VdMX+Q/xswLodEaaBLE7z1ED+ogAILoe31HGQcUpcajujKEDG9msqrXBmHZHQl0jiKYcQhVxfiYzxIxUfK0Q+9In6KqFD//69f5ew+L3dB6ERjvJC2Ibxb3MgBpAQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(186003)(16576012)(66946007)(316002)(16526019)(8676002)(53546011)(36756003)(4326008)(26005)(66476007)(31686004)(31696002)(66556008)(5660300002)(2616005)(6486002)(478600001)(8936002)(956004)(2906002)(86362001)(83380400001)(44832011)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VFJtVUoxWDlUcUpGT0dyNzF1VDlXNzNVMFZUR3pDY2JTL1NoaXpIaHpWSnBF?=
 =?utf-8?B?ODdMSSt0VTRCc3M3dmZmYzZwWWdFdVpBMUFCQzR0TVpHOFI0ODhzRHU5QVFy?=
 =?utf-8?B?cG95d3RvRTRhNlovL0FRNWJRNmo5NE04TG5xS0dpN1BKZXVYT2gyNSs4azhJ?=
 =?utf-8?B?OEt0YnZleE15bFZhRVpkMDk4NmdPZjFqeEdlRStwVnEvdG9ESW1OVEd2Rnli?=
 =?utf-8?B?Qmd5bmFCY1dQMzZlTnVUSmpyajIyVkYrMDNCdlJaUnVGaWxjYkpaWFVZVjJX?=
 =?utf-8?B?LzZSUVVDQXM0RWZyVUJsUnlxNGJVcmN1cG54aGdNQzJ4cGFvU3QzU3RkYmFm?=
 =?utf-8?B?WWg3bG9QTWw0UWVEV3gvc3BJYmdmd3RZT1RJeU8vbjU3TVJxQmN6d2krWEx3?=
 =?utf-8?B?dXM4WDRJUnM1VndlRnFHNUUxeU8yYnFBRkR5TGo5bk04ZVh0NnM3MGhoY0pj?=
 =?utf-8?B?bFdZM3E1MDVKeU42YXEySXZ4U3hocWhsclZZdUVHa3VSbDRqYndGYTFyTVBE?=
 =?utf-8?B?R0dxU2NVL1RDOHFqS3hJQU1Xd1dndVJuR0dDSFVxWlRicmFvUWdpSGhXdjJT?=
 =?utf-8?B?WXZBNzdBTUgzOGREZGxTU1N3SGN3UE9YcjlLV1pjbVNjY1pVWnlmRmppMyt0?=
 =?utf-8?B?QXV1VnUvbnVxZHVkMStNZnh2TGRkckhqaGRqM3k1aDA4citxUHVhTTBlQ1Vl?=
 =?utf-8?B?cHBtRmRIWVJ0UHo3MFhtRHJsTlFUMFVoRG9hQndNaEc3aS9xZStEVGorWi92?=
 =?utf-8?B?bDdWQ25yS1RWazRXaHpHcURyaUlyL1JxS1hUU1daVzUrWE1iVC95dXpJVlN1?=
 =?utf-8?B?K1JWdUtYNkdtK3NJQTgyNVJOUlQ4M3JqSjZzUWJhQXdGRmYwMXcycnpJcHQ5?=
 =?utf-8?B?WmJSaTRoN2dSSDFWM29xOXNuNysyb01vSXpNVGpxSEZjUVEyTXFqRHZ0ZVo1?=
 =?utf-8?B?NGxNRThQQnBPdzR5RjlYbU5Nd2FVNWxjNy96MUVQQTJ4Q2NMN1pIR1o5TXNz?=
 =?utf-8?B?MnAxZ1FSNDlsTUNCYkx4NjNWUlRpa29YYTRFd1Z0YTJuUy9LSFptREZMMmpn?=
 =?utf-8?B?b3JtRmk2T2laUm9DS29YbGFQZWprUmNwRWt6VndNUk4wakRBUGZLTTVhUElu?=
 =?utf-8?B?bVdHQTV4dnJzdEdnbURkRGw4SEh0NVBGRHlEK2lvT2x2Mmsva1V0a0dXa2dN?=
 =?utf-8?B?WjhTNy8reFRpc2dMaGVIQlU5TnZPZ3ozWlhJempZVUFrbEZaTElPWEI4UnM0?=
 =?utf-8?B?ek5BVXZTWmo1T20yU2tlWUJuRnZDRDRaQWhBb0dEVnpUd3NSSHVEWDlXNkFX?=
 =?utf-8?B?aUc4NndDTzc2VG1aYzFza29iUUd1K0RLZ01ES0Fjd3RRK3hGczVHNDFVbmFQ?=
 =?utf-8?B?NWdtUVQ1b0F3cjljSGJhWjMzNWxrYkZUNkVySGNLYkZRclFVVWd6RDI3TVVJ?=
 =?utf-8?Q?jo6r0xEm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea80b24-7da4-4edb-00b6-08d8c1a01a07
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 02:14:25.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5JouT91+hF9Ds5dvCR7cmTwVWSaU8Pl02zY/1KSE98/PRfAjVh7pzqpHUYQXJZWIAGQg8IJfxFV9k0vaVXIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260007
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 12:57 PM, Joao Martins wrote:
> follow_hugetlb_page() once it locks the pmd/pud, it checks all the
> subpages in a huge page and grabs a reference for each one,
> depending on how many pages we can store or the size of va range.
> Similar to gup-fast, have follow_hugetlb_page() grab the head
> page refcount only after counting all its subpages that are part
> of the just faulted huge page.
> 
> Consequently we reduce the number of atomics necessary to pin
> said huge page, which improves non-fast gup() considerably:
> 
>  - 16G with 1G huge page size
>  gup_test -f /mnt/huge/file -m 16384 -r 10 -L -S -n 512 -w
> 
>  PIN_LONGTERM_BENCHMARK: ~87.6k us -> ~11k us
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/linux/mm.h |  3 +++
>  mm/gup.c           |  5 ++---
>  mm/hugetlb.c       | 43 ++++++++++++++++++++++++-------------------
>  3 files changed, 29 insertions(+), 22 deletions(-)

Thanks.  Nice straight forward improvement.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a5d618d08506..0d793486822b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1182,6 +1182,9 @@ static inline void get_page(struct page *page)
>  }
>  
>  bool __must_check try_grab_page(struct page *page, unsigned int flags);
> +__maybe_unused struct page *try_grab_compound_head(struct page *page, int refs,
> +						   unsigned int flags);
> +
>  
>  static inline __must_check bool try_get_page(struct page *page)
>  {
> diff --git a/mm/gup.c b/mm/gup.c
> index 3e086b073624..ecadc80934b2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -79,9 +79,8 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>   * considered failure, and furthermore, a likely bug in the caller, so a warning
>   * is also emitted.
>   */
> -static __maybe_unused struct page *try_grab_compound_head(struct page *page,
> -							  int refs,
> -							  unsigned int flags)
> +__maybe_unused struct page *try_grab_compound_head(struct page *page,
> +						   int refs, unsigned int flags)
>  {
>  	if (flags & FOLL_GET)
>  		return try_get_compound_head(page, refs);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a6bad1f686c5..016addc8e413 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4798,7 +4798,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  	unsigned long vaddr = *position;
>  	unsigned long remainder = *nr_pages;
>  	struct hstate *h = hstate_vma(vma);
> -	int err = -EFAULT;
> +	int err = -EFAULT, refs;
>  
>  	while (vaddr < vma->vm_end && remainder) {
>  		pte_t *pte;
> @@ -4918,26 +4918,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			continue;
>  		}
>  
> +		refs = 0;
> +
>  same_page:
> -		if (pages) {
> +		if (pages)
>  			pages[i] = mem_map_offset(page, pfn_offset);
> -			/*
> -			 * try_grab_page() should always succeed here, because:
> -			 * a) we hold the ptl lock, and b) we've just checked
> -			 * that the huge page is present in the page tables. If
> -			 * the huge page is present, then the tail pages must
> -			 * also be present. The ptl prevents the head page and
> -			 * tail pages from being rearranged in any way. So this
> -			 * page must be available at this point, unless the page
> -			 * refcount overflowed:
> -			 */
> -			if (WARN_ON_ONCE(!try_grab_page(pages[i], flags))) {
> -				spin_unlock(ptl);
> -				remainder = 0;
> -				err = -ENOMEM;
> -				break;
> -			}
> -		}
>  
>  		if (vmas)
>  			vmas[i] = vma;
> @@ -4946,6 +4931,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		++pfn_offset;
>  		--remainder;
>  		++i;
> +		refs++;
>  		if (vaddr < vma->vm_end && remainder &&
>  				pfn_offset < pages_per_huge_page(h)) {
>  			/*
> @@ -4953,6 +4939,25 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			 * of this compound page.
>  			 */
>  			goto same_page;
> +		} else if (pages) {
> +			/*
> +			 * try_grab_compound_head() should always succeed here,
> +			 * because: a) we hold the ptl lock, and b) we've just
> +			 * checked that the huge page is present in the page
> +			 * tables. If the huge page is present, then the tail
> +			 * pages must also be present. The ptl prevents the
> +			 * head page and tail pages from being rearranged in
> +			 * any way. So this page must be available at this
> +			 * point, unless the page refcount overflowed:
> +			 */
> +			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i-1],
> +								 refs,
> +								 flags))) {
> +				spin_unlock(ptl);
> +				remainder = 0;
> +				err = -ENOMEM;
> +				break;
> +			}
>  		}
>  		spin_unlock(ptl);
>  	}
> 
