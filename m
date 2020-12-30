Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901642E76C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 08:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgL3HL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 02:11:26 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:59685 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgL3HLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 02:11:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UKD938t_1609312238;
Received: from 30.25.200.77(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0UKD938t_1609312238)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Dec 2020 15:10:39 +0800
Subject: Re: [PATCH] checkpatch: ignore warning designated initializers using
 NR_CPUS
To:     Joe Perches <joe@perches.com>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org
References: <2eba2ec8531f440410ee8164aaf2ab754bd5a0d1.1609301434.git.rocking@linux.alibaba.com>
 <5ca6c2d28f6cf091a676f8e7d8f14a933da0b267.camel@perches.com>
From:   Peng Wang <rocking@linux.alibaba.com>
Message-ID: <8564dd96-7ad2-c603-4ff4-ab85caad2852@linux.alibaba.com>
Date:   Wed, 30 Dec 2020 15:10:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <5ca6c2d28f6cf091a676f8e7d8f14a933da0b267.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joe

On 12/30/20 1:35 PM, , Joe Perches wrote:
> On Wed, 2020-12-30 at 12:13 +0800, Peng Wang wrote:
>> Some max_length wants to hold as large room as possible to
>> ensure enough size to tackle with the biggest NR_CPUS. As
>> an example below:
>>
>> kernel/cgroup/cpuset.c:
>> static struct cftype legacy_files[] = {
>>          {
>>                  .name = "cpus",
>>                  .seq_show = cpuset_common_seq_show,
>>                  .write = cpuset_write_resmask,
>>                  .max_write_len = (100U + 6 * NR_CPUS),
>>                  .private = FILE_CPULIST,
>>          },
>> 	...
>> }
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -7022,12 +7022,15 @@ sub process {
>>   
>>
>>   # use of NR_CPUS is usually wrong
>>   # ignore definitions of NR_CPUS and usage to define arrays as likely right
>> +# ignore designated initializers using NR_CPUS
>> +
>>   		if ($line =~ /\bNR_CPUS\b/ &&
>>   		    $line !~ /^.\s*\s*#\s*if\b.*\bNR_CPUS\b/ &&
>>   		    $line !~ /^.\s*\s*#\s*define\b.*\bNR_CPUS\b/ &&
>>   		    $line !~ /^.\s*$Declare\s.*\[[^\]]*NR_CPUS[^\]]*\]/ &&
>>   		    $line !~ /\[[^\]]*\.\.\.[^\]]*NR_CPUS[^\]]*\]/ &&
>> -		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/)
>> +		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/ &&
>> +		    $line !~ /\s*\..*=.*\bNR_CPUS\b.*,$/)
>>   		{
>>   			WARN("NR_CPUS",
>>   			     "usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc\n" . $herecurr);
> 
> I wonder if it's worth it as there just aren't many of these: (6 total)

It does not look that much, but checkpatch.pl makes warning on this 
especially when "0 errors, 0 warnings" is needed.

> 
> $ git grep -P '\..*=.*\bNR_CPUS\b.*,\s*$'
> drivers/firmware/efi/efi.c:     .cpu_bitmap             = { [BITS_TO_LONGS(NR__CPUS)] = 0},
> drivers/infiniband/hw/hfi1/sdma.c:      .max_size = NR_CPUS,
> init/init_task.c:       .nr_cpus_allowed= NR_CPUS,
> kernel/cgroup/cpuset.c:         .max_write_len = (100U + 6 * NR_CPUS),
> kernel/cgroup/cpuset.c:         .max_write_len = (100U + 6 * NR_CPUS),
> kernel/sysctl.c:                .maxlen         = NR_CPUS,
> 
> It also seems it might be more sensible as:
> 
> 	$line !~ /^.\s*\.\w+\s*=\s*.*\bNR_CPUS\b/

Aha, this is better!
Will send a v2 patch including this if you don't mind, Thanks.

> 
> Which finds a couple more:
> 
> $ git grep -P '^\s*\.\w+\s*=\s*.*\bNR_CPUS\b'
> arch/arm64/include/asm/processor.h:     .fpsimd_cpu = NR_CPUS,                  \
> arch/powerpc/kernel/prom_init.c:                .max_cpus = cpu_to_be32(NR_CPUS),       /* number of cores supported */
> drivers/firmware/efi/efi.c:     .cpu_bitmap             = { [BITS_TO_LONGS(NR_CPUS)] = 0},
> drivers/infiniband/hw/hfi1/sdma.c:      .max_size = NR_CPUS,
> init/init_task.c:       .nr_cpus_allowed= NR_CPUS,
> kernel/cgroup/cpuset.c:         .max_write_len = (100U + 6 * NR_CPUS),
> kernel/cgroup/cpuset.c:         .max_write_len = (100U + 6 * NR_CPUS),
> kernel/sysctl.c:                .maxlen         = NR_CPUS,
> 
