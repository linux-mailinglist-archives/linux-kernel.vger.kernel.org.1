Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074B12860B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgJGN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgJGN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:56:57 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91988C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 06:56:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so2451803ion.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8oRD8LT/3S5G8509ul/PnBl5dx6h253AKwvEmRsvyAc=;
        b=QPkocxYM9HKwOzMQjAFecDlkLau2QjNN5OfM7Y/VT1h4Jz7MYWSHOY5dwlsNTi+/zZ
         Ls2/32jguM+Awpix2QoNHROaqzKIZlZ16cBIBp2QA8arIzqaOtJlGN/ePOaORWVxzi53
         CaMtnvw2UoxPG/jimGUPV8LtsHtSqsSjZzg4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8oRD8LT/3S5G8509ul/PnBl5dx6h253AKwvEmRsvyAc=;
        b=X1DGWe7OOvpuix51dWJlPhyo62IL/zwPPVWgdK6u4nK7HUhzE54cBzAZaeCo0DptOu
         gJig2mFHpmqGapCpmtcAIaKAxMVg1KAhki/+VwvD3wogxjMcYV7PoOfPo7gtej/zL4fH
         oDd0nDpfG93ekvygrde6nRuJ/O6Ijpkq2D33UorFGC9mursPDFa8fuT/pE+wx8wwNXaU
         Gc7ozowf0zC2dTXJvPk5L4heOOurVTwjZHsV0+oQW2KDp4iSUkWHQX1B+9gDeA5o2rZR
         4PYvMXxe0NJ+Pz/sxWASw94yx2stkK6sg8y0dDaZrHqh24I8zHf+fK2Z58z9dV3pH1ux
         PbOA==
X-Gm-Message-State: AOAM531dpI02raB1lD9vQ6esu8QifzkS+CxlDYcHNrTzG3FLyrDvlBCV
        aay4jBbAMfKCxklE1Dmj//jSCA==
X-Google-Smtp-Source: ABdhPJxtY+3tYBU2t4rrYYVoTab7aPCIfemauQQXHc8OJstFGnIcBLcl6zgbpJvelmLA082jkRfN3w==
X-Received: by 2002:a05:6638:2512:: with SMTP id v18mr3087951jat.106.1602079016842;
        Wed, 07 Oct 2020 06:56:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v9sm902611ioq.41.2020.10.07.06.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 06:56:55 -0700 (PDT)
Subject: Re: KASAN: null-ptr-deref Write in event_handler
To:     Andrey Konovalov <andreyknvl@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <000000000000810a4405b0ece316@google.com>
 <CAAeHK+xWQp87S=bF2RfUjcudGaLVjk3yKLL-bxRzVM=YNRtzRA@mail.gmail.com>
 <2947473d-76cd-a663-049a-4d51a97e2a3e@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4b6c9d53-a4de-8749-e0b1-055dbb42703b@linuxfoundation.org>
Date:   Wed, 7 Oct 2020 07:56:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2947473d-76cd-a663-049a-4d51a97e2a3e@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 2:44 PM, Shuah Khan wrote:
> On 10/5/20 8:04 AM, Andrey Konovalov wrote:
>> On Mon, Oct 5, 2020 at 3:59 PM syzbot
>> <syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    d3d45f82 Merge tag 'pinctrl-v5.9-2' of 
>>> git://git.kernel.or..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15781d8f900000
>>> kernel config:  
>>> https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
>>> dashboard link: 
>>> https://syzkaller.appspot.com/bug?extid=bf1a360e305ee719e364
>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>> syz repro:      
>>> https://syzkaller.appspot.com/x/repro.syz?x=16cbaa7d900000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1364f367900000
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the 
>>> commit:
>>> Reported-by: syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com
>>>
>>> vhci_hcd: stop threads
>>> vhci_hcd: release socket
>>> vhci_hcd: disconnect device
>>> ==================================================================
>>> BUG: KASAN: null-ptr-deref in instrument_atomic_write 
>>> include/linux/instrumented.h:71 [inline]
>>> BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed 
>>> include/asm-generic/atomic-instrumented.h:142 [inline]
>>> BUG: KASAN: null-ptr-deref in refcount_add 
>>> include/linux/refcount.h:201 [inline]
>>> BUG: KASAN: null-ptr-deref in refcount_inc 
>>> include/linux/refcount.h:241 [inline]
>>> BUG: KASAN: null-ptr-deref in get_task_struct 
>>> include/linux/sched/task.h:104 [inline]
>>> BUG: KASAN: null-ptr-deref in kthread_stop+0x90/0x7e0 
>>> kernel/kthread.c:591
>>> Write of size 4 at addr 000000000000001c by task kworker/u4:5/2519
>>>
>>> CPU: 1 PID: 2519 Comm: kworker/u4:5 Not tainted 5.9.0-rc7-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, 
>>> BIOS Google 01/01/2011
>>> Workqueue: usbip_event event_handler
>>> Call Trace:
>>>   __dump_stack lib/dump_stack.c:77 [inline]
>>>   dump_stack+0x198/0x1fd lib/dump_stack.c:118
>>>   __kasan_report mm/kasan/report.c:517 [inline]
>>>   kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
>>>   check_memory_region_inline mm/kasan/generic.c:186 [inline]
>>>   check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
>>>   instrument_atomic_write include/linux/instrumented.h:71 [inline]
>>>   atomic_fetch_add_relaxed 
>>> include/asm-generic/atomic-instrumented.h:142 [inline]
>>>   refcount_add include/linux/refcount.h:201 [inline]
>>>   refcount_inc include/linux/refcount.h:241 [inline]
>>>   get_task_struct include/linux/sched/task.h:104 [inline]
>>>   kthread_stop+0x90/0x7e0 kernel/kthread.c:591
>>>   vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
>>>   event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
>>>   process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>>>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>>>   kthread+0x3b5/0x4a0 kernel/kthread.c:292
>>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>> ==================================================================
>>> Kernel panic - not syncing: panic_on_warn set ...
>>> CPU: 1 PID: 2519 Comm: kworker/u4:5 Tainted: G    B             
>>> 5.9.0-rc7-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, 
>>> BIOS Google 01/01/2011
>>> Workqueue: usbip_event event_handler
>>> Call Trace:
>>>   __dump_stack lib/dump_stack.c:77 [inline]
>>>   dump_stack+0x198/0x1fd lib/dump_stack.c:118
>>>   panic+0x382/0x7fb kernel/panic.c:231
>>>   end_report+0x4d/0x53 mm/kasan/report.c:104
>>>   __kasan_report mm/kasan/report.c:520 [inline]
>>>   kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
>>>   check_memory_region_inline mm/kasan/generic.c:186 [inline]
>>>   check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
>>>   instrument_atomic_write include/linux/instrumented.h:71 [inline]
>>>   atomic_fetch_add_relaxed 
>>> include/asm-generic/atomic-instrumented.h:142 [inline]
>>>   refcount_add include/linux/refcount.h:201 [inline]
>>>   refcount_inc include/linux/refcount.h:241 [inline]
>>>   get_task_struct include/linux/sched/task.h:104 [inline]
>>>   kthread_stop+0x90/0x7e0 kernel/kthread.c:591
>>>   vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
>>>   event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
>>>   process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>>>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>>>   kthread+0x3b5/0x4a0 kernel/kthread.c:292
>>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>>> Kernel Offset: disabled
>>> Rebooting in 86400 seconds..
>>
>> Hi Valentina and Shuah,
>>
>> There appears to be a race condition in the USB/IP vhci_hcd shutdown
>> procedure. It happens quite often during fuzzing with syzkaller, and
>> prevents us from going deeper into the USB/IP code.
>>
>> Could you advise us what would be the best fix for this?
>>
> 
> Hi Andrey,
> 
> Reading the comments for this routine, looks like there is an assumption
> that context begins cleanup and race conditions aren't considered.
> 
> The right fix is holding vhci->lock and vdev->priv_lock to protect
> critical sections in this routine. I will send a patch for this.
> 

Hi Andrey,

I have been unable to reproduce the problem with the reproducer
so far. You mentioned it happens quite often.

- matched config with yours
- load vhci_hcd module and run the reproducer

I do see the messages during shutdown - stop threads etc.

What am I missing?

thanks,
-- Shuah



