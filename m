Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952FF28E2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgJNO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgJNO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:58:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA58C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 07:58:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f29so3548626ljo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2FYcnBU8H0J4i4s6bItghVeyyamolxWxwc9jW/lSt9o=;
        b=WNh39a4gl/EH3fm2dIpI4wEg2id2C8Jqzi4XG+VU1c9uCUP0ZmnRUh8SVK3yOmWd0r
         ZoVB+TOLaXukBMirWqTvAHmKnfBqXmYQfFK+YEpzxmsMAkSLCaf6dXsyrNAiG6VV4yzQ
         tI1Tv8x+t8ZyR5nfMsHnVC4bIxN7ovLlGV5xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2FYcnBU8H0J4i4s6bItghVeyyamolxWxwc9jW/lSt9o=;
        b=V1/LB4NGknjHMliQg9lZji2TYlamBL/oSZ3wpCXR65eZ5zOtD3Qgrk1DTMTXZBJO5b
         v8VYCcoBazAsZOB4vGw5y0U00Q57WMqvd/l08eAt2LVxtswmVeT/H+wEX6+Z4KLXLA6p
         pxj4ERH2sm84d/bYHXhi2OYmePbNRRfg5y1e6zaWyUKmpd2Uf7mmMhwRVKiggN0rBbY1
         kb210RkGnQgj8p6ZI0vo8ZHAdIKtayRJyoumLesOg8+swdPDG1ti7fYpMuh2fl+2Xqa4
         cnnBL5cOoYBRnH6XwuLZ0da1P6cwjeV+XXEclNqLJRQu9KQ9Rx2IrCqT+MCKqBSJqoxN
         axkw==
X-Gm-Message-State: AOAM5303xeUEKA0zlR6syIFFYFqT0rHTqxUdHgIhZo6UUaUMJMTfbVgf
        t2p1ERDM8a9p59O3EWVLevyvhEpnANJYYOwDpTE=
X-Google-Smtp-Source: ABdhPJwuCot+Qxowe+EFcmhs2IzkPUdBNba1DVm6pQBjc0e4vzL623NdCpOjHp3jCYjviSFXARX27w==
X-Received: by 2002:a2e:45d6:: with SMTP id s205mr2086373lja.333.1602687509609;
        Wed, 14 Oct 2020 07:58:29 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e10sm1309624ljl.41.2020.10.14.07.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 07:58:28 -0700 (PDT)
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
References: <20201012144916.GB10602@alley>
 <CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <49292e1a-7e46-b078-d15d-fb2f406317db@rasmusvillemoes.dk>
Date:   Wed, 14 Oct 2020 16:58:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 16.16, Geert Uytterhoeven wrote:
> Hi Petr,
> 
> On Mon, Oct 12, 2020 at 4:50 PM Petr Mladek <pmladek@suse.com> wrote:
>> - Fully lockless ringbuffer implementation, including the support for
>>   continuous lines. It will allow to store and read messages in any
>>   situation wihtout the risk of deadlocks and without the need
>>   of temporary per-CPU buffers.
> 
>     linux-m68k-atari_defconfig$ bloat-o-meter vmlinux.old
> vmlinux.lockless_ringbuffer
>     add/remove: 39/16 grow/shrink: 9/15 up/down: 214075/-4362 (209713)
>     Function                                     old     new   delta
>     _printk_rb_static_infos                        -  180224 +180224
>     _printk_rb_static_descs                        -   24576  +24576
>     [...]
> 
> Seriously?!? Or am I being misled by the tools?
> 
>     linux-m68k-atari_defconfig$ size vmlinux.old vmlinux.lockless_ringbuffer
>        text    data     bss     dec     hex filename
>     3559108 941716 177772 4678596 4763c4 vmlinux.old
>     3563922 1152496 175276 4891694 4aa42e vmlinux.lockless_ringbuffer
> 
> Apparently not...

Hm, that's quite a lot. And the only reason the buffers don't live
entirely in .bss is because a few of their entries have non-zero
initializers.

Perhaps one could add a .init.text.initialize_static_data section of
function pointers, with the _DEFINE_PRINTKRB macro growing something like

static void __init __initialize_printkrb_##name(void) { \
  _##name##_descs[_DESCS_COUNT(descbits) - 1] = ...; \
  _##name##_infos[0] = ...; \
  _##name##_infos[_DESCS_COUNT(descbits) - 1] = ...; \
} \
static_data_initializer(__initialize_printkrb_##name);

with static_data_initalizer being the obvious yoga for putting a
function pointer in the .init.text.initialize_static_data section. Then
very early in start_kernel(), probably first thing, iterate that section
and call all the functions. But maybe that's not even early enough?

Rasmus
