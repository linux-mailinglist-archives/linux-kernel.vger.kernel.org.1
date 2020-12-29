Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283942E734F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 21:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgL2UBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 15:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2UB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 15:01:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F948C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hknaYncnvFzO1C779LIvHAn1a7BE6equJ8aDcI93zR8=; b=kj+AwoTcwamJZXhxHkWyKVxsQe
        foUYulmgp9J8vj+6JxeYNddC3xyDjTObRg0FyFEuqtPFIXKrppvG30lqrxw5vkXVOMtxH5yCeOc/M
        ue9tARmpv2vTHvxTphUP7vKmvBfLeGMJnNvcBUaPD3UafYN+vLWloTm4426v6nkITvPp5Mve7HVjT
        gTN1cViNW5uSAuigOF2avCuKU3wum7lt1339mv7pyOYPFxtvzFNdYBQlXRhHj1tQDpVEKZe3sWkFT
        Y19x7CBHkwo/lK3UcXGtFaiST7jdxQGSPlFHHHsuWKIB+1aoGjnLKycMz9iE5g8W3HDsYSO5Apu74
        KoZqJ1TA==;
Received: from [2601:1c0:6280:3f0::2c43]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kuLAe-0001DZ-S3; Tue, 29 Dec 2020 20:00:41 +0000
Subject: Re: [RFC PATCH 2/2] mm: readahead: handle LARGE input to
 get_init_ra_size()
From:   Randy Dunlap <rdunlap@infradead.org>
To:     =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
References: <20201220211051.1416-1-rdunlap@infradead.org>
 <20201222173533.c9e28416835d7487b0e28cda@linux-foundation.org>
 <6a595671-20a8-e63f-f3ea-f4749a574efa@infradead.org>
 <d2edfb69-93b4-d938-faf0-5f7c0f1158b9@gmx.de>
 <1f5a6e7b-c779-861e-fde8-409ca8e2541b@infradead.org>
Message-ID: <bb5d8aee-96bf-4403-6a64-27f4c1159320@infradead.org>
Date:   Tue, 29 Dec 2020 12:00:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1f5a6e7b-c779-861e-fde8-409ca8e2541b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 10:11 AM, Randy Dunlap wrote:
> On 12/29/20 10:01 AM, Toralf Förster wrote:
>> On 12/23/20 2:50 AM, Randy Dunlap wrote:
>>>> What motivates this change?  Is there any reason to think this can
>>>> happen?
>>> Spotted in the wild:
>> I run 2 hardened Gentoo systems, a server and a desktop.
>>
>> I patched the server with this:
>>
>> mr-fox ~ # cat ubsan.patch
>> --- linux-5.10.1.orig/mm/readahead.c
>> +++ linux-5.10.1/mm/readahead.c
>> @@ -310,7 +310,11 @@ void force_page_cache_ra(struct readahea
>>   */
>>  static unsigned long get_init_ra_size(unsigned long size, unsigned
>> long max)
>>  {
>> -       unsigned long newsize = roundup_pow_of_two(size);
>> +       unsigned long newsize;
>> +
>> +       if (!size)
>> +               size = 32;
>> +       newsize = roundup_pow_of_two(size);
>>
>>         if (newsize <= max / 32)
>>                 newsize = newsize * 4;
>>
>>
>>
>> and the issue did no longer occurred at the server (5.10.2).
>>
>> I did not patched the desktop system and the issue occurred still 3
>> times since 21th of december (5.10.2/3)
> 
> Yes, that's the patch that I posted on 2020-DEC-22.
> 
> Looks like I should submit a real patch for that.
> 
> thanks.
> 

Hi Toralf,

Do you want either or both of your
Reported-by: and Tested-by: on the patch?

thanks.
-- 
~Randy

