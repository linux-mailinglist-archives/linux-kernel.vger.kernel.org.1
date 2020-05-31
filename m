Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0551E95D2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 07:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgEaFwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 01:52:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45862 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaFwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 01:52:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id s19so4786286edt.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 22:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEESxdWkBaFZaHt1Qo9sGBPt3NVRbxITfikSAaK4xFw=;
        b=Gs028hPWlUOhIRwh6kYt9kMoZPHPsTMnaVkFikkwNVEI5HBlrf4a/CKZOz9xXlsyTj
         CpgaZcNKAIA+FfZGjEUHWzkRU2OYHvJ9u15lejmazyy++HIcY16f7KQ9WrtvS5B+kh0r
         CLWU65jGnWdI/nXPvtHPBQSHb5gKDulZ7s8awCE9RFSz1OXDZ95lnJp4nE7XzsIH8ZfD
         6PVDjE4vpkzs1qnbvI/4rcC1b4r7me1lkrIWc8h+OfsWQREBB3ggilFcxrGVwFoi5dUn
         qIoP4EN6UjeC3796WnItEzQ2tuW1hMnHM7fJY99lckBZxT+c1eQtPt2WownpahyY3k/m
         p/ew==
X-Gm-Message-State: AOAM531IfM81gSpKqsIEYyW4YqkX4cfvayvlTSttUGv9J/30soNcZO7I
        7sJDRJi3PyarVgJDhwtlEZ03tiVwvVPytEsiP4o9Uw==
X-Google-Smtp-Source: ABdhPJwU1L3H4lm0iPH1LESIa0ELFZFrlSzAWxKU7ukQ81bUZMiS+gPAVaoKl8+cqXRy9Uc3ji9h8WcCtYfBVWWSnlg=
X-Received: by 2002:adf:a50e:: with SMTP id i14mr4342367wrb.21.1590904354886;
 Sat, 30 May 2020 22:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200510150628.16610-1-changbin.du@gmail.com> <20200510150628.16610-4-changbin.du@gmail.com>
In-Reply-To: <20200510150628.16610-4-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 31 May 2020 14:52:23 +0900
Message-ID: <CAM9d7cgAxg_=1ZZHh0JPCRJpH1mpfcR50vu8MAGnQP7WThBpqg@mail.gmail.com>
Subject: Re: [PATCH 03/19] perf ftrace: select function/function_graph tracer automatically
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, May 11, 2020 at 12:07 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> The '-g/-G' options have already implied function_graph tracer should be
> used instead of function tracer. So the extra option '--tracer' can be
> killed.
>
> This patch changes the behavior as below:
>   - By default, function tracer is used.

Why?  You also removed -t/--tracer option.

>   - If '-g' or '-G' option is on, then function_graph tracer is used.

I'm ok with this.

>   - The perf configuration item 'ftrace.tracer' is removed.

Why?

>   - The default filter for -G is to trace all functions.

There's no reason to use -G option then.  Also It might be confusing
if it sees an argument - whether it's a function or a workload.

I just don't know why you want to change this as we have a way to
change the default tracer already.

Thanks

Namhyung
