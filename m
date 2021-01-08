Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C5B2EEF51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbhAHJST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbhAHJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:18:18 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D06C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 01:17:38 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z11so7905187qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJnl+FZ1gpOcd35fdEFuMTp9+v183tYb0UiM+fOy7cU=;
        b=di5xAHbQJBIzcIWF3bZji77qGMchbDheH0ljp9OeVzxTJsTkb1EEh34uHGhcXd+m8m
         5iqambvjFTe572A7AoC16IwDHfrRhZxHxhlJzWPmrO1wJUB205Y1INzACZRzIQbU9YXZ
         /ypBV5AK+hR/1EyVAzOpzWPZOenaDnRLgHgUW80KsjG1DpqABnI+g6n/LxGbUjGS2lHg
         6E6v8FlKp76BiO+yl2ER5CEkut0OvIkrLvOUmf3a7890RChpZNYop62WodONPAA2yvZM
         RGZOXFC2C1OwJlfrLDF60NCJEYq5gN5LAhZAnaTix/0HE5uGhgns7qZ8nbufaKH37Nix
         SIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJnl+FZ1gpOcd35fdEFuMTp9+v183tYb0UiM+fOy7cU=;
        b=C2q4mnvO5tbKdvHYVY5c8td2ieSthXT431vom4HZn4sWnili5pVPEZof1YGX59Ojwf
         GlUnCXmdUy/Uw5KVgr+V0ltnGXctAljtVk/9s/D0VAQLmzwuVS/vVwthV7tHs9E5F7p8
         vnJsWcPXJvnfQ3FIAZ1AUGGcB2LeYLmimJGyjD5pwqBgFNwvQcnVw95nc2QYdkWrvkkD
         VpwQ2r0FZD/iYmjIYg+onIVgREV4nGTSrEr9Tgd6NRDO/Hf6a+GbijUCw2SL61CC+AlW
         +lzcsObD4Q9DB8gXBuD4DmI8+BYAMgl9HyuStYlM4PLIMt4JDmkZUAonTnOFHt7H+m//
         gk5g==
X-Gm-Message-State: AOAM5303464Fv1DrZgJ9+oUTPc+syqS1ZWU1BzTDWICtSvx/Y/G+Yoic
        clXa4938zrC9BDUpchZtY3aopQMZcJpAPmb0cExAaALjiFmDJQ==
X-Google-Smtp-Source: ABdhPJwgedTY862qpgm479A9m2UJWEKg7jtCcvc3RXMc3hBBjnqJesYi2jlShDdx8J8kJGzFlV2lK/PbOOI2sqRem/k=
X-Received: by 2002:a37:4285:: with SMTP id p127mr2790403qka.501.1610097456944;
 Fri, 08 Jan 2021 01:17:36 -0800 (PST)
MIME-Version: 1.0
References: <00000000000053e36405b3c538fc@google.com> <0000000000008f60c505b84f2cd0@google.com>
In-Reply-To: <0000000000008f60c505b84f2cd0@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 8 Jan 2021 10:17:25 +0100
Message-ID: <CACT4Y+YJCMyTDrUFWXEnZ-raQMos0+1F1O8k5eX998pqNUWKSw@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in start_transaction
To:     syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 2:11 PM syzbot
<syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit f30bed83426c5cb9fce6cabb3f7cc5a9d5428fcc
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Fri Nov 13 11:24:17 2020 +0000
>
>     btrfs: remove unnecessary attempt to drop extent maps after adding inline extent
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ddc30b500000
> start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=6700bca07dff187809c4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a07ab2500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe69c6500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: btrfs: remove unnecessary attempt to drop extent maps after adding inline extent
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: btrfs: remove unnecessary attempt to drop extent maps after
adding inline extent
