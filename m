Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F056290E05
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409056AbgJPXNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393608AbgJPXNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:13:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629DC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:13:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b23so2302964pgb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QvsRxAR3QLRh7ySxFHudvfnvGYyrt1u/17WyPPBYrPM=;
        b=TQJGlod6lc/tFgFLsxCnR2bpXzvV0h5L5be1xy4ghjuJsPKqwuHdPqIRsXC3kEPUNo
         wJvTiK9GsZEYxy2hAG7KO+bXt/rc42Nypg3yko5VmC5eH4Ke2FACtg04Q9eCatPl4TG4
         kvPNRwlvPn94jRgvvEjWGoTCSKnWX6src1xlBMuIZFuhYLJML+L4SauIM2fSN3y0cVCE
         RlRLwhIbOjS04lHWiXSl5CvC0K0+TtPPT8CmozBMRmGU0tANtExiqNO1+8eK5E/E8g0J
         gN5VBzZUPKp+HTBmjvoxV0wFWSev/f9jU3iHDdSjRsp4Qw6hy2SVF/WUETwM3AVNqG87
         Txkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QvsRxAR3QLRh7ySxFHudvfnvGYyrt1u/17WyPPBYrPM=;
        b=EA4qQKORQ7WG6ipbJ/+0RS9EQIjdQTFNild5m2GTem44jFEwCiR86KfZZLYgGCuFWv
         LJKveXkABYfxm9Jgds7kaf7N/tRt8XVqi6mO9/55WE4aOalXWPXaObMMXbbaBHRZ6/8e
         aDmfM6e9BRjnbVZ/mTIAJXxX8E/WRFqr6U/HuOulMpCctvrw7/ucV1RCzZvYhDsTFOFM
         aUFbAuRF8J0jn3TzU8ANOGe87rj5r2vLMvEfddBgJ69qriN2WfEjUZJyjAWCPRChbTku
         pgKwpaV3eG+3d+t+Pye+zBf1ceZNKsFVAh9NT9JwjUaN0YtMptMR7tu/A/kvNOmZb45b
         zvAg==
X-Gm-Message-State: AOAM533cpYAUySctJj5T9YC5xyNoUIHoFZpn40FL4neqfERQVx1zPFka
        1Z0Fh83ujXbluPb7bD1L7gyHhCnmhR3uQn2O
X-Google-Smtp-Source: ABdhPJwZYONFGdcr9EkLM+w/FT+9Qof47mD0qUPPtBwyINvQ13IEofgmvXl3VyZJw0FxrysGaviRSA==
X-Received: by 2002:a62:30c2:0:b029:15c:77c7:4687 with SMTP id w185-20020a6230c20000b029015c77c74687mr1371660pfw.19.1602890000552;
        Fri, 16 Oct 2020 16:13:20 -0700 (PDT)
Received: from ?IPv6:2600:380:4910:fe35:1659:7eea:2a98:b14b? ([2600:380:4910:fe35:1659:7eea:2a98:b14b])
        by smtp.gmail.com with ESMTPSA id q23sm4197429pfl.162.2020.10.16.16.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 16:13:19 -0700 (PDT)
Subject: Re: [PATCH] task_work: cleanup notification modes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk>
 <87tuutalre.fsf@nanos.tec.linutronix.de>
 <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk>
 <87zh4lix8l.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk>
Date:   Fri, 16 Oct 2020 17:13:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87zh4lix8l.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 5:09 PM, Thomas Gleixner wrote:
> On Fri, Oct 16 2020 at 16:39, Jens Axboe wrote:
>> On 10/16/20 3:44 PM, Thomas Gleixner wrote:
>>>> - * @notify: send the notification if true
>>>> + * @notify: send chosen notification, if any
>>>
>>> Is that really all you found to be wrong in that comment?
>>
>> There really is nothing wrong, but it's not very descriptive (wasn't
>> before either).
> 
>  * This is like the signal handler which runs in kernel mode, but it doesn't                                                                                                                                                                                                   
>  * try to wake up the @task.   
> 
> If find a lot of wrongs in that sentence in context of TWA_SIGNAL.
> 
> Agreed, it was hard to understand before that, but with TWA_SIGNAL it
> does not make sense at all.

This is what I currently have:

/**
 * task_work_add - ask the @task to execute @work->func()
 * @task: the task which should run the callback
 * @work: the callback to run
 * @notify: how to notify the targeted task
 *
 * Queue @work for task_work_run() below and notify the @task if @notify
 * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL work like signals, in that the
 * it will interrupt the targeted task and run the task_work. @TWA_RESUME
 * work is run only when the task exits the kernel and returns to user mode.
 * Fails if the @task is exiting/exited and thus it can't process this @work.
 * Otherwise @work->func() will be called when the @task returns from kernel
 * mode or exits.
 *
 * Note: there is no ordering guarantee on works queued here.
 *
 * RETURNS:
 * 0 if succeeds or -ESRCH.
 */

-- 
Jens Axboe

