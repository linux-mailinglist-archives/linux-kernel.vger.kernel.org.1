Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF62B0080
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 08:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKLHqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 02:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:46:36 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29DC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 23:46:35 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id v143so4498381qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 23:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dF6RsaHHIktkgvNBNcIGSvuJrffVhhKggv8dUohnJ78=;
        b=s1+Y+mgkOIPDImQ7+qhoLYAv+8HIcm0jtKng+rBM058O91yrM70sNDkZEvFcuSQwCf
         nfZ4r5zrts5eqi8rF69zRl4IVJApCEgvVf+lFcl/OUAoDppXUYJDN5ejjFdeJv1fflVK
         7yx9syFT7/NQLWmWrGdJsq9zWOcI9E7z/leMrsB65P17Zfk9cM55jmqYlNWa2FGKpY3/
         XYlJl8g9IreYXKFYEl2TxgbzAnModswig9O48a8CjkUFD5PQvJ/4mfbx9iTGqNcZkAnT
         2+9O2GeRBpgpyVTXEXZ/YcPm3gHf0v77LsFeKUSPC43OJ+nuTBinPPr+4AxRUciY30hN
         g+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dF6RsaHHIktkgvNBNcIGSvuJrffVhhKggv8dUohnJ78=;
        b=eG+ui6qvdcc8Un5VUxE0IoC1b1rSHmp7nI1KtlLrzbdCZ1Zk1qzvhK/gtGJoYinSM7
         EGe4AqmRb5jzZ4n5JXOtbBArQeTE04kHwvol6/hqwtep6C1MeSW0t3OUK5/OZZK2X719
         mnoU+M0ORC7OYqmJy3H8he7qLZTtVTeL/KQtkb09pTDtYX6JKuqeuwpxaiWIzaL6Iptf
         65moCaqqcz42shBTb44KbGXLOTgH/fVqY47DtdJRJYh3KdioIIgOb477l6/qkv+Zq8os
         NToD7rBXV9QcMEQbFZm5rNpgeSxUqfVX44hNdYqN0Sl71bvT2b3Lz/FL0ShAl8d29i1N
         p7FQ==
X-Gm-Message-State: AOAM532sAW5BPuViTgRbJD4impd69YL6aBBkSVhKIGhTCAY4yElMaaHw
        eXNdgsMTGZ60NgYYJAH8OO+1q8/3ShS8ZZeQtJa8Mw==
X-Google-Smtp-Source: ABdhPJy53I2pmcwfoMMCaFBNL0uOIL4e8m02+lk1EoqoKwbKgw2ugMXtQC76nNyTgV5AZ2CecuISh1Jf/hPxijDPTE8=
X-Received: by 2002:a37:9747:: with SMTP id z68mr28440407qkd.424.1605167194845;
 Wed, 11 Nov 2020 23:46:34 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Nov 2020 08:46:23 +0100
Message-ID: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
Subject: Process-wide watchpoints
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello perf maintainers,

I have a wish for a particular kernel functionality related to
watchpoints, and I would appreciate it if you can say how
feasible/complex to add it is (mostly glueing existing infra pieces,
or redesigning and adding lots of new code), or maybe it exists
already and I am missing it.

You can think of the functionality as setting MPROT_NONE but for a few
bytes only using watchpoints. On the access the accessing thread
should receive a signal (similar to SIGSEGV). Kernel copy_to/from_user
should not be affected (no EFAULT), I think this is already satisfied
for watchpoints. This functionality is also intended for production
environments (if you are interested -- for sampling race detection),
number of threads in the process can be up to, say, ~~10K and the
watchpoint is intended to be set for a very brief period of time
(~~few ms).

This can be done today with both perf_event_open and ptrace.
However, the problem is that both APIs work on a single thread level
(? perf_event_open can be inherited by children, but not for existing
siblings). So doing this would require iterating over, say, 10K
threads, calling perf_event_open, F_SETOWN, F_SETSIG, later close and
consuming 40K file descriptors.

What I would like to have is a single syscall that does all of it for
the whole process (either sending IPIs to currently running siblings,
or maybe activating this only on the next sched in).

I see at least one potential problem: what do we do if some sibling
thread already has all 4 watchpoints consumed? We don't necessarily
want to iterate over all 10K threads synchronously, nor we even want
to fail in this case. The intended use case is that only this feature
will mostly use watchpoints, so all threads will have equal number of
available watchpoints. So perhaps the removal of the watchpoint could
just communicate that there were some threads that were not able to
install the watchpoint.

Does it make any sense? How feasible/complex to add it is?

Thanks in advance
