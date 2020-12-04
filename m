Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C72CED62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgLDLp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:45:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729779AbgLDLp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:45:28 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4BXXPZ104298;
        Fri, 4 Dec 2020 06:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BxocSLlgfloMe6T+L8rIEKZtxjAGh/dLtKfxgPAFIvQ=;
 b=lnW9X/vNLrljm4wrEBQBJReMOJ7THvwkIAxhJ1oj5weSlgzWlMnNJvLFEBtsLWUt21fn
 W2DefjL8xXLy8wr/UymSIsgAQ0yg06eStdg/G2/FS5BXSl5MUcvtF7eoF1gz2X8bTt2p
 S4PY0pFIb6Z1Em+rpnX2jltx5Tt/zuRuMcoqbEnBiMo9H0yGsQUp2iP2BmvryT3fmwwy
 WLXqb7EVhoa9QrPwG2hZH77lwRzewMiVhhdYeaZwS2AS2zHRROj/m+9a9NY3VsK9pOdO
 jRygdDHzbwptKh9UUS6/EaMSlID/gOt8yycHZqPVNggDZyi13UzijVDg2iRa6hsFAjbO +Q== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35773521mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 06:44:08 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B4BcCcC023793;
        Fri, 4 Dec 2020 11:44:06 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 353dthb8ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 11:44:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B4Bi3ms4588224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Dec 2020 11:44:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1925A4040;
        Fri,  4 Dec 2020 11:44:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAADAA404D;
        Fri,  4 Dec 2020 11:44:02 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Dec 2020 11:44:02 +0000 (GMT)
Date:   Fri, 4 Dec 2020 13:44:00 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Wei Li <liwei213@huawei.com>, catalin.marinas@arm.com,
        fengbaopeng2@hisilicon.com, nsaenzjulienne@suse.de,
        steve.capper@arm.com, song.bao.hua@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        butao@hisilicon.com
Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the
 memory reserved for the page map
Message-ID: <20201204114400.GT123287@linux.ibm.com>
References: <20201204014443.43329-1-liwei213@huawei.com>
 <20201204111347.GA844@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204111347.GA844@willie-the-truck>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_03:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=562 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=5
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:13:47AM +0000, Will Deacon wrote:
> On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
> > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> > do not free the reserved memory for the page map, decrease the section
> > size can reduce the waste of reserved memory.
> > 
> > Signed-off-by: Wei Li <liwei213@huawei.com>
> > Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
> > Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> > ---
> >  arch/arm64/include/asm/sparsemem.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> > index 1f43fcc79738..8963bd3def28 100644
> > --- a/arch/arm64/include/asm/sparsemem.h
> > +++ b/arch/arm64/include/asm/sparsemem.h
> > @@ -7,7 +7,7 @@
> > 
> >  #ifdef CONFIG_SPARSEMEM
> >  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> > -#define SECTION_SIZE_BITS	30
> > +#define SECTION_SIZE_BITS	27
> 
> We chose '30' to avoid running out of bits in the page flags. What changed?

I think that for 64-bit there are still plenty of free bits. I didn't
check now, but when I played with SPARSEMEM on m68k there were 8 bits
for section out of 32.

> With this patch, I can trigger:
> 
> ./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds SECTION_SIZE
> #error Allocator MAX_ORDER exceeds SECTION_SIZE
> 
> if I bump up NR_CPUS and NODES_SHIFT.

I don't think it's related to NR_CPUS and NODES_SHIFT. 
This seems rather 64K pages that cause this.

Not that is shouldn't be addressed.

> Will

-- 
Sincerely yours,
Mike.
