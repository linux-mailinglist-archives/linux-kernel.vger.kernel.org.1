Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF6C27EE10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgI3P56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3P54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:57:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFFBC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:57:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s14so175115pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1uLbpKRCix6ip0P860eY71YWHM0FgUim0HU08GftBtE=;
        b=TFBEgsjkFjmtckZ6OyxL24N8QLzw9DMwFHMxlrfKlT/HSfb6CTszIBTc9i8mogVqFx
         vds1WtTQA/yJPaTHPTM0DcAsOii0+UOoKGhkW1Rw9zovsQwpNO41eXDJtt8FSq5YUMFK
         5gqHc+bIQFGla9BaLzj4hylkL5+tmiLKNA6flCCToDZJ+/nkSfB6bsLFtfTBGGEc0Kmt
         GV0NZQ7SFcd21dYaIQFlQESnHTUKR9zUvPU6TT2J3P3jgEC0ix8dQV7j4b7fbaSQcoNv
         1u1G8feaXCJ0vOCtWTpAuYWsx8QhRXXv3RpY0X8RJVVaQNdpWhJlrKfBAp8gH01MmYBa
         W/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1uLbpKRCix6ip0P860eY71YWHM0FgUim0HU08GftBtE=;
        b=G8pMYWluCP5k5BKatIy9rhuUZaF/aJdHKv18bmDweEpGceOnJfZzaIUV2rCHXIAtm8
         C/EHh19EJMjF6P8bCxfE36jJcyxIEco0Bg7hskdNlTB1nSnX6ih6t7CtgrKoseuBgG/w
         xDZBIERMIzx5a44t8rXLtgfpIpt1u+Wo1ngvQ+SGx+ns/fX1x8PA9JGK/aJO7qrpXvlP
         5rMga0IXfU80uB8GsuiE/i8PNgfZ1Z7RZsclXIghz/OKxVLoePWP3oZzHLUTLf19O0og
         g9qKms8zJ1RJ1q1mnpS3lw2dcPT0dKy3WH/5c+7aodtRyMVGPua1Esm5GYSyygPm4GGA
         pt+Q==
X-Gm-Message-State: AOAM531F8pIQhUdIe3KUb96FQJbVHGwHY4eZPPNTO/PltyGgFSLcAYek
        S6NkIq9/zfFsfFSKIHWTMxw=
X-Google-Smtp-Source: ABdhPJw/scf642PK2WYpd2Yq++6NiYOQ8QEpCcuGhwira58TYgFAeVyKseLr0d2vFSK+/9m8foOpGQ==
X-Received: by 2002:a17:90b:1050:: with SMTP id gq16mr3338024pjb.234.1601481475499;
        Wed, 30 Sep 2020 08:57:55 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.218.220])
        by smtp.gmail.com with ESMTPSA id bt13sm2881856pjb.23.2020.09.30.08.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 08:57:54 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] KMSAN: uninit-value in rt2500usb_probe_hw
To:     Greg KH <greg@kroah.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        syzbot <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <CAKBsNO=G_t6KrAYXcnMy07HyR8yrFELFoknd=9CnHBM-CJij=A@mail.gmail.com>
 <000000000000b8d3ef05b02efa93@google.com>
 <CACT4Y+aBTN3HzDWADsvD053T=qszSu5wGTCijM-kj9xZXDHTyg@mail.gmail.com>
 <20200926065704.GA661191@kroah.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <f7073a07-d00a-8f0e-c9b1-7878a3c065f8@gmail.com>
Date:   Wed, 30 Sep 2020 21:27:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926065704.GA661191@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/09/20 12:27 pm, Greg KH wrote:
> On Sat, Sep 26, 2020 at 08:53:07AM +0200, Dmitry Vyukov via Linux-kernel-mentees wrote:
>> On Sat, Sep 26, 2020 at 5:25 AM syzbot
>> <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>>>
>>> Reported-and-tested-by: syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com
>>>
>>> Tested on:
>>>
>>> commit:         c5a13b33 kmsan: clang-format core
>>> git tree:       https://github.com/google/kmsan.git master
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=41fca8ac7f9e770a
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=35c80b2190255a410f66
>>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>>>
>>> Note: testing is done by a robot and is best-effort only.
>> Hi Anant,
>>
>> I see you are testing lots of USB bugs. USB subsystem is currently
>> broken, testing of any USB bugs will give false "no crash" results,
>> see:
>> https://lore.kernel.org/linux-kernel-mentees/CACT4Y+YmbmrH9gCCnCzP-FYa-dKxx9qhKZ+RQxi1f-+Hoj1SUg@mail.gmail.com/
> Fixes for this USB problem are in my tree now and should show up in
> linux-next on Monday.
>
> thanks,
>
> greg k-h

Is there any chance you could identify the commit that fixes this bug?
It would help us close the bug for good. :)

Thanks,
Anant
