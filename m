Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E62AA761
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 19:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgKGSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 13:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKGSMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 13:12:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A2C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 10:12:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 5B9641F453A0
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
In-Reply-To: <20201107102203.GV1551@shell.armlinux.org.uk>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201107102203.GV1551@shell.armlinux.org.uk>
Date:   Sat, 07 Nov 2020 20:12:39 +0200
Message-ID: <87r1p5ujc8.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020, Russell King - ARM Linux admin 
<linux@armlinux.org.uk> wrote:
> On Fri, Nov 06, 2020 at 07:14:36AM +0200, Adrian Ratiu wrote: 
>> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c 
>> index e1e76186ec23..84c91c48dfa2 100644 --- 
>> a/arch/arm/lib/xor-neon.c +++ b/arch/arm/lib/xor-neon.c @@ 
>> -18,6 +18,10 @@ MODULE_LICENSE("GPL"); 
>>   * Pull in the reference implementations while instructing GCC 
>>   (through * -ftree-vectorize) to attempt to exploit implicit 
>>   parallelism and emit * NEON instructions. 
>> + 
> 
> Please tidy this up before submission; we normally continue the 
> "*" for blank lines in comment blocks. Thanks. 

Indeed, thank you. I will fix it if I don't replace this patch 
entirely with something similar to what Nick suggested.

Perhaps adding a checkpatch test for this is a good idea?

Adrian

>
>> + * On Clang the loop vectorizer is enabled by default, but due to a bug
>> + * (https://bugs.llvm.org/show_bug.cgi?id=40976) vectorization is broke
>> + * so xor-neon is disabled in favor of the default reg implementations.
>>   */
>>  #ifdef CONFIG_CC_IS_GCC
>>  #pragma GCC optimize "tree-vectorize"
>> -- 
>> 2.29.0
>> 
>> 
>
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
