Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160BF2AF7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgKKSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:11:41 -0500
Received: from foss.arm.com ([217.140.110.172]:59444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgKKSLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:11:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A240C142F;
        Wed, 11 Nov 2020 10:11:40 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 229A83F718;
        Wed, 11 Nov 2020 10:11:39 -0800 (PST)
Subject: Re: [PATCH 10/24] x86/resctrl: Move the schema names into struct
 resctrl_schema
To:     Jamie Iles <jamie@nuviainc.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-11-james.morse@arm.com>
 <20201110113922.GA94467@poplar>
From:   James Morse <james.morse@arm.com>
Message-ID: <45b6313b-eef3-86ff-f27e-8630c2e19288@arm.com>
Date:   Wed, 11 Nov 2020 18:11:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201110113922.GA94467@poplar>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

Thanks for taking a look,

On 10/11/2020 11:39, Jamie Iles wrote:
> On Fri, Oct 30, 2020 at 04:11:06PM +0000, James Morse wrote:
>> Move the names used for the schemata file out of the resource and
>> into struct resctrl_schema. This allows one resource to have two
>> different names, based on the other schema properties.
>>
>> This patch copies the names, eventually resctrl will generate them.
>>
>> Remove the arch code's max_name_width, this is now resctrl's
>> problem.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 311a3890bc53..48f4d6783647 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2150,6 +2151,12 @@ static int create_schemata_list(void)
>>  		s->num_closid = resctrl_arch_get_num_closid(r);
>>  		s->conf_type = resctrl_to_arch_res(r)->conf_type;
>>  
>> +		ret = snprintf(s->name, sizeof(s->name), r->name);
>> +		if (ret >= sizeof(s->name)) {
>> +			kfree(s);
>> +			return -EINVAL;
>> +		}
>> +
> 
> How about:
> 
> +		ret = strscpy(s->name, r->name, sizeof(s->name));
> +		if (ret < 0)) {
> +			kfree(s);
> +			return -EINVAL;
> +		}

Never heard of it ... yup, that looks better. Thanks!
(I thought I knew not to write that bug!)


> So that there isn't a non-constant format specifier that'll trip 
> Coverity+friends up later?

Heh, its gone by the last patch.
Fixed locally.


Thanks,

James
