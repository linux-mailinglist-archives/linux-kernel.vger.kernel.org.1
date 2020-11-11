Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152B82AF1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKKNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKKNLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:11:15 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E160BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:11:14 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 199so1510938qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GjFdEigLvXfDvlbjJo1wDn3OLDS9qQ6oorF/luuVY5Q=;
        b=I1yU2uIGDyGfUl0OL1K+/AAYTzHtxCSGD9rN1EqjliZMD8lAPY4vwY+5lTgfmeIMsj
         5fwCe4pcwCsgjDIkeehkbUP2ZPm7tC/kPTiemQ2Bpc36ITMdgHQEkns8kU5pM+3cPEWe
         xUAT6eqe3Ar2yFVmO5JQAdLFADvaNKnRvkszrSt9vF8VRXRoGHRHNa1f3xb/C6AgQCEM
         biIWa1uMqymgVZIOk4iH4WEiS4xgUDF5BVY8iX8V73BjdBUgSC1EXwCHSKkoyfQCCzLC
         3F9w+h7djQqmxx6d/okhonh1VUlVDFsW5+OHRLWpKNsWCgKzJhCvjwp/luSr7n3lKVwb
         Io5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GjFdEigLvXfDvlbjJo1wDn3OLDS9qQ6oorF/luuVY5Q=;
        b=J+9X5snex69sHHTZ9+6ho49ZINBgMnlvKvMtp3yej5N2+cfXGXM9y0w9sW/beMhLnM
         uwSgtUF45zEm6tdDv3m0mlNySmlaS0A52ude2aj7lMnGFpTeah7+rvPwtDcAbkSWmDKm
         Ew1Pexspyr6S19qFot7iGAT2A7AlwfCvfpLNoxaltVgM5wu7mE4cvwb5SBXJC37zD6nu
         VqqQHiq76Po3RbX0A1o4nwxuSlBAFSn2d6R77VSF242jdoNTQ0GBe5NvzOT6n/ZTmo4E
         9qIYhgQ2lx+L0aG41R5f+OHQUbF3wi8rpg/bp7K6ykirJWGvHwpUsJr39Y/OW8GJF6vO
         aqgA==
X-Gm-Message-State: AOAM533E6QR1GiswSG+6BN1ABxlu/hHpaqJNJhkAar8YEjnKvF+zhydO
        n+61jW5Mli9DfqRU2jCmilhPRlLpAOtsFqvmmkv9n9mOvX6elQ==
X-Google-Smtp-Source: ABdhPJwRO21Z+SE9Hv8PFSbNwJRKHETxvGdQhKfZKY481gKFf7Z2JAHlnk9D7itLlDAZ1GN1BvOVI3UFlHijiwnfEXs=
X-Received: by 2002:a37:9747:: with SMTP id z68mr23902083qkd.424.1605100273754;
 Wed, 11 Nov 2020 05:11:13 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008b9e0705a38afe52@google.com> <000000000000a3de6505ae9e6831@google.com>
In-Reply-To: <000000000000a3de6505ae9e6831@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:11:02 +0100
Message-ID: <CACT4Y+bJevNFi6P9kYEEQshTuNhpzLyHL1Q_NatjyS90dMHwqw@mail.gmail.com>
Subject: Re: WARNING: refcount bug in do_enable_set
To:     syzbot <syzbot+2e9900a1e1b3c9c96a77@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 6, 2020 at 7:31 AM syzbot
<syzbot+2e9900a1e1b3c9c96a77@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b83764f9220a4a14525657466f299850bbc98de9
> Author: Miao-chen Chou <mcchou@chromium.org>
> Date:   Tue Jun 30 03:15:00 2020 +0000
>
>     Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115a4245900000
> start commit:   fffe3ae0 Merge tag 'for-linus-hmm' of git://git.kernel.org..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=226c7a97d80bec54
> dashboard link: https://syzkaller.appspot.com/bug?extid=2e9900a1e1b3c9c96a77
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b3efea900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11131284900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()
