Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7412BC289
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 23:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgKUW64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 17:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKUW6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 17:58:55 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72990C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 14:58:53 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v21so10719182pgi.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 14:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8N2VIxy4A38xM9fza7pYtkI6qVSxAWz8XM0qC0aqKNA=;
        b=aA8gRTFnBjKSrdZOuqzLfMX0EviV1Q2jdQGv5HFtI8AfSp12HBIgeQbJG913u5JzvB
         mRuZhFDCTAg1spMe7KfcCo4nMz8HpE3bfSyt1HPD7pcCUFPh3kHGbGMHl4JMS66QncUS
         bnIrBGh5NDNzxbbb2HggjWJbaYpPMptexx8ssy9IXRhKJNRd6y0rWuVEH1NLHtuvaVKG
         OClajwCMPdoOWKN4CMObTvoTFyf8BsI4eXHrAocFAdB2sn6TV7Mw9NKx0EYoTZXU1h3f
         NxwWOOzIxtKKLnBI4gUnI7a1i8laziEceymvcjm9kgjNDmslyXbWa5d5fkX3D/lpWcob
         bXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8N2VIxy4A38xM9fza7pYtkI6qVSxAWz8XM0qC0aqKNA=;
        b=B20dB+q6ol+AT3xT2d93CPfHQBYYZ6nooVrE1+ZBV9rAwhvk2umkhPzLSMymvBAOvY
         Exxz8w+JnrGveCIIp8C79QqTlzyszdBwFza3yDJNwtCdm6uSZ2j1+e7+FUhPam/BUtUe
         l1AspDbco/x8Pe7s9YAIId5NBEtof0/AbooZbXr1hSR8cmJ/m4IVo3P1ApPCmj+wRDHk
         c7Dd5IJ2XI3v8oxZ8ZfQQ4zRjqqQfb2mhO4aIw8VlNEY9GWBaFFxyfqiWUd7OwR/v6+E
         uOnsfL7KdDf6/K6AKtTzM88P3drErs75aOlqQHKJ5Y2UJU/T8h3k+FyRthMFGtaNb2To
         1v7w==
X-Gm-Message-State: AOAM5335j6UlRlnI13RCAQFWx3ORIvwDG43nR2YPLt+X+NG1OvddkZs6
        FFRJ4a/Wa0ty/dmPY1lyCrsWmBcsiuN1NA==
X-Google-Smtp-Source: ABdhPJzwqY3bjKLxtEhUmyvVzgWg+xoDMgYnat9YMGfFhKhMlV7bTltdWtWSYhi4263Ov5zIgUxNdw==
X-Received: by 2002:a17:90b:309:: with SMTP id ay9mr17382473pjb.6.1605999531230;
        Sat, 21 Nov 2020 14:58:51 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s12sm3992707pgi.14.2020.11.21.14.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 14:58:50 -0800 (PST)
Subject: Re: [GIT PULL] io_uring fixes for 5.10-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6535286b-2532-dc86-3c6e-1b1e9bce358f@kernel.dk>
 <CAHk-=wjrayP=rOB+v+2eTP8micykkM76t=6vp-hyy+vWYkL8=A@mail.gmail.com>
 <4bcf3012-a4ad-ac2d-e70b-17f17441eea9@kernel.dk>
 <CAHk-=wimYoUtY4ygMNknkKZHqgYBZbkU4Koo5cE6ar8XjHkzGg@mail.gmail.com>
 <ad8db5d0-2fac-90b6-b9e4-746a52b8ac57@kernel.dk>
 <d7095e1d-0363-0aad-5c13-6d9bb189b2c8@kernel.dk>
 <CAHk-=wgyRpBW_NOCKpJ1rZGD9jVOX80EWqKwwZxFeief2Khotg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87f88614-3045-89bb-8051-b545f5b1180a@kernel.dk>
Date:   Sat, 21 Nov 2020 15:58:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgyRpBW_NOCKpJ1rZGD9jVOX80EWqKwwZxFeief2Khotg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/20 11:07 AM, Linus Torvalds wrote:
> On Fri, Nov 20, 2020 at 7:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Actually, I think we can do even better. How about just having
>> do_filp_open() exit after LOOKUP_RCU fails, if LOOKUP_RCU was already
>> set in the lookup flags? Then we don't need to change much else, and
>> most of it falls out naturally.
> 
> So I was thinking doing the RCU lookup unconditionally, and then doing
> the nn-RCU lookup if that fails afterwards.
> 
> But your patch looks good to me.
> 
> Except for the issue you noticed.

After having taken a closer look, I think the saner approach is
LOOKUP_NONBLOCK instead of using LOOKUP_RCU which is used more as
a state than lookup flag. I'll try and hack something up that looks
passable.

>> Except it seems that should work, except LOOKUP_RCU does not guarantee
>> that we're not going to do IO:
> 
> Well, almost nothing guarantees lack of IO, since allocations etc can
> still block, but..

Sure, and we can't always avoid that - but blatant block on waiting
for IO should be avoided.

>> [   20.463195]  schedule+0x5f/0xd0
>> [   20.463444]  io_schedule+0x45/0x70
>> [   20.463712]  bit_wait_io+0x11/0x50
>> [   20.463981]  __wait_on_bit+0x2c/0x90
>> [   20.464264]  out_of_line_wait_on_bit+0x86/0x90
>> [   20.464611]  ? var_wake_function+0x30/0x30
>> [   20.464932]  __ext4_find_entry+0x2b5/0x410
>> [   20.465254]  ? d_alloc_parallel+0x241/0x4e0
>> [   20.465581]  ext4_lookup+0x51/0x1b0
>> [   20.465855]  ? __d_lookup+0x77/0x120
>> [   20.466136]  path_openat+0x4e8/0xe40
>> [   20.466417]  do_filp_open+0x79/0x100
> 
> Hmm. Is this perhaps an O_CREAT case? I think we only do the dcache
> lookups under RCU, not the final path component creation.

It's just a basic test that opens all files under a directory. So
no O_CREAT, it's all existing files. I think this is just a case of not
aborting early enough for LOOKUP_NONBLOCK, and we've obviously already
dropped LOOKUP_RCU (and done rcu_read_unlock() again) at this point.

> And there are probably lots of other situations where we finish with
> LOOKUP_RCU (with unlazy_walk()), and then continue.> 
> Example: look at "may_lookup()" - if inode_permission() says "I can't
> do this without blocking" the logic actually just tries to validate
> the current state (that "unlazy_walk()" thing), and then continue
> without RCU.
> 
> It obviously hasn't been about lockless semantics, it's been about
> really being lockless. So LOOKUP_RCU has been a "try to do this
> locklessly" rather than "you cannot take any locks".
> 
> I guess we would have to add a LOOKUP_NOBLOCK thing to actually then
> say "if the RCU lookup fails, return -EAGAIN".
> 
> That's probably not a huge undertaking, but yeah, I didn't think of
> it. I think this is a "we need to have Al tell us if it's reasonable".

Definitely. I did have a weak attempt at LOOKUP_NONBLOCK earlier, I'll
try and resurrect it and see what that leads to. Outside of just pure
lookup, the d_revalidate() was a bit interesting as it may block for
certain cases, but those should be (hopefully) detectable upfront.

-- 
Jens Axboe

