Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF933014DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 12:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAWL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 06:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbhAWL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 06:27:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B699AC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 03:26:33 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id h15so2274130pli.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 03:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Es16ji9JzCk0d8FX+7ONZxGIUMkfIN2YI8ed9LzZPjQ=;
        b=Tl2UyA+OlrO678IteKY8M7hcIf3MpCi9FIqc1Uw3wCuaOfPQIZkHgPF2bJgKBE241Q
         L8U4RiEcAb58/FP+5NNHDOJ8Jgz6JsNDKckptdqbvr2Xx5QwVlS4gjV3CrM/xPEuYyKg
         vnyP8J43+pdFO1JiQO3Lns/A5jAc0sz8gycd1JAKF16Gov0vsj/2RTKbFwypzs581qQ6
         /HlaUL77mrybzam/kBfuwwAiR40pgEhCks0BqvNdxa+TFZGi75EZgh02K6dHUED5dW+x
         vjtc4diuAZnkuZJgrGph1Xt2F927L/8n4ZoltATDzFlCeib0JUCzanLjkIof7afKbyNS
         FwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Es16ji9JzCk0d8FX+7ONZxGIUMkfIN2YI8ed9LzZPjQ=;
        b=UOgub4FDNonzn672CW8wRd9xd31K5V0ZlcYcTwky65vM1FYallYiJFySFfP8EN0r56
         eD6eGoIeTPO2a6Qy/KoDuMN/E1luV15+IyYnh8IpwuaGe1B/4kaAwPoSSmkB7OUZtt39
         3Eul6zLBAD7g7JkzG7ZNmB59IvtjWtL5S5ESq96QKiKpG86dPULjQDN6yXuA1ip3zWbs
         wLsWXLYn1L6B+Qm8HmXxsuw1/CWqKC+a7w2tJTLL9srZAM1HbUf5KeY5WvKgyiNIw+jY
         OKXTkx+YcpNrPwJ7pxEo7vHHvxjGydcBX8nzvlhSDamDHhbSwcL5r0HD8KFhizXTR768
         TikQ==
X-Gm-Message-State: AOAM5308Dm55meYU3WdK7wbs0cjxfLHQewGyMvkvw5JzpErUWPzjZRFJ
        YWFh5DMkbcBLhWVMvUeB+iKFng==
X-Google-Smtp-Source: ABdhPJy9Zq8XLh+z521xpbJtrVd96M4GTB+BO0OhrMkyBmi1THVYwPLFzKZE84wOKLQxNIP1Pk+8Wg==
X-Received: by 2002:a17:902:a512:b029:db:cf4c:336b with SMTP id s18-20020a170902a512b02900dbcf4c336bmr1610087plq.17.1611401193188;
        Sat, 23 Jan 2021 03:26:33 -0800 (PST)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id h4sm8400693pfo.187.2021.01.23.03.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 03:26:32 -0800 (PST)
Subject: Re: BUG: MAX_LOCKDEP_KEYS too low!
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hillf Danton <hdanton@sina.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <c099ad52-0c2c-b886-bae2-c64bd8626452@ozlabs.ru>
 <CACT4Y+Z+kwPM=WUzJ-e359PWeLLqmF0w4Yxp1spzZ=+J0ekrag@mail.gmail.com>
 <6af41136-4344-73da-f821-e831674be473@i-love.sakura.ne.jp>
 <70d427e8-7281-0aae-c524-813d73eca2d7@ozlabs.ru>
 <CACT4Y+bqidtwh1HUFFoyyKyVy0jnwrzhVBgqmU+T9sN1yPMO=g@mail.gmail.com>
 <eb71cc37-afbd-5446-6305-8c7abcc6e91f@i-love.sakura.ne.jp>
 <6eaafbd8-1c10-75df-75ae-9afa0861f69b@i-love.sakura.ne.jp>
 <20210123060145.18356-1-hdanton@sina.com>
 <8b1fff6b-1acc-4582-0abe-86f948ac4b4a@ozlabs.ru>
 <0bfad7f4-550a-0645-d24b-940e399e9c2c@i-love.sakura.ne.jp>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <dc1e9f3a-b40f-8db3-bce3-07c3c12af8ea@ozlabs.ru>
Date:   Sat, 23 Jan 2021 22:26:28 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <0bfad7f4-550a-0645-d24b-940e399e9c2c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/01/2021 21:29, Tetsuo Handa wrote:
> On 2021/01/23 15:35, Alexey Kardashevskiy wrote:
>> this behaves quite different but still produces the message (i have show_workqueue_state() right after the bug message):
>>
>>
>> [   85.803991] BUG: MAX_LOCKDEP_KEYS too low!
>> [   85.804338] turning off the locking correctness validator.
>> [   85.804474] Showing busy workqueues and worker pools:
>> [   85.804620] workqueue events_unbound: flags=0x2
>> [   85.804764]   pwq 16: cpus=0-7 flags=0x4 nice=0 active=1/512 refcnt=3
>> [   85.804965]     in-flight: 81:bpf_map_free_deferred
>> [   85.805229] workqueue events_power_efficient: flags=0x80
>> [   85.805357]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
>> [   85.805558]     in-flight: 57:gc_worker
>> [   85.805877] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 82 24
>> [   85.806147] pool 16: cpus=0-7 flags=0x4 nice=0 hung=69s workers=3 idle: 7 251
>> ^C[  100.129747] maxlockdep (5104) used greatest stack depth: 8032 bytes left
>>
>> root@le-dbg:~# grep "lock-classes" /proc/lockdep_stats
>>   lock-classes:                         8192 [max: 8192]
>>
> 
> Right. Hillf's patch can reduce number of active workqueue's worker threads, for
> only one worker thread can call bpf_map_free_deferred() (which is nice because
> it avoids bloat of active= and refcnt= fields). But Hillf's patch is not for
> fixing the cause of "BUG: MAX_LOCKDEP_KEYS too low!" message.
> 
> Like Dmitry mentioned, bpf syscall allows producing work items faster than
> bpf_map_free_deferred() can consume. (And a similar problem is observed for
> network namespaces.) Unless there is a bug that prevents bpf_map_free_deferred()
>   from completing, the classical solution is to put pressure on producers (i.e.
> slow down bpf syscall side) in a way that consumers (i.e. __bpf_map_put())
> will not schedule thousands of backlog "struct bpf_map" works.


Should not the first 8192 from "grep lock-classes /proc/lockdep_stats" 
decrease after time (it does not), or once it has failed, it is permanent?




-- 
Alexey
