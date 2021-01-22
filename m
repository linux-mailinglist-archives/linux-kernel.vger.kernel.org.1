Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9027E2FFC74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 07:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhAVGMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 01:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbhAVGMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:12:30 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 22:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=QPNdt7ovBYNhxHq39ggDMXhhyoXYMScMZEiARI31TjM=; b=z2C4K8hygWN2/0+W9n5SbxsWyc
        a5oSwKl3vasWP/GbetJhiYq63AaZHX0MZCmpd6RkVcb5WAEjWNoDsxhprqGTswUOXST/bukcV6LBA
        xGVTmd1dOn7hsqdy1CDzCXzOlxjrScuQ3fF3QTlz2cTIws2HnYceZnn+ukHWHbVdUV6fO7DEe+OU2
        tW7Oh2+o5rekEyyWHHdxCXZ3Cwfm671lReFgVsDljdZUxRAYeoEFL9rklsA5gD3/kddluqIvKAXZH
        CQtrfvl4HjPxoGaPaA8U/n4ybQ/xoqwHdM7If1apqaCLd1sNTlBCx26dI0CjdISsprxUZOVJCo3MR
        LVUB87Zg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2pfN-00059h-UT; Fri, 22 Jan 2021 06:11:30 +0000
Subject: Re: [PATCH] powerpc/8xx: export 'cpm_setbrg' for modules
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20210122010819.30986-1-rdunlap@infradead.org>
 <91159e78-4eea-c645-9171-a5b90271710f@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8e78537-0775-95b2-3161-5b5e07e784fe@infradead.org>
Date:   Thu, 21 Jan 2021 22:11:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <91159e78-4eea-c645-9171-a5b90271710f@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 9:51 PM, Christophe Leroy wrote:
> 
> 
> Le 22/01/2021 à 02:08, Randy Dunlap a écrit :
>> Fix missing export for a loadable module build:
>>
>> ERROR: modpost: "cpm_setbrg" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
>>
>> Fixes: 4128a89ac80d ("powerpc/8xx: move CPM1 related files from sysdev/ to platforms/8xx")
> 
> I don't understand. Before that commit cpm_setbrg() wasn't exported either.
> 
> For me, it fixes the commit that brought the capability to build the cpm uart driver as a module, that is commit 1da177e4c3f4 ("Linux-2.6.12-rc")

OK, I didn't have a lot of confidence in that tag.

Thanks for commenting.

>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: clang-built-linux@googlegroups.com
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>>   arch/powerpc/platforms/8xx/cpm1.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> --- linux-next-20210121.orig/arch/powerpc/platforms/8xx/cpm1.c
>> +++ linux-next-20210121/arch/powerpc/platforms/8xx/cpm1.c
>> @@ -280,6 +280,7 @@ cpm_setbrg(uint brg, uint rate)
>>           out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
>>                     CPM_BRG_EN | CPM_BRG_DIV16);
>>   }
>> +EXPORT_SYMBOL(cpm_setbrg);
>>     struct cpm_ioport16 {
>>       __be16 dir, par, odr_sor, dat, intr;
>>


-- 
~Randy
RFC: Features and documentation: http://lwn.net/Articles/260136/
