Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37A2AEF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgKKLTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgKKLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:19:21 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833FC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:19:21 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so1275071qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdlWGa9W9j2/2idrafRO8NF9kHbSgdMNIKF8WBfZVnE=;
        b=Zf90S74xeQ2LgIINAlHaNh3n+wxSPSw6MWf8Xd3cGwGlR2g4zYQEqzjNbV21x/Yzvh
         w99oPltcMDq0BMMuF8orFw0dHU3XwsniZhq1vP/gBoW+LXFtcA9aDwE3WxoOtSFQ+XSQ
         XkFwCOJH+VHug5Jp8RT+iRUi8EmRsQ9UduJe6AIDOi2FqARmUIiQT6FZ0NCB0PHpYyci
         JML2ElQrHBcmnXQDrF+FGwR4I9pVBWBdc8QJczC/eTQ38o9Z5E227CFQnsT6tjHvS9U9
         4cGdauMHOE2ZHa3PEvI0/wsbPFaAgsY4xUizR53ibKhCJdvQPiN+poSppN9475DJMNgF
         DBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdlWGa9W9j2/2idrafRO8NF9kHbSgdMNIKF8WBfZVnE=;
        b=YwdMt271HAwz0KcrSXSADHbN9/X501TYyl6koJdv1sU87r8EOZ9JlWSqmxXaahjbOt
         BJus5xjYrrRV90HR80q6WEVDG1XSpXSvkHSpIZqfVBsX0Mrlmc1GCbx7rYNxt5y1OaBG
         e7w4+HeLarxNuPlwTz1oHPI4lh/6MZWXAXUD7fxM5aA3Q/XAVEdB4+hN2nrSqKNp0ANL
         1LzU9UUyiS8sGvc1dJku/wUQ1FYByKa8tH/7S8J4cKuPlYRJEbgx6yivZD+CJuxh5Xp6
         +jpF186G/QVOfmISk45BpJ75ry5jciO3oOm+ysjSUOkNpQ2DxRLg16klYpg67MHqna7S
         5gNw==
X-Gm-Message-State: AOAM532F1Ai9blmNItMZO4MRPmoGMYTQOx5YKsEMCmKBxWlCMhF2hy3Y
        5BlE8pOs58JmW4CujgFAnU2sUUPQ9ntNOl1nDXBQ+w==
X-Google-Smtp-Source: ABdhPJyYlG8RGNjUZKn1NEXiU475Oqt1Wa5/f335MCR9/btvvCw3lKf1NDB71nTIM92AcHxiyDRqaQx4DK6yxSs7XQw=
X-Received: by 2002:a37:9747:: with SMTP id z68mr23444181qkd.424.1605093560351;
 Wed, 11 Nov 2020 03:19:20 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009383f505adc8c5a0@google.com> <0000000000000b380805b09dbf40@google.com>
In-Reply-To: <0000000000000b380805b09dbf40@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:19:09 +0100
Message-ID: <CACT4Y+ZM6kjJjaiocArfb2EEhJKqqA3=S2Y_7GeTx2SXz-xVAQ@mail.gmail.com>
Subject: Re: general protection fault in nexthop_is_blackhole
To:     syzbot <syzbot+b2c08a2f5cfef635cc3a@syzkaller.appspotmail.com>
Cc:     a@unstable.cc, Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, anmol.karan123@gmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>, hariprasad.kelam@gmail.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        netdev <netdev@vger.kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Song Liu <songliubraving@fb.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 5:34 PM syzbot
<syzbot+b2c08a2f5cfef635cc3a@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit eeaac3634ee0e3f35548be35275efeca888e9b23
> Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date:   Sat Aug 22 12:06:36 2020 +0000
>
>     net: nexthop: don't allow empty NHA_GROUP
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116177a7900000
> start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
> dashboard link: https://syzkaller.appspot.com/bug?extid=b2c08a2f5cfef635cc3a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d75e39900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aea519900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: nexthop: don't allow empty NHA_GROUP
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


#syz fix: net: nexthop: don't allow empty NHA_GROUP
