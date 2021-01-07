Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2782EC750
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 01:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAGAZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 19:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAGAZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 19:25:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C2C06136F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 16:24:39 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o13so10744160lfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 16:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2JDLTfqOpjQxN8FILQClzf9FmSPwRHg0vB82buu7nE=;
        b=inAS7K5t7adUK26GrcC2htux/ANDgLVum0YBEXPqfJkCbBgVNpow5XIcZbgx2rps5c
         S7fh2UIOEowFv4GLK6bJquuhDUzISPL4KUHqWIdyyEdR1Scag7APmNCN5niYl1bBh0uo
         3DP5EMyEqNnzd/cmlCIMcIYfQm4HqSnXor7wNGqubQpoCfP1G0+3ewE/QHpWQjox0JFi
         Aak/cBv6OF63BXXC5TGUK0SYyxp4OXIQglaEYYhDW4Burfb5zqELqcG9LoeOkF2giOlP
         5UdR/3ln0f7p96O/HwtOotFXBuvZRXDgjJ5bw+22onLM5NcdUaaIwim1gQ9TnYa45dGd
         PJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2JDLTfqOpjQxN8FILQClzf9FmSPwRHg0vB82buu7nE=;
        b=WDT8T6JrnCISNOyt7Eh3Ovq0TEMBtJUAWNtqXmpYM0UpQMDjXWJuBMfcOvRlP/91JD
         nYprKax9Z8rh5RZ0P6XyGTZjb8YZw4jP8r/9/OpeuK6QpJfsizgRNogzd9u3Ts2qH6HQ
         eS6Q1UUlofcYTXA4m6+02ODoenHoI6BaVawOnQ98ke6x+jsxewFKHM265KNk1Jxag7Qt
         pQAqUgjxGT7MIDkeKGJE68ardhY7qga442aiuTtqEXVu23SUt0ODrqUhGxCnyovd8AQ3
         8VOvXzSGEy6g7GP+OypomlXKYzvdVHdKslBkPKkKy/2JAbKn3DVcOqP9ysGD7iw338T1
         SB/g==
X-Gm-Message-State: AOAM533Hi/+wYgGZpxKuNREQg+jcsAqnZXaPRazwKmr3biztRFdlNmFU
        4y1b1e1qa9uL7MAa3n+8FcU/L8XO7L/krdFk0m880DWLO3RdjA==
X-Google-Smtp-Source: ABdhPJwSrbvBZizwUDwD9EsBcL8ZrzHv8Wff2CJqlkBuAlD67nLTGHkuPWke/DnrHU1JwLLrhbZfRnqaA86N5RzHlyk=
X-Received: by 2002:a2e:9896:: with SMTP id b22mr2905956ljj.9.1609979077706;
 Wed, 06 Jan 2021 16:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20201117025522.1874864-1-rkir@google.com> <CAOGAQerMMg5+WgfebtFO3nut47QKa9QtpWxg3Eb3cR2ri3pRTQ@mail.gmail.com>
In-Reply-To: <CAOGAQerMMg5+WgfebtFO3nut47QKa9QtpWxg3Eb3cR2ri3pRTQ@mail.gmail.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Wed, 6 Jan 2021 16:24:26 -0800
Message-ID: <CAOGAQeqMUj0MCbTfetAX54iN40UCYqxqQ48UPtntYQKOTK6N3w@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: platform: retire arch/x86/platform/goldfish
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Thoman, +Ingo, +Borislav

On Mon, Dec 14, 2020 at 1:20 PM Roman Kiryanov <rkir@google.com> wrote:
>
> On Mon, Nov 16, 2020 at 6:55 PM <rkir@google.com> wrote:
> >
> > From: Roman Kiryanov <rkir@google.com>
> >
> > The Android Studio Emulator (aka goldfish) does not
> > use arch/x86/platform/goldfish since 5.4 kernel.
> >
> > Signed-off-by: Roman Kiryanov <rkir@google.com>
>
> Gentle ping.
