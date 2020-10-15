Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7639928F4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbgJOOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbgJOOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:31:26 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B8C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:31:25 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r4so4736543ioh.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+VxgZKb2+vBYVr5mu5U+vAyYVzQnDkd2rjir40SUpEA=;
        b=wmfWABbqo3HemXdCeFC8JjwtYMVMcOqE9QUYlqrs6kIICqYmX5HLawsRTaepxXapFy
         OtPvrcqwp9c+ztSImnhCZrGMmZE9iNyMOBFQKzyJsdb2o7hmolKolIrbwuB0bsiM3IwO
         CazZUQFxZGuU0Du5gfSqsxepg7sUoGwIg1jOp4pcNfY0qzJS6v7c3Mt48vhQCqHhiuTg
         FgfxDkTMi1iLMos2obKUTavJRVz0+ZpLm1e14b1ZFwi2La0Ufog641obTV1myanJy036
         s+KpN3vcdEHHDN+l3i78SozLAwCuF8H6XEjbSgHM+Jbs4HtS88qCXspNysGuOm1tygAp
         aa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+VxgZKb2+vBYVr5mu5U+vAyYVzQnDkd2rjir40SUpEA=;
        b=VCiXJ9ucwd2aSE1VRk1ef0i2ju2CWPlh8FRkCBy2XWqZVMSLQtLgy+eGhDw+MygQJe
         j11WgFO/CW4mSU4PH3Meh3fbBDtIycjKU81NVN6xD7NnKkBA6JJnI54/1zIYrs74M62m
         MimiLulbkJKZaxNLqBTMuhOnxQ+VxebHZgKd0pTMjb8lYPo3caY5ZUm1NCqgjoFBygBx
         naBM/MXLwUSyWzcl6M2Tv1WLLvOnJj2E99iDfVPbS+lR1Wbpa9pORwp+2mkWPpDjU68f
         6KESxvzORQFVJGptQ4lBVh+bTvNErB/KYcw+v3wBaVpTjhsJjricFES3Nzy4RmE1ohAh
         vW2g==
X-Gm-Message-State: AOAM530WxHWEi6onpH53CDAPOCrQqbONmpCQaXj58oYQJGjWOEcERMw4
        1i8UlNDg0Od1wRQF4HIzMWsvgA==
X-Google-Smtp-Source: ABdhPJz7JhlRkCddlG+904l4LT6MuIyj9Z821h0UXA8vJhbHQS39HC6styoio37tALXXOoUKtqxPcA==
X-Received: by 2002:a05:6638:3a7:: with SMTP id z7mr3877799jap.52.1602772284342;
        Thu, 15 Oct 2020 07:31:24 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y75sm2892759iof.36.2020.10.15.07.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 07:31:23 -0700 (PDT)
Subject: Re: [PATCH 4/5] x86: wire up TIF_NOTIFY_SIGNAL
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-5-axboe@kernel.dk>
 <87o8l3a8af.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da84a2a7-f94a-d0aa-14e0-3925f758aa0e@kernel.dk>
Date:   Thu, 15 Oct 2020 08:31:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8l3a8af.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 8:11 AM, Thomas Gleixner wrote:
> On Thu, Oct 15 2020 at 07:17, Jens Axboe wrote:
>> --- a/arch/x86/kernel/signal.c
>> +++ b/arch/x86/kernel/signal.c
>> @@ -808,7 +808,10 @@ void arch_do_signal(struct pt_regs *regs, unsigned long ti_work)
>>  {
>>  	struct ksignal ksig;
>>  
>> -	if (get_signal(&ksig)) {
>> +	if (ti_work & _TIF_NOTIFY_SIGNAL)
>> +		tracehook_notify_signal();
>> +
>> +	if ((ti_work & _TIF_SIGPENDING) && get_signal(&ksig)) {
>>  		/* Whee! Actually deliver the signal.  */
>>  		handle_signal(&ksig, regs);
>>  		return;
> 
> Instead of adding this to every architectures signal magic, we can
> handle TIF_NOTIFY_SIGNAL in the core code:
> 
> static void handle_singal_work(ti_work, regs)
> {
> 	if (ti_work & _TIF_NOTIFY_SIGNAL)
>         	tracehook_notify_signal();
> 
>         arch_do_signal(ti_work, regs);
> }
> 
>       loop {
>       		if (ti_work & (SIGPENDING | NOTIFY_SIGNAL))
>                 	handle_signal_work(ti_work, regs);
>       }

We could, should probably make it:

static void handle_signal_work(ti_work, regs)
{
	if (ti_work & _TIF_NOTIFY_SIGNAL)
        	tracehook_notify_signal();

	if (ti_work & _TIF_SIGPENDING)
        	arch_do_signal(regs);
}

and then we can skip modifying arch_do_signal() all together, as it'll
only be called if _TIF_SIGPENDING is set.

-- 
Jens Axboe

