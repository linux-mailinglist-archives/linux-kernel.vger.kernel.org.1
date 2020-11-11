Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75B42AEF44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgKKLMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKKLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:11:54 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89065C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:11:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h15so1199588qkl.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DxT1s+tsfCJVj6OZY+5EDNCcZKFA5EYcAH/UK8gjKs=;
        b=KSHeypMSZHEVJvLuOPyLxy4LjzQZ1te9OW7PVMKo+kvATEyFciMMiBsQ4T2Bt6DAnf
         R9wNfzpk2D39pMdrkjipdnlji5GOYKzpp9eLq0TcFxTCosecbmJzX+BKQ/GRXiNe2jc3
         CUxb31pGLP4PKLOe080TnnD/aVgfv2b4drES4Mn+ZfaexYSsD02TVsLGlBK1hQIaK/gj
         VnnQmHQqcYaGfPX3n4KaPA7VaV5+CearwC3ST+Vgrd+i1MIeGgyT7J2xO8qGNV0oiK+d
         Vpefst9ZO9ufRFn8mzXfGc0qpXbqoEMuZv1W+cFx61N+i8lLY5eg85ZmU1jdmeQ64zxv
         izMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DxT1s+tsfCJVj6OZY+5EDNCcZKFA5EYcAH/UK8gjKs=;
        b=Bf7a1r9QFvR5B9Ie/9CtQWIzSBiShzGCj5OM5E154vP4h9oYxe5S2f6Y+H6hE8wz1w
         ftEl6fewE+tnEZPpXv10HujRFbq2WXywwXPRdF7fN0EkaC5aQbJz4e1ZOiswJbeOhgTA
         QI3iureajzTk4mh2vQOgPnK1Uvemngd5VNX7136yzJRvfTl8lkKe6rY95PxTr45doS+j
         oWKSEogwpVfQEa4Ym/On8nQUMA286pOnqKavuSGsFV6YLk0dRNmw2SXhowPGRyXs21Bc
         pkv77FV3nL8NR7LnFZhp9KG1S4LMhiD5YufYSfKy+mHR54nNC4U9GdB7QtQ0XTiqxmCs
         mDCw==
X-Gm-Message-State: AOAM533juRMkoGtUmBonrY8pwFieOxaENrIIlKGMuCmdaxwMnx97tTxF
        BODOyC4lbCzfBt4tcjN3bSZVSsbl73pHf/NAC0bYCQ==
X-Google-Smtp-Source: ABdhPJyYsEyLUcs16fkwoN62F2UeQApfDCX3s9EQw2NnahBRJbvCTbOlujrNs3O9jm3Fmdjinx1K9CF4GmfEZLyyGsI=
X-Received: by 2002:a37:49d6:: with SMTP id w205mr24385862qka.501.1605093112552;
 Wed, 11 Nov 2020 03:11:52 -0800 (PST)
MIME-Version: 1.0
References: <00000000000018a47605af074c7d@google.com> <0000000000006942a305b39baf75@google.com>
In-Reply-To: <0000000000006942a305b39baf75@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:11:41 +0100
Message-ID: <CACT4Y+YmTfr9cJ49=OvVUk4X0cPiiv=LsuSQY-B9owqgmuAJuw@mail.gmail.com>
Subject: Re: WARNING in syscall_exit_to_user_mode
To:     syzbot <syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christian Brauner <christian@brauner.io>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 8, 2020 at 6:22 PM syzbot
<syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a49145acfb975d921464b84fe00279f99827d816
> Author: George Kennedy <george.kennedy@oracle.com>
> Date:   Tue Jul 7 19:26:03 2020 +0000
>
>     fbmem: add margin check to fb_check_caps()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a21f32500000
> start commit:   f4d51dff Linux 5.9-rc4
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ffc7214b893651d52b8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122d7335900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cea1a5900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fbmem: add margin check to fb_check_caps()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: fbmem: add margin check to fb_check_caps()
