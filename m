Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8662C130A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgKWSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgKWSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:25:36 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:25:34 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id z1so731455ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqcYLKj/NZRsqtATYR+P+/ypK5dgCZ+R6Ix8LeOTgdM=;
        b=XOYSyXSCBiFCeiwN5T3mq03mJVEfjBlNTRNj+97JpTIv9QNoYcq4KVTHoZKM0RHUiZ
         aMU5eBLcUVn2oepe6LrQnnte++28IjEawjsUcGYm7bg7xVWSL0ZVXbri92VAFRnzmk1D
         ELGEE8c/OC8+MrV/MShiQvK0KfsI5O3l0+7BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqcYLKj/NZRsqtATYR+P+/ypK5dgCZ+R6Ix8LeOTgdM=;
        b=MnumrPsdreGkOwodrdpycd+4g40P8RQhTOPfbnqEPGjZQIIi/2fgnQ4u9Q1cCteN0v
         /S71UehuydB8Ujn11wK0m/HUrTJ8v3vnpj4FqjjqC8YCgAtid9MflD9WH+xJpA4RW/7r
         oHW50jO1Hb9E04kwqMw8N5/uF/OSos0zT0Wu2F4iZPtrSPzXj7pa3Bi8Mczewp++s3is
         0jdpGfZKoeE79xXnj99FmW6P0h65e/CorEQHon2G0ZaGDGEfgMD4TwnXXrqYRFR6GPRW
         Xrc+MjsVc+n1hLuwTDfsVpqJRV2ONM7aI5cOLmRO5mCbu8YXRhC2oAgIDwnSYX9Q5GdS
         Zxdg==
X-Gm-Message-State: AOAM530/kWaYu2KoyXEBAXq4+PWwuY8LvJfn3XjxI1mdL/uARQqEU9GP
        IbQ/dWnwcNLe8FS873Vm4pLJu9Ii7pOGqg==
X-Google-Smtp-Source: ABdhPJz8n7o6feaLBEqvEZw6Lm0aOYHDDo3kvSJYtfvR8o99LyXo5eUUp24BXcHMzNjYNH/jESWmGw==
X-Received: by 2002:a2e:9dd0:: with SMTP id x16mr300756ljj.406.1606155932730;
        Mon, 23 Nov 2020 10:25:32 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 7sm47144ljq.34.2020.11.23.10.25.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 10:25:31 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 142so19056577ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:25:30 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr281899ljk.102.1606155929844;
 Mon, 23 Nov 2020 10:25:29 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com>
In-Reply-To: <20201123175052.GA20279@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 10:25:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
Message-ID: <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 9:52 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Can anyone explain why does do_coredump() need unshare_files() at all?

Hmm. It goes back to 2012, and it's placed just before calling
"->core_dump()", so I assume some core dumping function messed with
the file table back when..

I can't see anything like that currently.

The alternative is that core-dumping just keeps the file table around
for a long while, and thus files don't actually close in a timely
manner. So it might not be a "correctness" issue as much as a latency
issue.

             Linus
