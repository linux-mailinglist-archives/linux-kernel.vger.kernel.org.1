Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C632AF2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgKKODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKKODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:03:03 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA61C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:03:01 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so1299516qtp.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fop/5FcBYqp1EBb0J0yxC9ZD7voBHevk86AMf6jgdxM=;
        b=sn1NyOykSACfdi1Rv5XhNBLkcQi2W0ropTn56ckWh2Z2KVCVK3yXxwJbCZJm2c/vhI
         zbe2xJsdNM+uIpP3LQ0V5l2RGIU2aMd05Q/q2KfqQ7i2EY+Kg4k6Lwkb9uWtMRN41lUN
         PCSAkL+gWA8a50M6AyKD0N/amtzM047JQHF00Zyb5lfAtwjDAX1zFJcYyBRtVsd5JvY7
         kNaHujbmHIa0FIYGLRGYD7Hmw3o03XRoeTu9c6N7dGiMigWtNSuzRRDgQnHfZ7iOA8mR
         RvH4LMS8iyo2d12iTMdnaU5b8bCUkIQpXjHdmxu11pwc8i31tK2fL1MJ4913Lqz34TQb
         G3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fop/5FcBYqp1EBb0J0yxC9ZD7voBHevk86AMf6jgdxM=;
        b=sNKiB6AjWDB/6l/MxWI85HDl7lcHroM8w2VQg+ttfJTD1KiyxfsLgFETShkT4KKaCu
         5k7oHG6dtWpknr4bRAf41OpoJw0HByUCveaWyod3JdjMVK7L+j75MB4p46weu9QNsSUb
         RWQFn+mFaq/utvsDbfwttT+svZSALUQ3kqmkCJGi7zGHM0zV7nAWJyR5KYniXWykvk3O
         p7Qe+BltbCZ1WReMDLwZWPrQIeTgV0dNUCXn7p+beik7JeLSiH69HzZ1ZQN/KzKNLpu2
         owqiwPuHN3Ykm0F28DpTccB8Ma3ts6T/Yl2RBXeyHsXPHO8ye7l8XJNTgQ63HJSjfSdc
         1DDA==
X-Gm-Message-State: AOAM532KbhUoil03MsZUcfoAA/cZv5ye16ea4tptWn15M70MiFKiYt8G
        vJUec5mNYzaVb1J6XgmHFgm+RS8+I/kQMfQAHiyadCEtSZycxVRW
X-Google-Smtp-Source: ABdhPJxLT6erSrr/ltStEmpl/WsryKcih7RpQd6VHdCsY8O7dVsTLr6/S5PXbuRITY7bFVeU3jawQrrHHe0eqpMqHUI=
X-Received: by 2002:aed:2b47:: with SMTP id p65mr22176340qtd.337.1605103380353;
 Wed, 11 Nov 2020 06:03:00 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000a9cca057cd141bd@google.com> <000000000000f472ee05a6764e46@google.com>
In-Reply-To: <000000000000f472ee05a6764e46@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 15:02:49 +0100
Message-ID: <CACT4Y+Zr6aEahp+jQhCoZCLQ4CY10oHUKB8yGfZxE+6WujeyNg@mail.gmail.com>
Subject: Re: inconsistent lock state in icmp_send
To:     syzbot <syzbot+251ec6887ada6eac4921@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 12:19 PM syzbot
<syzbot+251ec6887ada6eac4921@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit 1378817486d6860f6a927f573491afe65287abf1
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu May 21 18:29:58 2020 +0000
>
>     tipc: block BH before using dst_cache
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cbef06100000
> start commit:   f5d58277 Merge branch 'for-linus' of git://git.kernel.org/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> dashboard link: https://syzkaller.appspot.com/bug?extid=251ec6887ada6eac4921
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ab6ba3400000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: tipc: block BH before using dst_cache
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: tipc: block BH before using dst_cache
