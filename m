Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C12CC7E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgLBUgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:36:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgLBUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:36:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2KY1DP048621;
        Wed, 2 Dec 2020 15:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=AROrU5uf8FK5x25WkTE5ro/clfKSdtvAsxWSgMb/DW0=;
 b=rf4IyNHjmfnEiS2+lIiNIdBQqHl5jL7DT9zBRVckrF/rF4FB0uHEkbWDZd5YsiR96Dd7
 EXXfwoYnvjFGsCrWK0JtkqS/QFgnsV9JX5qibBvjXB3YKQoAA6X4kGBQFKeS7TQC/31l
 P6XywBDf+wFWDt3W55N4mqKJV7+7OsK81XO3AtTutTXIqIrmb58FuoFAhn8Ht1kX9GHd
 L5nlbLO8k51y9UHheELtlgjY1X88/SIOsnjIAI4qXjDYqgt9ClulzTSDythmSYdIsw+8
 H350sfvep7tgBtYiNyN0PJ80N+Rc90br0Wr5ZtaI5OYx/oH9TtD1CWWlrZZ+WEbsgaln 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 356dgfr1mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 15:35:47 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B2KY8VG049170;
        Wed, 2 Dec 2020 15:35:46 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 356dgfr1kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 15:35:46 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2KRwv9032470;
        Wed, 2 Dec 2020 20:35:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 353e68acha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 20:35:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2KZg9H27197908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 20:35:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46254A4040;
        Wed,  2 Dec 2020 20:35:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A2DA4057;
        Wed,  2 Dec 2020 20:35:41 +0000 (GMT)
Received: from osiris (unknown [9.171.12.240])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 20:35:41 +0000 (GMT)
Date:   Wed, 2 Dec 2020 21:35:40 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC V2 0/3] mm/hotplug: Pre-validate the address range with
 platform
Message-ID: <20201202203540.GC11274@osiris>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_12:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=792
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012020119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:59:49AM +0530, Anshuman Khandual wrote:
> This series adds a mechanism allowing platforms to weigh in and prevalidate
> incoming address range before proceeding further with the memory hotplug.
> This helps prevent potential platform errors for the given address range,
> down the hotplug call chain, which inevitably fails the hotplug itself.
> 
> This mechanism was suggested by David Hildenbrand during another discussion
> with respect to a memory hotplug fix on arm64 platform.
> 
> https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> 
> This mechanism focuses on the addressibility aspect and not [sub] section
> alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
> have been left unchanged. Wondering if all these can still be unified in
> an expanded memhp_range_allowed() check, that can be called from multiple
> memory hot add and remove paths.
> 
> This series applies on v5.10-rc6 and has been slightly tested on arm64.
> But looking for some early feedback here.
> 
> Changes in RFC V2:
> 
> Incorporated all review feedbacks from David.
> 
> - Added additional range check in __segment_load() on s390 which was lost
> - Changed is_private init in pagemap_range()
> - Moved the framework into mm/memory_hotplug.c
> - Made arch_get_addressable_range() a __weak function
> - Renamed arch_get_addressable_range() as arch_get_mappable_range()
> - Callback arch_get_mappable_range() only handles range requiring linear mapping
> - Merged multiple memhp_range_allowed() checks in register_memory_resource()
> - Replaced WARN() with pr_warn() in memhp_range_allowed()
> - Replaced error return code ERANGE with E2BIG
> 
> Changes in RFC V1:
> 
> https://lore.kernel.org/linux-mm/1606098529-7907-1-git-send-email-anshuman.khandual@arm.com/
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Btw. please use git send-email's --cc-cover option to make sure that
all patches of this series will be sent to all listed cc's.
I really dislike to receive only the cover-letter and maybe on patch
and then have to figure out where to find the rest.

Thanks :)
