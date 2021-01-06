Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083EA2EBB52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbhAFIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAFIvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:51:00 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33877C06135B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:49:58 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id i18so2085407ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iibSmPq0eLjVX/S5+pf4M3ZmZCgI0X4nBBazQytepq8=;
        b=enRj3UJck+B7jDr9WMCk8x8sFE9xWXZP0rwVFDPxIOnaOWpU9HBK2QpAsmQuBu0jx4
         O+KF4CxoNh3XPXe4zX4uoou9LzxbEPjLYHr/jKS0RhjVM8Bq5kWbhv+3AMzxXSqWGpTd
         gS4lQ8q9QsZrLfLB8vhH+1/CN32lltmJ1OqI4P7iA7QvCdPKB4WbM4eSXeQtIgJRi0Oy
         zObUsJlESGGuZ+kI8a1kGO/WfJjbNj7pwn9bCKayEz0LJ8NxT1LLrE+lmF/WDrEHP1A0
         zgC31ra8/PgcX6BAHWjChvp2+m6GuWLQderxBxn15eo54btiWOm2rTizGmw1HIVlHQVL
         Bzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iibSmPq0eLjVX/S5+pf4M3ZmZCgI0X4nBBazQytepq8=;
        b=UdHzp/I4GSl/bjpAnRUZUiFKV5fAF9Ejev9t5xQ3E5le2dioJvFaObT95R87ws7XXS
         GzZCpADbZ1cjbNw4K7YDUGrIJGGSvTzH3nETUQvWls8t6I9TP4kRzLnHY/WUQjw6N6Mp
         9eqUHBW+pp1+KEqiUZW/S4Pjd4Hslj2YpxFcBu/q2d1ocMRZA5bEdpbRABa+UQd9xlnl
         5G7oVlP/n3snIRALtEUMXD+UP7LjlpAvwraYkc4XoaTyhtomNWRWALbFRL1ikZQFa14G
         VMF82kqYIF55CSgAaLN9HHp6MJVD/8MyK49H1TsDE0du7RiHX7uAl4ov9Ck0+CDAjv2+
         N/lg==
X-Gm-Message-State: AOAM532EaaPs13ceEy714gQrC7XrRxMTkBcz0lbKDJJloUzNWIo8arff
        RqyjI3cDZv+Y+TB61V7CoQxUVi13vUSBp5SsuW3ehJCSrQk=
X-Google-Smtp-Source: ABdhPJwjxL1rOtX8rTMTGgznA5BoxcBf5qXD2FiPG89ll77Pvuc+RRsQ/3CCiGmKvuL5TSuLt+avz0ARMpz/M+lrE7U=
X-Received: by 2002:a02:b042:: with SMTP id q2mr2849056jah.29.1609922997523;
 Wed, 06 Jan 2021 00:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
In-Reply-To: <20210106004850.GA11682@paulmck-ThinkPad-P72>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 6 Jan 2021 00:49:46 -0800
Message-ID: <CAAH8bW95nyx6PEnPiBPoHMLoduvgU9KO7N=K7mhLORkA+zzhDw@mail.gmail.com>
Subject: Re: [PATCH RFC cpumask] Allow "all", "none", and "last" in cpumask strings
To:     paulmck@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paul.gortmaker@windriver.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 4:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello!
>
> This series allows "all", "none", and "last" to be used in cpumask
> strings.  This allows these strings to be less dependent on the underlying
> system.  For example, currently a string specifying all but the first
> CPU must be "1-7" on an eight-CPU system and "1-15" on a 16-CPU system.
> With this series, the single string "1-last" can be used regardless of the
> number of CPUs (at least assuming that each system has at least one CPU).

'none' may be implemented as an empty string or string with separators only,
but I have nothing against explicit 'none'. See other comments inline.

Thanks,
Yury.

> 1.      Un-inline cpulist_parse for SMP; prepare for ascii helpers,
>         courtesy of Paul Gortmaker.
>
> 2.      Make "all" alias global and not just RCU, courtesy of Paul
>         Gortmaker.
>
> 3.      Add a "none" alias to complement "all", courtesy of Paul
>         Gortmaker.
>
> 4.      Add "last" alias for cpu list specifications, courtesy of Paul
>         Gortmaker.
>
> 5.      Use "all" and "last" in "nohz_full" and "rcu_nocbs".
>
>                                                 Thanx, Paul
>
> ------------------------------------------------------------------------
>
>  Documentation/admin-guide/kernel-parameters.rst            |   20 +
>  Documentation/admin-guide/kernel-parameters.txt            |    4
>  include/linux/cpumask.h                                    |    8
>  kernel/rcu/tree_plugin.h                                   |   13 -
>  lib/cpumask.c                                              |  136 ++++++++++++-
>  tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot |    2
>  tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot |    2
>  7 files changed, 169 insertions(+), 16 deletions(-)
