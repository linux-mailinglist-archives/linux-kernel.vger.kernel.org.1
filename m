Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05962D5448
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 08:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgLJG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:59:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387710AbgLJG7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:59:41 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BA6k3wX053355;
        Thu, 10 Dec 2020 01:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ATakwJINK6jnXKdq0dMDiMbEb7rzVkjImDTQ3oeVrrs=;
 b=qs+VAx5Pa/t45KFXarmsKvAgoxHH70Ora3rKINoRs45ItPoFIZ6Npaa5rL5KyuOczDbM
 qjT4mQ3udtD0FmB8OJyJjIm5pdeIk2icVLqjUer5pCefz98PqdTZ9HXGN8JfmdXDM8/V
 cI29jt1UQ0Cj/xfUomiVZ2RFQlMQKWnS3l/s2MfssYkWXCWc3JI0YUt2bfT0KNI6QA3g
 F/bD2e2OU5VfTHZUyUMab7EcD0AnuaR8xmUk4/3vhq+7KhFv6QKkguRXIIMpfw3pLf9D
 opsXsLFnAIT6+g9V518GqG8irmX8L5gW8Uum5+4mPctK+AM5MA385vFHOu5RcJa6SaH9 jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35beps88b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 01:58:51 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BA6wpo4096854;
        Thu, 10 Dec 2020 01:58:51 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35beps88ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 01:58:51 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BA6vdl9005466;
        Thu, 10 Dec 2020 06:58:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u85fhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 06:58:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BA6wlLW22479132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 06:58:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55EFF42042;
        Thu, 10 Dec 2020 06:58:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D241F4203F;
        Thu, 10 Dec 2020 06:58:46 +0000 (GMT)
Received: from osiris (unknown [9.171.82.177])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 10 Dec 2020 06:58:46 +0000 (GMT)
Date:   Thu, 10 Dec 2020 07:58:45 +0100
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
Message-ID: <20201210065845.GA20691@osiris>
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
 <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
 <20201208152709.GA26979@osiris>
 <7484e153-6c77-8325-6195-621fe144011e@arm.com>
 <20201209145717.GD7160@osiris>
 <04da0f9c-d50e-7729-5e4c-b0dc4e76d608@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04da0f9c-d50e-7729-5e4c-b0dc4e76d608@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_01:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:48:11AM +0530, Anshuman Khandual wrote:
> >> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
> >> will create three range checks i.e two memhp_range_allowed() and the
> >> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
> >> paths, which is not optimal.
> > 
> > Ah, sorry. I didn't follow this discussion too closely. I just thought
> > my point of view would be clear: let's not have two different ways to
> > check for the same thing which must be kept in sync.
> > Therefore I was wondering why this next version is still doing
> > that. Please find a way to solve this.
> 
> The following change is after the current series and should work with
> and without memory hotplug enabled. There will be just a single place
> i.e vmem_get_max_addr() to update in case the maximum address changes
> from VMEM_MAX_PHYS to something else later.

Still not. That's way too much code churn for what you want to achieve.
If the s390 specific patch would look like below you can add

Acked-by: Heiko Carstens <hca@linux.ibm.com>

But please make sure that the arch_get_mappable_range() prototype in
linux/memory_hotplug.h is always visible and does not depend on
CONFIG_MEMORY_HOTPLUG. I'd like to avoid seeing sparse warnings
because of this.

Thanks.

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 77767850d0d0..e0e78234ae57 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -291,6 +291,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
+	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
 	rc = vmem_add_mapping(start, size);
 	if (rc)
 		return rc;
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b0..ccd55e2f97f9 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -4,6 +4,7 @@
  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
+#include <linux/memory_hotplug.h>
 #include <linux/memblock.h>
 #include <linux/pfn.h>
 #include <linux/mm.h>
@@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
 	mutex_unlock(&vmem_mutex);
 }
 
+struct range arch_get_mappable_range(void)
+{
+	struct range range;
+
+	range.start = 0;
+	range.end = VMEM_MAX_PHYS;
+	return range;
+}
+
 int vmem_add_mapping(unsigned long start, unsigned long size)
 {
+	struct range range;
 	int ret;
 
-	if (start + size > VMEM_MAX_PHYS ||
+	range = arch_get_mappable_range();
+	if (start < range.start ||
+	    start + size > range.end ||
 	    start + size < start)
 		return -ERANGE;
 
