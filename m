Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D072AEFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKKLtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKLto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:49:44 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF49C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:49:44 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so1345759qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9pawpngbrgzwBTZ9koabDZVAC9jv4KPdgxMf4ukZapA=;
        b=Z8qMlOlzJgJLMoT9qaVAWVoZc3pvU3DlOU78YER5Y1BdMQr/Ysk4F412OB8hVwn+yp
         2MDfYFZZuL8ylL6baZLKRVvTyJCwWEQuaXLMPAhucdqF3LQKqCiulNWDwWXvJnrzoDpK
         BdGoopd1/7KEpP6PfZEjRfQ5fSNAqWLh2dcZMjKPljdOifGD5bTVjpBkERL4C/rpoAuG
         QDAgHJgkEhpiwtpyFaOggJJrD5jNatH7K74vb92PHwiacATSjaLKD+gaxDVyFMzGD24e
         IVKzZO1xVAGR6XX2ffkFkMBhgUmvd/fYpLwXSxXYu83ss+ZgiGKpF8d4sKZdtu13+Gtb
         zRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9pawpngbrgzwBTZ9koabDZVAC9jv4KPdgxMf4ukZapA=;
        b=r2s1aKWPMLHFSz8t9nOZAK2nBXoQdcbNwyhmh5J8wa34hmYW4oKD+dPdIxSIL35/JS
         IBoz4KUPRUbJoM+NviBRKJsgyqT+1kXiKeiVWMJPUTZvZTHcDAoYArUwHmA3PYwLvLRr
         w3ex9k3VMdWdoZKctBeIzx+mioIum8MWVyX6BLZGa0vugo7MHBjqErOvWCrzkCNXazNb
         wOy52gKQb6+wp66GoEpK/8cyg3iEGjobrYi13yIkM5XOSa3TaRdz2mpR3OUpbLUsHvwL
         7Jo/wFc4Kol+RbRdTr32FL4jnYzGz7nnPYdfTUUlpCIQtqYBzXp2mj1z5wjdLAZYucF7
         IA7A==
X-Gm-Message-State: AOAM533CGXChCoFFBjIL3sN6cSeqHT+z4a9+09MK+q8wPF+zRzaAky8k
        7TuNcuS+9vt07BcvLRww+6R40tYhWWFPCIPaZjzRdw==
X-Google-Smtp-Source: ABdhPJy7EiDHSGrXx8yLuynkl4A0xn5akOI/uotPr4UqXn7TciV8OV3mAD87s+bo8NFv9M61JN5dCSXRFGSwEAEoST0=
X-Received: by 2002:a37:9747:: with SMTP id z68mr23549365qkd.424.1605095383475;
 Wed, 11 Nov 2020 03:49:43 -0800 (PST)
MIME-Version: 1.0
References: <000000000000add83505a8e38c4c@google.com> <0000000000006f439b05b241c3c5@google.com>
In-Reply-To: <0000000000006f439b05b241c3c5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:49:32 +0100
Message-ID: <CACT4Y+a-Ff412cHSguc61syKvXtUV70JjGic8HLkwa9=ooEc4g@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in ctrl_cmd_new_lookup
To:     syzbot <syzbot+3025b9294f8cb0ede850@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 2:40 PM syzbot
<syzbot+3025b9294f8cb0ede850@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a7809ff90ce6c48598d3c4ab54eb599bec1e9c42
> Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Date:   Sat Sep 26 16:56:25 2020 +0000
>
>     net: qrtr: ns: Protect radix_tree_deref_slot() using rcu read locks
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143867c8500000
> start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
> dashboard link: https://syzkaller.appspot.com/bug?extid=3025b9294f8cb0ede850
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11802cf9100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144acc03100000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: qrtr: ns: Protect radix_tree_deref_slot() using rcu read locks
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: net: qrtr: ns: Protect radix_tree_deref_slot() using rcu read locks
