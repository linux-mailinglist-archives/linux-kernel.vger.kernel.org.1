Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5D302272
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 08:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhAYHdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 02:33:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727237AbhAYHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 02:32:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10P7DBO7142692;
        Mon, 25 Jan 2021 02:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=TuGY8IWz75AhAWPLAr7pIVZsBex+aBv7yqLuEEUeVbM=;
 b=iWgbiYIc/92wYYo6EJoAUn+v5x+nFUHTojI4PIqIgFMDORxEbRCwg0kT8UjVkukvHJlA
 t5yWoDRdjTYE2sLP9C5xoHSBFVOlVjjhHmNQAacdaCFgPyy7VJf9+xm2O0psbgLfh+lT
 aRRqVbi4l7UVyttqdbdPEIQ+Qk04xVB3i6ReVQOeB6lAIYCdMp00sJ1VM3RegW7G++n6
 V822zTSB3ll60q332dBb7W1NEW7erCNoTNwT5Id0W/D6o5aDSLUz9U2ymA5a5fMc18QI
 STL+ErGjb0rH7XFN/zFlfkJdFiILGZz4w57w5yNEh7UV+67hG82oTKlv/7xZsqLYiPee Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 369sddgbxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 02:31:11 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10P7EnXT149247;
        Mon, 25 Jan 2021 02:31:10 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 369sddgbx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 02:31:10 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10P7MQdv002163;
        Mon, 25 Jan 2021 07:31:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 368be88t8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 07:31:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10P7V50b45875668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 07:31:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A76744C040;
        Mon, 25 Jan 2021 07:31:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F97C4C05A;
        Mon, 25 Jan 2021 07:31:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.26.126])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Jan 2021 07:31:04 +0000 (GMT)
Date:   Mon, 25 Jan 2021 09:31:02 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Message-ID: <20210125073102.GF7648@linux.ibm.com>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
 <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
 <bb5b9c39-d25b-6170-68ea-5b2bf297c1fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb5b9c39-d25b-6170-68ea-5b2bf297c1fd@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_01:2021-01-22,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:52:32AM +0530, Anshuman Khandual wrote:
> 
> On 12/22/20 12:42 PM, Anshuman Khandual wrote:
> > pfn_valid() asserts that there is a memblock entry for a given pfn without
> > MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
> > that they do not have memblock entries. Hence memblock_is_map_memory() will
> > invariably fail via memblock_search() for a ZONE_DEVICE based address. This
> > eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
> > to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
> > into the system via memremap_pages() called from a driver, their respective
> > memory sections will not have SECTION_IS_EARLY set.
> > 
> > Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
> > regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
> > for firmware reserved memory regions. memblock_is_map_memory() can just be
> > skipped as its always going to be positive and that will be an optimization
> > for the normal hotplug memory. Like ZONE_DEVIE based memory, all hotplugged
> > normal memory too will not have SECTION_IS_EARLY set for their sections.
> > 
> > Skipping memblock_is_map_memory() for all non early memory sections would
> > fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
> > performance for normal hotplug memory as well.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Hello David/Mike,
> 
> Given that we would need to rework early sections, memblock semantics via a
> new config i.e EARLY_SECTION_MEMMAP_HOLES and also some possible changes to
> ARCH_KEEP_MEMBLOCK and HAVE_ARCH_PFN_VALID, wondering if these patches here
> which fixes a problem (and improves performance) can be merged first. After
> that, I could start working on the proposed rework. Could you please let me
> know your thoughts on this. Thank you.

I didn't object to these patches, I think they are fine.
I agree that we can look into update of arm64's pfn_valid(), maybe right
after decrease of section size lands in.
 
> - Anshuman

-- 
Sincerely yours,
Mike.
