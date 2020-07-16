Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA262218BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 02:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGPAUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 20:20:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgGPAUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:20:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G02nFu017494;
        Wed, 15 Jul 2020 20:20:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3298ec8pkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 20:20:42 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06G049A9020564;
        Wed, 15 Jul 2020 20:20:41 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3298ec8pkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 20:20:41 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G0KIl8015970;
        Thu, 16 Jul 2020 00:20:40 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 327529cq4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 00:20:40 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G0KedW30802178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 00:20:40 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EF93AC059;
        Thu, 16 Jul 2020 00:20:40 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F708AC05F;
        Thu, 16 Jul 2020 00:20:35 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.73.114])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 00:20:34 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466093748.24747.4655547403463921814.stgit@hbathini.in.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 07/12] ppc64/kexec_file: add support to relocate purgatory
In-reply-to: <159466093748.24747.4655547403463921814.stgit@hbathini.in.ibm.com>
Date:   Wed, 15 Jul 2020 21:20:31 -0300
Message-ID: <871rlc9upc.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> Right now purgatory implementation is only minimal. But if purgatory
> code is to be enhanced to copy memory to the backup region and verify

Can't the memcpy be done in asm? We have arch/powerpc/lib/memcpy_64.S
for example, perhaps it could be linked in with the purgatory?

> sha256 digest, relocations may have to be applied to the purgatory.

Do we want to do the sha256 verification? My original patch series for
kexec_file_load() had a purgatory in C from kexec-tools which did the
sha256 verification but Michael Ellerman thought it was unnecessary and
decided to use the simpler purgatory in asm from kexec-lite.

As a result, this relocation processing became unnecessary.

> So, add support to relocate purgatory in kexec_file_load system call
> by setting up TOC pointer and applying RELA relocations as needed.

If we do want to use a C purgatory, Michael Ellerman had suggested
building it as a Position Independent Executable, which greatly reduces
the number and types of relocations that are needed. See patches 4 and 9
here:

https://lore.kernel.org/linuxppc-dev/1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com/

In the series above I hadn't converted x86 to PIE. If I had done that,
possibly Dave Young's opinion would have been different. :-)

If that's still not desirable, he suggested in that discussion lifting
some code from x86 to generic code, which I implemented and would
simplify this patch as well:

https://lore.kernel.org/linuxppc-dev/5009580.5GxAkTrMYA@morokweng/

> Reported-by: kernel test robot <lkp@intel.com>
> [lkp: In v1, 'struct mem_sym' was declared in parameter list]
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> v2 -> v3:
> * Fixed get_toc_section() to return the section info that had relocations
>   applied, to calculate the correct toc pointer.
> * Fixed how relocation value is converted to relative while applying
>   R_PPC64_REL64 & R_PPC64_REL32 relocations.
>
> v1 -> v2:
> * Fixed wrong use of 'struct mem_sym' in local_entry_offset() as
>   reported by lkp. lkp report for reference:
>     - https://lore.kernel.org/patchwork/patch/1264421/
>
>
>  arch/powerpc/kexec/file_load_64.c      |  337 ++++++++++++++++++++++++++++++++
>  arch/powerpc/purgatory/trampoline_64.S |    8 +
>  2 files changed, 345 insertions(+)

--
Thiago Jung Bauermann
IBM Linux Technology Center
