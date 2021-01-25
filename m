Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85547302118
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAYE2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbhAYE2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:28:45 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B32DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:28:05 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e9so383587pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6dXiISuywEBuazI4xj4yFxY1nkp6ZflUiyorvnDifvs=;
        b=Pq81h34KvrPTQiyWomze+Gw0KOD9of/oGveHh8B5C5f5Sw4seL+lndqGq/fAjIrD+J
         05Cx+85/WkzFyXxhTM5yroL3dsKGbDYim/4ymqHmdb7IR3xzTBf3w2oGIBTQFsDm1st3
         hHEDn3TsvNVeMQ3/2qwteLe7YDeG/gE+x/cn6aO3UAHsIa7MF1h9DPFeoaf2sCEvujnO
         6JaptvWLA7TZRWpvpkGFFG4C6yh9Hy5FZUS1NW8LBIQbROK31BVgszsAhQZK9qtmOJzX
         WqSFtCAH8vAZvmoCr00LoAGUqYUtjbSl418ug6Cav3y2Loqs5rsA09FKY4BJumwuwhQa
         d0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6dXiISuywEBuazI4xj4yFxY1nkp6ZflUiyorvnDifvs=;
        b=YK+fJMrzBcUPQW9C6G+9S9V54snXqfHh7ZOPCDoxI+WjvMmQGf8A3cKsh9I8tSQN/i
         xDcOKbZxdNaHTx81/U7+5twlP6GllYSlRgTiuVK0wUlxgHdtdiMZiMa+/SaP9ZFpzwte
         V7NFz+7bxIMhaakwckrKpCiD85CqUbCqZ2ImSezZVrN0pCB7n0q2ql4URM0bvg6R3oP+
         uHeo1NUOZEsQhmsEZT6P8AIlcQ0Wle6auZE1i4MAIrUSzUu0sacCovlTzOoKIV0N2vHh
         8vFVL/8T1FJbtH+/pvrN8AsEo2rBH06Hi+mu07TIjjlYDhmvbnLZufR9n2X/cp/UPaoC
         Nz9g==
X-Gm-Message-State: AOAM533+mDp7WM65AhiG6mf9cJYfHEvSFkL/UVPHQVofG1MP7SnLrVgo
        ocXyfrUcfDvxhZ7PXQnZIXgNRg==
X-Google-Smtp-Source: ABdhPJw/2/1B5rytSzbIS7zdfgAkoF4oaB/9PLp8Tj4sfje42S00tsY6WtySESAMMoXHwKIe7NHOoQ==
X-Received: by 2002:a17:902:ed88:b029:de:86f9:3e09 with SMTP id e8-20020a170902ed88b02900de86f93e09mr17759813plj.38.1611548885148;
        Sun, 24 Jan 2021 20:28:05 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id gv22sm16102738pjb.56.2021.01.24.20.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:28:04 -0800 (PST)
Subject: Re: [PATCH v3 0/3] blk-mq: Don't complete in IRQ, use llist_head
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e703284-2f75-6030-f697-aa2d362c3949@kernel.dk>
Date:   Sun, 24 Jan 2021 21:27:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210123201027.3262800-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/21 1:10 PM, Sebastian Andrzej Siewior wrote:
> Patch 2+3 were applied and then dropped by Jens due to a NOHZ+softirq
> related warning [0]. Turns out a successful wakeup via
> set_nr_if_polling() will not process any softirqs and the CPU may go
> back to idle. This is addressed by patch #1.
> 
> smpcfd_dying_cpu() will also invoke SMP-functions calls via
> flush_smp_call_function_queue() but the block layer shouldn't queue
> anything because the CPU isn't online anymore.
> The two caller of flush_smp_call_function_from_idle() look fine with
> opening interrupts from within do_softirq().
> 
> [0] https://lkml.kernel.org/r/1ee4b31b-350e-a9f5-4349-cfb34b89829a@kernel.dk

I can queue up the block side once the IPI fix is in some stable branch
that I can pull in.

-- 
Jens Axboe

