Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDF62AEF38
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKKLKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgKKLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:10:07 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7332C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:10:06 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id dj6so686412qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGFFuXVt+Pn6ve/IqyBgXXFPrtvsdxZB2xhmY0dsZJM=;
        b=kv1o2cYLLhoZw4SUAwvLnDzjC6f6r7X3l+WlHhUG0rXcWzIhHi4CTGqbdXHzAiUGQF
         GKJH3hGbLb6NXMm37AYtJMYeKOjssTi5J75C0nAYDI3fIuMZTnfwlSRHb2h0dyzIzHUH
         Fco3jiC3ERdgCZeYHS/cPN/daJW7vFnQFq98H42pGUCWiTinorlRPPM1tWdirG1b8HZa
         +RZr3QCri2OWKTwQlSEt5Q8Jiaz3spbx1ic5slD6M4DJQiqItLKcBEsIPtnd7hqw6F0h
         pjRMPaFA0pHLK7VUo2U9j0qHlFoyJXYlXU51evGNjeRMIRxo2o95sgrBs1mFH1VdM7NC
         RYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGFFuXVt+Pn6ve/IqyBgXXFPrtvsdxZB2xhmY0dsZJM=;
        b=lDu3a3nCT+uD3TALzwlLA0vAX2F3Xrm1KedEh7KSEHKoPuA7JTpo9giHcMlc8IoESx
         CTq8CuOCoWJBpzZaFgfvVHFnyhGrxlPPPmgTmoUY+bS2+CTa/p3YZBEjRtuH7z1Mtt3h
         df/lJYmqIh0t/X4sLKFkTVrtGS2BQWsnUL54fhvTIfD3v8Q8OCEBi0FKMsMGpn7iHErI
         yEE1Ws+Qw6FYWpNV6Qi0xe2YHBd8YPqgDgLSQGdanrx16XhSv0kCHOiEFvZwBTSdjpJE
         A+ffzgoXyMBpWtgk2upm7LWZPklE+0c/Os9GCZaZPp9dWt/XaKKEs/umU4dRpJ+dzwF5
         SHaw==
X-Gm-Message-State: AOAM531u9HfBPmzJjtYPKXTcDIqfgY8KuktJHmm01cN8E7M5hJSLCdjn
        bVqicp/0qdTf7mXTeYeGuy5IJVvz3Llu/3OuBvie5g==
X-Google-Smtp-Source: ABdhPJwd3Av8z/OYK+KLjnRspRkHygWEC+5h6lpBgewOxvYD902nsHhctvXKTm+JvLNcl6fU1TTIGvWCl2IyTDUTylc=
X-Received: by 2002:a05:6214:12ed:: with SMTP id w13mr19336057qvv.23.1605093005791;
 Wed, 11 Nov 2020 03:10:05 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a4b3c205b0c24743@google.com> <00000000000068a67705b2cfd6e9@google.com>
In-Reply-To: <00000000000068a67705b2cfd6e9@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:09:54 +0100
Message-ID: <CACT4Y+a96S30Ge5zAWjAZgNqU6TfoyApxibJj+W9DTdR9JKvTg@mail.gmail.com>
Subject: Re: KASAN: out-of-bounds Read in __switch_to (2)
To:     syzbot <syzbot+2667188e965125ab6e7a@syzkaller.appspotmail.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Borislav Petkov <bp@alien8.de>, chang.seok.bae@intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 3:10 PM syzbot
<syzbot+2667188e965125ab6e7a@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a49145acfb975d921464b84fe00279f99827d816
> Author: George Kennedy <george.kennedy@oracle.com>
> Date:   Tue Jul 7 19:26:03 2020 +0000
>
>     fbmem: add margin check to fb_check_caps()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174684b8500000
> start commit:   fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=41b736b7ce1b3ea4
> dashboard link: https://syzkaller.appspot.com/bug?extid=2667188e965125ab6e7a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11743a37900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fbmem: add margin check to fb_check_caps()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: fbmem: add margin check to fb_check_caps()
