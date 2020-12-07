Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568AD2D0D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgLGJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:43:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13416 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgLGJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:43:25 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B79VqvC196429;
        Mon, 7 Dec 2020 04:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mQGSCBXNc8nCe9NfCcbbUQy7sSkvGUcFQbqQDgycAUE=;
 b=l7NgRGBXLzvfS1gF4adM4aodiZgPbg3nra6vS5oc6Kub/IoLAA88b9e63sLTCAC1RJwm
 tupnt5EYt2ijgRtbnwH9neSmDCRvXCuXhomXTMMa5/L78VI1wEThFagvibfRIyXBXHN5
 Bh/ulEAN3fXVMEdesOC+nq1i/7exgg9XPoiNT0VrLW6chRuDN9BiUq74sXTcOwJ5HBrg
 GkakJh7xTHUmXt8NeWt1osLbAyC2eGfsMiWx48X3cuRxWhUxDlJtEhY4SSx3AuG6vDoy
 4kWLi2XvbOkJpOW4pXF+bBZmPu9L5x8seT2Z3OSh8i/Gpy5P7o3A0TjnOV3mmAro7UvO ig== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359hhsrytb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 04:42:23 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B79SZgC012085;
        Mon, 7 Dec 2020 09:42:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3583svj870-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 09:42:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B79gJBZ48234816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 09:42:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23DA0AE051;
        Mon,  7 Dec 2020 09:42:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB976AE056;
        Mon,  7 Dec 2020 09:42:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  7 Dec 2020 09:42:17 +0000 (GMT)
Date:   Mon, 7 Dec 2020 11:42:15 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Wei Li <liwei213@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fengbaopeng2@hisilicon.com, butao@hisilicon.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the
 memory reserved for the page map
Message-ID: <20201207094215.GC1112728@linux.ibm.com>
References: <20201204014443.43329-1-liwei213@huawei.com>
 <20201204111347.GA844@willie-the-truck>
 <CAMj1kXGQ-CeYcbS-hc+Yy8DKHm2t-RYsLu4+7wOG1bWuJqkjGQ@mail.gmail.com>
 <390f5f441d99a832f4b2425b46f6d971@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390f5f441d99a832f4b2425b46f6d971@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-07_08:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=974 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:35:06AM +0000, Marc Zyngier wrote:
> On 2020-12-07 09:09, Ard Biesheuvel wrote:
> > (+ Marc)
> > 
> > On Fri, 4 Dec 2020 at 12:14, Will Deacon <will@kernel.org> wrote:
> > > 
> > > On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
> > > > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> > > > do not free the reserved memory for the page map, decrease the section
> > > > size can reduce the waste of reserved memory.
> > > >
> > > > Signed-off-by: Wei Li <liwei213@huawei.com>
> > > > Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
> > > > Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> > > > ---
> > > >  arch/arm64/include/asm/sparsemem.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> > > > index 1f43fcc79738..8963bd3def28 100644
> > > > --- a/arch/arm64/include/asm/sparsemem.h
> > > > +++ b/arch/arm64/include/asm/sparsemem.h
> > > > @@ -7,7 +7,7 @@
> > > >
> > > >  #ifdef CONFIG_SPARSEMEM
> > > >  #define MAX_PHYSMEM_BITS     CONFIG_ARM64_PA_BITS
> > > > -#define SECTION_SIZE_BITS    30
> > > > +#define SECTION_SIZE_BITS    27
> > > 
> > > We chose '30' to avoid running out of bits in the page flags. What
> > > changed?
> > > 
> > > With this patch, I can trigger:
> > > 
> > > ./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds
> > > SECTION_SIZE
> > > #error Allocator MAX_ORDER exceeds SECTION_SIZE
> > > 
> > > if I bump up NR_CPUS and NODES_SHIFT.
> > > 
> > 
> > Does this mean we will run into problems with the GICv3 ITS LPI tables
> > again if we are forced to reduce MAX_ORDER to fit inside
> > SECTION_SIZE_BITS?
> 
> Most probably. We are already massively constraint on platforms
> such as TX1, and dividing the max allocatable range by 8 isn't
> going to make it work any better...

I don't think MAX_ORDER should shrink. Even if SECTION_SIZE_BITS is
reduced it should accomodate the existing MAX_ORDER.

My two pennies.

>         M.
> -- 
> Jazz is not dead. It just smells funny...

-- 
Sincerely yours,
Mike.
