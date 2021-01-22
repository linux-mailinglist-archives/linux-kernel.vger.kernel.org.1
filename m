Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82130113D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 00:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbhAVX4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 18:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbhAVXxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:53:49 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF273C061220
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 15:53:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d6so3915364plr.17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 15:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=czvPGg+phyjaYMgUGHzGP9QH82/Cq90/8/OI17KG2dg=;
        b=HZ3FSoxxK/yWuIZd2Rtl7cLwIYI8JeXm3AAUASvRDUVqu/vpToiRHu88HIOUUUflu7
         reOKY5aaGiGd90i6Ttd9jvpczybnu5Da88e81/LpNqvAZji1We13R0lK8TWabRHRwlw/
         5sw148DOuYCtU53OkGZ0FJr/TLWwi+FUBdE5nTO3nBGT59Lw0+oRrr50Hz7SAe//0Hfw
         S3039bd0iElKnKNv+HjPRhYnGwyPZUOIb0FSic+DEpuSpwemwi7jO4KycEdtdMfVO7fx
         +On1EQN+9iPNvNbJTq4LMb/TRgpgTsVTn5cB7dp8VoE/oCaXAZ1nhtqmHliJdDdA/xd1
         igZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :subject:from:to:cc;
        bh=czvPGg+phyjaYMgUGHzGP9QH82/Cq90/8/OI17KG2dg=;
        b=MzITwV4v3b27W3iuHwsCrdprcRk4LFdxhEfZbDjazxKPXxU/QkBRgejXF7PZ9/JdBp
         p9Gs65Oqz6/hlL5gayomYAtNeJm2OiNJOK7IgZrtJ8hO9puDl1ggCF3R03ixbbGoEumY
         /kklamCIaMIKH3HnYPF4FHHZp3H3F/PPe19yULSEpx4mmfqjfALBQmkkpbn4t+a8Emv+
         IZyA7adYokWoDCrjwCFmPPJpQ4rJwIrd/xCC3juNWPkM6LYNAHbB5TTY2WlgitXSvryl
         +GVfytYzC5fZygb8bOiyQ1LI0Gsqp7TfkBkM1/Z5j9M9FUF0SL0o2VRwAY6uJwkAw854
         2EQA==
X-Gm-Message-State: AOAM530IkY9E8BCPDZ+9nOAzge2cjXRFW3Nk3Hemb8yZOQ9dGTW23zh5
        Oiwwoie0+bZX4hv+H6WNmVL0czo0QiS1
X-Google-Smtp-Source: ABdhPJxNrgba9XRZchk2+Av/loSj3isTM8P2Ng7XrxkK+MwAMdjkWTrh9zlPMNq8CLzud5oh1nRScmFitnkk
Sender: "elavila via sendgmr" <elavila@elavila.c.googlers.com>
X-Received: from elavila.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:25bb])
 (user=elavila job=sendgmr) by 2002:a17:902:d901:b029:de:67a0:98c6 with SMTP
 id c1-20020a170902d901b02900de67a098c6mr7183250plz.9.1611359582155; Fri, 22
 Jan 2021 15:53:02 -0800 (PST)
Date:   Fri, 22 Jan 2021 23:52:39 +0000
In-Reply-To: <20200709132344.760-5-john.ogness@linutronix.de>
Message-Id: <20210122235238.655049-1-elavila@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: Issue in dmesg time with lockless ring buffer
From:   "J. Avila" <elavila@google.com>
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

When doing some internal testing on a 5.10.4 kernel, we found that the
time taken for dmesg seemed to increase from the order of milliseconds to
the order of seconds when the dmesg size approached the ~1.2MB limit. After
doing some digging, we found that by reverting all of the patches in printk/
up to and including 896fbe20b4e2333fb55cc9b9b783ebcc49eee7c7 ("use the
lockless ringbuffer"), we were able to once more see normal dmesg times.

This kernel had no meaningful diffs in the printk/ dir when compared to
Linus' tree. This behavior was consistently reproducible using the
following steps:

1) In one shell, run "time dmesg > /dev/null"
2) In another, constantly write to /dev/kmsg

Within ~5 minutes, we saw that dmesg times increased to 1 second, only
increasing further from there. Is this a known issue?

Thank you,

Avila
