Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A50304629
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394613AbhAZSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:19:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56836 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394050AbhAZSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:09:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QHwY7F166387;
        Tue, 26 Jan 2021 18:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nHuSpyAvp80pg4Y5O1YKxwjKEowV1w2Q7vBKO1emKhc=;
 b=R3FiFqYyAYkCmz8YyMkSX/Yc2A8nXXssPf0wCdqGYuok6OVLNrAx/k7wOeQb17hflPD6
 3SR/VK4Pqk7sZ0mQNIDTzsZhR0AnjhDhAIRcC7bWcYb9rhkLhmSk+quhlkts+jO6HZAF
 UTqRYi3Jo1tL7hdwYEgLdSUJWt5jA06YtYBtkx+LEzyJqs3Ke6gNv4pq/tnrZ8Je8bDB
 YGuZQwKiaUuo04GxxCDQzxY6Ddek4+w3/AupkUbVSYPz7229Mt4kO6pQbKkfS7Ejvo3G
 zsnWyvB3+i8mqZylVjWsxNK3TLMQtWjm0HQrYrXzF3SrE6KxZJd0tOrl5UGSJOYXVc+h Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 368brkkac7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 18:08:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QI0WRP134385;
        Tue, 26 Jan 2021 18:08:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 368wpy81j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 18:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBlSSkIp4Y0Rm4Deo6DgFY797Mtp+IF2XzK1wpfVWDKNPJX9SxIJWwf6IuoQMO3NgVmu3vvZvl3QeiY7TylnXDkhNEvRv97jj3yqEgmAjXqabh6GTf1xmiAz1G7mbAR8seBufrYsUl0s7bwKQhwG17OPOb62FR03FuCW2xl/jXgnGY9/HO2Gqz1C64U4jhzmoMGOWP5m387InA9HTaRpPPEKoazImXBJDr9pVHniea9azBfbUsDk1xGftW/l22v8DhjPyz8dq4TkKBzVekOL68zHeT51aJjwltIAncZKlScrRRMQZwDPDoVPQF30Xo7z/BBkrZd+9A9Fjs70bRfTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHuSpyAvp80pg4Y5O1YKxwjKEowV1w2Q7vBKO1emKhc=;
 b=dObKCsy/wkhX61uIlKDk1/8fwSukzZW6ccWsvuU8WoCja9b5urSqHU4w0qQtTRPkKuLGzxxskRDLbZokkBnrq+M7/HQe4Ncnaj2L3dipp39rPW7h7zEhViO/095HOuFRskXnrofC/QL/nN251Q1vTFke9mIPpoUveKNMz0aIBSNrVNPC4fR0N4q/6nJ3HBaku0rgYpRSHFvdAQU2ef819vNgZ4B1uYmYJOPp1LRLWXsa26OrTi1A+XUX49D3Hm6dvqSwnHKS8BMoyYmHTGi+IWszab2ftiFv+FB77MUeg6YcTZ6DcpVrglyN5nPh4MsKV/TQDlg/Q7zyYq03F9/UAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHuSpyAvp80pg4Y5O1YKxwjKEowV1w2Q7vBKO1emKhc=;
 b=wKzQmvws+P2MiqZwsUPsdQyEsnYR1ktv7lBSmJ1KDzQ+Mq61t09SEoaqbJ0ADq+AjSYyTLiWFBft51dMjF0iamT1Q90npY3qUSJA6nVix7EhA1G38HGq7nvAgs93Gw6sIX1V8tGljDgrrgVh1a5KDCduHvOpCLhOG79DfH/4B40=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 18:08:26 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 18:08:26 +0000
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
To:     Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
Date:   Tue, 26 Jan 2021 10:08:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210125205744.10203-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:300:116::18) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR07CA0008.namprd07.prod.outlook.com (2603:10b6:300:116::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 18:08:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb749535-be89-4bce-1293-08d8c2256053
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4531FC2396ADA489BDC7A788E2BC9@CO1PR10MB4531.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwPWPwriH6RbGdakqqM/MOHk8gAsUAblIfxWgyHR+XY/0NwTFItgH9xjG2Z0REiMHJQY4EG4aJjRTa8lv/0Os61LwJvVpyQ+iMq1Eon94o3E37iVO500Yd8n3QlYz7oiV6heSd1zksv8IivZBi3TBniVLNzSVhd0XjcgOiGhdAupEwCzAPh+tUX6Qy6D/3ExNXGpc7+iwgMzHiOpGvG9JixymCW6S7fm3gUxX9CTOG0HONH51aW7IQ8t0ZnwqapU51OwSQboG6zylPStyGGYy/QerJ1xCJjwzKX4DoelhQBROJE5dI4VZFcN1MCOcaM3fWIEjfGs5P4Y6xCPwJEq4MfvhMd6Y7wGb8qxPV0/DQ/AT3eAk6a7go7y87m/wMGP3Pn4U+OJ12pZSVLF40nFlUZxOWbGj1ozWj3Vfun22/yz1NJXlfgDNoy8wRGnpusQnUKchHZd1uux1DSVCmAHmC4lveKzb8TbsC+DfZwwwsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(53546011)(16526019)(6486002)(31686004)(4326008)(956004)(316002)(16576012)(36756003)(52116002)(5660300002)(83380400001)(86362001)(8936002)(66946007)(66476007)(66556008)(2616005)(44832011)(478600001)(31696002)(186003)(26005)(2906002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NlhWV0FWQms3NnNkUUpWTEJDYUFaNHVvWmxWcU1oZFlNZi8xd043eWh4WFJE?=
 =?utf-8?B?Q3ErMkszTm9XOHRIUVRPTDJTNlF1cTFZTzVtMDBVcUJyVjlkS1NDUDFESGJp?=
 =?utf-8?B?ejkvQThMM0JRNklvTGVaT0hXSDA2UVpRZXgwQUZTRGRhdTBBcnNmVWlxQTdS?=
 =?utf-8?B?bzZXR3MyQmlRREg4VFc1ZU8wRk5scUZCZVpCSmIxMVowSWhyM21vL21md2Nn?=
 =?utf-8?B?UE1lUEJLWWZGbmJkRlg2aUVxVXJ1eVRpV0JYWkdwSzhyR3diY0gvQVA4eEVC?=
 =?utf-8?B?bnVXejdrMWxnVzcrQmZvVzd4dGRKcjZ4c1pNY2RML1hUeU04NGI5aXQrMnV0?=
 =?utf-8?B?Vk9tQ2trQVFQSS9UNmNEYWhROUpHTWZyTWwxVUNtOElQNHhOdm1iYjl1MzRX?=
 =?utf-8?B?UXBpZFk3bmxpb0o1TDhaekVUWSszVUpOQ2UwZVM3OXNwZjNOZENQcHZialcz?=
 =?utf-8?B?dE5vREZIUlM1UEFPRVdBOTlUTkpYSkRCWXZaMzRuaHpsUVpuK2pwb2gySWtr?=
 =?utf-8?B?REhwTUZZd21LNU1aWjJMY0VFam41dy92L2Y4M0kvNnBweWttZHFsQ3EwWUtF?=
 =?utf-8?B?b1FEMFlJdUEwZmhVOStHMkMraFJMSXo5MCtMdlRjaE52SHNQN3J6cXV3M0Fv?=
 =?utf-8?B?R0lOdHJlUUYvbDJQNDF6MitMU2RoWnhsTVMvajZTM0lRN0JBSkYyWHZVZTVn?=
 =?utf-8?B?TitGZ0tJK0RaQlE3bnp0dEk3cjBqM1EyUER4ZmZDMEpIbG5oak9pR0xxMzlV?=
 =?utf-8?B?Y1V1REt2V0c5SVZ3MWk2eFhmNGhwME02aDJjREl6TVVidjUydnhwSVVQMDdO?=
 =?utf-8?B?MHZ2QXlzWEI5ekd6dWwrOHFrdVBSU3hualEzSmo0eEVxK0RpMlJrdDFQbzZ5?=
 =?utf-8?B?a0dCSTBIemVLYnMrbDFsRStHdjgvRjVtUDlZZ2laaldqR1NXNXd5VlFnWjA4?=
 =?utf-8?B?eGtsc3FsMzgyOC9WWVlQczBJZ05Za2J4TFV3YSt0VTlVU1c2ZU82V1FlTXRB?=
 =?utf-8?B?aUQ0U3NVSTM3U25tYU5lRHRzK2NBYWM1VUR3STBFKytWQU1HRWVDajllRkJL?=
 =?utf-8?B?WVRjNDhSbjFsa0tDbzRMN05NWEpHM0F1RWhpUmJEbVdBZ25RUGtlZFFxTHpj?=
 =?utf-8?B?UWR5NFdDcXFYbFA1eW03blJuKzVmbW5tQUJ2cWlmQm9RZUl3enpIdXpmVG0r?=
 =?utf-8?B?L0E1Wm1QTkgwUGYzT09GdUZyaEtEWnAwSWE5bTY1eXZBZlBGN093VWwvaWtz?=
 =?utf-8?B?UWNoRWVRNW5ESjhwNmJ5NEhtMnNCa0dzSG5iUDFxTE1JWUErb1F0Y0RJWkN3?=
 =?utf-8?B?S3RMa0tFMkVUT2dxOTI1anYzT1JCVFk0dmdMVjluQmpZNFhVRFlnaGdVbWRJ?=
 =?utf-8?B?NzNZcDNEVVh0bWRzTmVQOXpCN2ZYN2RKMHpLdm9LVVJEQkI1Q0FDVVphK20z?=
 =?utf-8?Q?kPqRY8bw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb749535-be89-4bce-1293-08d8c2256053
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 18:08:26.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOZGilRJmhZi8IORbHUCnWLiYDOWwglYhXMCzyhuDv6AusFPxO87bTUmwZmR0NDkABkxR7bhGl2LSONbzwNUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 12:57 PM, Joao Martins wrote:
> For a given hugepage backing a VA, there's a rather ineficient
> loop which is solely responsible for storing subpages in the passed
> pages/vmas array. For each subpage we check whether it's within
> range or size of @pages and keep incrementing @pfn_offset and a couple
> other variables per subpage iteration.
> 
> Simplify this logic and minimize ops per iteration to just
> store the output page/vma. Instead of incrementing number of @refs
> iteratively, we do it through a precalculation of @refs and having
> only a tight loop for storing pinned subpages/vmas.
> 
> pinning consequently improves considerably, bringing us close to
> {pin,get}_user_pages_fast:
> 
>  - 16G with 1G huge page size
>  gup_test -f /mnt/huge/file -m 16384 -r 10 -L -S -n 512 -w
> 
>  PIN_LONGTERM_BENCHMARK: ~11k us -> ~4400 us
>  PIN_FAST_BENCHMARK: ~3700 us
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 016addc8e413..1f7a95bc7c87 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4789,6 +4789,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	goto out;
>  }
>  
> +static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
> +				 int refs, struct page **pages,
> +				 struct vm_area_struct **vmas)
> +{
> +	int nr;
> +
> +	for (nr = 0; nr < refs; nr++) {
> +		if (likely(pages))
> +			pages[nr] = page++;
> +		if (vmas)
> +			vmas[nr] = vma;
> +	}
> +}
> +
>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			 struct page **pages, struct vm_area_struct **vmas,
>  			 unsigned long *position, unsigned long *nr_pages,
> @@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			continue;
>  		}
>  
> -		refs = 0;
> +		refs = min3(pages_per_huge_page(h) - pfn_offset,
> +			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
>  
> -same_page:
> -		if (pages)
> -			pages[i] = mem_map_offset(page, pfn_offset);
> +		if (pages || vmas)
> +			record_subpages_vmas(mem_map_offset(page, pfn_offset),

The assumption made here is that mem_map is contiguous for the range of
pages in the hugetlb page.  I do not believe you can make this assumption
for (gigantic) hugetlb pages which are > MAX_ORDER_NR_PAGES.  For example,

/*
 * Gigantic pages are so large that we do not guarantee that page++ pointer
 * arithmetic will work across the entire page.  We need something more
 * specialized.
 */
static void __copy_gigantic_page(struct page *dst, struct page *src,
                                int nr_pages)


-- 
Mike Kravetz

> +					     vma, refs,
> +					     likely(pages) ? pages + i : NULL,
> +					     vmas ? vmas + i : NULL);
>  
> -		if (vmas)
> -			vmas[i] = vma;
> -
> -		vaddr += PAGE_SIZE;
> -		++pfn_offset;
> -		--remainder;
> -		++i;
> -		refs++;
> -		if (vaddr < vma->vm_end && remainder &&
> -				pfn_offset < pages_per_huge_page(h)) {
> -			/*
> -			 * We use pfn_offset to avoid touching the pageframes
> -			 * of this compound page.
> -			 */
> -			goto same_page;
> -		} else if (pages) {
> +		if (pages) {
>  			/*
>  			 * try_grab_compound_head() should always succeed here,
>  			 * because: a) we hold the ptl lock, and b) we've just
> @@ -4950,7 +4952,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			 * any way. So this page must be available at this
>  			 * point, unless the page refcount overflowed:
>  			 */
> -			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i-1],
> +			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i],
>  								 refs,
>  								 flags))) {
>  				spin_unlock(ptl);
> @@ -4959,6 +4961,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  				break;
>  			}
>  		}
> +
> +		vaddr += (refs << PAGE_SHIFT);
> +		remainder -= refs;
> +		i += refs;
> +
>  		spin_unlock(ptl);
>  	}
>  	*nr_pages = remainder;
> 
