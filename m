Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8884D2F374B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbhALRgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbhALRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:36:35 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8627DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:35:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 23so4562028lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MnIgAhmisz4E0s06xEL4s4qvWxytXtewmzprYh4ynhU=;
        b=dsjRXi6j2zvSNzyFxrbs/oadYWHhd2Uh46WE/fO/mNqqI6pwHIQT53oQcu0+o7/sK7
         tnG31hlAZpaUlZNXMbK0WO41csf5opNfR8TXRcJcjtgIRRRITJ6OCMAcSZiYefXA0/PT
         vKUVDnoYPqW1OTDZFbWCjtCq+vYJEEXgPWowE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnIgAhmisz4E0s06xEL4s4qvWxytXtewmzprYh4ynhU=;
        b=WQI5I4LnE23MBTZBvmC/wZoUhtu09EGZZ/f93qA4S2bUiQnqE0kttqZvfT32GlCICh
         DqiqjctGNkNbLn0bLZw/VBBP2A1dH7Lg6tUpl9pqLbXgMAyZrfCyZwjREf6hMS1lenAh
         IsSQIZnMaWAg8w0AOsJAK3K8bcz8wvat6riGVv3jDihlPJXsgPGgfOvoYdpvelc7MD5X
         u0R++Sbanxi54FHEGjdhn9+gYJ6N0EpaqJhzgT99lrDIykQ/p4sVrVdV59+L23DRn0tj
         M5XJQ4iXLthSYd7ehMXfvQ3f5SIr4q3kZcW+QCKe5XZOZJoTq/O/OSaf4UbGGnP9mPl7
         dUOw==
X-Gm-Message-State: AOAM5312TJuUmpsoyXV3H9COICVoS3Xy56JSQx162qJhrBVo8kwbXk+v
        XdGQCjgpk7QPDpa0O6VsYv0Trl0m1KSobw==
X-Google-Smtp-Source: ABdhPJy+Iur4SHPkmABU0AYgNQVxwj7YdDt0WV+A9e4NmY2R/HB0iwBkY5VxI/q9C8LVfXFxJJHzfg==
X-Received: by 2002:a05:6512:242:: with SMTP id b2mr20868lfo.460.1610472952714;
        Tue, 12 Jan 2021 09:35:52 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 19sm479401lft.90.2021.01.12.09.35.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 09:35:51 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id o19so4627427lfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:35:51 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr28583lfu.40.1610472950962;
 Tue, 12 Jan 2021 09:35:50 -0800 (PST)
MIME-Version: 1.0
References: <000000000000886dbd05b7ffa8db@google.com> <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
 <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
 <alpine.LSU.2.11.2101041839440.3466@eggly.anvils> <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
 <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
 <CAHk-=wgD9GK5CeHopYmRHoYS9cNuCmDMsc=+MbM_KgJ0KB+=ng@mail.gmail.com> <20210112104425.GA8760@quack2.suse.cz>
In-Reply-To: <20210112104425.GA8760@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jan 2021 09:35:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNKdNaBn2SuWa5=gjLNC3iAcG4+Si_TPBF7R8AbkC8tQ@mail.gmail.com>
Message-ID: <CAHk-=whNKdNaBn2SuWa5=gjLNC3iAcG4+Si_TPBF7R8AbkC8tQ@mail.gmail.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 2:44 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 08-01-21 18:04:21, Linus Torvalds wrote:
> >
> > Oh, and Michael Larabel (of phoronix) reports that that one-liner does
> > something bad to a few PostgreSQL tests, on the order of 5-10%
> > regression on some machines (but apparently not others).
>
> Do you have more details? From my experience (we do regular pgbench runs
> for various kernels in various configs in SUSE) PostgreSQL numbers tend to
> be somewhat noisy and more dependent on CPU scheduling and NUMA locality
> than anything else. But it very much depends on the exact config passed to
> pgbench so that's why I'm asking...

No, I don't really have many more details. I don't have things like
raw numbers or exact configurations, but Michael has been very
responsive if you ask, so if you are interested, just email him at
Michael Larabel <Michael@michaellarabel.com>.

It wasn't NUMA - apparently the machines he saw this on were just
plain consumer setups, and his larger machines didn't actually show
the effect. But yes, I suspect it was some scheduling artifact, and
probably just fairly random noise from just changing the scheduling
pattern a bit.

            Linus
