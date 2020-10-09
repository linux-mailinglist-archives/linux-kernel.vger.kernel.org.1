Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE53288B89
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388981AbgJIOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388728AbgJIOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:38:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81A8C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 07:38:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r4so2649186ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XVrBkRh7WovECMWIdkIhxMceYVKOtAwoCGaLrOL91gE=;
        b=E9tUgrMUHYRxt/tsYwBlrKdU9Tk0FJGwQ9sGlUwPVsR3YzQFE7no6sZrGDxYypc0ZM
         UNxvKUYTdV/StkeTuTULX2fHHx1TppufjP1fzQu7QSo80VvlcuEyRz63QOfNgXzmiwl0
         81En/ougC/eIebLrfRLFfmlCpDSyipO5gpZdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVrBkRh7WovECMWIdkIhxMceYVKOtAwoCGaLrOL91gE=;
        b=oR/1z8IJ7NUGb7dFAYqj8TBi8djkZEyhBMhXHQoVh4j4oiXt7JJkUGl+Sqz9kU+/GK
         OgI7CSu4DxAYdtWhazwHAMGGNBva5ECYc2F/TFjv2D9MzrVMUiOqD4VXavFf5lYekc/w
         hAh2cFqsnPti8tDgDkNjns8dxbkz1YZQxDO4oSMPfbz7Zj1G34olT76D0slSbfJgV3hG
         all5BQqJMMbt/HCvyCsBxQjZ0fdRSzt5D0g/2b+1nQHFU+7fVr9zWPhB/mO1ezjDbemi
         cNCWiGVolhETMJp5xUZSeMHPr8uO2bdomhyRnYBHGn4XsqFAJBf5LErTYE/EaZWPoItH
         3Mgg==
X-Gm-Message-State: AOAM531bmQSLy89P7Fbfz1f5QZsakRYHZ8N05ora3fkXAP6F/91ucoB0
        pWsxSL7/fXZim1Jy/WzTRclEJs72eBrODQ==
X-Google-Smtp-Source: ABdhPJwc3d0/0QQXtCcr92w/QKouthEWbPJ4vVVv17veb2ioYZTCgZOY5jSfWRm6oEoQgtqcQUKC+g==
X-Received: by 2002:a6b:fb0d:: with SMTP id h13mr9543802iog.12.1602254280916;
        Fri, 09 Oct 2020 07:38:00 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l77sm4446748ill.4.2020.10.09.07.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:38:00 -0700 (PDT)
Subject: Re: KASAN: null-ptr-deref Write in event_handler
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <000000000000810a4405b0ece316@google.com>
 <20201007103029.16388-1-hdanton@sina.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <eafbf05b-dd8a-e04c-0d30-9c7b9151fbd8@linuxfoundation.org>
Date:   Fri, 9 Oct 2020 08:37:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007103029.16388-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 4:30 AM, Hillf Danton wrote:
> 
> Mon, 05 Oct 2020 06:59:19
>> syzbot found the following issue on:
>>
>> HEAD commit:    d3d45f82 Merge tag 'pinctrl-v5.9-2' of git://git.kernel.or..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15781d8f900000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf1a360e305ee719e364
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cbaa7d900000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1364f367900000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+bf1a360e305ee719e364@syzkaller.appspotmail.com
>>
>> vhci_hcd: stop threads
>> vhci_hcd: release socket
>> vhci_hcd: disconnect device
>> ==================================================================
>> BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:71 [inline]
>> BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
>> BUG: KASAN: null-ptr-deref in refcount_add include/linux/refcount.h:201 [inline]
>> BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:241 [inline]
>> BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:104 [inline]
>> BUG: KASAN: null-ptr-deref in kthread_stop+0x90/0x7e0 kernel/kthread.c:591
>> Write of size 4 at addr 000000000000001c by task kworker/u4:5/2519
>>
>> CPU: 1 PID: 2519 Comm: kworker/u4:5 Not tainted 5.9.0-rc7-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Workqueue: usbip_event event_handler
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x198/0x1fd lib/dump_stack.c:118
>>   __kasan_report mm/kasan/report.c:517 [inline]
>>   kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
>>   check_memory_region_inline mm/kasan/generic.c:186 [inline]
>>   check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
>>   instrument_atomic_write include/linux/instrumented.h:71 [inline]
>>   atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
>>   refcount_add include/linux/refcount.h:201 [inline]
>>   refcount_inc include/linux/refcount.h:241 [inline]
>>   get_task_struct include/linux/sched/task.h:104 [inline]
>>   kthread_stop+0x90/0x7e0 kernel/kthread.c:591
>>   vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
>>   event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
>>   process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>>   kthread+0x3b5/0x4a0 kernel/kthread.c:292
>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>> ==================================================================
>> Kernel panic - not syncing: panic_on_warn set ...
>> CPU: 1 PID: 2519 Comm: kworker/u4:5 Tainted: G    B             5.9.0-rc7-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Workqueue: usbip_event event_handler
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x198/0x1fd lib/dump_stack.c:118
>>   panic+0x382/0x7fb kernel/panic.c:231
>>   end_report+0x4d/0x53 mm/kasan/report.c:104
>>   __kasan_report mm/kasan/report.c:520 [inline]
>>   kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
>>   check_memory_region_inline mm/kasan/generic.c:186 [inline]
>>   check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
>>   instrument_atomic_write include/linux/instrumented.h:71 [inline]
>>   atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:142 [inline]
>>   refcount_add include/linux/refcount.h:201 [inline]
>>   refcount_inc include/linux/refcount.h:241 [inline]
>>   get_task_struct include/linux/sched/task.h:104 [inline]
>>   kthread_stop+0x90/0x7e0 kernel/kthread.c:591
>>   vhci_shutdown_connection+0x170/0x2a0 drivers/usb/usbip/vhci_hcd.c:1015
>>   event_handler+0x1a5/0x450 drivers/usb/usbip/usbip_event.c:78
>>   process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>>   kthread+0x3b5/0x4a0 kernel/kthread.c:292
>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
> 
> Add a state for vhci device to avoid stop more than once.

It is better for it be called more than once and protect the
paths.

I am working on a fix for this.

thanks,
-- Shuah


