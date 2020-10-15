Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243A228F4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbgJOOmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgJOOmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:42:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2942AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:42:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b8so1847876ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xRHb+4Ky/V1Lt2ATs65TeA1Gfdh7+qDb/BnroGwTxJU=;
        b=lL7W34viiafNzotEjh2hT9nzGgdzO7xopaFI8MqHUnHh6IGk0h8djzj1KG2IIG4yRo
         8JSQe9HZxSnlWgS1Ud/FrWrOVPs5uOyJ3CSKXCP2UpAJJRd2lVj2a+Od/SBEJ/UGF+M7
         mwF8ldI9AxlJvYhiZp/7A+uAWz5/O2rwqdAyw/MPA9ql67exyEZWoadX3U/K2oiuHexB
         DWv7qz9DxxwT5aILEXgcFBZMTfZ4xuZeqOYSnHX1kLo8MKEoZde8wHiiqWXVHKAjBfwm
         aGk8oUsTwSOHZkzeH1Hm20qhMeprB9FwVs662l6m6KTsWfRb93VYToqWM6pVjg6C+cF7
         CvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xRHb+4Ky/V1Lt2ATs65TeA1Gfdh7+qDb/BnroGwTxJU=;
        b=EXs1FF+UrynMN01SZHyHLlh1o0CB2LGbyvNiG1pFt4DZXVHzH2dGpmaMtYuDG+3YqY
         uu6k9W5q5/5uXy87xCaZ90s3PVEjk0LHI6FoRAt+hXaOyFgCQrJtuBX0NYTcAJL2IiqA
         A0vSYTlnvy8mowBh7ZZdo8bKKoh8F1WJQBGcN2pPIdOgrasglL8cnmOfOZbMvUsujWft
         pTZuXjEpvjvQY/fK60xLpiXC5T0HylRwutgm1S6S8EQvRVA3lYx+vaOHeMjfp3IwZ6rd
         9U/5uvOv+fCmTaZsAxz4WT15HiyjXuDKxVU4AP5ur7SV+ZqzSUjHAxFoe0eGAEIqo8hP
         /ZQQ==
X-Gm-Message-State: AOAM532eJ+wmJBuaWkF2o6m3PXl7bmCKYrdX8SdduUdqDhn74DedvA71
        Zi/4dWHYlIrpJtMdD4MMKYUshQ==
X-Google-Smtp-Source: ABdhPJz0FF5JoezsTqeMb1zaWDjR++rf7L998eS5Jfkid3LVkjGGZe30D3+qlhG8OWcZyE1490m6bg==
X-Received: by 2002:a02:caa1:: with SMTP id e1mr3918642jap.80.1602772930092;
        Thu, 15 Oct 2020 07:42:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d7sm2640754ilr.31.2020.10.15.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 07:42:09 -0700 (PDT)
Subject: Re: [PATCH 4/5] x86: wire up TIF_NOTIFY_SIGNAL
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, peterz@infradead.org
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-5-axboe@kernel.dk>
 <87o8l3a8af.fsf@nanos.tec.linutronix.de>
 <da84a2a7-f94a-d0aa-14e0-3925f758aa0e@kernel.dk>
 <20201015143616.GD24156@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f432092d-5304-110e-a03f-e97c7993a68b@kernel.dk>
Date:   Thu, 15 Oct 2020 08:42:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015143616.GD24156@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 8:36 AM, Oleg Nesterov wrote:
> On 10/15, Jens Axboe wrote:
>>
>> static void handle_signal_work(ti_work, regs)
>> {
>> 	if (ti_work & _TIF_NOTIFY_SIGNAL)
>>         	tracehook_notify_signal();
>>
>> 	if (ti_work & _TIF_SIGPENDING)
>>         	arch_do_signal(regs);
>> }
>>
>> and then we can skip modifying arch_do_signal() all together, as it'll
>> only be called if _TIF_SIGPENDING is set.
> 
> No, this can't work. We need to restart the syscall if TIF_NOTIFY_SIGNAL.

Yeah braino, Thomas caught that one too.

-- 
Jens Axboe

