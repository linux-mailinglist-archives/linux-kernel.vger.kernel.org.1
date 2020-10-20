Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5329457B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 01:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439341AbgJTXjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 19:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410643AbgJTXjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 19:39:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D3CC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:39:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o3so290434pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ToYVqAuRslfV2xN1qT6iAKHV1XSHNs1p2CBD10apCwY=;
        b=RCmU6ZRXOjK7P/28TPwRYythgWeW1hp6TuQdHDGl5jrVeAna18AuBG0B2gQ40KBP5Z
         8YMoL+7t9OYjgg9JEAlp1CMyf3zwAPLNIqMqcMSpMuB7DiJtYQIfeUrveNj5Wny9WbS/
         ImrwtswqdxbHTUe/FKD5tZzNFYh6AXncHt8iguTA0iyZxCH7igCTKDG39kprEOt681Xq
         DSXP8SdvG3cnoGBFfTG3FM9nA7dCay1RSzjECfd3rCsssUtvbKIDpPqNiwMNFZXqsFta
         wBrLw9oW+jEAvbH+bf/P40hJFxUE3XWFm3VEq8+sKpJkDOkw21lMh1iwbFNMXHjTshg7
         ccOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ToYVqAuRslfV2xN1qT6iAKHV1XSHNs1p2CBD10apCwY=;
        b=ANzqqogBkKBQGZN4UdxaMZbNyTP/hYuRS/rRxQloYR+FEn1rq/5uliuen/6i2w0lDq
         YbhGU5/ytx11STvX79yxQIJkQWkMxL5zf6Jcow17E3UaDY79x33XJDn7tgBc60eZZAbU
         js6HILdH9x9b28IdBlH9MoXYeCPl1/e8PyGA13je0Qqm8p8E0yQJiG6byTpp4Je/qr17
         rWV+FlhQWkdcwgCeSHEtjl9BmMxhZNU9ZwJ4d3oF+sxCnlrX/Mc/ydi1qrCGYvANjMFu
         mwwMjnp4B+j9rcyqtD4Ic/t2T9Xifsi4hTwrhkFuzeAgNitWFHB54RStn8M5SUSHWnM5
         Y3JQ==
X-Gm-Message-State: AOAM5328JsPxdZc61nHFw+aIUmtdW/scl30WDCt56srSRsg8gDhw8dr3
        UNpiGjI+ssAzFTnX0s6YeADIoxasFPE=
X-Google-Smtp-Source: ABdhPJyfFO+/8AXyuBLZArxGYLxslC8CNUU1X7Q/yIzig9RCFJ6OaW/7OYtkXbp+BAJLZ5Vc1kaKnQ==
X-Received: by 2002:a63:e00c:: with SMTP id e12mr574465pgh.441.1603237183185;
        Tue, 20 Oct 2020 16:39:43 -0700 (PDT)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id hg15sm196138pjb.39.2020.10.20.16.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 16:39:42 -0700 (PDT)
Subject: Re: [sched] c3a340f7e7: invalid_opcode:#[##]
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com,
        linux@rasmusvillemoes.dk
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <20200630144905.GX4817@hirez.programming.kicks-ass.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
Date:   Tue, 20 Oct 2020 16:39:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200630144905.GX4817@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 7:49 AM, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 02:46:28PM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 29, 2020 at 08:31:27AM +0800, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-4.9):
>>>
>>> commit: c3a340f7e7eadac7662ab104ceb16432e5a4c6b2 ("sched: Have sched_class_highest define by vmlinux.lds.h")
>>
>>> [    1.840970] kernel BUG at kernel/sched/core.c:6652!
>>
>> W T H
>>
>> $ readelf -Wa defconfig-build/vmlinux | grep sched_class
>> 62931: c1e62d20     0 NOTYPE  GLOBAL DEFAULT    2 __begin_sched_classes
>> 65736: c1e62f40    96 OBJECT  GLOBAL DEFAULT    2 stop_sched_class
>> 71813: c1e62dc0    96 OBJECT  GLOBAL DEFAULT    2 fair_sched_class
>> 78689: c1e62d40    96 OBJECT  GLOBAL DEFAULT    2 idle_sched_class
>> 78953: c1e62fa0     0 NOTYPE  GLOBAL DEFAULT    2 __end_sched_classes
>> 79090: c1e62e40    96 OBJECT  GLOBAL DEFAULT    2 rt_sched_class
>> 79431: c1e62ec0    96 OBJECT  GLOBAL DEFAULT    2 dl_sched_class
>>
>> $ printf "%d\n" $((0xc1e62dc0 - 0xc1e62d40))
>> 128
>>
>> So even though the object is 96 bytes in size, has an explicit 32 byte
>> alignment, the array ends up with a stride of 128 bytes !?!?!
>>
>> Consistently so with GCC-4.9. Any other GCC I tried does the sane thing.
>>
>> Full patch included below.
>>
>> Anybody any clue wth 4.9 is doing crazy things like this?
>>
>> ---
> 
> This seems to make everything work, it builds and boots for 4.9 and
> builds x86_64-defconfig with clang11 (just to check a !GCC compiler).

Hi Peter,

This patch causes all files under kernel/sched/* that include sched.h to
be rebuilt whenever the value of CONFIG_BLK_DEV_INITRD. There are at
least two build systems (buildroot and OpenWrt) that toggle this
configuration value in order to produce a kernel image without an
initramfs, and one with.

On ARM we get all of these to be needlessly rebuilt:

  CC      kernel/sched/core.o
  CC      kernel/sched/loadavg.o
  CC      kernel/sched/clock.o
  CC      kernel/sched/cputime.o
  CC      kernel/sched/idle.o
  CC      kernel/sched/fair.o
  CC      kernel/sched/rt.o
  CC      kernel/sched/deadline.o
  CC      kernel/sched/wait.o
  CC      kernel/sched/wait_bit.o
  CC      kernel/sched/swait.o
  CC      kernel/sched/completion.o
  CC      kernel/sched/cpupri.o
  CC      kernel/sched/cpudeadline.o
  CC      kernel/sched/topology.o
  CC      kernel/sched/stop_task.o
  CC      kernel/sched/pelt.o
  CC      kernel/sched/debug.o
  CC      kernel/sched/cpufreq.o
  CC      kernel/sched/membarrier.o

Short of moving the STRUCT_ALIGNMENT to a separate header that would not
be subject to any configuration key change, can you think of a good way
to avoid these rebuilds, including for architectures like ARM that ship
their own vmlinux.lds.h? I would not say this is a bug, but it is
definitively an inconvenience.

Thanks!
-- 
Florian
