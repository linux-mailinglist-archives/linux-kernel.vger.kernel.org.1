Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0517D303CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404729AbhAZK7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbhAZDvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 22:51:42 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26144C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 19:51:02 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id u22so3612931vke.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 19:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERr5chMqnNNOJKWjJQq+7FvSss//dhrARZABMDducAA=;
        b=W/5lZiBQNy1JWJYiV5a6JWLJcRKAUyoKq3slnRqZSP4vOjPev+cn+lNyupPDziwn9w
         6+WUe48shBn7tR9tR/udXYSJT0Dww3knoEu2UWFmh1ZQQlAQst0b15RVbB0Hrl/7QD3D
         mRUVvAHou5iwmkNVsSVglunqWxGATL+TT9hgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERr5chMqnNNOJKWjJQq+7FvSss//dhrARZABMDducAA=;
        b=HhjQM36mlRvqSnjtkXDFSBCACmxX7Jgmffcfsl/aWgITOTM4Gq0/63jLMMjjMTF0Jg
         zAuk48ivDuEPp+xviGDf3eO/8VjFKtU2LiD8dOAgNjVE9aYcRlISP+Cjmq+WvIjRkEFH
         pnGqDEKuEG6WvkWvQDz0UoKOv5KvS0I49Ox0zH7DPvNhNGKSLqW714CcVhuhBEk5rM87
         o2acM96RCKrNX4C3HymmqQOP3pMe1eW5ODmp4ZK4GZKfPNbTL6Hn5zlwp6eyYsQ1rP9b
         9FbHHwub5kVRB5L4IK2khr8rth+hg7DSorh7Oo0gYeYZWfwVDDFqPDX4okQwHVpaB/aM
         GX1w==
X-Gm-Message-State: AOAM5329piurDY1Fru8U6brBJK8y+1T0cs3DR9+/i3S9RkMMqLvzeY7d
        70RtaIIhRHcSAFlk+uolwaCmIN9a+E/zM7cMns+n9A==
X-Google-Smtp-Source: ABdhPJz69r02bEWD3eKp0baSYASMm3Qknvcg9NadY9ZzXeYK9s/g659l+yUCcvs8dDhMVq9K3yZ9udvKzrJCk0SJcmw=
X-Received: by 2002:ac5:ce9b:: with SMTP id 27mr3045021vke.9.1611633061185;
 Mon, 25 Jan 2021 19:51:01 -0800 (PST)
MIME-Version: 1.0
References: <CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com>
 <20210126013414.GE4626@dread.disaster.area>
In-Reply-To: <20210126013414.GE4626@dread.disaster.area>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 26 Jan 2021 11:50:50 +0800
Message-ID: <CANMq1KAgD_98607w308h3QSGaiRTkyVThmWmUuExxqh3r+tZsA@mail.gmail.com>
Subject: Re: [BUG] copy_file_range with sysfs file as input
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Luis Lozano <llozano@chromium.org>, iant@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:34 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jan 25, 2021 at 03:54:31PM +0800, Nicolas Boichat wrote:
> > Hi copy_file_range experts,
> >
> > We hit this interesting issue when upgrading Go compiler from 1.13 to
> > 1.15 [1]. Basically we use Go's `io.Copy` to copy the content of
> > `/sys/kernel/debug/tracing/trace` to a temporary file.
> >
> > Under the hood, Go now uses `copy_file_range` syscall to optimize the
> > copy operation. However, that fails to copy any content when the input
> > file is from sysfs/tracefs, with an apparent size of 0 (but there is
> > still content when you `cat` it, of course).
> >
> > A repro case is available in comment7 (adapted from the man page),
> > also copied below [2].
> >
> > Output looks like this (on kernels 5.4.89 (chromeos), 5.7.17 and
> > 5.10.3 (chromeos))
> > $ ./copyfrom /sys/kernel/debug/tracing/trace x
> > 0 bytes copied
>
> That's basically telling you that copy_file_range() was unable to
> copy anything. The man page says:
>
> RETURN VALUE
>        Upon  successful  completion,  copy_file_range() will return
>        the number of bytes copied between files.  This could be less
>        than the length originally requested.  If the file offset
>        of fd_in is at or past the end of file, no bytes are copied,
>        and copy_file_range() returns zero.
>
> THe man page explains it perfectly.

I'm not that confident the explanation is perfect ,-)

How does one define "EOF"? The read manpage
(https://man7.org/linux/man-pages/man2/read.2.html) defines it as a
zero return value. I don't think using the inode file size is
standard. Seems like the kernel is not even trying to read from the
source file here.

In any case, I can fix this issue by dropping the count check here:
https://elixir.bootlin.com/linux/latest/source/fs/read_write.c#L1445 .
I'll send a patch so that we can discuss based on that.

> Look at the trace file you are
> trying to copy:
>
> $ ls -l /sys/kernel/debug/tracing/trace
> -rw-r--r-- 1 root root 0 Jan 19 12:17 /sys/kernel/debug/tracing/trace
> $ cat /sys/kernel/debug/tracing/trace
> tracer: nop
> #
> # entries-in-buffer/entries-written: 0/0   #P:8
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>
> Yup, the sysfs file reports it's size as zero length, so the CFR
> syscall is saying "there's nothing to copy from this empty file" and
> so correctly is returning zero without even trying to copy anything
> because the file offset is at EOF...
>
> IOWs, there's no copy_file_range() bug here - it's behaving as
> documented.
>
> 'cat' "works" in this situation because it doesn't check the file
> size and just attempts to read unconditionally from the file. Hence
> it happily returns non-existent stale data from busted filesystem
> implementations that allow data to be read from beyond EOF...

`cp` also works, so does `dd` and basically any other file operation.

(and I wouldn't call procfs, sysfs, debugfs and friends "busted", they
are just... special)


>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
