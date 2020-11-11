Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61E2AF296
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKKNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgKKNyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:54:25 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738C8C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:54:25 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so1302741qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LMnlJ2VRlaOy+haUyyLTMNZ0UZN6e6p3lev+fiH8MWQ=;
        b=nL2rYwNnyY2XC7fcLKOB2btPl2qk4U78gZnijZ1GWhNx5Wgvv8v/SrldceQD1ldpU2
         Rm2oacK+IAi9LUKdDe50BQ0UnNeN21WnPUcYRz0seWMAtCdVUy3a5v3uaglbFU1d/fdc
         xur0kdwJUekyq3s+B5H9bTO2JXzQfyy8eSQiRY/a0ZTlAZWPayRP9IbzaeWxwz/e++Xs
         b2HoDWpyN3vfVVSU7urhtS7Smg0T1E5Kdg1biWRjDXRdhjIz3fxJ/oAmGVYuMW8Veoc8
         bhUJUIqeC9cFJG5vPsJLCFZputHy3v6EmhsvqOqBDukGK1+l6ZThSM2ltMrsbr3ZQ4aU
         QdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LMnlJ2VRlaOy+haUyyLTMNZ0UZN6e6p3lev+fiH8MWQ=;
        b=ug60n/6MHGsoKiVoRraSSFiPUYWFlsNt4UTr/2ZGlC/gbdXzqA9Vca8q5jvswTW6NU
         B6D1VJWZyzTqqUXTKFvpyHwbvBJTcNA5uph67yYOmUDkr4aiIV2UITdAII/i7HUm1USK
         LM87H1KLZarqDKYWQ1chg1Tz9fO+qIFrnKKiOpkJiXsN9XMoHSrHX5WAXuQDLqcIorvY
         sewi5VJts3XCsMNbCp9PUJgOWlbFznFdyEN2NRYz29dRxRmZgcSHZymgPF3SPk7s3Jq6
         THD120RUO+0BKqZYQMJxNptIix2IgKAgd3eM92nxvhjGS5kx9gy8tJxz1E1m28Z5LQmZ
         zcMg==
X-Gm-Message-State: AOAM533AKVZirSwCpUHMJ8hEV23Se/M2NdyuUS88Cj6PyJiagHiz3DEH
        sS26nU2hcxieTL8zi68DieomERGrgLgbHf1rawjKXFGefIs2ZFgz
X-Google-Smtp-Source: ABdhPJxDKIPaFA0Ln02v+76S56BqDnkGV/4xBzsRqEHYdC7SlVTuD6d08kqCmRgx6E3L56XOxy4v7x9ThnV9w1GZAaU=
X-Received: by 2002:aed:2b47:: with SMTP id p65mr22140084qtd.337.1605102864435;
 Wed, 11 Nov 2020 05:54:24 -0800 (PST)
MIME-Version: 1.0
References: <000000000000eb6a8e057ab79f82@google.com> <00000000000098e02c05ace3bbfb@google.com>
In-Reply-To: <00000000000098e02c05ace3bbfb@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:54:13 +0100
Message-ID: <CACT4Y+YqTf9X84=vtWjiL6CJeqp08VkpRSBTmHWaxM-OERdLYg@mail.gmail.com>
Subject: Re: WARNING: refcount bug in p9_req_put
To:     syzbot <syzbot+edec7868af5997928fe9@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 7:23 AM syzbot
<syzbot+edec7868af5997928fe9@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a39c46067c845a8a2d7144836e9468b7f072343e
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Jul 10 08:57:22 2020 +0000
>
>     net/9p: validate fds in p9_fd_open
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1015f012900000
> start commit:   459e3a21 gcc-9: properly declare the {pv,hv}clock_page sto..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ef1b87b455c397cf
> dashboard link: https://syzkaller.appspot.com/bug?extid=edec7868af5997928fe9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1642ee48a00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net/9p: validate fds in p9_fd_open
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: net/9p: validate fds in p9_fd_open
