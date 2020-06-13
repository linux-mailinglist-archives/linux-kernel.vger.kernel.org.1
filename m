Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898C61F8055
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 04:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgFMCTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 22:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgFMCTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 22:19:54 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9AC8206F5;
        Sat, 13 Jun 2020 02:19:50 +0000 (UTC)
Subject: Re: drivers/net/can/kvaser_pciefd.c:801:17: sparse: sparse: cast
 removes address space '<asn:2>' of expression
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>,
        Henning Colliander <henning.colliander@evidente.se>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
References: <202006121356.lKucoVPo%lkp@intel.com>
 <e93fe895-a6b8-34ff-f9c8-00ec7138b1c1@pengutronix.de>
 <9b599221-3c15-909c-168a-766c554827d9@linux-m68k.org>
 <20200612163509.6ieqxm4peqcfgd7o@ltop.local>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <27273ebc-1240-8615-798e-b68878b80494@linux-m68k.org>
Date:   Sat, 13 Jun 2020 12:19:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612163509.6ieqxm4peqcfgd7o@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/6/20 2:35 am, Luc Van Oostenryck wrote:
> On Sat, Jun 13, 2020 at 01:33:16AM +1000, Greg Ungerer wrote:
>> On 12/6/20 5:48 pm, Marc Kleine-Budde wrote:
>> I think this one is due to not forcing the volatile cast in __raw_write().
>> So this change will fix that:
>>
>> diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
>> index 0498192e1d98..1bc739f1f1ad 100644
>> --- a/arch/m68k/include/asm/io_no.h
>> +++ b/arch/m68k/include/asm/io_no.h
>> @@ -14,15 +14,15 @@
>>    * that behavior here first before we include asm-generic/io.h.
>>    */
>>   #define __raw_readb(addr) \
>> -    ({ unsigned char __v = (*(volatile unsigned char *) (addr)); __v; })
>> +    ({ u8 __v = (*(__force volatile u8 *) (addr)); __v; })
>>   #define __raw_readw(addr) \
>> -    ({ unsigned short __v = (*(volatile unsigned short *) (addr)); __v; })
>> +    ({ u16 __v = (*(__force volatile u16 *) (addr)); __v; })
>>   #define __raw_readl(addr) \
>> -    ({ unsigned int __v = (*(volatile unsigned int *) (addr)); __v; })
>> +    ({ u32 __v = (*(__force volatile u32 *) (addr)); __v; })
>> -#define __raw_writeb(b, addr) (void)((*(volatile unsigned char *) (addr)) = (b))
>> -#define __raw_writew(b, addr) (void)((*(volatile unsigned short *) (addr)) = (b))
>> -#define __raw_writel(b, addr) (void)((*(volatile unsigned int *) (addr)) = (b))
>> +#define __raw_writeb(b, addr) (void)((*(__force volatile u8 *) (addr)) = (b))
>> +#define __raw_writew(b, addr) (void)((*(__force volatile u16 *) (addr)) = (b))
>> +#define __raw_writel(b, addr) (void)((*(__force volatile u32 *) (addr)) = (b))
> 
> Look good to me but isn't easier to leave them undefined and include
> asm-generic/io.h?

Not so simple at the moment. Although juggling a few things around within
io_no.h will let you use the asm-generic functions it will now throw up
a _lot_ of warnings in many of the architecture files that pass int constant
addresses to the raw_* functions. That is on my todo list.

Regards
Greg

