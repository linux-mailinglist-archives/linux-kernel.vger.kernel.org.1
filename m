Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CC0211272
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgGASSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 14:18:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63946 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbgGASSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:18:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061I3AKg069652;
        Wed, 1 Jul 2020 14:18:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 320s23dsbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:18:13 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 061IICwq116143;
        Wed, 1 Jul 2020 14:18:12 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 320s23dsay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:18:12 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061IGdL4011473;
        Wed, 1 Jul 2020 18:18:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 31wwr7teqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 18:18:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 061IGlgD54133104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jul 2020 18:16:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C58B42061;
        Wed,  1 Jul 2020 18:18:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5625E42059;
        Wed,  1 Jul 2020 18:18:04 +0000 (GMT)
Received: from [9.102.31.46] (unknown [9.102.31.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jul 2020 18:18:04 +0000 (GMT)
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
To:     Dave Young <dyoung@redhat.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
From:   Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <6e96ae5a-91fd-726e-1eda-314f2317d8b4@linux.ibm.com>
Date:   Wed, 1 Jul 2020 23:48:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_09:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 cotscore=-2147483648 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/20 1:10 pm, Dave Young wrote:
> Hi Hari,
> On 06/27/20 at 12:35am, Hari Bathini wrote:
>> crashkernel region could have an overlap with special memory regions
>> like  opal, rtas, tce-table & such. These regions are referred to as
>> exclude memory ranges. Setup this ranges during image probe in order
>> to avoid them while finding the buffer for different kdump segments.
>> Implement kexec_locate_mem_hole_ppc64() that locates a memory hole
>> accounting for these ranges. Also, override arch_kexec_add_buffer()
>> to locate a memory hole & later call __kexec_add_buffer() function
>> with kbuf->mem set to skip the generic locate memory hole lookup.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/crashdump-ppc64.h |   10 +
>>  arch/powerpc/include/asm/kexec.h           |    7 -
>>  arch/powerpc/kexec/elf_64.c                |    7 +
>>  arch/powerpc/kexec/file_load_64.c          |  292 ++++++++++++++++++++++++++++
>>  4 files changed, 312 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/powerpc/include/asm/crashdump-ppc64.h
>>
> [snip]
>>  /**
>> + * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
>> + *                             regions like opal/rtas, tce-table, initrd,
>> + *                             kernel, htab which should be avoided while
>> + *                             setting up kexec load segments.
>> + * @mem_ranges:                Range list to add the memory ranges to.
>> + *
>> + * Returns 0 on success, negative errno on error.
>> + */
>> +static int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
>> +{
>> +	int ret;
>> +
>> +	ret = add_tce_mem_ranges(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_initrd_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_htab_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_kernel_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_rtas_mem_range(mem_ranges, false);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_opal_mem_range(mem_ranges, false);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_reserved_ranges(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* exclude memory ranges should be sorted for easy lookup */
>> +	sort_memory_ranges(*mem_ranges);
>> +out:
>> +	if (ret)
>> +		pr_err("Failed to setup exclude memory ranges\n");
>> +	return ret;
>> +}
> 
> I'm confused about the "overlap with crashkernel memory", does that mean
> those normal kernel used memory could be put in crashkernel reserved

There are regions that could overlap with crashkernel region but they are
not normal kernel used memory though. These are regions that kernel and/or
f/w chose to place at a particular address for real mode accessibility
and/or memory layout between kernel & f/w kind of thing.

> memory range?  If so why can't just skip those areas while crashkernel
> doing the reservation?

crashkernel region has a dependency to be in the first memory block for it
to be accessible in real mode. Accommodating this requirement while addressing
other requirements would mean something like what we have now. A list of
possible special memory regions in crashkernel region to take care of.

I have plans to split crashkernel region into low & high to have exclusive
regions for crashkernel, even if that means to have two of them. But that
is for another day with its own set of complexities to deal with...

Thanks
Hari
