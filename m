Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA4A2DF5B6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 15:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgLTOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 09:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgLTOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 09:46:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEEEC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 06:45:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r4so8154598wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 06:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mz8BsaxNNlnHJLjt0Fg0HyojxYhI6tuWtXep5xqP0XM=;
        b=KQ4d+sLq4zH6Q+xYjxE2NMrjTAJ7y8s9U1wqeK0uqd7t4yNrq6updVDJlq84nSAVg6
         JfPX0/+8lXbw0muj+uuC7jS8m06z8nYxS0HhjnIMINrpNQsxWT9L+xWzJviIN8gOcZhy
         v28OS3/pd1mEKfyDBWE/uZlMNZg5lj2TAo8NNq/ziGRdoCtJphUIW0ylyAf8huryfTUS
         4fBHbdeo1VCSOCZIqTFvcOcCOND+IkwDwcPYzvgcrGxR1MZkewEz9ODLSMS77iL+hSCq
         T7zfpl3xhesDiSbkM+IdsH8X6bYPNuU9G6tKpfnwKTsk+0+HNx2vvYA+rgWYP4t6VJ0W
         aY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mz8BsaxNNlnHJLjt0Fg0HyojxYhI6tuWtXep5xqP0XM=;
        b=ZXxE0B4rStUXhWvYfZWU90WP9A/UpXbI9IK9VJBktuCDMPKt5jN4e7jeaqKQXqC1Gc
         +F8SMcjfdcqhGAaqQaIumyX727j+Bg9tpyF5/oHqfPkKKdZ89xYr8vG3y4KwkZYxIJPO
         FBHBJVK6YXjs5HXgY3CAHjgSvuYEiDZIbZuksUg6lK5kuL6Eq6Wgq/bWJL3ldQIAE2qs
         pYfB7jdqsOy5pA+SRm3mUvc96MUzqsUTRzJ9JZLaWedMOqLpYt0HJky+6O4jgn7mcUEj
         syuaEYSifrdI5VoxG3IJESCEdv8m4iykUuc9AaUE5H9TARZzi1nQOill+nD0WICM4Vjp
         UOiQ==
X-Gm-Message-State: AOAM533qbyASif0DOiNRSxmz5ngbKuZn5jmLNHqWB2J2rCwsfTX1i87X
        yDuTnmGIur9j+mfjlncGihM=
X-Google-Smtp-Source: ABdhPJytXwfYLAcCF6nLoHMiMGy8QJJjz8+FNpdoIJ+wSAJhWL4I8HgYC72JjBjNB6ah6PKJls9uAA==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr12535706wmj.168.1608475530936;
        Sun, 20 Dec 2020 06:45:30 -0800 (PST)
Received: from [192.168.8.139] ([85.255.237.164])
        by smtp.gmail.com with ESMTPSA id j7sm19654953wmb.40.2020.12.20.06.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 06:45:30 -0800 (PST)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <abab9af4e0d26358538a45a2826650e9cefd2924.1606961931.git.asml.silence@gmail.com>
 <20201208013722.GG3579531@ZenIV.linux.org.uk>
 <ce5be208-99eb-f7bd-e602-9361008ff83c@gmail.com>
 <20201220135803.GA16470@redhat.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [RFC] exit: do exit_task_work() before shooting off mm
Message-ID: <de4bdebf-89ad-fd74-bac0-c3359994b488@gmail.com>
Date:   Sun, 20 Dec 2020 14:42:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201220135803.GA16470@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2020 13:58, Oleg Nesterov wrote:
> On 12/20, Pavel Begunkov wrote:
>>
>> On 08/12/2020 01:37, Al Viro wrote:
>>> On Thu, Dec 03, 2020 at 02:30:46AM +0000, Pavel Begunkov wrote:
>>>> Handle task works and lock it earlier before it starts killing off
>>>> task's resources like mm. io_uring makes use of it a lot and it'd
>>>> nicer to have all added task_work finding tasks in a consistent state.
> 
> I too do not understand this patch. task_work_add() will fail after
> exit_task_work(). This means that, for example, exit_files() will use
> schedule_delayed_work().

The first one? Between PF_EXITING and exit_task_work() do_exit() will
kill mm/etc., I wanted to not see tasks half dismantled for task_works
run in the exit_task_work(). Anyway, forget about it :)

>> One more moment, after we've set PF_EXITING any task_work_run() would be
>> equivalent to exit_task_work()
> 
> Yes, currently task_work_run() can not be called after exit_signals().
> And shouldn't be called imo ;)
> 
>> io_uring
>> may want (currently doesn't) to run works for cancellation purposes.t
> 
> Please see https://lore.kernel.org/io-uring/20200407163816.GB9655@redhat.com/>> Shouldn't it be like below (not tested)? Also simplifies task_work_run().
> 
> I'd prefer the patch from the link above, but your version looks correct too.

I missed the thread, thanks! tbh, splitting into 2 functions looks better
to me, but it's not like that matters

> However, I still think it would be better to not abuse task_work_run() too
> much...

The problem is that io_uring cancels requests in exit_files() and some
of them may be sitting in task_works, and we need to get them out of there
to complete.

Also, I need to double check, but seems new requests may be added during
and by cancellation because we did not yet set it to work_exited by the
time (in exit_files()). 

-- 
Pavel Begunkov
