Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16371287647
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgJHOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbgJHOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:41:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:41:15 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y20so2234771iod.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o/r+z6NJAT0nW29OdZMW/5sNzsTKXtEQXeKtZeE84ig=;
        b=zbeOwmzO7Oz0PHNyyYbFeYw/xNCOg23Xgu4HmIPVMYtOZmueranXhG5yYTYtctRxQo
         UOqaVYAmevGL5UDGEVoAvaj32nJXlaM+3kzwQsixcRbteyIUA+/r/M0PQJEKpSjBXI3q
         M1npn6QJ8WS8n/fW4aYljFNwT398KVQHGw2ZEL89s3QhPUZG30Va8XNmYDUi8tTqzw6C
         8g4TfXeL6vy7nmTiSFRMV5c35c+laIXKvxhxyGoUKlSw4xcgMoBSo74qyCNkgbVReHmv
         EzT+hvBQuxfJl1c0vkBkE2rXGMO46jqKnMk6uF5c6XonvfYEwaey7ebU5g1SprhI/fSS
         JKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o/r+z6NJAT0nW29OdZMW/5sNzsTKXtEQXeKtZeE84ig=;
        b=g7+pi18Q0dHWMY1iAxTYMGYtKc4ExScic0gvZNNJxFuviZJQCvnBqlzlIbq+XN333v
         WLffTF20bLloBF51jVbwSkRMtV9l4pdhewvf8KHG3gZtV42tGGzoGMYP48qwz0vQST/U
         xVs1CrODZ8ZM6unoWXUiPdgnomNGhfbkD9AH1XvVuSiKj9Cc2tcte2SLyereVWbX6Jao
         z4pch6LDiSC8PAJkFwdMjS2QmjVTJzR11FLJiBdf1YHglXZgg/ZxYAVY62wH1oYcadUx
         7n+FCQGB9kXHEbfXGnLz/uEwNlMNUhqov0zys6C0u7+zE1ngFowDtU/Pmg8ezOBOb5th
         TQgA==
X-Gm-Message-State: AOAM530RTxKB/TXkbUwMRdTsdC0aAqACHX8Rgk/NX/dm6DdVn0oESGD3
        xLGo8sNPHI5VA1QDH9IYmW+WsA==
X-Google-Smtp-Source: ABdhPJxC4j/URwqOfwDaDxXzuOSObafy9l0gNqe1gaRPdqXdcdVutjZZ+u9poisO296n2wXtkgRv8Q==
X-Received: by 2002:a05:6602:1306:: with SMTP id h6mr6144357iov.160.1602168074804;
        Thu, 08 Oct 2020 07:41:14 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v18sm2744843ilj.12.2020.10.08.07.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:41:14 -0700 (PDT)
Subject: Re: [PATCH 3/6] kernel: split syscall restart from signal handling
From:   Jens Axboe <axboe@kernel.dk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
References: <20201005150438.6628-1-axboe@kernel.dk>
 <20201005150438.6628-4-axboe@kernel.dk> <20201008142135.GH9995@redhat.com>
 <de00f13d-9ff0-6955-5d37-557f044ce2aa@kernel.dk>
Message-ID: <0c06829a-17dc-3adc-f96a-25b2a41ea00c@kernel.dk>
Date:   Thu, 8 Oct 2020 08:41:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <de00f13d-9ff0-6955-5d37-557f044ce2aa@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 8:31 AM, Jens Axboe wrote:
> On 10/8/20 8:21 AM, Oleg Nesterov wrote:
>> On 10/05, Jens Axboe wrote:
>>>
>>> Move the restart syscall logic into a separate generic entry helper,
>>> and handle that part separately from signal checking and delivery.
>>>
>>> This is in preparation for being able to do syscall restarting
>>> independently from handling signals.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  arch/x86/kernel/signal.c     | 32 ++++++++++++++++++--------------
>>>  include/linux/entry-common.h | 14 ++++++++++++--
>>>  kernel/entry/common.c        | 11 ++++++++---
>>>  3 files changed, 38 insertions(+), 19 deletions(-)
>>
>> Can't we avoid this patch and the and simplify the change in
>> exit_to_user_mode_loop() from the next patch? Can't the much more simple
>> patch below work?
>>
>> Then later we can even change arch_do_signal() to accept the additional
>> argument, ti_work, so that it can use ti_work & TIF_NOTIFY_SIGNAL/SIGPENDING
>> instead of test_thread_flag/task_sigpending.
> 
> Yeah I guess that would be a bit simpler, maybe I'm too focused on
> decoupling the two. But if we go this route, and avoid sighand->lock for
> just having TIF_NOTIFY_SIGNAL set, then that should be functionally
> equivalent as far as I'm concerned.
> 
> I'll make the reduction, I'd prefer to keep this as small/simple as
> possible initially.

FWIW, then we should also just integrate the x86 define change into
that patch, so we can drop patches 3 + 5 with this change.

-- 
Jens Axboe

