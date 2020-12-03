Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560222CD4F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbgLCLzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:55:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55708 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbgLCLzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:55:02 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3BXIuc171029;
        Thu, 3 Dec 2020 06:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gZarAZii17HyVU/DRNSA4zOTNYXDV1w/TMHXDm5c6IM=;
 b=mPWDlmFnInDA4rQowSzTiVESHAlcPTW+Zmr6EDW6WiFDc25i4oCz21Uca1wmmvQgO8Gk
 tqd3mPnfLR4w7mG3pq+g5cGRWBj71ASJ9LbUc2xypJ+GqNnINBZY7uD5vwYrM9lo+5Cu
 0yzXjqaEotYytEOq+RwX7z6f9s/3uuTaXOnOFgnRyJpQYfHuRVeoXdzZGx1BHAd/K1wV
 rd99NIFKO5EIBzDIbcEoPPYLcpNQqxAtAMbinBQJI13GqKm3BtG09pRLL0jY68XULJBn
 di46DGAAuMdba5lHOmuhGdhV22yRq8FlHvmPTa8dvERGl2PD+DRZOzo/EZ4VQm1DRa/F CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355k1acye1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 06:54:14 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B3BXRYR171226;
        Thu, 3 Dec 2020 06:54:13 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355k1acyb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 06:54:13 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B3BrL3A008047;
        Thu, 3 Dec 2020 11:54:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 353e687nxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 11:54:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B3BpZjW10093058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Dec 2020 11:51:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47EAF4C040;
        Thu,  3 Dec 2020 11:51:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D61804C044;
        Thu,  3 Dec 2020 11:51:34 +0000 (GMT)
Received: from osiris (unknown [9.171.50.208])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Dec 2020 11:51:34 +0000 (GMT)
Date:   Thu, 3 Dec 2020 12:51:33 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
Message-ID: <20201203115133.GB9994@osiris>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
 <20201202203233.GB11274@osiris>
 <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=5 bulkscore=0 mlxlogscore=604 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 06:03:00AM +0530, Anshuman Khandual wrote:
> >> diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
> >> index 5060956b8e7d..cc055a78f7b6 100644
> >> --- a/arch/s390/mm/extmem.c
> >> +++ b/arch/s390/mm/extmem.c
> >> @@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
> >>  		goto out_free_resource;
> >>  	}
> >>  
> >> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
> >> +		rc = -ERANGE;
> >> +		goto out_resource;
> >> +	}
> >> +
> >>  	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
> >>  	if (rc)
> >>  		goto out_resource;
> >> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> >> index b239f2ba93b0..06dddcc0ce06 100644
> >> --- a/arch/s390/mm/vmem.c
> >> +++ b/arch/s390/mm/vmem.c
> >> @@ -532,14 +532,19 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
> >>  	mutex_unlock(&vmem_mutex);
> >>  }
> >>  
> >> +struct range arch_get_mappable_range(void)
> >> +{
> >> +	struct range memhp_range;
> >> +
> >> +	memhp_range.start = 0;
> >> +	memhp_range.end =  VMEM_MAX_PHYS;
> >> +	return memhp_range;
> >> +}
> >> +
> >>  int vmem_add_mapping(unsigned long start, unsigned long size)
> >>  {
> >>  	int ret;
> >>  
> >> -	if (start + size > VMEM_MAX_PHYS ||
> >> -	    start + size < start)
> >> -		return -ERANGE;
> >> -
> > 
> > I really fail to see how this could be considered an improvement for
> > s390. Especially I do not like that the (central) range check is now
> > moved to the caller (__segment_load). Which would mean potential
> > additional future callers would have to duplicate that code as well.
> 
> The physical range check is being moved to the generic hotplug code
> via arch_get_mappable_range() instead, making the existing check in
> vmem_add_mapping() redundant. Dropping the check there necessitates
> adding back a similar check in __segment_load(). Otherwise there
> will be a loss of functionality in terms of range check.
> 
> May be we could just keep this existing check in vmem_add_mapping()
> as well in order avoid this movement but then it would be redundant
> check in every hotplug path.
> 
> So I guess the choice is to either have redundant range checks in
> all hotplug paths or future internal callers of vmem_add_mapping()
> take care of the range check.

The problem I have with this current approach from an architecture
perspective: we end up having two completely different methods which
are doing the same and must be kept in sync. This might be obvious
looking at this patch, but I'm sure this will go out-of-sync (aka
broken) sooner or later.

Therefore I would really like to see a single method to do the range
checking. Maybe you could add a callback into architecture code, so
that such an architecture specific function could also be used
elsewhere. Dunno.
