Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7900A2E750B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 23:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgL2W4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 17:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL2W4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 17:56:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F4DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 14:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=f+I1LAcrnF7P65uDZQXvWz0UkdO1KBhlZ7poyZtMoZo=; b=etrwlRRw/aXgjwHjIFVxie64ON
        pYUPeTlAmY8UFf2dp3n3SQLSdIMYANSjSkBhJQtUtzcz95EGB2VH2uPhM//G8jObFRJHoB5n3EcK9
        WjACR+EMORE7sFn9rk+8sxw7twupDn34DBdQzjfAKzs9f/dUlCYoief1KPOB58Xz+CaJPlxpEcvIc
        ZYZplPADW4jF2O8lnXFRWeNxYyMAm7O93t11KpmYNcEIus2XBLR3hhmhypFd+sxbqiGu5i0wbkcH5
        bjUmd9bHRppqqslQBz0q//GSbvRq7uYoTiBWo1NQ1S1Lxrtiwd5zOywATEb2rBNJiAQG5A8Qmi8pL
        r2alw1CA==;
Received: from [2601:1c0:6280:3f0::2c43]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kuNto-0001j6-At; Tue, 29 Dec 2020 22:55:28 +0000
Subject: Re: [PATCH -mm] mm: readahead: apply a default readahead size
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org
References: <20201229212634.31307-1-rdunlap@infradead.org>
 <20201229222311.GD28221@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ec3030fd-d549-99cf-fe47-703b1fbd678d@infradead.org>
Date:   Tue, 29 Dec 2020 14:55:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201229222311.GD28221@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 2:23 PM, Matthew Wilcox wrote:
> On Tue, Dec 29, 2020 at 01:26:34PM -0800, Randy Dunlap wrote:
>> UBSAN reports an invalid shift size:
>>
>> mr-fox kernel: UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>> mr-fox kernel: shift exponent 64 is too large for 64-bit type 'long unsigned int'
>>
>> Original report:
>> https://lore.kernel.org/lkml/c6e5eb81-680f-dd5c-8a81-62041a5ce50c@gmx.de/
>>
>> Follow-up report:
>> https://lore.kernel.org/lkml/0c283ea9-b446-0e40-6dc8-e9585ae171b4@gmx.de/T/#m9b604660925f9e8a544f7453130c31d083c1e5bb
>>
>>
>> Willy suggested that get_init_ra_size() was being called with a size of 0,
>> which would cause this (instead of some Huge value), so add a check in
>> that function for size == 0, and if 0, default it to 32 (pages).
> 
> No, this is wrong.  'size' in this case is the size of the read.
> And it's zero.  Is this fixed by commit
> 3644e2d2dda78e21edd8f5415b6d7ab03f5f54f3
> 

Toralf, can you test with 5.11-rc1 (or later)?

thanks.
-- 
~Randy

