Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC42D23AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 07:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLHGdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 01:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgLHGdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 01:33:54 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E69C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 22:33:13 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id u16so1347898qvl.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 22:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjGBizsQuqAYSTH9PhUDz3K9900CQ12Hy6bVTWK7Db0=;
        b=HCVUrsPSVTe5e0k7pZ0vOLU8BXfOzpCdoZx6CY/vJxWVuoLXqewWdyHIH1v8oHdtBr
         Go6zaMZ7INvGcr0Hv6P3a9NzQsIb0JrA0FU+HgbONQ+6aadQPoqZFCCAk9vxnlShPb0M
         94/pfthQGK9WnUZNAHUKHtx2gA9+IRBK7HQS/X4vif8sR9JTS005lzkRmdPLLb0LB5u9
         VqoWJnV/sk7ehYbFnD8WvTIuQh1pg4L0rFcb2xrJw0Yl6sMGz92KgE3/rA4NrPoJ+jFN
         WJDKkT34Jpzs+XGmPpLe9y8jExCV/zM6wADYeWyvN/V+OQBHbEoeehKp/gU3qrSNYKaC
         WulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjGBizsQuqAYSTH9PhUDz3K9900CQ12Hy6bVTWK7Db0=;
        b=trwZrQ1NrnZgZ2tWOnrc3tv8dfUlAZw/p5Te54hQ4hR81kh4AtGCmgwSbLfgjz5fLJ
         JJ2c/zJU6qd+sgbMBK9yI1YeKsZtD0jzamE+yzHqM7GCEXp69IuxmWbF6LtEZSQKtNC6
         QPu34tDgvPbQOFtdwgcbgL7M83OWkLiRhwH9C5XaEU7VyxV3AfoPmINZtHi+9/sW1gEs
         PRjTiycUc6j+t2JsnjKqph2SZp9wnQlZEZyaR/t0FBC207q7Zd/g1xa2Ln4h5kFWS2Ri
         3o29KgNcSkwe12V88rgUDoi7GEncOZNgirxi7vGG65qEtyKd9FzD+uXzbrrrZjeRw5bR
         gWEQ==
X-Gm-Message-State: AOAM530SvTgiK8befmy9m8vIZ8XwQOsotCiKh7+w3NvPoW3nN9cRLKHO
        A7ETo8E6E9R4bv0mHCK65kz2rKLWdUNSYm6oPo42X5Xjf5q/mQ==
X-Google-Smtp-Source: ABdhPJz0A/5qLzf/WoKC3tSsPva3lJSf9OEYwdGpy/jOBAQCVL+GatEDzyBkihTbe/Huz62cWx65pNFR7kkpPuKda+I=
X-Received: by 2002:a0c:edab:: with SMTP id h11mr4278598qvr.23.1607409192833;
 Mon, 07 Dec 2020 22:33:12 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009caba805a9c7b840@google.com> <00000000000013d25705b5e55be6@google.com>
In-Reply-To: <00000000000013d25705b5e55be6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Dec 2020 07:33:01 +0100
Message-ID: <CACT4Y+aX1eZ3Pwb=LfeH+rsadx2ehwmfFb9MQy=FK25MegP6CA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in __se_sys_mount
To:     syzbot <syzbot+3f2db34df769d77edf8c@syzkaller.appspotmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 9:06 PM syzbot
<syzbot+3f2db34df769d77edf8c@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Oct 16 12:21:14 2020 +0000
>
>     afs: Fix cell removal
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162cebcf500000
> start commit:   c85fb28b Merge tag 'arm64-fixes' of git://git.kernel.org/p..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f2db34df769d77edf8c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11df5d4f900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157851e0500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: afs: Fix cell removal
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: afs: Fix cell removal
