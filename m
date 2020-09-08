Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA426137A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgIHP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgIHPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:25:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E566EC09B042
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:40:26 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id n2so5318550oij.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c9iLLuaBGWovpf3B0g/X+Be4Wvsv3eYnfu+1G59OB1k=;
        b=kqCUFpCoTDDfSASaEJvIJAiAEk00ZBFZ9CsdE/srJCRow00E8MDGoB8oBrZE54OYh/
         4nFJjUfqN8xQcdEfKqKPEoF4g8M4Wzow8qitAFWwwOaBE672WX9jxOelwbkYpWYuMMcB
         woutcAdntjSHlOIhr26yIrod9d2kPfPyRge6tr+v+kjeqT+9Om0yAB2vcew/ReX7uk/5
         Y0YvTP8lbYn9jjUszs3Bv3psYU3owl7VrvvJFHM/NEBXci9UMORNtaNj20x3lX+owa82
         IXwj8zSvVqmavhqWreoRzSnuN/pnhBQtkOIJIcIEcX+uGb6+cxIhAhFI8oFcD1uEZvaP
         Hffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c9iLLuaBGWovpf3B0g/X+Be4Wvsv3eYnfu+1G59OB1k=;
        b=ILUQWWxR7BlrXIp/DO5YcuN1hNvoZ9Fi02R6Dec37MvSy4aikcsqlgqYkf8e7lG37Y
         EX+6wBlSVS28yifF9qwwn6IHlAe3Z2RYHe6lfVX1b7YXjhDj11b83jvWrW5x75fywkzu
         UCYLtRH8mxd6oZhJG64H/HQm7j37Pj/l5vqVVQU3hIUHstzET3LlcQgFzScZka6jYWbl
         331ZZ3QxZo/XB7/gI1QNuGDIiqo6IzaRzvR6FEtvBOKOVr0cLu9zLlcvVVnb4WnPpG/T
         I5zDAAcG1m5pKA7tUYclLN28RIn9SfQ0HpgtdGx/bPVW+e1MWD+0K6hV4IQayGhh5Hpw
         fESw==
X-Gm-Message-State: AOAM531QpnZE/e2guV0zuzuWeA9NpSstNxO2MdZPK3KPFeIQMrZeSEcw
        z3zaS4buyuUf/UrE/Bk5PJY=
X-Google-Smtp-Source: ABdhPJyRFkv2DLr9eFRB/EyD+tYxiBCuUluHuNErbQCpbxncj8+9WhrYhx8EXhKWhspz/O68K+V9ng==
X-Received: by 2002:aca:52d6:: with SMTP id g205mr2947653oib.54.1599576025932;
        Tue, 08 Sep 2020 07:40:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm3501452ots.5.2020.09.08.07.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 07:40:25 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] lockdep: Only trace IRQ edges
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        davem@davemloft.net
References: <20200821084738.508092956@infradead.org>
 <20200821085348.723775490@infradead.org>
 <20200902042137.GA163925@roeck-us.net>
 <20200902090935.GW1362448@hirez.programming.kicks-ass.net>
 <20200902091247.GX35926@hirez.programming.kicks-ass.net>
 <559ff09a-275b-21bf-15f1-daa0d02d1c76@roeck-us.net>
 <20200908142215.GU1362448@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b52cdc64-bb37-077a-eb8b-9615e341d069@roeck-us.net>
Date:   Tue, 8 Sep 2020 07:40:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908142215.GU1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 7:22 AM, peterz@infradead.org wrote:
> On Wed, Sep 02, 2020 at 06:48:30AM -0700, Guenter Roeck wrote:
>> On 9/2/20 2:12 AM, peterz@infradead.org wrote:
>>> On Wed, Sep 02, 2020 at 11:09:35AM +0200, peterz@infradead.org wrote:
>>>> On Tue, Sep 01, 2020 at 09:21:37PM -0700, Guenter Roeck wrote:
>>>>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4875 check_flags.part.39+0x280/0x2a0
>>>>> [    0.000000] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
>>>>
>>>>> [    0.000000] [<00000000004cff18>] lock_acquire+0x218/0x4e0
>>>>> [    0.000000] [<0000000000d740c8>] _raw_spin_lock+0x28/0x40
>>>>> [    0.000000] [<00000000009870f4>] p1275_cmd_direct+0x14/0x60
>>>>
>>>> Lol! yes, I can see that going side-ways... let me poke at that.
>>>
>>> I suspect this will do.
>>>
>>> diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
>>> index 889aa602f8d8..7cfe88e30b52 100644
>>> --- a/arch/sparc/prom/p1275.c
>>> +++ b/arch/sparc/prom/p1275.c
>>> @@ -38,7 +38,7 @@ void p1275_cmd_direct(unsigned long *args)
>>>  	unsigned long flags;
>>>
>>>  	local_save_flags(flags);
>>> -	local_irq_restore((unsigned long)PIL_NMI);
>>> +	arch_local_irq_restore((unsigned long)PIL_NMI);
>>>  	raw_spin_lock(&prom_entry_lock);
>>>
>>>  	prom_world(1);
>>>
>> No, that doesn't help. Even removing that line entirely doesn't help.
>> The problem seems to be that interrupts are not enabled in the first
>> place. But why wasn't this a problem before ?
> 
> Previously every interrupt opt would disable/enable things, now we only
> update state when something actually changes.
> 
> Anyway, I'm struggling with qemu-system-sparc64, I've got a sparc64
> cross booting to mount, but I'm not seeing this, could you get me your
> specific qemu cmdline please?
> 

initrd:

qemu-system-sparc64 -M sun4u -cpu "TI UltraSparc IIi" -m 512 \
    -initrd rootfs.cpio \
    -kernel arch/sparc/boot/image -no-reboot \
    -append "panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyS0" \
    -nographic -monitor none

root file system:

qemu-system-sparc64 -M sun4u -cpu "TI UltraSparc IIi" -m 512 \
    -snapshot =drive file=rootfs.ext2,format=raw,if=ide \
    -kernel arch/sparc/boot/image -no-reboot \
    -append "panic=-1 slub_debug=FZPUA root=/dev/sda rootwait console=ttyS0" \
    -nographic -monitor none

Some of it, like the CPU, should not be needed. qemu version is v5.1,
but v5.0 should do as well. Some older qemu versions won't accept the
kernel from the command line.

Did you enable lockdep debugging ? In my configuration I enable lots
of debug options on top of defconfig. See [1], function __setup_fragment(),
for details.

Some root file systems are at [2] if needed. The complete script used
to build and run the code is at [3].

Guenter

---
[1] https://github.com/groeck/linux-build-test/blob/master/rootfs/scripts/common.sh
[2] https://github.com/groeck/linux-build-test/tree/master/rootfs/sparc64
[3] https://github.com/groeck/linux-build-test/blob/master/rootfs/sparc64/run-qemu-sparc64.sh
