Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6E2DF70A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 23:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgLTWmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 17:42:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56628 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgLTWmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 17:42:09 -0500
X-Greylist: delayed 1296 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Dec 2020 17:42:09 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sz/EbcnGNOCBpN/E8/hfZ8UgBDqiTG7GKChg0oTB2K8=; b=MD87AnHmnuOf0wmh+DQBfADaS9
        Ht03roOFzZGhEwSRJoDTeJ0wDcxpCLQqZQVgJ3iQsgveC9HoPznp5LGCWKf7QKRvslsp6tZ1u2Gxp
        OhCISVDJBRV26huxNeJ2QJHFUfJvIqr2XvCWDFipg8i2Lyq4SNPQ+ewwmXvLPANhwutKNGVh4Bu1O
        1uy0LtmFo4GjiyjgMCPrTLyezh50IS31ozpNSOvHNA9lVNmslR2kxi7uSwwk//kRGIy5HcpodjPOb
        CbjZ+Sj+rQPvA0udLxjToCLttBya0ciXEz6HmgYj/33ZqBrBBMq/IArEq8pc6t7Xze+AjAPcbtJcC
        qDwzFRxQ==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kr73I-0002px-5B; Sun, 20 Dec 2020 22:19:44 +0000
Subject: Re: [RFC PATCH 1/2] log2: handle LARGE input to
 __roundup_pow_of_two()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        linux-mm@kvack.org
References: <20201220211037.1354-1-rdunlap@infradead.org>
 <20201220212320.GA15600@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3495987e-6b38-758a-4940-0964119c1426@infradead.org>
Date:   Sun, 20 Dec 2020 14:19:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201220212320.GA15600@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/20 1:23 PM, Matthew Wilcox wrote:
> On Sun, Dec 20, 2020 at 01:10:37PM -0800, Randy Dunlap wrote:
>> UBSAN detected a 64-bit shift in log2.h:__roundup_pow_of_two():
>>   UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>>   shift exponent 64 is too large for 64-bit type 'long unsigned int'
>>
>> This is during a call from mm/readahead.c:ondemand_readahead(),
>> get_init_ra_size(), where the 'size' parameter must have been
>> extremely large (or "negative").
> 
> Actually, I think it was zero, which is the real bug that should be fixed.
> 

Hm, OK, that would make more sense than some Huge value (other than -1).

Do you mean something like this?

---
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


Thanks.

