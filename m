Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADEC290665
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408165AbgJPNfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408061AbgJPNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:35:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF394C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:35:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 1so1309245ple.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sIIYwVzr9MZ7XYUxbhtiYcNWGt28tWA4X7MM75B6zyY=;
        b=PfHSe1B8Nd1DK90c+5psOE40Qq0rPLQprXnrW667HZqtFIAJEi24skC70NnNmLipSI
         /NKUpfU3MT5xNgol8wfpdlMtn2YpP39dDZMjh0yYS5lV+0X2+ceTGM/qOiUj3ewdrfSH
         hfNz4naxFqDYDhyBoQNDZSLp7FgzGsGA4xYG8Qb15tIOdYXym31SHPGhdiRdv6DGc0mK
         PjpfXIozTggBIBgssa73/11RZCZpQoKuYh9Du2VYNONZuBsA2xVR6CVv73ZdOkdGJnm0
         vFHJZN8s0zRrzqanHokHI1IlJasJ1HZKNPgisLkYWkNfNtBQWdcQQq4TE29Eg8we1tSv
         IZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIIYwVzr9MZ7XYUxbhtiYcNWGt28tWA4X7MM75B6zyY=;
        b=YsktnUDrtg6cCQ/dJ5l2sCNECMAe56niRJMp8Hy2BV7n+SUjE2GzJhg6QNo+5kBj3m
         oy0zRwo6u0fRkok0p0R6urKIf+Ff58CCC9CFS2R6LC/2VP4VVdYjSkW9K2iinjwjNpWB
         bUjIAtqQJK9i7pvfPn5CQT9gBh+wVuRRKeObDghykDaPbDPgN5R/oMlXFuQV2SGn78B1
         SG6+QobBac0ZSosH+WGEQKIBqfFru8UHw9Y5A+xZMn2lNhwxGE1IJJ8pG3Ns3OMG1OFd
         iOiJxjd/5NaKbbamq4vjw1nl+minTlRSHHnflfAnxVSgbsMCbVgeM7TOKqaLRAhCx2KM
         s+/w==
X-Gm-Message-State: AOAM533CCU5lUBoDRiKRVr5HxjnSCNkgECJwArQtC4qUMaRBFo+EYvWJ
        zkRhQAtk4DjgDUcv8r4XTa8V9w==
X-Google-Smtp-Source: ABdhPJwvnspF+6nSd9+lZoOoE2oz8Wq61FmRXXvgWk1GKMx83qDFyrY+Xuw4agOx9kDfalH/6ctTDQ==
X-Received: by 2002:a17:90a:8585:: with SMTP id m5mr4046253pjn.69.1602855346208;
        Fri, 16 Oct 2020 06:35:46 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l199sm3035423pfd.73.2020.10.16.06.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 06:35:45 -0700 (PDT)
Subject: Re: [PATCH 5/5] task_work: use TIF_NOTIFY_SIGNAL if available
To:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, Roman Gershman <romger@amazon.com>
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-6-axboe@kernel.dk> <20201015154953.GM24156@redhat.com>
 <e17cd91e-97b2-1eae-964b-fc90f8f9ef31@kernel.dk>
 <87a6wmv93v.fsf@nanos.tec.linutronix.de>
 <871rhyv7a8.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fbaab94b-dd85-9756-7a99-06bf684b80a4@kernel.dk>
Date:   Fri, 16 Oct 2020 07:35:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871rhyv7a8.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 3:39 AM, Thomas Gleixner wrote:
> On Fri, Oct 16 2020 at 11:00, Thomas Gleixner wrote:
>> On Thu, Oct 15 2020 at 12:39, Jens Axboe wrote:
>>> On 10/15/20 9:49 AM, Oleg Nesterov wrote:
>> So if you change #2 to:
>>
>>    Drop the CONFIG_GENERIC_ENTRY dependency, make _all_ architectures
>>    use TIF_NOTIFY_SIGNAL and clean up the jobctl and whatever related
>>    mess.
>>
>> and actually act apon it, then I'm fine with that approach.
> 
> Which makes me rethink my view on Olegs suggestion:
> 
>>>> You can simply nack the patch which adds TIF_NOTIFY_SIGNAL to
>>>> arch/xxx/include/asm/thread_info.h.
> 
> That's a truly great suggestion:
> 
>    X86 is going to have that TIF bit once the above is available.
> 
> I'm happy to help with the merge logistics of this.

Not really following this email...

But it seems to me that you're happy with approach 2, so I'll do
the following:

- Get rid of the CONFIG_GENERIC_ENTRY dependency for TIF_NOTIFY_SIGNAL
- Respin the arch additions and cleanups on top of that again

And hopefully we'll have something mergeable at that point. Once we
have this series merged somewhere (would be great if you could carry
it), I'll be talking to arch folks on the rest. Once archs have taken
the necessary bits, I'll be posting the third and final series which
is the cleanups that are currently sitting on top of the arch support.

-- 
Jens Axboe

