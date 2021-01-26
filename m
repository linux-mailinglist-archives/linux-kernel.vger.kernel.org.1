Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B503030BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 01:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbhAZABh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 19:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbhAZABG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 19:01:06 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C47C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:00:16 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v3so11096840qtw.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3hQKKDL/rIKCOLNuY7qc43WgUGbkH80XLlaEuiLryY=;
        b=mL2GizBDe++KylkdLkw3fSBjaCsZnW+ica9Z8b1bZn/53QIC+zlbK0geHaLG4oZAnG
         sfhfkhDqu2udUKflCpK8lE4bICKCq648gecjdKcyPg1I59jVbpsQgfB2vkj+jXcaDgEr
         cFfZ+p1LAgasC9ylOCTKp15uKDIPEpWBnSTtHkQySTLrbBgB31+T2vUY7jcSlOa28gke
         fHI2gYCCTbobG4dJC2nxEvjaqtwGdZuUwGlxkHkgS5EN+VG4IAFBNutbBaZhL+80UyN6
         ufFGq1vQyp7CRncoGZbzCFmLWm17br8xGOnmMjnJyT/evJ47ZTpbu+C8g0F0TQ+AcCXS
         aXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3hQKKDL/rIKCOLNuY7qc43WgUGbkH80XLlaEuiLryY=;
        b=jFQVHQh5r9rMu2pvqThKhs0oP5h+8gvwOb6YKXPIZc0mXn0wvTTreduP3yMCcrJ4JT
         ewFLuGw+pL0FQPGHXqqhfeHYfxxnbk9jLy1i9k2l6LJxkkthd3SOOSew2XNZ9trfQSlV
         TtXILs554t6aaqnXHDDo9RiAaKlOslEWj6fac/VL7zIQsFWCAim76zS/vv1gMfa2nHpl
         MOm0WPkZNhfneTPszR/d0/qMRNiPm1mXKTMQGJtK3Lo9Y8o1RB+pyckMc3BvmDafDCGe
         O1Bpi7b3PQbldDeEuNenpAb3Jf+iCeR+ZtJJdeJ5VUXNcoLhYFYiRkWM5l0X8Ig91Kln
         0vcg==
X-Gm-Message-State: AOAM532Uet0BZDFpR/g2IxqVxGuc8WzW4wlD6p16Qe+FsmxXHkdBrdam
        d6jEx2/0Q/TgpV76cljsi7Ozni0Ed+zRZn9BA0nJMg==
X-Google-Smtp-Source: ABdhPJzxM8AkLfzXiiKd2XqBDnujkPjqBLq1Jf0h+R5Eot05NvEGmzQ236hj1qOiUqvOMrroCSOOMP9t4vldAX3XuNo=
X-Received: by 2002:ac8:7cb:: with SMTP id m11mr2952690qth.307.1611619215955;
 Mon, 25 Jan 2021 16:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20210122235238.655049-1-elavila@google.com> <87im7l2lcr.fsf@jogness.linutronix.de>
In-Reply-To: <87im7l2lcr.fsf@jogness.linutronix.de>
From:   "J. Avila" <elavila@google.com>
Date:   Mon, 25 Jan 2021 16:00:05 -0800
Message-ID: <CAGFReeNEf7a4W4hEx5bD+v0qsdszrgPfh1Sa-B-2HeaAY5natg@mail.gmail.com>
Subject: Re: Issue in dmesg time with lockless ring buffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This dmesg uses /dev/kmsg; we've verified that we don't see this long
dmesg time when reading from syslog (via dmesg -S).

We've also tried testing this with logging daemons disabled as well as
within initrd - both result in similar behavior.

If it's relevant, this was done on a toybox shell.

Thanks,

Avila

On Mon, Jan 25, 2021 at 5:32 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2021-01-22, "J. Avila" <elavila@google.com> wrote:
> > When doing some internal testing on a 5.10.4 kernel, we found that the
> > time taken for dmesg seemed to increase from the order of milliseconds
> > to the order of seconds when the dmesg size approached the ~1.2MB
> > limit. After doing some digging, we found that by reverting all of the
> > patches in printk/ up to and including
> > 896fbe20b4e2333fb55cc9b9b783ebcc49eee7c7 ("use the lockless
> > ringbuffer"), we were able to once more see normal dmesg times.
> >
> > This kernel had no meaningful diffs in the printk/ dir when compared
> > to Linus' tree. This behavior was consistently reproducible using the
> > following steps:
> >
> > 1) In one shell, run "time dmesg > /dev/null"
> > 2) In another, constantly write to /dev/kmsg
> >
> > Within ~5 minutes, we saw that dmesg times increased to 1 second, only
> > increasing further from there. Is this a known issue?
>
> The last couple days I have tried to reproduce this issue with no
> success.
>
> Is your dmesg using /dev/kmsg or syslog() to read the buffer?
>
> Are there any syslog daemons or systemd running? Perhaps you can run
> your test within an initrd to see if this effect is still visible?
>
> John Ogness
