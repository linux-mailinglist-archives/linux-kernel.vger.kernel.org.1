Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540352C6851
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgK0O6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:58:41 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:12340 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729913AbgK0O6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:58:40 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AREu134028481;
        Fri, 27 Nov 2020 14:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=P78eiXI2l6YSBMrsOcqwG8GAu1JGBCWoQ88M2ehrAjc=;
 b=dPH0TafQGCUM7TRKVbFzsIQhhY9xWodzsa1AjvLGLFGO90nxlj5/I2A8K7MLIhx9TwCS
 ET136Zei20ZLxNP9vn29zVBvmxzFTG3jO0Gv9jiREy7wWvCOxFXSMTHOlhqg1Vyb9pSH
 sRWLe10QYbANeTGGnB/aESZqv6mK5QeEoI9GV9cGD+MFVFL4n4nf5yKNiLnOrYldVOJb
 SX47jcYV36ZR2z7EPwAsaBKkpl2I4vZ3TKkPtCNit8hDanDFAZzOJ5rT4IJ5R5P7+aAh
 TckmErAWwv22a7F/Jlt7bfo+E5zWbHiwjeuv8GO3bpKK1+Oi8q8CP+ZtO9cpSOn0ZQ1p yw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 352fm3qh5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 14:58:25 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 5980C54;
        Fri, 27 Nov 2020 14:58:24 +0000 (UTC)
Received: from [16.99.208.125] (unknown [16.99.208.125])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id CF33B4B;
        Fri, 27 Nov 2020 14:58:22 +0000 (UTC)
Subject: Re: [PATCH 4/5] x86/platform/uv: Add deprecated messages to /proc
 info leaves
To:     Hans de Goede <hdegoede@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20201125172907.240996-1-mike.travis@hpe.com>
 <20201125172907.240996-5-mike.travis@hpe.com>
 <b0339696-049a-e46e-bcd4-079f1b13d725@redhat.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <ebd8451a-5910-1da5-4792-2a3d2f59b348@hpe.com>
Date:   Fri, 27 Nov 2020 06:58:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <b0339696-049a-e46e-bcd4-079f1b13d725@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_08:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2020 2:45 AM, Hans de Goede wrote:
> Hi,
> 
> On 11/25/20 6:29 PM, Mike Travis wrote:
>> Add "deprecated" message to any access to old /proc/sgi_uv/* leaves.
>>
>> Signed-off-by: Mike Travis <mike.travis@hpe.com>
>> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
>> ---
>>   arch/x86/kernel/apic/x2apic_uv_x.c | 26 +++++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
>> index 48746031b39a..bfd77a00c2a1 100644
>> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
>> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
>> @@ -1615,21 +1615,45 @@ static void check_efi_reboot(void)
>>   		reboot_type = BOOT_ACPI;
>>   }
>>   
>> -/* Setup user proc fs files */
>> +/*
>> + * User proc fs file handling now deprecated.
>> + * Recommend using /sys/firmware/sgi_uv/... instead.
>> + */
>> +static void proc_print_msg(int *flag, char *what, char *which)
>> +{
>> +	if (*flag)
>> +		return;
>> +
>> +	pr_notice(
>> +		"%s: using deprecated /proc/sgi_uv/%s, use /sys/firmware/sgi_uv/%s\n",
>> +		current->comm, what, which ? which : what);
>> +
>> +	*flag = 1;
>> +}
>> +
> 
> You have just re-invented pr_notice_once, please just use pr_notice_once
> directly in the _show functions.

I tried it both ways (actually with rate limiting as well).  The problem 
with using a static check in the error print function it will only print 
the first instance it encounters, not all of the references.

If I move it to the final output I need to replicate the verbiage of the 
format for every instance as you can't seem to combine the KERN_* level 
of printing and the pr_fmt reference of the format string.  I tried a 
few ways including just putting everything into a format character list. 
  But what used to work (indirect format pointer) doesn't any more.  Or 
I didn't hit on the correct combination of KERN_* level and indirect 
format string.

The last combination was no print limiting which caused of course the 
error message to be output on every occurrence.  (NASA has 35,000 
customers for their big systems, that's a lot of potential console 
messages.)  This really annoys them and we would get calls from those 
that don't have any means of changing this so they ask us.

So I just chose this method of accomplishing all goals, except of course 
using the higher level of print function (pr_notice_once).  But if you 
think method two ("use pr_notice_once directly in the _show function") 
is most favorable I will switch to that.  Thanks.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>>   static int __maybe_unused proc_hubbed_show(struct seq_file *file, void *data)
>>   {
>> +	static int flag;
>> +
>> +	proc_print_msg(&flag, "hubbed", "hub_type");
>>   	seq_printf(file, "0x%x\n", uv_hubbed_system);
>>   	return 0;
>>   }
>>   
>>   static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
>>   {
>> +	static int flag;
>> +
>> +	proc_print_msg(&flag, "hubless", NULL);
>>   	seq_printf(file, "0x%x\n", uv_hubless_system);
>>   	return 0;
>>   }
>>   
>>   static int __maybe_unused proc_archtype_show(struct seq_file *file, void *data)
>>   {
>> +	static int flag;
>> +
>> +	proc_print_msg(&flag, "archtype", NULL);
>>   	seq_printf(file, "%s/%s\n", uv_archtype, oem_table_id);
>>   	return 0;
>>   }
>>
> 
