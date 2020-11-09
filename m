Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F92AB3DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgKIJoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:44:14 -0500
Received: from foss.arm.com ([217.140.110.172]:36358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgKIJoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:44:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6421042;
        Mon,  9 Nov 2020 01:44:13 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24A543F718;
        Mon,  9 Nov 2020 01:44:11 -0800 (PST)
Subject: Re: [PATCH v3 18/26] coresight: etm4x: Clean up exception level masks
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-20-suzuki.poulose@arm.com>
 <20201106185241.GA3299843@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e385a0ff-90e5-de72-78c5-bf4344a854cd@arm.com>
Date:   Mon, 9 Nov 2020 09:44:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201106185241.GA3299843@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/20 6:52 PM, Mathieu Poirier wrote:
> Good morning,

Good morning.

> 
> On Wed, Oct 28, 2020 at 10:09:37PM +0000, Suzuki K Poulose wrote:
>> etm4_get_access_type() calculates the exception level bits
>> for use in address comparator registers. This is also used
>> by the TRCVICTLR register by shifting to the required position.
>>
>> This patch cleans up the logic to make etm4_get_access_type()
>> calcualte a generic mask which can be used by all users by
>> shifting to their field.
>>
>> No functional changes, only code cleanups.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since previous version:
>>    - Fix the duplicate shift. More commentary
>> ---

>> -/* access level control in TRCVICTLR - same bits as TRCACATRn but shifted */
>> -#define ETM_EXLEVEL_LSHIFT_TRCVICTLR	8
>> +/*
>> + * Exception level mask for Secure and Non-Secure ELs.
>> + * ETM defines the bits for EL control (e.g, TRVICTLR, TRCACTRn).
>> + * The Secure and Non-Secure ELs are always to gether.
>> + * Non-secure EL3 is never implemented.
>> + * We use the following generic mask as they appear in different
>> + * registers and this can be shifted for the appropriate
>> + * fields.
>> + */
>> +#define ETM_EXLEVEL_S_APP		BIT(0)	/* Secure EL0		*/
>> +#define ETM_EXLEVEL_S_OS		BIT(1)	/* Secure EL1		*/
>> +#define ETM_EXLEVEL_S_HYP		BIT(2)	/* Secure EL2		*/
>> +#define ETM_EXLEVEL_S_MON		BIT(3)	/* Secure EL3/Montor	*/
> 
> s/Montor/Monitor
> 

>> +#define ETM_EXLEVEL_NS_APP		BIT(4)	/* NonSecure EL0	*/
>> +#define ETM_EXLEVEL_NS_OS		BIT(5)	/* NonSecure EL1	*/
>> +#define ETM_EXLEVEL_NS_HYP		BIT(6)	/* NonSecure EL2	*/
>> +
>> +#define ETM_EXLEVEL_MASK		(GENMASK(6, 0))
> 
> Not used.
> 
>> +#define ETM_EXLEVEL_S_MASK		(GENMASK(3, 0))
>> +#define ETM_EXLEVEL_NS_MASK		(GENMASK(6, 4))
> 
> This needs to be GENMASK(2, 0) in order TRCVICTLR_EXLEVEL_NS_SHIFT to be 20.
> Otherwise the resulting mask is 4 bit off to the left.
> 



Will address the comments. Thanks for spotting the mistakes.

Suzuki

