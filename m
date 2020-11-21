Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29112BBAD0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgKUAYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKUAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:24:01 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CBBC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:24:00 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v144so15866933lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZbEJojvKRknfau35lFY33ra5qqumn9V5o3ENFtZUe8=;
        b=B2nnATivx9RG57+BY/dVu2VycMvpNW2OA23BZ3K/IBs/qRBUJWWY/LlZ0PV4Ygt8pv
         lg5SsoVIcMXj1KdAKQxPpQGzF/jjNe46t+1L/2Of2biqgFm0SJiX+gBKlrdXIAdmLhzr
         uhnB5KEZs0y3fzqgIk0CeZhR6FZ5ISmRHnVF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZbEJojvKRknfau35lFY33ra5qqumn9V5o3ENFtZUe8=;
        b=l96KWW/qNF9IsEVBYb88eCSPA5PtivSUCNZYaP0rVJpT0UAiHP2mBCP6snmCKtIQ/8
         107YzBRoFlhxIf7oENSgMqsM1PUiC43eY7H1NNQEozJmNAC3i2FMavDgAdYIu7Yzlu6S
         CgDKGfgWAuE4qD4fIM54iLg83yOkX+qCyRxJ4upsmVyoTd2NCTKmCENPRBJLicX5S5hU
         6OjbVpS0dFZ11gO7EA+OoLmNV6bT9WaW42Q+N5iMnRX6qdSwPzr+c1NBMj/GjIY6Jso0
         UXMv0Q7jeeMZccZiBngBKLPY9KVpezhkimlfoJH8WjrpRXQxsPCpUM5vBXIp2ACi2iRW
         SHzA==
X-Gm-Message-State: AOAM5306bXDlwM9l9WoGD8t5+8IWQpNTN4EeHUTiCia+3GPPjHMRXyOa
        KyW9XM+ciVDAfCV+ikIDt+5uujcrsr9oVQ==
X-Google-Smtp-Source: ABdhPJwcEsPHwyEYynYMWoBp3p3F9Xjy5lQNMXMppbxflrgFmnTuqy3ZukYGB289PjLjiycBnIYQuA==
X-Received: by 2002:ac2:53af:: with SMTP id j15mr10177465lfh.256.1605918238841;
        Fri, 20 Nov 2020 16:23:58 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c6sm429300ljj.140.2020.11.20.16.23.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 16:23:57 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id d20so25437lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:23:57 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr8113080lfy.352.1605918237133;
 Fri, 20 Nov 2020 16:23:57 -0800 (PST)
MIME-Version: 1.0
References: <6535286b-2532-dc86-3c6e-1b1e9bce358f@kernel.dk>
 <CAHk-=wjrayP=rOB+v+2eTP8micykkM76t=6vp-hyy+vWYkL8=A@mail.gmail.com> <4bcf3012-a4ad-ac2d-e70b-17f17441eea9@kernel.dk>
In-Reply-To: <4bcf3012-a4ad-ac2d-e70b-17f17441eea9@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 16:23:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wimYoUtY4ygMNknkKZHqgYBZbkU4Koo5cE6ar8XjHkzGg@mail.gmail.com>
Message-ID: <CAHk-=wimYoUtY4ygMNknkKZHqgYBZbkU4Koo5cE6ar8XjHkzGg@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring fixes for 5.10-rc
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 1:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> I don't disagree with you on that. I've been a bit gun shy on touching
> the VFS side of things, but this one isn't too bad. I hacked up a patch
> that allows io_uring to do LOOKUP_RCU and a quick test seems to indicate
> it's fine. On top of that, we just propagate the error if we do fail and
> get rid of that odd retry loop.

Ok, this looks better to me (but is obviously not 5.10 material).

That said, I think I'd prefer to keep 'struct nameidata' internal to
just fs/namei.c, and maybe we can just expert that

        struct nameidata nd;

        set_nameidata(&nd, req->open.dfd, req->open.filename);
        file = path_openat(&nd, &op, op.lookup_flags | LOOKUP_RCU);
        restore_nameidata();
        return filp == ERR_PTR(-ECHILD) ? -EAGAIN : filp;

as a helper from namei.c instead? Call it "do_filp_open_rcu()" or something?

That "force_nonblock" test seems a bit off, though. Why is that RCU
case only done when "!force_nonblock"? It would seem that if
force_nonblock is set, you want to do this too?

Al? You can see the background on lkml, but basically io_uring wants
to punt file open to a kernel thread, except if it can just be done
directly without blocking (which is pretty much that RCU lookup case).

And the thing that triggered this is that /proc/self/ can only be done
directly - not in a kernel thread. So the RCU case actually ends up
being interesting in that it would handl those things.

            Linus
