Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42DA2FD5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391695AbhATQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:42:04 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54725 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391263AbhATQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:38:02 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l2GTl-003FBA-3X; Wed, 20 Jan 2021 17:37:08 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l2GTk-002sLr-FP; Wed, 20 Jan 2021 17:37:08 +0100
Subject: Re: [PATCH] arch/alpha: fix typo in a comment in
 arch/alpha/boot/bootpz.c
To:     Randy Dunlap <rdunlap@infradead.org>,
        ChunyouTang <tangchunyou@163.com>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, tangchunyou@yulong.com
References: <20210120133410.2182-1-tangchunyou@163.com>
 <5e4ed85d-140c-3d85-e4f4-97b27fa37885@infradead.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <0df77d48-8541-32c9-d39d-3e59f89f1f86@physik.fu-berlin.de>
Date:   Wed, 20 Jan 2021 17:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5e4ed85d-140c-3d85-e4f4-97b27fa37885@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 5:20 PM, Randy Dunlap wrote:
> On 1/20/21 5:34 AM, ChunyouTang wrote:
>> From: tangchunyou <tangchunyou@yulong.com>
>>
>> "kerne" -> "kernel"
>>
>> Signed-off-by: tangchunyou <tangchunyou@yulong.com>
>> ---
>>  arch/alpha/boot/bootpz.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
>> index 43af718..61b61be 100644
>> --- a/arch/alpha/boot/bootpz.c
>> +++ b/arch/alpha/boot/bootpz.c
>> @@ -200,7 +200,7 @@ extern int decompress_kernel(void* destination, void *source,
>>  	START_ADDR	KSEG address of the entry point of kernel code.
>>  
>>  	ZERO_PGE	KSEG address of page full of zeroes, but 
>> -			upon entry to kerne cvan be expected
>> +			upon entry to kernel cvan be expected
> 
> s/cvan/can/ also

Right. Reading the whole paragraph helps. It probably should be:

ZERO_PGE	KSEG address of page full of zeroes, but
		upon entry to kernel, it can be expected
		to hold the parameter list and possible
		INTRD information.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

