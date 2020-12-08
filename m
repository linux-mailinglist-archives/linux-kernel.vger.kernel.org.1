Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D127C2D2E37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgLHP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:28:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730004AbgLHP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:28:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Ewv9r066396;
        Tue, 8 Dec 2020 10:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=W85YL1dcXF/cQQmTjiYg+YSjrvyToTPW+4OEJYW2+9o=;
 b=F4V5NpO/CqmYNlXWS9VKX3Xpyi0G6EfTCSFiyG1vjjUoB8Ye5gUtxXIM9HriAGf0wDKw
 RQxhp9f+gMcs9AVnJ5iESE1VncHImvYPuEW4E/E4o/7E/ue9/8usggc8urEAvf2nnQdv
 H/ARpNjWlmgG9rrDl2f0D9MlHFR9fSTCY4Wuk1LDVVQZHwhHLQ+WYLv7otTNg0BF5SSr
 CJCiSxB4M7hmGWaaij8Q2BtjZAVpYOVRH1odLD8EueVkl7a7Qure0l09e9WWcLkDFzgH
 bzA6oDwQcrSfG8O+kS+7rhpFLKHn6ZrSxuDhJZeNlnAIHMsVpl6GVV7tSK1O0wMMILrv Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35aany3cjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 10:27:17 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B8ExBQk068063;
        Tue, 8 Dec 2020 10:27:17 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35aany3chb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 10:27:17 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8FGSRh031607;
        Tue, 8 Dec 2020 15:27:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3581fhkps2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 15:27:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8FRCe230474644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 15:27:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1C51AE045;
        Tue,  8 Dec 2020 15:27:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CA6DAE053;
        Tue,  8 Dec 2020 15:27:11 +0000 (GMT)
Received: from osiris (unknown [9.171.80.71])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Dec 2020 15:27:11 +0000 (GMT)
Date:   Tue, 8 Dec 2020 16:27:09 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
Message-ID: <20201208152709.GA26979@osiris>
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
 <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=5 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 09:46:18AM +0530, Anshuman Khandual wrote:
> This overrides arch_get_mappabble_range() on s390 platform which will be
> used with recently added generic framework. It drops a redundant similar
> check in vmem_add_mapping() while compensating __segment_load() with a new
> address range check to preserve the existing functionality. It also adds a
> VM_BUG_ON() check that would ensure that memhp_range_allowed() has already
> been called on the hotplug path.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/s390/mm/extmem.c |  5 +++++
>  arch/s390/mm/init.c   | 10 ++++++++++
>  arch/s390/mm/vmem.c   |  4 ----
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
> index 5060956b8e7d..cc055a78f7b6 100644
> --- a/arch/s390/mm/extmem.c
> +++ b/arch/s390/mm/extmem.c
> @@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
>  		goto out_free_resource;
>  	}
>  
> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
> +		rc = -ERANGE;
> +		goto out_resource;
> +	}
> +
>  	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
>  	if (rc)
>  		goto out_resource;
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 77767850d0d0..64937baabf93 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -278,6 +278,15 @@ device_initcall(s390_cma_mem_init);
>  
>  #endif /* CONFIG_CMA */
>  
> +struct range arch_get_mappable_range(void)
> +{
> +	struct range memhp_range;
> +
> +	memhp_range.start = 0;
> +	memhp_range.end =  VMEM_MAX_PHYS;
> +	return memhp_range;
> +}
> +
>  int arch_add_memory(int nid, u64 start, u64 size,
>  		    struct mhp_params *params)
>  {
> @@ -291,6 +300,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>  		return -EINVAL;
>  
> +	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
>  	rc = vmem_add_mapping(start, size);
>  	if (rc)
>  		return rc;
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b0..749eab43aa93 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -536,10 +536,6 @@ int vmem_add_mapping(unsigned long start, unsigned long size)
>  {
>  	int ret;
>  
> -	if (start + size > VMEM_MAX_PHYS ||
> -	    start + size < start)
> -		return -ERANGE;
> -

Is there a reason why you added the memhp_range_allowed() check call
to arch_add_memory() instead of vmem_add_mapping()? If you would do
that, then the extra code in __segment_load() wouldn't be
required.
Even though the error message from memhp_range_allowed() might be
highly confusing.
