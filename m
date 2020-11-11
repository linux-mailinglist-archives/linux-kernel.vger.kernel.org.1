Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FAB2AF22D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKKNaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgKKNaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:30:10 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE2C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:30:08 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y197so1576706qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Mrf0d0bxYH+6GH0lvsgm2uEX7jLFPjyo3DZnCKJ0/0Y=;
        b=bgpBn97B9nq1SWvjUEtBeKWBDj005oKswykPrMMU/kypedSDkiNNXAUwzKW+R2ueCJ
         Se8nOTvZEIgs0IyaYA6wJDuO7oyTSUtx1n3AAidUiqay8cu5vrgiHu6D+zjESngqESDK
         DnGm7xl2OKb0xEHo51+YZB5WXVJxziWgDPihpNBOo9MyxAlL5wL3ElgXUToLSryNnPXg
         BwIeRgD3ZhxXqRB9d+bhpDcWZ8vGIk9FJWs83s6ZqrwHKhwvh//sbotDR15n6hzMb2wP
         jgiQc34TGMFbMQThldjFGWsxhQIatQiCP5fsYODZ7kPqNBfUPNoq19rrYG0zVB0bxDo0
         VoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Mrf0d0bxYH+6GH0lvsgm2uEX7jLFPjyo3DZnCKJ0/0Y=;
        b=m+ccun8xa3lzj5XpxaHAh1wHuer6TaUxDerXZ53Fq/P6LRPM0Ze4R1WA3PATt9dOqU
         Qs5VqSWXLb33mtxKfJH9lNH1zYilepqpUJaVs/2Y45jygw+G5zvQ+i+aseUcDOmuEF5z
         6VeY//8l5kZ/jdmC2O1S1JAWqPI1ENW3fzEGcAI9IODAartTd8m7sFTSFhtv3QFvNgdN
         Wk0XaFjuI5MqnEDey20pbTyMTF8YaAeHTZcykmfxQXpfGFZiJWBOKtcJpZhvycCi79l/
         YQJFQf4lxXiDdgjUsGv2D4C1eIf4inEFhRs2kH+QIYS4ModTZZHJVBot+asfYQ2d7AOS
         kSRA==
X-Gm-Message-State: AOAM533tHSapl4PWSiSOn9R538jtLPxzR+cybiqNg6MDkCsDeu241vyY
        MLPGeswycI9d+EF8hwQaeXdkVT33gv1RMBhA7rV8+Q==
X-Google-Smtp-Source: ABdhPJyxyZ80WQyvQSfath8VmPjxYL1ABS4kGXtU6ceB3M/Ive9IT8dmInULusYU/wmx2oTw1k500RCiVwr3tc95sLk=
X-Received: by 2002:a37:9747:: with SMTP id z68mr23987360qkd.424.1605101407964;
 Wed, 11 Nov 2020 05:30:07 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005eaea0059aa1dff6@google.com> <00000000000039c12305a141e817@google.com>
In-Reply-To: <00000000000039c12305a141e817@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:29:57 +0100
Message-ID: <CACT4Y+YFEhTsTdjNTpkcrmDdWJriS-ezgxM_q9U2enepcoFTQQ@mail.gmail.com>
Subject: Re: INFO: task hung in htable_put
To:     syzbot <syzbot+84936245a918e2cddb32@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 5:42 AM syzbot
<syzbot+84936245a918e2cddb32@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit 99b79c3900d4627672c85d9f344b5b0f06bc2a4d
> Author: Cong Wang <xiyou.wangcong@gmail.com>
> Date:   Thu Feb 13 06:53:52 2020 +0000
>
>     netfilter: xt_hashlimit: unregister proc file before releasing mutex
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17446eb1e00000
> start commit:   f2850dd5 Merge tag 'kbuild-fixes-v5.6' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=735296e4dd620b10
> dashboard link: https://syzkaller.appspot.com/bug?extid=84936245a918e2cddb32
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a96c29e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fcc65ee00000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: netfilter: xt_hashlimit: unregister proc file before releasing mutex
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: netfilter: xt_hashlimit: unregister proc file before releasing mutex
