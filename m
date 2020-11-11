Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE9B2AEF40
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKKLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKKLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:11:27 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:11:27 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id m65so954993qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPSfk1DzzMwkClF1T0Gvn+w9FrgwTmCSdwXk7GPFAA4=;
        b=FzxZWQjkYeerxwpVpt91L6A4qMW57eE7XsecG7FaMy8r6iFfuSI8MKchBU0DWkJiis
         /2jWKk3JFcMctHKYNg5TTUwitfNSVPjpQJJtK/ygIWHhJ3QW8LvyrhCP1/afeRhtHgZA
         gVMLT6QJ5J14kTOPUXrhPSUb3EkwINTVbOanAPE01ghqZ/In7QWWkzh40WyovBoca+8s
         AaAqDM8l8umyEkhgFqyalpgCoEanSBOeU/Ub/nht3L4wZpwDj9EdE1pBkAtathL7V0pQ
         1wcOQpHXcb4DEQhNoo1vPfqjDHk5ZiMH3GWRWWv/MI3tYJFeJa165gvuHnuRKTDoKYDV
         Xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPSfk1DzzMwkClF1T0Gvn+w9FrgwTmCSdwXk7GPFAA4=;
        b=BW30Y4q462uZrjbH1wTcrUrEcvktC7isO/hFN2+6eAhR9kRfllZ31YKOT029UU3M2H
         kfYOoOk29R6HYStF/QFLe6uzJb1mJIGOFidIy/3bPOo66mZzTqBGpTF/+BfwEhfXWZRo
         fF5s+RrFp90ZgLIWLsMTqJ1P6Ey8BLCGDnKqrwUpEHFjPXQvQWaiqWYWTQ/oOPz5JbuM
         9JSAtkVHQYFFnIVpR4TCkHK4Q53qQ0Dc+INLb0b9Np/+SJcrKfbdQCBi7DjvNJsJ1AIb
         aRsxA0+ppwzEaVJzjfUs2zgyTq5NxAucIGYBYpdBpYUnMTbCd+7IfFMwnh8MUxgdteLn
         hZmQ==
X-Gm-Message-State: AOAM530No0VzlIRDthQ1lsU88Q/8ohAbxvgmJPB/9oZP6C5UoyYLAH9m
        +GFYuCUeRdoCVK/ndDVeW+l9yGpV/OV3wX1Kl6MDUg==
X-Google-Smtp-Source: ABdhPJypPYaomSrYo7uejc9+V65fbmzOQzUuJqhpp6C1UzwaUeWcLEXhPW4kbRijVBnzvygXaNG1TZuzbNARNjQr8+s=
X-Received: by 2002:aed:2744:: with SMTP id n62mr23587399qtd.67.1605093086373;
 Wed, 11 Nov 2020 03:11:26 -0800 (PST)
MIME-Version: 1.0
References: <00000000000052792305af1c7614@google.com> <00000000000022d95405b308d905@google.com>
In-Reply-To: <00000000000022d95405b308d905@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:11:15 +0100
Message-ID: <CACT4Y+Y6RajGXJOcXt5UNMoC9hiK9Cuno1sk6bAWgb8GO=i+EA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in pvclock_gtod_notify
To:     syzbot <syzbot+815c663e220da75b02b6@syzkaller.appspotmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, wanpengli@tencent.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 1, 2020 at 11:11 AM syzbot
<syzbot+815c663e220da75b02b6@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a49145acfb975d921464b84fe00279f99827d816
> Author: George Kennedy <george.kennedy@oracle.com>
> Date:   Tue Jul 7 19:26:03 2020 +0000
>
>     fbmem: add margin check to fb_check_caps()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17499724500000
> start commit:   60e72093 Merge tag 'clk-fixes-for-linus' of git://git.kern..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
> dashboard link: https://syzkaller.appspot.com/bug?extid=815c663e220da75b02b6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1162b04d900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135e7383900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fbmem: add margin check to fb_check_caps()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: fbmem: add margin check to fb_check_caps()
