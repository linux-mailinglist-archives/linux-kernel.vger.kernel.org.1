Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2918B2C7E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgK3GzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:55:05 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50550 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgK3GzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:55:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGwypdg_1606719263;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UGwypdg_1606719263)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Nov 2020 14:54:23 +0800
Subject: Re: [PATCH] crypto: ecrdsa - use subsys_initcall instead of
 module_init
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201015110241.89676-1-tianjia.zhang@linux.alibaba.com>
 <20201015120504.GA12976@gondor.apana.org.au>
 <f6d98764-dde8-6f40-c0e7-9eb5b087d713@linux.alibaba.com>
 <20201130022422.GA21049@gondor.apana.org.au>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <df22e694-0a2e-811a-412e-269303c5d27d@linux.alibaba.com>
Date:   Mon, 30 Nov 2020 14:54:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201130022422.GA21049@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/20 10:24 AM, Herbert Xu wrote:
> On Mon, Nov 30, 2020 at 10:21:56AM +0800, Tianjia Zhang wrote:
>>
>>> That is true only if there are non-generic implementations of
>>> the algorithms, which is not the case here.  Please explain the
>>> real reason why this is needed.
>>
>> This is a generic algorithm, the author Vitaly Chikunov has also confirmed
>> it, please consider this patch again.
> 
> As I said, the generic algorithm only needs to be loaded early *if*
> there are non-generic implementations.
> 
> Cheers,
> 

For ecrdsa, there is no reason to advance the initialization to 
subsys_init, this is just to make code clean up to have algorithm 
initialization uniform with other implementations.

It’s just that I think that in the commit c4741b230597 ("crypto: run 
initcalls for generic implementations earlier"), the modification to 
ecrdsa happened to be omitted, because from the point of commit time, it 
was submitted at the same time as the ecrdsa commits, and it may happen 
to be omitted for ecrdsa.

Best regards,
Tianjia
