Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0162BBCEA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKUEMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgKUEMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:12:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CEBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=y9J6TA2XyIOiGe135EkUeEFKYt+K/2ofYTqPfM8e/Hg=; b=UFhGKBLKLlMO8H35N3k/HTU7fO
        eJ2ZZhm/uIlwbtp58Dku/UBNsQThaWEl97F5S0sVZDY/WU3VfhahcTlp/CRXEs9WMWacqmFqcfAF5
        nyoOuNXnLZQPBKl0p7RH6cvpwRPsO7rWMe6ZobzlH4S/AnogSu5SZ+t2xpbujvCwT84fZO6Qufffy
        kj1LRfFanOacmBjc+YEfOj0ijarCQK1M9mM1V7sxQvevX/w3aUJoRHEWVyjJwQQBVMzXCJLHOBXm4
        FN2zx03TGX3DoqIkAoun19WpVYWtO4u+KLt9wp0QF+Gkxw2grI8s5EBfHFb6JQyXWEC53IC1SGg0L
        WopuaFAA==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgKFw-0003el-3I; Sat, 21 Nov 2020 04:12:12 +0000
Subject: Re: [PATCH v3 4/4] Documentation/admin-guide: Change doc for
 split_lock_detect parameter
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <20201121023624.3604415-1-fenghua.yu@intel.com>
 <20201121023624.3604415-5-fenghua.yu@intel.com>
 <d90ce156-5c44-e0b2-276e-a818ce99317f@infradead.org>
 <38db3c2d5d51432b95cd1011c9f83c27@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <171caa46-8431-ee58-2cad-954cb63cb1f3@infradead.org>
Date:   Fri, 20 Nov 2020 20:12:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <38db3c2d5d51432b95cd1011c9f83c27@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 8:09 PM, Yu, Fenghua wrote:
> Hi, Randy,
> 
>>> +			ratelimit:N -
>>> +				  Set rate limit to N bus locks per second
>>> +				  for bus lock detection. 0 < N <= HZ/2 and
>>> +				  N is approximate. Only applied to non-root
>>> +				  users.
>>
>> Sorry, but I don't know what this means. I think it's the "and N is
>> appropriate"
>> that is confusing me.
>>
>> 	0 < N <= HZ/2 and N is appropriate.
> 
> You are right. I will remove "and N is appropriate" in the next version.
> 
> Could you please ack this patch? Can I add Acked-by from you in the updated patch?
> 
> Thank you very much for your review!

Sure, no problem.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy

