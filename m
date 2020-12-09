Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2A2D44F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbgLIO7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:59:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgLIO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:59:32 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B9EvbGE047445;
        Wed, 9 Dec 2020 09:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9rqM1yV5HCd1G1JHSlYx/u8/TFPCo5Lt6nrGr4WlAGg=;
 b=QHHx/e59DWoxkKOIq6hy3MNMT/oToB8KN0lfZ+NrMdtbNNMVaiT/Yw1wOoNhExXb5Si+
 fYbl/Zyx/pOSHOxnsLcZ+fuZQvRsu8OlpgRa5avVb8p1flKYBNE1uRRupc1DkxBk+ZWz
 xZSikdy/IqTmq8NNWEPDCpJgYm3hjEynDunbg+mq7J2Kk+BqrrU3po+VUPndwLhYgqjj
 qJUiXWaAeJeTj6BtQayrxLkEKdInE6DdL89kAf+wOd/aCEK5q9+dZhXHD5nG4jxu+bsL
 ImKlHV2TxqmeJTiMYo5jHOk+4l+9ULN7dfCjq0UXft1vJOvvqsp9mPYw0UzAwqhrphRb yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35afekmgkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 09:58:39 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B9EvpME049302;
        Wed, 9 Dec 2020 09:58:38 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35afekmgk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 09:58:38 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B9EqKQ6001485;
        Wed, 9 Dec 2020 14:58:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8pyy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 14:58:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B9EvJM811010532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 14:57:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0BF24C06A;
        Wed,  9 Dec 2020 14:57:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 814FC4C050;
        Wed,  9 Dec 2020 14:57:18 +0000 (GMT)
Received: from osiris (unknown [9.171.90.105])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Dec 2020 14:57:18 +0000 (GMT)
Date:   Wed, 9 Dec 2020 15:57:17 +0100
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
Message-ID: <20201209145717.GD7160@osiris>
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
 <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
 <20201208152709.GA26979@osiris>
 <7484e153-6c77-8325-6195-621fe144011e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7484e153-6c77-8325-6195-621fe144011e@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_13:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=1 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:07:04AM +0530, Anshuman Khandual wrote:
> >> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
> >> +		rc = -ERANGE;
> >> +		goto out_resource;
> >> +	}
> >> +
...
> >> +struct range arch_get_mappable_range(void)
> >> +{
> >> +	struct range memhp_range;
> >> +
> >> +	memhp_range.start = 0;
> >> +	memhp_range.end =  VMEM_MAX_PHYS;
> >> +	return memhp_range;
> >> +}
> >> +
> >>  int arch_add_memory(int nid, u64 start, u64 size,
> >>  		    struct mhp_params *params)
> >>  {
> >> @@ -291,6 +300,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
> >>  		return -EINVAL;
> >>  
> >> +	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
> >>  	rc = vmem_add_mapping(start, size);
> >>  	if (rc)
> > Is there a reason why you added the memhp_range_allowed() check call
> > to arch_add_memory() instead of vmem_add_mapping()? If you would do
> 
> As I had mentioned previously, memhp_range_allowed() is available with
> CONFIG_MEMORY_HOTPLUG but vmem_add_mapping() is always available. Hence
> there will be a build failure in vmem_add_mapping() for the range check
> memhp_range_allowed() without memory hotplug enabled.
> 
> > that, then the extra code in __segment_load() wouldn't be
> > required.
> > Even though the error message from memhp_range_allowed() might be
> > highly confusing.
>
> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
> will create three range checks i.e two memhp_range_allowed() and the
> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
> paths, which is not optimal.

Ah, sorry. I didn't follow this discussion too closely. I just thought
my point of view would be clear: let's not have two different ways to
check for the same thing which must be kept in sync.
Therefore I was wondering why this next version is still doing
that. Please find a way to solve this.
