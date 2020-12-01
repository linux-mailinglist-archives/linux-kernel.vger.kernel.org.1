Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED3B2CA67E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391584AbgLAPDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388695AbgLAPDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:03:46 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8677AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:03:06 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i9so1902495ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Og6g/lyCjIcL1kVP5tZ0QAgJA4aZEi6Vqr/nNvj+z/c=;
        b=MuJqInQZV0OrkCoMCfzib+ByRspfryye7ScpvL1lLH2mX7NIsytrmRxolmgtJ9fehy
         EbBP/aISbDHRpdOD5loNtEUerij2pZmUpMmUXabE4MTbgLqQTGiN1E8/2+XHluf6FGt7
         RX2J4Jg/H1cUlGQdmuUFT6gfHB2UBbkhTCfAwzG5pdvDGhtrcqZz6tB4oxo19nKrQsOu
         jKoANA3VnBqbkAYWC8rpsG34RztYl9VAjQzCZc2EVqsalbS9SdeVQE9rsjul3fuGnFXA
         LEQIXyj9US4vZsCrqyALxiMfO2iSyFmFdxk7I7HJVNQcsSl4LlCsElbVCoxYnRqt17Jm
         y6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Og6g/lyCjIcL1kVP5tZ0QAgJA4aZEi6Vqr/nNvj+z/c=;
        b=s76lCc1bujSUSuhFmjfBLqwfFn/OFuJ6XvfOdsznA2jG/WczNumpijxeuQ92Mq4jEK
         0fSXN2IFBDpKUEq/kSlLqD8+Cuuq1epBw06MDt5v7D6/Oelcfc9ttmMP1BGTh8vg646p
         QApcMHRjSRvIioMLDOOYO43h6GSnewRCz8+fgUPZFxLgETp4emRX9TNllcmAlUm5n0bL
         D25LIi2+UwqtHrYrDDutyZyOjJLV9TuT1bCjPHboAP2MYZxUTUXBjsa7nwojEdAgohGc
         WKuC4zfJEDiSXf2/WXi0Fb56aZONvqDya6ympj3+mwn+iGrdZLQaxFakHh8oux73BKx1
         sn2Q==
X-Gm-Message-State: AOAM530+DCSpzGP5wpJaSL6facx81c4MT+5kZtPxKP0KcQ56Yce21KOH
        aAUcN4Ij8z5su0hP4OxCDFsyKQ==
X-Google-Smtp-Source: ABdhPJwnZnnT3CSvidMrOWY7WttjZ3ON/dA9qpMhE8X0d7c2GzTEq5bmfutQ1PBUEhW9MbRonHjKIw==
X-Received: by 2002:a02:90c6:: with SMTP id c6mr2924306jag.3.1606834985798;
        Tue, 01 Dec 2020 07:03:05 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h70sm35580iof.31.2020.12.01.07.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 07:03:04 -0800 (PST)
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
References: <20201101170454.9567-1-rppt@kernel.org>
 <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org>
 <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
 <20201201102901.GF557259@kernel.org>
 <e3d5d791-8e4f-afcc-944c-24f66f329bd7@physik.fu-berlin.de>
 <20201201121033.GG557259@kernel.org>
 <49a2022c-f106-55ec-9390-41307a056517@physik.fu-berlin.de>
 <20201201135623.GA751215@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59351dbb-96cc-93b2-f2ec-b8968e935845@kernel.dk>
Date:   Tue, 1 Dec 2020 08:03:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201135623.GA751215@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 6:56 AM, Mike Rapoport wrote:
> (added Jens)
> 
> On Tue, Dec 01, 2020 at 01:16:05PM +0100, John Paul Adrian Glaubitz wrote:
>> Hi Mike!
>>
>> On 12/1/20 1:10 PM, Mike Rapoport wrote:
>>> On Tue, Dec 01, 2020 at 12:35:09PM +0100, John Paul Adrian Glaubitz wrote:
>>>> Hi Mike!
>>>>
>>>> On 12/1/20 11:29 AM, Mike Rapoport wrote: 
>>>>> These changes are in linux-mm tree (https://www.ozlabs.org/~akpm/mmotm/
>>>>> with a mirror at https://github.com/hnaz/linux-mm)
>>>>>
>>>>> I beleive they will be coming in 5.11.
>>>>
>>>> Just pulled from that tree and gave it a try, it actually fails to build:
>>>>
>>>>   LDS     arch/ia64/kernel/vmlinux.lds
>>>>   AS      arch/ia64/kernel/entry.o
>>>> arch/ia64/kernel/entry.S: Assembler messages:
>>>> arch/ia64/kernel/entry.S:710: Error: Operand 2 of `and' should be a general register
>>>> arch/ia64/kernel/entry.S:710: Error: qualifying predicate not followed by instruction
>>>> arch/ia64/kernel/entry.S:848: Error: Operand 2 of `and' should be a general register
>>>> arch/ia64/kernel/entry.S:848: Error: qualifying predicate not followed by instruction
>>>>   GEN     usr/initramfs_data.cpio
>>>> make[1]: *** [scripts/Makefile.build:364: arch/ia64/kernel/entry.o] Error 1
>>>> make: *** [Makefile:1797: arch/ia64/kernel] Error 2
>>>> make: *** Waiting for unfinished jobs....
>>>>   CC      init/do_mounts_initrd.o
>>>>   SHIPPED usr/initramfs_inc_data
>>>>   AS      usr/initramfs_data.o
>>>
>>> Hmm, it was buidling fine with v5.10-rc2-mmotm-2020-11-07-21-40.
>>> I'll try to see what could cause this.
>>>
>>> Do you build with defconfig or do you use a custom config?
>>
>> That's with "localmodconfig", see attached configuration file.
> 
> Thanks.
> It seems that the recent addition of TIF_NOTIFY_SIGNAL to ia64 in
> linux-next caused the issue. Can you please try the below patch?

That's a lot of typos in that patch... I wonder why the buildbot hasn't
complained about this. Thanks for fixing this up! I'm going to fold this
into the original to avoid the breakage.

-- 
Jens Axboe

