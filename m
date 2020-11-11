Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D02AF256
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgKKNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgKKNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:39:46 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89167C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:39:46 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so1615155qkq.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GumszjvNgwjE3QKLoLF59KpeottKAMj7F7aMgIrJUxg=;
        b=lwyBQi1sL1I1G2apxji33UOsDH8SrudX+R4TP1pKfKhP3QApOTvsMu30Qb/Z5fAoND
         lvSl2/NQusY+FObx0QzCF/s7HUA6Lm2oIsCTvPbaV2VZOUrf1Tj1jnVV9Uc7mwo2ytdU
         vpNcdc4b8QAL0nlzIcZE68BhgCDIjN0KAdkhusZe+mbXcZAkxeBDEiAS23iAQ9BrrjZG
         cQ5t0wG8PUTeVeVerwNBzsasCuNSLHiG7JbXNHzsbODTBhV2Uuf9sQzPp6RiGoFt63Na
         ATN7CVtb94E+FWX3LK4vYF+7xmm9nBE2IoxI0vP5uploK7yxqzYlIpbUOL0EEYfsYi3M
         8Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GumszjvNgwjE3QKLoLF59KpeottKAMj7F7aMgIrJUxg=;
        b=tm7WzYnAUmE+lWvNvIYlBHYULgye2tKWbwZb6YLAo4Ia7qo+gU+VYNDeIkLRgr55Gm
         Hkg9REKDBriODSO7RzQDZ2HoZXamjt3quio/r0+Ast4LhoTBnneILm7e04WO9i3OxDoR
         L3HEsBI+9LcUtQQeKPCZFaePX5jZ2qlEy9pk8I/pKKz5o1vvgdw6Mk3pPSE+znpFiA6M
         JfipawsYW4DU8zey+w07RuwkDCQW5icueXdBF/t+smdEG3IlkaY3vP4Bkg6OjrxMuaT1
         2hNvcsdkynDUhwjJexjhM8WugCIjljkAW3Q4uIwDyY3RZnndh7MFaW9KyEqWJ7V9XPrF
         D7Uw==
X-Gm-Message-State: AOAM533APPeHXuuDEdQddh0MB+OZvhV/I9H45/QNYBUTJ2scAaTrSPCJ
        5FNNVlnh34jltVtqCqgG/jcWX6FPdEjcozdqZWS0PQ==
X-Google-Smtp-Source: ABdhPJxSvk9O1KTGx9oqKR3aacKcjj2UL47whviuE1wpq8K3iTsLrqG9WhSVlPsGPSclNiX2vBY32qT2WBH6AlD6hyQ=
X-Received: by 2002:a37:9747:: with SMTP id z68mr24031626qkd.424.1605101985587;
 Wed, 11 Nov 2020 05:39:45 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005b2aad058e722bf3@google.com> <00000000000043f47d0596c26e68@google.com>
In-Reply-To: <00000000000043f47d0596c26e68@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:39:34 +0100
Message-ID: <CACT4Y+bp=jmo-WAZUCxT04G-DtbvZmf29KEToq1EMGB0gEpDOw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in do_swap_page
To:     syzbot <syzbot+2a89b1fb6539ff150c16@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 3:25 PM syzbot
<syzbot+2a89b1fb6539ff150c16@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit 32aaf0553df99cc4314f6e9f43216cd83afc6c20
> Author: Pengfei Li <lpf.vector@gmail.com>
> Date:   Mon Sep 23 22:36:58 2019 +0000
>
>      mm/compaction.c: remove unnecessary zone parameter in
> isolate_migratepages()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=159dcaaae00000
> start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c8985c08e1f9727
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a89b1fb6539ff150c16
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1456f9d0600000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: mm/compaction.c: remove unnecessary zone parameter in
> isolate_migratepages()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

This does not look like the right commit. The bug happened only twice
long time ago, so:

#syz invalid
