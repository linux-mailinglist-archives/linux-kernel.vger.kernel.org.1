Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F32D3B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 07:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgLIGiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:38:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbgLIGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:38:08 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B96YYW5112139;
        Wed, 9 Dec 2020 01:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=XiMdUiW/Z+awuZ/fbPA1OWDrBX07RpPtQsrXhAFeXSA=;
 b=FEpEAECD+QCgjSrhNC2Z+78eiHRzqHLFlgohJx+8odIMtFNG1KR1p1GvTwszUPpMiGeH
 RZwmWCjXf7dO9vrw1D2svcEVN1oR+81XayxM5/9Q9ZqGOtVt/0uK1O8vmCgt5xh5/txf
 v5PsaS6BhF8RTgohCmix7+/u1ZYn4Zi9S1Y/Ato9ry7N2QawKfEAXZ+xkrB528o3DrD5
 gkrIWGIfy234idQQXgLGq17X8mYJFF0cQO43dctTTEurIDs2yRFdpeYq4tIYSvVfxZdC
 UQrFTdsKfwiAP2CWLmYTksr/GzHdnmde3J8uUyUUz+9gE5HiQQHdjoRMAnEB8AOY7Z7j 8g== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a5t4xkb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 01:35:51 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B96QfCP009994;
        Wed, 9 Dec 2020 06:29:50 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 3581u9dd2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 06:29:50 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B96TnVu22216996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 06:29:49 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FE2A6E050;
        Wed,  9 Dec 2020 06:29:49 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 248A36E04C;
        Wed,  9 Dec 2020 06:29:47 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.103.212])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Dec 2020 06:29:46 +0000 (GMT)
X-Mailer: emacs 27.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Refactor the floor/ceiling check in hugetlb
 range freeing functions
In-Reply-To: <16a571bb32eb6e8cd44bda484c8d81cd8a25e6d7.1604668827.git.christophe.leroy@csgroup.eu>
References: <16a571bb32eb6e8cd44bda484c8d81cd8a25e6d7.1604668827.git.christophe.leroy@csgroup.eu>
Date:   Wed, 09 Dec 2020 11:59:44 +0530
Message-ID: <87360febl3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_06:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=2 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> All hugetlb range freeing functions have a verification like the following,
> which only differs by the mask used, depending on the page table level.
>
> 	start &= MASK;
> 	if (start < floor)
> 		return;
> 	if (ceiling) {
> 		ceiling &= MASK;
> 		if (! ceiling)
> 			return;
> 		}
> 	if (end - 1 > ceiling - 1)
> 		return;
>
> Refactor that into a helper function which takes the mask as
> an argument, returning true when [start;end[ is not fully
> contained inside [floor;ceiling[
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 56 ++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 37 deletions(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 36c3800769fb..f8d8a4988e15 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -294,6 +294,21 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
>  static inline void hugepd_free(struct mmu_gather *tlb, void *hugepte) {}
>  #endif
>  
> +/* Return true when the entry to be freed maps more than the area being freed */
> +static bool range_is_outside_limits(unsigned long start, unsigned long end,
> +				    unsigned long floor, unsigned long ceiling,
> +				    unsigned long mask)
> +{
> +	if ((start & mask) < floor)
> +		return true;
> +	if (ceiling) {
> +		ceiling &= mask;
> +		if (!ceiling)
> +			return true;
> +	}
> +	return end - 1 > ceiling - 1;
> +}
> +
>  static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshift,
>  			      unsigned long start, unsigned long end,
>  			      unsigned long floor, unsigned long ceiling)
> @@ -309,15 +324,7 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
>  	if (shift > pdshift)
>  		num_hugepd = 1 << (shift - pdshift);
>  
> -	start &= pdmask;
> -	if (start < floor)
> -		return;
> -	if (ceiling) {
> -		ceiling &= pdmask;
> -		if (! ceiling)
> -			return;
> -	}
> -	if (end - 1 > ceiling - 1)
> +	if (range_is_outside_limits(start, end, floor, ceiling, pdmask))
>  		return;
>  
>  	for (i = 0; i < num_hugepd; i++, hpdp++)
> @@ -334,18 +341,9 @@ static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
>  				   unsigned long addr, unsigned long end,
>  				   unsigned long floor, unsigned long ceiling)
>  {
> -	unsigned long start = addr;
>  	pgtable_t token = pmd_pgtable(*pmd);
>  
> -	start &= PMD_MASK;
> -	if (start < floor)
> -		return;
> -	if (ceiling) {
> -		ceiling &= PMD_MASK;
> -		if (!ceiling)
> -			return;
> -	}
> -	if (end - 1 > ceiling - 1)
> +	if (range_is_outside_limits(addr, end, floor, ceiling, PMD_MASK))
>  		return;
>  
>  	pmd_clear(pmd);
> @@ -395,15 +393,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>  				  addr, next, floor, ceiling);
>  	} while (addr = next, addr != end);
>  
> -	start &= PUD_MASK;
> -	if (start < floor)
> -		return;
> -	if (ceiling) {
> -		ceiling &= PUD_MASK;
> -		if (!ceiling)
> -			return;
> -	}
> -	if (end - 1 > ceiling - 1)
> +	if (range_is_outside_limits(start, end, floor, ceiling, PUD_MASK))
>  		return;
>  
>  	pmd = pmd_offset(pud, start);
> @@ -446,15 +436,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>  		}
>  	} while (addr = next, addr != end);
>  
> -	start &= PGDIR_MASK;
> -	if (start < floor)
> -		return;
> -	if (ceiling) {
> -		ceiling &= PGDIR_MASK;
> -		if (!ceiling)
> -			return;
> -	}
> -	if (end - 1 > ceiling - 1)
> +	if (range_is_outside_limits(start, end, floor, ceiling, PGDIR_MASK))
>  		return;
>  
>  	pud = pud_offset(p4d, start);
> -- 
> 2.25.0
