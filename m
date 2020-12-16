Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55862DBE35
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgLPKFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgLPKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:05:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E9C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 02:04:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id 6so17209567ejz.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 02:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8lX54bFY3GA8vFrzRbSw5g4u4NUJ5PS2ieZ5MmN9qcE=;
        b=Z7EfUjngukapy6e6qjTuPsXAkXQprUbsTNkpwZ5CuRYRw/qnyL15yOyYI1vSyDoLU2
         8z5t9xh4V5O2eyWCLyNjHBFrszDZG+sV4BoGcfqCbwxIihrzBAMj/J0eawb7ZgsuoOPs
         Vm20zEHQs1M8ELn4sLP2xC6ZQgioA3dPpXDD+5EJlTVs3SvActi6D7kAU2ifqa1bwJ/V
         93QDMQsJBCUn1R/PVOAunlMOnOvnXfNhIhpXCTwT3jYRrXu2t6WtLHLmvBbLiYOGav8g
         wgDPoI8/BlIQOMviiKiWJUkTUCuNr1tGRP3rLxvaiCFIDZB/OVpmWKViE5UMCxS3eUXa
         2reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8lX54bFY3GA8vFrzRbSw5g4u4NUJ5PS2ieZ5MmN9qcE=;
        b=DqrJZMz52TojUt/0nL2gentGLnuOxAgSCkRvLyo/IDdqsoBeWQ0EqN8fVTf5my7PmV
         zjCwXAxjsQUMZQhPMoxrtdoxDMCTUs3XXpb4FxWJmIXzcOh6mUZeHGWUkjOFnDnbPms2
         7mUn9tAGGkjBPbTAysCUedTiPQE4dMwondMsH5M0SsYYwKvlrjWnuO+krxEQJEIQHjZE
         2eUtF092bH8pSEAAZghP3MlCgG8iBF/+6xs7haf15n75wUDInE6E7YFaOWMxMJlyIwrc
         xGik8i2xPue2tJWHbokdJ7Ar6ggs0FuklnMOrwRvCEdBDDbtSdujmAuo3+QL2d5x4jFm
         O+CQ==
X-Gm-Message-State: AOAM532eApt/H1broJT0uMv+woKb4CX3UrwjhjFMzczy7K1OHP2JBAQy
        dIi+TakQI1bx4W/2Us3Up3hqqQ==
X-Google-Smtp-Source: ABdhPJy55jVixIg4KAi4YQ9Ae6Y+p1mTgxDQzXLw1aj2vnZ/jGfzZrtLKnO8x/H37XwYD9qSzJWHCA==
X-Received: by 2002:a17:906:17d0:: with SMTP id u16mr29804757eje.452.1608113067864;
        Wed, 16 Dec 2020 02:04:27 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id qn4sm1012892ejb.50.2020.12.16.02.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 02:04:26 -0800 (PST)
Subject: Re: linux-next: manual merge of the tip tree with the microblaze tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201210155808.717a7257@canb.auug.org.au>
 <1848f245-2a64-0aec-58db-b575de29debc@monstr.eu>
 <20201216120025.3901896a@canb.auug.org.au>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <8a63492b-b1f1-1781-c584-d8f0e78500e6@monstr.eu>
Date:   Wed, 16 Dec 2020 11:04:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201216120025.3901896a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 16. 12. 20 2:00, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 10 Dec 2020 15:03:23 +0100 Michal Simek <monstr@monstr.eu> wrote:
>>
>> On 10. 12. 20 5:58, Stephen Rothwell wrote:
>>>
>>> Today's linux-next merge of the tip tree got conflicts in:
>>>
>>>   arch/microblaze/Kconfig
>>>   arch/microblaze/mm/Makefile
>>>
>>> between commit:
>>>
>>>   05cdf457477d ("microblaze: Remove noMMU code")
>>>
>>> from the microblaze tree and commit:
>>>
>>>   7ac1b26b0a72 ("microblaze/mm/highmem: Switch to generic kmap atomic")
>>>
>>> from the tip tree.
>>>
>>> I fixed it up (see below) and can carry the fix as necessary. This
>>> is now fixed as far as linux-next is concerned, but any non trivial
>>> conflicts should be mentioned to your upstream maintainer when your tree
>>> is submitted for merging.  You may also want to consider cooperating
>>> with the maintainer of the conflicting tree to minimise any particularly
>>> complex conflicts.
>>>   
>>
>> Thanks for letting me know. I will mentioned it to Linus.
>> Your resolution is correct.
> 
> These are now conflicts between the microblaze tree and Linus' tree.
> 

Yes. I am just preparing pull request to Linus with mentioning
resolution as you sent last time.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

