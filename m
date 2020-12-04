Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C732CF480
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgLDTEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:04:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A9BC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 11:04:04 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v22so6924373edt.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MqRGZy01kstwz9ClfAxBNg8au7mjb5Di2jtSuxAThnw=;
        b=cKh7YAPyiW5dF2YKcQ6YErWfHBKONF7uMnPY9TYmHN7gPmV7kfqvsO4K0lg++uClO4
         /NKlA32KStz5R5xgk/EmX5yO3AeBxOVahoO7Cr/jlnA8KqQqzxvURXxN06PLGzr6WMff
         onAd2r/QLhG3fZ+UTnXB7iwVosDOUPxQfGz4C8bJhE2yN1OhePi+9XpIiqRjOES4G6Us
         PH6bCU13CsY7mDMvTvYQ/b13hFDg5UwUmsOMVIFCogK/Kz+7mHZ64tLeW9PR81vJ+une
         J/od/fTCV8y1bBhUuty/kWa4a3dAtkQmR1L+3v7h8E1Ampsvk9MEVlznXOkGJ/x6L0eQ
         FnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MqRGZy01kstwz9ClfAxBNg8au7mjb5Di2jtSuxAThnw=;
        b=t6C2WUfuSnDDs4zQ2SGTVF22pMZP3CTrjlyHa2wnnB9S34QOoblj6hJLMwSUcGsc4m
         lz6+gsNr8w1kk/1IrN4Nsaq+66+F3noV1LWZBVKdECAQyvphoaY+y67XvSVr8ui22Ea3
         6gvDNJ4Ow69eTHs9Xg1+pAT7EAnlUpi+BbWIXGPdB7u+eEb5Et7emufXPrpapgsrB5P5
         pOkiNxXC5LPYrgwDBZX/93VYgjW97kw6xAdkpCq19fTdCA6sU7QHG5JkCATtgs77xP7p
         tXS82Es21cUo5QNsVKd05JE5oKxKTRHnF7xgAwh7beo9wdC219cJe84/krW1gi7I2fQT
         nkgw==
X-Gm-Message-State: AOAM533lssEkLk/jRS4aFlDCdfPY+4GBgjPrwBVKGKD0/ViMIZVAbB3O
        7xcJQPt8pKxJSHrotDWnzetW3SdJJH7hSW76uSAuzC9eCJOYRT64
X-Google-Smtp-Source: ABdhPJwhhMhsQr+VWTK66ALmYBtYgDGk3593gFW7FRQCJRH8kC4J57TPK3zbqIHhm1yF098qCGo9CPVlPYN9XjZIZrQ=
X-Received: by 2002:aa7:da8f:: with SMTP id q15mr8904092eds.239.1607108642178;
 Fri, 04 Dec 2020 11:04:02 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 5 Dec 2020 00:33:51 +0530
Message-ID: <CA+G9fYsHo-9tmxCKGticDowF8e3d1RkcLamapOgMQqeP6OdEEg@mail.gmail.com>
Subject: BUG: KCSAN: data-race in tick_nohz_next_event / tick_nohz_stop_tick
To:     open list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        lkft-triage@lists.linaro.org
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKFT started testing KCSAN enabled kernel from the linux next tree.
Here we have found BUG: KCSAN: data-race in tick_nohz_next_event /
tick_nohz_stop_tick

This report is from an x86_64 machine clang-11 linux next 20201201.
Since we are running for the first time we do not call this regression.

[   47.811425] BUG: KCSAN: data-race in tick_nohz_next_event /
tick_nohz_stop_tick
[   47.818738]
[   47.820239] write to 0xffffffffa4cbe920 of 4 bytes by task 0 on cpu 2:
[   47.826766]  tick_nohz_stop_tick+0x8b/0x310
[   47.830951]  tick_nohz_idle_stop_tick+0xcb/0x170
[   47.835571]  do_idle+0x193/0x250
[   47.838804]  cpu_startup_entry+0x25/0x30
[   47.842728]  start_secondary+0xa0/0xb0
[   47.846482]  secondary_startup_64_no_verify+0xc2/0xcb
[   47.851531]
[   47.853034] read to 0xffffffffa4cbe920 of 4 bytes by task 0 on cpu 3:
[   47.859473]  tick_nohz_next_event+0x165/0x1e0
[   47.863831]  tick_nohz_get_sleep_length+0x94/0xd0
[   47.868539]  menu_select+0x250/0xac0
[   47.872116]  cpuidle_select+0x47/0x50
[   47.875781]  do_idle+0x17c/0x250
[   47.879015]  cpu_startup_entry+0x25/0x30
[   47.882942]  start_secondary+0xa0/0xb0
[   47.886694]  secondary_startup_64_no_verify+0xc2/0xcb
[   47.891743]
[   47.893234] Reported by Kernel Concurrency Sanitizer on:
[   47.898541] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
5.10.0-rc6-next-20201201 #2
[   47.906017] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018

metadata:
    git_repo: https://gitlab.com/aroxell/lkft-linux-next
    target_arch: x86
    toolchain: clang-11
    git_describe: next-20201201
    download_url: https://builds.tuxbuild.com/1l8eiWgGMi6W4aDobjAAlOleFVl/

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/2002643#L2019

-- 
Linaro LKFT
https://lkft.linaro.org
