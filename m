Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862752B020F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgKLJht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgKLJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:37:48 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D519AC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:37:46 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so4644894qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/rIDPNZ+fS0XAdtYtJb+WN4xPGo9PpZ/qzDzORSloq0=;
        b=KejX1Edu+r7ZJGM2Z3GOynxgw4AZawxLJnsuRDPDXkogNJcxkUl6BWFjg0KQhFbBgW
         53PS6YoMoJc7VaGRlorLsVBtWUe5CTA479qjEWiw9ehMMBYq9R4vDEUOYeUFaYcKyZmE
         1KHzeZjkmUbVaYs5+F1A/2AIHRb0ygQVmBLTNot9od+RXYTvo91+HzYMyERr9TBXaynL
         pNq+5WqAKbF212HbpydyZ47xzjf9Eq04PETfMZtqQwWK9J+GBIkRqaUvwwWhAX1zkhnW
         X6SDB40UC0+cKKsrAipdLrBpxLGmWjjdA6CUqI/zEkckVUhvWhgXAqSCsNyHsTNGu3+o
         9yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/rIDPNZ+fS0XAdtYtJb+WN4xPGo9PpZ/qzDzORSloq0=;
        b=rlQ5SL/orfFjxioh2TI7Ao8aMn9Shnso6RfWlT5aBGJvDHvSqis3YtARoIIlOhUnki
         qi7zJLRz/XN9SH9kXIn5zZGlB6AsQCq0CknE7dr9A52vqeydhPXMQRzF+YCgqYzC6SAm
         c9UaMd8+KWL/8yfNh+Y+ZctGbweYbGlWhANJ86pgHgrRoZPJcoy5XSWOMo1fUmrv67KB
         2atwYeSOcVFJC9lLhkmUdXGX2MoExRIIy0dAEAEdmKsyOkAnLlf7KVX4QuI8TPSU5UjD
         qOZJpmQVepVOjOlZrWflsE1Oyf/5HU+ISbomPDujd0p5/PScgcylqknm5ksa/0me/u4o
         Kvbw==
X-Gm-Message-State: AOAM531oUjcKlsbyCU3Df6kmHfxB3SEwWAQqQyRPq+ebZdYsUeqv5vOz
        Meeb/4nAhVIaRl5H3SFxrCWdWpN7EvtKcovKsq1RyowlPd6NdaFK
X-Google-Smtp-Source: ABdhPJwQRukKnqrE8hc0YvlNQ3IConNb19c2WyGUobA+BAm4HPCJWobck1hquH+Q61CqcCbS6WfjByMG8W999om8BrQ=
X-Received: by 2002:a37:7b44:: with SMTP id w65mr30488529qkc.350.1605173865872;
 Thu, 12 Nov 2020 01:37:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e3068105ac405407@google.com> <00000000000005858405b3df4904@google.com>
In-Reply-To: <00000000000005858405b3df4904@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Nov 2020 10:37:34 +0100
Message-ID: <CACT4Y+Z3Vqx+1bo1AF1XPvOmy68=foW5KM0W=+sOGfA9nyNAxg@mail.gmail.com>
Subject: Re: WARNING in irqentry_exit
To:     syzbot <syzbot+d4336c84ed0099fdbe47@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 3:01 AM syzbot
<syzbot+d4336c84ed0099fdbe47@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Oct 2 09:04:21 2020 +0000
>
>     lockdep: Fix lockdep recursion
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1202919a500000
> start commit:   f873db9a Merge tag 'io_uring-5.9-2020-08-21' of git://git...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
> dashboard link: https://syzkaller.appspot.com/bug?extid=d4336c84ed0099fdbe47
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15312a66900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b01641900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: lockdep: Fix lockdep recursion
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: lockdep: Fix lockdep recursion
