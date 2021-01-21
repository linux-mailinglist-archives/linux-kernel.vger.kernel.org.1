Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208C42FE924
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbhAULqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbhAULpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:45:14 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C629E238E3;
        Thu, 21 Jan 2021 11:44:25 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2YNz-009B6g-L6; Thu, 21 Jan 2021 11:44:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Jan 2021 11:44:23 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
In-Reply-To: <20210121112725.GA21750@willie-the-truck>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <20210121112725.GA21750@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <fdc49d125ef9f520254196509f6c0aa2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, mohamed.mediouni@caramail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, mark.rutland@arm.com, marcan@marcan.st, linux-kernel@vger.kernel.org, stan@corellium.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-21 11:27, Will Deacon wrote:
> On Wed, Jan 20, 2021 at 02:27:13PM +0100, Mohamed Mediouni wrote:
>> Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious 
>> hardware quirk.
>> 
>> On Apple processors, writes using the nGnRE device memory type get 
>> dropped in flight,
>> getting to nowhere.
>> 
>> Signed-off-by: Stan Skowronek <stan@corellium.com>
>> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
>> ---
>>  arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>> 
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 1f7ee8c8b7b8..06436916f137 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -51,6 +51,25 @@
>>  #define TCR_KASAN_HW_FLAGS 0
>>  #endif
>> 
>> +#ifdef CONFIG_ARCH_APPLE
>> +
>> +/*
>> + * Apple cores appear to black-hole writes done with nGnRE.
>> + * We settled on a work-around that uses MAIR vs changing every 
>> single user of
>> + * nGnRE across the arm64 code.
>> + */
>> +
>> +#define MAIR_EL1_SET_APPLE						\
>> +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |	\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
>> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
>> +
>> +#endif
>> +
>>  /*
>>   * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal 
>> memory and
>>   * changed during __cpu_setup to Normal Tagged if the system supports 
>> MTE.
>> @@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
>>  	 * Memory region attributes
>>  	 */
>>  	mov_q	x5, MAIR_EL1_SET
>> +#ifdef CONFIG_ARCH_APPLE
>> +	mrs	x0, MIDR_EL1
>> +	lsr	w0, w0, #24
>> +	mov_q	x1, MAIR_EL1_SET_APPLE
>> +	cmp	x0, #0x61			// 0x61 = Implementer: Apple
>> +	csel	x5, x1, x5, eq
> 
> Why does this need to be done so early? It would be a lot cleaner if we
> could detect this in a similar fashion to other errata and update the 
> MAIR
> appropriately. If that's not possible because of early IO mappings 
> (which
> ones?), then we could instead initialise to nGnRnE unconditionally, but
> relax it to nGnRE if we detect that we _don't_ have the erratum.

Would that imply another round-trip into the idmap, much like we do
when we switch to non-global mappings? Or do you expect that we can 
change
the MAIR with live mappings?

         M.
-- 
Jazz is not dead. It just smells funny...
