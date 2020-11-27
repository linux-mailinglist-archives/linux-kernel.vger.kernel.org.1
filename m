Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397C62C680B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgK0OmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:42:03 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:1088 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727653AbgK0OmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:42:03 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AREafeF009256;
        Fri, 27 Nov 2020 14:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=9jmo7taftnySMyGHhJ7mEYoDjdfBXZTyj1fL7vlCtMg=;
 b=oLiLp0/dfMV54r9/0BeQTHS4Kge1kv6r7fqgwxtRZViR25u6NBtR4hB7nPbHiCH4SV3u
 wjOZqb4nzznI1zMmsM+OmRzNNMtPkTjYdyLEpoz13199ffqSE7VrP/+febpL+N0R2ezO
 Hi/GsCQnHK0wOkTqUOoShtmtasfbIVts2YrxGkfSb+JWzeQcZryAdLSwmrPModvhDzWr
 F7uEfm4l/qXjUBKYbzVEdDJweAFvVXH0v1z9wX0QJsNYYSV79Kdpoulh0cffN9GSO5eA
 q104sZ+R1y0LSI3iFS7PPih5WnR9bq0hxqBs6rsQxqRXdxsJQ0D53/S6bjOuPG26QxuB 2A== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 351hp4mkxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 14:41:35 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id A1BAD9A;
        Fri, 27 Nov 2020 14:41:34 +0000 (UTC)
Received: from [16.99.208.125] (unknown [16.99.208.125])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 9480A4C;
        Fri, 27 Nov 2020 14:41:32 +0000 (UTC)
Subject: Re: [PATCH 0/5] x86/platform/uv: Move UV procfs leaves to sysfs
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
 <815f9d40-6c17-9bd3-f3c8-626d007b8597@redhat.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <2acf6156-7bae-7817-4cc6-902798c7af4e@hpe.com>
Date:   Fri, 27 Nov 2020 06:41:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <815f9d40-6c17-9bd3-f3c8-626d007b8597@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_08:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2020 2:44 AM, Hans de Goede wrote:
> Hi,
> 
> On 11/25/20 6:29 PM, Mike Travis wrote:
>>
>> Duplicate the current UV procfs leaves to the uv_sysfs driver so they show
>> up under /sys/firmware/sgi_uv.  Show a 'deprecated' warning message if
>> any of the old /proc/sgi_uv leaves are used.
>>
>> These patches depend on the prior set sent by Justin Ernst <justin.ernst@hpe.com>
>> 	x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
>> 	x86/platform/uv: Add and export uv_bios_* functions
>> 	x86/platform/uv: Add new uv_sysfs platform driver
>> 	x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
>> 	x86/platform/uv: Update MAINTAINERS for uv_sysfs driver
>>
>> Mike Travis (5):
>>    x86/platform/uv: Add kernel interfaces for obtaining system info.
>>    x86/platform/uv: Add sysfs leaves to replace those in procfs
>>    x86/platform/uv: Add sysfs hubless leaves
>>    x86/platform/uv: Add deprecated messages to /proc info leaves
>>    x86/platform/uv: Update sysfs document file
>>
>>   .../ABI/testing/sysfs-firmware-sgi_uv         | 16 +++++
>>   arch/x86/include/asm/uv/bios.h                |  2 +
>>   arch/x86/kernel/apic/x2apic_uv_x.c            | 38 +++++++++-
>>   drivers/platform/x86/uv_sysfs.c               | 70 ++++++++++++++++++-
>>   4 files changed, 123 insertions(+), 3 deletions(-)
> 
> This series depends on the:
> 
> [PATCH v3 0/5] x86/platform/uv: Add uv_sysfs platform driver
> 
> Series, next time when such a thing is the case, please add a note
> about this to the cover letter.
> 
> Like with the "[PATCH v3 0/5] x86/platform/uv: Add uv_sysfs platform driver" series,
> this series too should be merged in its entirety through the x86/tip tree (once the
> other series is merged). Please also add this info to the cover letter.
> 
> I've one remark to patch 4 (which I send in a reply to that). So a v2 is going
> to be necessary. Please include the above bits in the v2 cover-letter.

I was just about to send a notice that Justin changed the underlying 
patch that these depend on.  (I was gone late Wednesday and all day 
yesterday).  That will be done later today, thanks!

> 
> Regards,
> 
> Hans
> 
