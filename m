Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85C245A26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 01:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHPX4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 19:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgHPX4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 19:56:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B727C061786;
        Sun, 16 Aug 2020 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=c9c9G3dB8869nqCG7k3c6jcYL3oO+4rkELQoO6iCoYQ=; b=haONcLnvILixrqRZGxk4vB/7Wv
        mBlBraJ5BmrqXZvsg9gD+eLwsJEA0PYWChL/mtSe7sTenFvNl66Fa5aI6tEKfrPtI0oejABtOQG0y
        1BkpLh7J8hAzFaljoeym9VskiPWlkL5d6pQf9EkS4vhFiCUe1qckdiBI7MbmW+hm+8dTQru9wOzxs
        XmcLj7zbip8jqvoUbF8lMne9q81RtQajFcfqx/oz+tsMrWSDSFVMNjz2TLJbZ2K3tapx4prsNpcU7
        VBJJm3sz2M7dWidkql3PUlgaHkrB9sT8zuspOlBHjyxBUOfGefeIlwZgQzZz57O1R4R0DVY+AzxQF
        nOBqKOLw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7SW5-0002f1-3H; Sun, 16 Aug 2020 23:56:45 +0000
Subject: Re: [PATCH v2] block: blk-mq.c: fix @at_head kernel-doc warning
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20200816233934.1573-1-rdunlap@infradead.org>
 <174779d5-d698-0893-881a-3e371f2a1296@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <525203fc-7f65-7de6-d59d-487d46c4f38f@infradead.org>
Date:   Sun, 16 Aug 2020 16:56:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <174779d5-d698-0893-881a-3e371f2a1296@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/20 4:50 PM, Jens Axboe wrote:
> On 8/16/20 4:39 PM, Randy Dunlap wrote:
>> Fix a new kernel-doc warning in block/blk-mq.c:
>>
>> ../block/blk-mq.c:1844: warning: Function parameter or member 'at_head' not described in 'blk_mq_request_bypass_insert'
> 
> Replaced the previous one - and since I was doing that anyway, I removed
> the 'new' from the commit message. Looks like it was from 5.6, so not
> what I'd call new.

Yes, I just hadn't seen it before and I check pretty carefully.

thanks.
-- 
~Randy
