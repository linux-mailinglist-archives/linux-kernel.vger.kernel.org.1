Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB662CC7E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgLBUdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:33:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729712AbgLBUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:33:31 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2KVwBA130825;
        Wed, 2 Dec 2020 15:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7k64mIQiHaWy//PZEHcOuqC7YfTe5Wp86SAsalsGFaI=;
 b=rN+M6x+LlMC8bCMdbdoM2WvFtpCPRZzBTx7BP4asjjkokc01+1K/lRQSMP7ZPFCjo4yN
 N/2RYqkAcC9qCD+CwpB73aOJwncBnIiGWh5ZCosszqrjqmKEpRNsm2k5cvgGfildYYmc
 rTMB/cv0lejPpqu5zLu8XpQ/Tm7bf092666Gs5Yd7iMwiWfmlVS6G+33m3SD/OiVeLm+
 8tsWd+ZVDisIDZJl0wMckruFUGsnhh5qXz3PYbVD7Qece8PxZn5KbGGZrd8oPn+iPDlM
 0BczSZ2LKl6btAnj8sc6xg6uhTf0EhlN4ZriCpjkRVqtfXMST2LVATmXg1BuPQcoKwjm JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3563qcaxbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 15:32:41 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B2KWfsF133876;
        Wed, 2 Dec 2020 15:32:41 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3563qcaxas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 15:32:41 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2KSDbJ001956;
        Wed, 2 Dec 2020 20:32:38 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 35693xgefb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 20:32:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2KWaHp22413764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 20:32:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B711A4059;
        Wed,  2 Dec 2020 20:32:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26841A404D;
        Wed,  2 Dec 2020 20:32:35 +0000 (GMT)
Received: from osiris (unknown [9.171.12.240])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 20:32:35 +0000 (GMT)
Date:   Wed, 2 Dec 2020 21:32:33 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
Message-ID: <20201202203233.GB11274@osiris>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_12:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=5
 priorityscore=1501 adultscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=880 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:59:52AM +0530, Anshuman Khandual wrote:
> This overrides arch_get_mappabble_range() on s390 platform and drops now
> redundant similar check in vmem_add_mapping(). This compensates by adding
> a new check __segment_load() to preserve the existing functionality.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/s390/mm/extmem.c |  5 +++++
>  arch/s390/mm/vmem.c   | 13 +++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
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
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b0..06dddcc0ce06 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -532,14 +532,19 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>  	mutex_unlock(&vmem_mutex);
>  }
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
>  int vmem_add_mapping(unsigned long start, unsigned long size)
>  {
>  	int ret;
>  
> -	if (start + size > VMEM_MAX_PHYS ||
> -	    start + size < start)
> -		return -ERANGE;
> -

I really fail to see how this could be considered an improvement for
s390. Especially I do not like that the (central) range check is now
moved to the caller (__segment_load). Which would mean potential
additional future callers would have to duplicate that code as well.
