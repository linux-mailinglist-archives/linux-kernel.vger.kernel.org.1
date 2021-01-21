Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344A2FE49A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbhAUIFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:05:33 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:42561 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727617AbhAUIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:01:33 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l2Ut6-002EdT-NB; Thu, 21 Jan 2021 09:00:16 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l2Ut6-000N4k-2q; Thu, 21 Jan 2021 09:00:16 +0100
Subject: Re: [PATCH] arch/alpha: fix typo in a comment in
 arch/alpha/boot/bootpz.c
To:     Chunyou Tang <tangchunyou@163.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, akpm@linux-foundation.org, rppt@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, tangchunyou@yulong.com
References: <20210120133410.2182-1-tangchunyou@163.com>
 <5e4ed85d-140c-3d85-e4f4-97b27fa37885@infradead.org>
 <0df77d48-8541-32c9-d39d-3e59f89f1f86@physik.fu-berlin.de>
 <20210121102042.00005504@163.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <42a71690-28a9-6bf8-e413-2fd1e03f7f7c@physik.fu-berlin.de>
Date:   Thu, 21 Jan 2021 09:00:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121102042.00005504@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyou!

On 1/21/21 3:20 AM, Chunyou Tang wrote:
>> Right. Reading the whole paragraph helps. It probably should be:
>>
>> ZERO_PGE	KSEG address of page full of zeroes, but
>> 		upon entry to kernel, it can be expected
>> 		to hold the parameter list and possible
>> 		INTRD information.
>>
>> Adrian
>>
> 
> ok, I change it as :
> ZERO_PGE	KSEG address of page full of zeroes, but
> 		upon entry to kernel, it can be expected
> 		to hold the parameter list and possible
> 		INTRD information.
> then I commit it.

Great, thank you.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

