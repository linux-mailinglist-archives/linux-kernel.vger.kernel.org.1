Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811353042A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbhAZPar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:30:47 -0500
Received: from m12-12.163.com ([220.181.12.12]:47333 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406342AbhAZP3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=ivLqm
        J1s2EDsj6FXSmy+6Xh15a30zNVySkMMhcp7/mI=; b=WytMhn0djV8vM8fJQY79A
        A85wGSpwTTAP1jE9t/sNbbhRxlr9gkIQRl0oGXqHZcEgMYsLzYk/W10p6hRd+1lI
        8h5QhJBaohK6eCye709+mNNl4QWDwMo5BNUBJGGeXon+y82W6gYNZ3LwcRGnrPDU
        6EYanJqdONprGB9fpiValQ=
Received: from [192.168.31.187] (unknown [36.170.37.79])
        by smtp8 (Coremail) with SMTP id DMCowABnbo6PKRBgoMiGNw--.4455S2;
        Tue, 26 Jan 2021 22:39:12 +0800 (CST)
Subject: Re: [PATCH] arch/arm/mm/mmu.c: Remove duplicate header
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hailong Liu <liu.hailong6@zte.com.cn>
References: <20210119133320.8557-1-carver4lio@163.com>
 <CACRpkdbVwjJygak+tqjLXtqs-kwVH4VbqWp23NUgs=8wFepSPg@mail.gmail.com>
From:   carver4lio@163.com
Message-ID: <bc9c4778-3188-f59a-1889-41eac9e84584@163.com>
Date:   Tue, 26 Jan 2021 22:39:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbVwjJygak+tqjLXtqs-kwVH4VbqWp23NUgs=8wFepSPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DMCowABnbo6PKRBgoMiGNw--.4455S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-WlkDUUUU
X-Originating-IP: [36.170.37.79]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/xtbBXgomnVaD5mSEfwABsC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 6:11 PM, Linus Walleij wrote:
> On Tue, Jan 19, 2021 at 2:34 PM Hailong liu <carver4lio@163.com> wrote:
> 
>> From: Hailong Liu <liu.hailong6@zte.com.cn>
>>
>> Remove asm/fixmap.h which is included more than once.
>>
>> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please put this into Russell's patch tracker so he can merge it.

I have put this patch into Russell's patch tracker, and its status now is
incoming.


