Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6B02F278E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbhALFMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbhALFMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:12:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0471C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=4SQiotDc0WyN3zkfnQk8JopWJhUdwzcHG6l2z2LoUko=; b=Ran4ZpWTGmneDCBX81RUxf2h+D
        106DfrT1pW1sj7wzWNTWkiT7gIQgNRyfF+QKWPMrAlPOQp+NIFcX9t8X1kQFUV7R2jloKF9MxThhl
        ZdFzNZzeSXk7WsHBU8OZ0bXtC+DQZ1sp93qKVfIoi7V+BfQHHEOcdUKlWH/fuzB0Yu1mUlLSjl8MS
        uA3ybnbYJc2zWNpCucyGe49w0DjvuaomGu7cJrhXnD4XRIm5CsPMwcHdXt/fNsrfGLEsVsHdhF90m
        yUY4JO3PCHdNONCUsvMrgEIjGdmrx9XLTEmGq6UL4uPCrvcYMvompThMrY0ffNuGpCG2bsFaLp5aS
        tKPWHdHg==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzByT-0004Aq-PA; Tue, 12 Jan 2021 05:12:10 +0000
Subject: Re: [PATCH] arch: x866: kernel: cpu: Take away a single latter to
 match the structure member below
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210112050111.5584-1-unixbhaskar@gmail.com>
 <e16c1779-37e3-4cb1-e68b-888b645cc7a2@embeddedor.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f0f447a2-a357-51d8-330e-3eee0dd777f6@infradead.org>
Date:   Mon, 11 Jan 2021 21:12:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e16c1779-37e3-4cb1-e68b-888b645cc7a2@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 9:10 PM, Gustavo A. R. Silva wrote:
> 
> The subject line contains a typo:
> 
> s/latter/letter
> 
> --
> Gustavo
> 
> On 1/11/21 23:01, Bhaskar Chowdhury wrote:
>> s/kernlfs/kernfs/p
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index ee71c47844cb..3bfca0bebf56 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -142,7 +142,7 @@ enum rdtgrp_mode {
>>
>>  /**
>>   * struct mongroup - store mon group's data in resctrl fs.
>> - * @mon_data_kn		kernlfs node for the mon_data directory
>> + * @mon_data_kn		kernfs node for the mon_data directory

and that should have an ending colon, as:

 * @mon_data_kn:		blah blah

>>   * @parent:			parent rdtgrp
>>   * @crdtgrp_list:		child rdtgroup node list
>>   * @rmid:			rmid for this rdtgroup


-- 
~Randy

