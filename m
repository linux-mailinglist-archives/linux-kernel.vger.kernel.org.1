Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C425228DC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgJNJJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgJNJJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:09:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F7C051105;
        Tue, 13 Oct 2020 23:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=xUnuNzpryiSejko6+sY87CqK2i6+keSsRxr2GtYeLOk=; b=KS6Legqv6hpLpdcGkeH0ecCl3M
        QdwmltajTxpqPYEw6TCitQPifvqni9dgV47MAvRTowbErk4RZo6tVWG3R2Bp9R3aDkYYi46PVQyfk
        l0FSw3Glzhr8C33Z0jbUE209psECR1Qk0wdeKmbGX/iTR5BgIZUTPlqBNt4IFAHc89xHxt4z/qI7+
        vmtg3zeLzHXXP5kBqQ9lgBXV52nxTMCVYumgP/T3Ii/t4pnReOhkOuWMCIQo9FJvKQmyOyf041TIA
        BvIaWj/OyWFOlB+uI1AZI2jHTYCi0hk6v2SkN6GUvFRx8+zG6PA8mNNymGR1SKPe2LvxlS3dLEEL5
        j0ak+NCQ==;
Received: from [2601:1c0:6280:3f0::9850] (helo=dragon.site)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSaSe-0008EV-BP; Wed, 14 Oct 2020 06:40:32 +0000
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions;
 use string size
To:     Michael Witten <mfwitten@gmail.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1329005-fa37-e02e-0105-2634ee566f55@infradead.org>
Date:   Tue, 13 Oct 2020 23:40:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/4/20 12:40 PM, Michael Witten wrote:
> The following patch improves the quality and correctness of the openprom code.
> 
> 
> --8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--
> 
> ---
>   arch/sparc/include/asm/prom.h   |   2 +-
>   arch/sparc/kernel/prom_common.c |  14 +--
>   drivers/sbus/char/openprom.c    | 263 ++++++++++++++++++++++++++++------------
>   3 files changed, 194 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
> index 30b9751aad30..9bc2877aa09a 100644
> --- a/drivers/sbus/char/openprom.c
> +++ b/drivers/sbus/char/openprom.c
>   	/* If the bufsize is too large, just limit it.
>   	 * Fix from Jason Rappleye.
>   	 */

The sparc cross-compiler that I am using does not like to see type
casting in preprocessor lines.
SIZE_MAX is #defined as (~(size_t)0) and for the #if line below,

> +	#if OPROMMAXPARAM > SIZE_MAX/2
> +		if (bufsize > SIZE_MAX/2)
> +			return -EFAULT;
> +	#endif

gcc (cpp) says:

In file included from ../drivers/sbus/char/openprom.c:19:
../include/linux/limits.h:9:21: warning: "size_t" is not defined, 
evaluates to 0 [-Wundef]
     9 | #define SIZE_MAX (~(size_t)0)
       |                     ^~~~~~
../drivers/sbus/char/openprom.c:95:22: note: in expansion of macro 
'SIZE_MAX'
    95 |  #if OPROMMAXPARAM > SIZE_MAX/2
       |                      ^~~~~~~~
../include/linux/limits.h:9:28: error: missing binary operator before 
token "0"
     9 | #define SIZE_MAX (~(size_t)0)
       |                            ^
../drivers/sbus/char/openprom.c:95:22: note: in expansion of macro 
'SIZE_MAX'
    95 |  #if OPROMMAXPARAM > SIZE_MAX/2
       |                      ^~~~~~~~

causing a build error.

--
~Randy

