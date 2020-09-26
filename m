Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7538F279767
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 08:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgIZG7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 02:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 02:59:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 23:59:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so4265651pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=x+w8mC5uh7lhThmDKLQTnM7Vp+EwquhpIaBsAyJi/Us=;
        b=EvSNzB5aXtjrzf4t4vxjwfn6z67Db2P+sSUtOWsU/WL5YbOMA5V7xzyD15OuwUCXMa
         utL367Q2VoYCHqmCDLuQ1eZ8tGLsqNx9sUpZ40WnA8sVAZ08hh8fSbV7KEuRo+lrilCN
         UPWVuxWtzWdXyJ5zBM6okFfsUX3gIWbg9tItj3nrC+AsfHez/n0mMTFWBOqKLmL2tElt
         C1EkT21V+whWfrl0w1W0HbUCR9iukAcPBqn4FtunIcaUIQDdmpzFJP2exRBLbpbYIZzs
         DC09KIZsK6m63tutAoGI9SRoiCNfBkBHRkALHMX5cLoUaHPKdW4G9WmHIXCa0kGEVV4Z
         yH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=x+w8mC5uh7lhThmDKLQTnM7Vp+EwquhpIaBsAyJi/Us=;
        b=mtyvukDaTEmcGxa1Pu4hAGN8mf50XXYwMa1scHGgzDx91N2HgwtwbaqH3XwLW7+BpM
         KqShvgQhQE+ok9sdm012yzYQ5Q37+Jyx2INSRDCSC5EuFCKmfYq/CYmlYHtEyAWpUBAV
         D1GIun+Hjb5LSYV57De2UBdVmy1e3mLBydwSjmL4tj8sXnq1/0swuAInJwedU4qNCuf/
         REHBRvhyKcSdawbn14iMhdW8yHPmFkAj+2M2hN1KATFspmA6u+xnn1Vx12YWxyUHAOYk
         N6gIMDgnHWNnRHqBvO/i7fbFxjEcKofezcXVIzKzGCyf8Ws0qfpQ5i1UAnyJXPOCXg+B
         sS/w==
X-Gm-Message-State: AOAM531CFxyxoYcF5ppNqzYGO0E+BSBMwPN8oQzNAsB+SRn779cHOXl7
        kwXsDNM3uIG2eg7XqTYax8k=
X-Google-Smtp-Source: ABdhPJydWziZKnB781wBUGUPyi+qSrJHGONVRL1BJ7DKwODQ2ZsC+KMRWHife/gTBfmWSXryOpKGZA==
X-Received: by 2002:aa7:941a:0:b029:142:2501:34dc with SMTP id x26-20020aa7941a0000b0290142250134dcmr2621144pfo.53.1601103560937;
        Fri, 25 Sep 2020 23:59:20 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.212.24])
        by smtp.gmail.com with ESMTPSA id w19sm4622501pfq.60.2020.09.25.23.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 23:59:20 -0700 (PDT)
Subject: Re: KMSAN: uninit-value in rt2500usb_probe_hw
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <CAKBsNO=G_t6KrAYXcnMy07HyR8yrFELFoknd=9CnHBM-CJij=A@mail.gmail.com>
 <000000000000b8d3ef05b02efa93@google.com>
 <CACT4Y+aBTN3HzDWADsvD053T=qszSu5wGTCijM-kj9xZXDHTyg@mail.gmail.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <e1baa592-9c7f-4bc0-dbb0-d76b3afe289f@gmail.com>
Date:   Sat, 26 Sep 2020 12:29:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aBTN3HzDWADsvD053T=qszSu5wGTCijM-kj9xZXDHTyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/09/20 12:23 pm, Dmitry Vyukov wrote:
> On Sat, Sep 26, 2020 at 5:25 AM syzbot
> <syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>>
>> Reported-and-tested-by: syzbot+35c80b2190255a410f66@syzkaller.appspotmail.com
>>
>> Tested on:
>>
>> commit:         c5a13b33 kmsan: clang-format core
>> git tree:       https://github.com/google/kmsan.git master
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=41fca8ac7f9e770a
>> dashboard link: https://syzkaller.appspot.com/bug?extid=35c80b2190255a410f66
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>>
>> Note: testing is done by a robot and is best-effort only.
> Hi Anant,
>
> I see you are testing lots of USB bugs. USB subsystem is currently
> broken, testing of any USB bugs will give false "no crash" results,
> see:
> https://lore.kernel.org/linux-kernel-mentees/CACT4Y+YmbmrH9gCCnCzP-FYa-dKxx9qhKZ+RQxi1f-+Hoj1SUg@mail.gmail.com/

Oh, I see. Thank you for letting me know. I'll be sure to keep that in mind, until I hear
otherwise. :)

Thanks,
Anant
