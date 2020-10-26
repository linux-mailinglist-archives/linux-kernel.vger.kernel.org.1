Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D129968A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792663AbgJZTOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1737755AbgJZTH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:07:57 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF50D21D41
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603739277;
        bh=vYbDisG7UZadajXMw/nlAuSTCeEhQwUZQJvu+Behapk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PuwWMFp/Hsj/gr+Y8SP1Q3U7qxUYAKqGg6LvnPMe5gme1MoqHSQ4ThL3MQXwF1mUm
         SLCKZdlQv6CpDQ9jrxyyHIKeVA6lKIwC8E7SwF71KPruU5t7riQ8SjQarBkp+soLrG
         yOH8M5OK+z8ban5yRlNr+AjZhMXl19h8XVUpVupo=
Received: by mail-qk1-f181.google.com with SMTP id h140so9441869qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:07:56 -0700 (PDT)
X-Gm-Message-State: AOAM532hBwJ79owt0u48NN/w7RVCnMHxWnlQD+795DlmKnSQQ1OynN4f
        GvXbkHFMveIPG+1OOc+KYGQc5ogJAvPC/qHjQHw=
X-Google-Smtp-Source: ABdhPJx8U0mDhIpTto7EjkABKog5y1+ZMYZ6+1tpD5ozQ/zCb/L2KWLwDnaCbZCUVbwdDGbxrwuBUJcCJjpsIu4BhC0=
X-Received: by 2002:a05:620a:b13:: with SMTP id t19mr16125103qkg.3.1603739276000;
 Mon, 26 Oct 2020 12:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201026161108.3707783-1-arnd@kernel.org> <20201026132300.6b175028@gandalf.local.home>
In-Reply-To: <20201026132300.6b175028@gandalf.local.home>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Oct 2020 20:07:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ASxy3w62A16Ne9AkM2kfF5ZokYOfos53FSTQdkXha4Q@mail.gmail.com>
Message-ID: <CAK8P3a1ASxy3w62A16Ne9AkM2kfF5ZokYOfos53FSTQdkXha4Q@mail.gmail.com>
Subject: Re: [PATCH] seq_buf: avoid type mismatch for seq_buf_init
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Petr Mladek <pmladek@suse.cz>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 6:23 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 26 Oct 2020 17:10:58 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Building with W=2 prints a number of warnings for one function that
> > has a pointer type mismatch:
> >
> > linux/seq_buf.h: In function 'seq_buf_init':
> > linux/seq_buf.h:35:12: warning: pointer targets in assignment from 'unsigned char *' to 'char *' differ in signedness [-Wpointer-sign]
>
> I've always hated the warning about char * and unsigned char *, as they are
> mostly meaningless. Yes, bugs happen with int to unsigned int conversions,
> but this is dealing with strings, where unsigned char * and char * are
> basically equivalent, except when it comes to one thing, which is why I
> prefer unsigned char * over char *, and that is printing out the numerical
> values of a buffer, if they go above 177, the char * prints the negative
> value, but unsigned char * keeps printing what you would expect.

I agree it's a super annoying warning, which is exactly why I sent the
fixes to shut it up in common headers. At least that way, building a specific
driver with W=2 will only show the warnings in that driver, rather than
those in header files as well.

> As this is just an annoyance (extra warnings), and not really a "fix", I'll
> queue it up for the next merge window.

Yes, that was the idea, thanks!

        Arnd
