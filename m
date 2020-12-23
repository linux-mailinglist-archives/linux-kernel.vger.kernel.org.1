Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE92E1177
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLWBvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLWBvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:51:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC6FC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 17:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Y/ki+pwiajt1JGckMLPHR2xc4WDa7IQDL+LHZUzD3iA=; b=bS5HJD18j31Q+5eh0KZPDYrfP3
        HSXt662IfbFyfBOCC+BEL0uRp8jyfjaojciTHRc9uyP3pnB6vIp2bGYVkfH5NsccYlfix2LrYHLsn
        XLj8umTznJGKEaDTGMZN36n2lEkclfTB5M0+Fn+hE3KQhs0xVBC2IzxD+wBzjRA1yCwvIP8MdYmwY
        dOEirZbCqKt9IRVRu8PXfxpTz1hpV9oJ5AL612jdWfJ+xzjA+V9SP5Iwu6YTg8D73oDAGuSrMqQ1H
        F5OOMqpGj0/X8iIPISOvUCWxcykHEehyA9uMJk8ULbK3vNTc193DhxViBDg/EFM6xZGAb8mED7JOm
        6eSNXE6Q==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krtIn-0006V8-92; Wed, 23 Dec 2020 01:50:57 +0000
Subject: Re: [RFC PATCH 2/2] mm: readahead: handle LARGE input to
 get_init_ra_size()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        linux-mm@kvack.org
References: <20201220211051.1416-1-rdunlap@infradead.org>
 <20201222173533.c9e28416835d7487b0e28cda@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6a595671-20a8-e63f-f3ea-f4749a574efa@infradead.org>
Date:   Tue, 22 Dec 2020 17:50:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201222173533.c9e28416835d7487b0e28cda@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 5:35 PM, Andrew Morton wrote:
> On Sun, 20 Dec 2020 13:10:51 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Add a test to detect if the input ra request size has its high order
>> bit set (is negative when tested as a signed long). This would be a
>> really Huge readahead.
>>
>> If so, WARN() with the value and a stack trace so that we can see
>> where this is happening and then make further corrections later.
>> Then adjust the size value so that it is not so Huge (although
>> this may not be needed).
> 
> What motivates this change?  Is there any reason to think this can
> happen?

Spotted in the wild:

mr-fox kernel: [ 1974.206977] UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
mr-fox kernel: [ 1974.206980] shift exponent 64 is too large for 64-bit type 'long unsigned int'

Original report:
https://lore.kernel.org/lkml/c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de/


Willy suggested that get_init_ra_size() was being called with a size of 0,
which would cause this (instead of some Huge value), so I made a follow-up
patch that only checks size for 0 and if 0, defaults it to 32 (pages).

---
 mm/readahead.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-5.10.1.orig/mm/readahead.c
+++ linux-5.10.1/mm/readahead.c
@@ -310,7 +310,11 @@ void force_page_cache_ra(struct readahea
  */
 static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
 {
-	unsigned long newsize = roundup_pow_of_two(size);
+	unsigned long newsize;
+
+	if (!size)
+		size = 32;
+	newsize = roundup_pow_of_two(size);
 
 	if (newsize <= max / 32)
 		newsize = newsize * 4;


Toralf has only seen this problem one time.


> Also, everything in there *should* be unsigned, because a negative
> readahead is semantically nonsensical.  Is our handling of this
> inherently unsigned quantity incorrect somewhere?
> 
>> --- linux-5.10.1.orig/mm/readahead.c
>> +++ linux-5.10.1/mm/readahead.c
>>
>> ...
>>
>> @@ -303,14 +304,21 @@ void force_page_cache_ra(struct readahea
>>  }
>>  
>>  /*
>> - * Set the initial window size, round to next power of 2 and square
>> + * Set the initial window size, round to next power of 2
>>   * for small size, x 4 for medium, and x 2 for large
>>   * for 128k (32 page) max ra
>>   * 1-8 page = 32k initial, > 8 page = 128k initial
>>   */
>>  static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
>>  {
>> -	unsigned long newsize = roundup_pow_of_two(size);
>> +	unsigned long newsize;
>> +
>> +	if ((signed long)size < 0) { /* high bit is set: ultra-large ra req */
>> +		WARN_ONCE(1, "%s: size=0x%lx\n", __func__, size);
>> +		size = -size;	/* really only need to flip the high/sign bit */
>> +	}
>> +
>> +	newsize = roundup_pow_of_two(size);
> 
> Is there any way in which userspace can deliberately trigger warning?
> Via sys_readadhead() or procfs tuning or whatever?
> 
> I guess that permitting a user-triggerable WARN_ONCE() isn't a huuuuge
> problem - it isn't a DoS if it only triggers a single time.  It does
> permit the malicious user to disable future valid warnings, but I don't
> see what incentive there would be for this.  But still, it seems
> desirable to avoid it.

Sure. I think that we can drop RFC patches 1/2 and 2/2 and just consider the
other one above.


-- 
~Randy

