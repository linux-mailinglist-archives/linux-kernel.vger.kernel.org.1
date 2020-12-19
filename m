Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0E2DF1D3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgLSVfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:35:52 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:34648 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgLSVfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:35:51 -0500
Received: from [192.168.42.210] ([93.23.15.221])
        by mwinf5d37 with ME
        id 6Ma4240034mA9Nd03Ma4rr; Sat, 19 Dec 2020 22:34:06 +0100
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Dec 2020 22:34:06 +0100
X-ME-IP: 93.23.15.221
Subject: Re: [PATCH] irqdomain: Add documentation for irq_create_of_mapping()
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, mripard@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20201215200747.148439-1-christophe.jaillet@wanadoo.fr>
 <87sg83q6t4.wl-maz@kernel.org>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <5bddaaae-d7d2-7ede-ab3f-db1ff9353c2d@wanadoo.fr>
Date:   Sat, 19 Dec 2020 22:34:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87sg83q6t4.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 18/12/2020 à 19:59, Marc Zyngier a écrit :
> Hi Christophe,
>
> On Tue, 15 Dec 2020 20:07:47 +0000,
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>> Add a description for 'irq_create_of_mapping()' and make explicit the fact
>> that the resources allocated by this function can be freed by calling
>> 'irq_dispose_mapping()' when needed (i.e. error handling path, remove
>> function, ...)
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> The wording can certainly be improved.
>>
>> My goal is only to make clear if patches such as:
>>     https://lore.kernel.org/lkml/20201214202117.146293-1-christophe.jaillet@wanadoo.fr/
>> are needed or not.
>> ---
>>   kernel/irq/irqdomain.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 6aacd342cd14..d761ece8d43e 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -858,6 +858,15 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>>   }
>>   EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
>>   
>> +/**
>> + * irq_create_of_mapping() - Map an interrupt
> I think this deserves a bit more work. My immediate questions when
> reading this are "map where? and to what?".

I won't be of great help here.
I don't know this code enough to be able to provide an accurate description.

>> + * @irq_data: structure of_phandle_args returned by a previous
>> + * of_irq_parse_xxx() call
> That's not strictly true. A of_phandle_args structure can be created
> from scratch (and numerous drivers do that).
>
>> + *
>> + * The resources allocated by this function should be freed by
>> + * calling irq_dispose_mapping() when the mapping if not useful
>> + * anymore.
> This really is a bit of documentation for irq_dispose_mapping(), isn't it?

Well, I don't agree.

I think it is easier to see that some resources need to be freed with a 
dedicated function if it is explained in the description of the function 
which allocates the resource.

CJ

>
>> + */
>>   unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>>   {
>>   	struct irq_fwspec fwspec;
> Thanks,
>
> 	M.
>
