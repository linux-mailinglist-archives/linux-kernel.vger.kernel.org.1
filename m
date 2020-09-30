Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA66927EEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbgI3QVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgI3QVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:21:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E66FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:21:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o25so1415600pgm.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1adC8Tkvj+zqWutRrTnpUxs4YYDIuCozInifjHCCiG4=;
        b=PoKoM5hkfHcJOUzAoToVpiuWu8svURVUi+lb9pwaOK5QDiPwjOi/8d+YhbsEUR6fth
         c7T0HRujiWA28AxgzdFwpi7jQ/kP6dF4LKU+cLRiGyxNiBRkeB8t+xs/GhHqBGkncib8
         9woS6WYIplUpEUWeL7VTd8uYq34Tx3FRKYyOkssDIOtmwL4a5cUj/w+s2QH0yYacUMzw
         qkFoRusDfmV5P5M9Dtog1LPUYjl+BUw4yoI7kGO31cHsJqeWf0ejaueZrrLD4aVWirAi
         FKikQnh1/fh/If9AgoRwizA3rrUdUI0RkPdoFCOvSY3fCTSDBrJOXOFJZ6dazPB87eXh
         yLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1adC8Tkvj+zqWutRrTnpUxs4YYDIuCozInifjHCCiG4=;
        b=TaQW44ilR76hoAOE4UvN/idPfVdyW8+BGgXKEThr9FbNxXpKcyBXSjQuxAKLQSnUnZ
         M7P/C6DgRXf7U4T+aJDq41hf0nvIgZ5KW00OR0nt4G4dJrf8vnvu3dC0fgracpG1y2GG
         fkZPd3wyS/DPhZh0wJthVDdFRS2X+ctGfgynSpn+Vhw3e4EPu84zU15kz1pVzqVjcdIQ
         CldAsSfat49ga5nEraDvAhIMDIEJR9aqA3SO58lri5syoje9TOMn/YmMOZL8RkJbAzIY
         8vassD7btYZn7/prlEN3wJUoQBTaNFcPm315GYWyde1z2JDgEHxpDpGF89phjQvltdcP
         2kqA==
X-Gm-Message-State: AOAM530Lsx42OA+I/U+X5aU4cTMJuFw0n20NFCujLGxema3khJGutWR5
        IsL/XX7JT/s7PoGxbwOXruY=
X-Google-Smtp-Source: ABdhPJwDiSkvBwIgfVIzBCzHZa3lNBxHaQf7HrK39JvOUTpQ+haZC/zzQ9ko4vBkI7QfuTGuazmB4g==
X-Received: by 2002:a05:6a00:888:b029:13f:f7eb:578c with SMTP id q8-20020a056a000888b029013ff7eb578cmr3220642pfj.10.1601482862889;
        Wed, 30 Sep 2020 09:21:02 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.218.220])
        by smtp.gmail.com with ESMTPSA id w206sm3138435pfc.1.2020.09.30.09.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 09:21:02 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] KMSAN: uninit-value in rt2500usb_probe_hw
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg KH <greg@kroah.com>, Andrey Konovalov <andreyknvl@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        syzbot <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <CAKBsNO=G_t6KrAYXcnMy07HyR8yrFELFoknd=9CnHBM-CJij=A@mail.gmail.com>
 <000000000000b8d3ef05b02efa93@google.com>
 <CACT4Y+aBTN3HzDWADsvD053T=qszSu5wGTCijM-kj9xZXDHTyg@mail.gmail.com>
 <20200926065704.GA661191@kroah.com>
 <f7073a07-d00a-8f0e-c9b1-7878a3c065f8@gmail.com>
 <CACT4Y+a3-_C3MJtyo1UC6NcwNPnU2bmhGeGKo7OPh54CVkq1CQ@mail.gmail.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <5e03840b-c090-9f30-ae19-ef4d3c2050d8@gmail.com>
Date:   Wed, 30 Sep 2020 21:50:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a3-_C3MJtyo1UC6NcwNPnU2bmhGeGKo7OPh54CVkq1CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/09/20 9:46 pm, Dmitry Vyukov wrote:
> On Wed, Sep 30, 2020 at 5:57 PM Anant Thazhemadam
> <anant.thazhemadam@gmail.com> wrote:
>> On 26/09/20 12:27 pm, Greg KH wrote:
>>> On Sat, Sep 26, 2020 at 08:53:07AM +0200, Dmitry Vyukov via Linux-kernel-mentees wrote:
>>>> On Sat, Sep 26, 2020 at 5:25 AM syzbot
>>>> <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com> wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>>>>>
>>>>> Reported-and-tested-by: syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com
>>>>>
>>>>> Tested on:
>>>>>
>>>>> commit:         c5a13b33 kmsan: clang-format core
>>>>> git tree:       https://github.com/google/kmsan.git master
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=41fca8ac7f9e770a
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=35c80b2190255a410f66
>>>>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>>>>>
>>>>> Note: testing is done by a robot and is best-effort only.
>>>> Hi Anant,
>>>>
>>>> I see you are testing lots of USB bugs. USB subsystem is currently
>>>> broken, testing of any USB bugs will give false "no crash" results,
>>>> see:
>>>> https://lore.kernel.org/linux-kernel-mentees/CACT4Y+YmbmrH9gCCnCzP-FYa-dKxx9qhKZ+RQxi1f-+Hoj1SUg@mail.gmail.com/
>>> Fixes for this USB problem are in my tree now and should show up in
>>> linux-next on Monday.
>>>
>>> thanks,
>>>
>>> greg k-h
>> Is there any chance you could identify the commit that fixes this bug?
>> It would help us close the bug for good. :)
> I think Greg meant the fix for the general USB brokenness, not a fix
> for this syzbot bug. This bug is not fixed to the best of syzbot
> knowledge.

Ah, okay. My bad. I was wondering why the bug wasn't closed already
if there was already a fix. Thank you for clearing that up :)

Thanks,
Anant

