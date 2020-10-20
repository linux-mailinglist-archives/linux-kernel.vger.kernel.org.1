Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90CD293498
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391940AbgJTGLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391885AbgJTGLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:11:46 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD613C061755
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:11:45 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c5so377918qtw.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44p3wi2to3ENYlxeXsgHcd8F8hXNCHcnGVpzkuLoxi4=;
        b=BYn6LV5OdU/Ag/Cikl6WY+lN+MCRZpO3UK4ouZoX7PRgu1aDU77v+3Hig/uoPBBbGs
         4S4anlxqYpjB8qz/gvVmdmiK/aeIMxhwUYsQWgH41nW+ul9VZ5CPmhIhouJAlb/DKrCL
         B9LMRaDfD5V6eVNO/C/gydkitfQ3gNC4g7+KWaLpd5U85ug+qxKZki0u5D8X/Nvfjt0T
         hTES2ADVz7hNtXJ4G3C0Chc/7XJCE+L97queBko7qeOyBKxyCaxn5USRbXHq4H3cxGWI
         S7DaKAwsAd11ZiG0WwPEkKMYzjt0xmY/ORWAwIYUuHjqJgFIjoDdDmeQtaaz35r2loTa
         X+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44p3wi2to3ENYlxeXsgHcd8F8hXNCHcnGVpzkuLoxi4=;
        b=qmwUbUSjHQXOyZzNa+ET3tlTVYHl4PY7//sqog0MJJzVan5jAHGo2lTHw+NLASluM3
         vC8+z3ooSOKaKffjJb/jOHc1zyXmZj08cQtf2InGXHo6md/EFHMhpKSQtFkXp5GvbAtm
         ADlBZzQLvkkVasev1eI9bRHRb6Ab516NkHe9sIg04epgR/2WThMVei/xJmSbD+kftV1e
         M3+d6D29DjhLuAXxkQqokhSTT0CfE/1g7eFp70Hq9mC2k1qFDVZy3TgXP+i+lJ2wsoCa
         DMYSLGKycHnbRwkizD0gWvG3yDZz8CYV7FHEe4+8080ynhKuK08iPamu5s2CUHM9OAK/
         YeoQ==
X-Gm-Message-State: AOAM5323s4M+Jzh6xoHyWdTqQu5Ypf6p95bvFVElBsdPQVFU3h5aQClo
        ZS1yKUXljGWyKrS1PvWZo28jmjQNAVSNoCyW16WCXg==
X-Google-Smtp-Source: ABdhPJxcF0uu6BHG3GCB3HF8mZfwyf6AxXtBL4QDOBqI7LwKl+Kk/HUntialW3kxkx/CW6QMNHWPPjd28pmjxupqAEM=
X-Received: by 2002:a05:622a:9:: with SMTP id x9mr1114273qtw.43.1603174304665;
 Mon, 19 Oct 2020 23:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000005f0b605af42ab4e@google.com> <000000000000f098f005b20ced50@google.com>
In-Reply-To: <000000000000f098f005b20ced50@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 20 Oct 2020 08:11:33 +0200
Message-ID: <CACT4Y+bXyW8++nEZJXjYoKon8a_3kzXArYHJ1MPomZRXRUddfA@mail.gmail.com>
Subject: Re: KASAN: unknown-crash Read in do_exit
To:     syzbot <syzbot+d9ae84069cff753e94bf@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christian Brauner <christian@brauner.io>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:38 PM syzbot
<syzbot+d9ae84069cff753e94bf@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a49145acfb975d921464b84fe00279f99827d816
> Author: George Kennedy <george.kennedy@oracle.com>
> Date:   Tue Jul 7 19:26:03 2020 +0000
>
>     fbmem: add margin check to fb_check_caps()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ce19c8500000
> start commit:   729e3d09 Merge tag 'ceph-for-5.9-rc5' of git://github.com/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
> dashboard link: https://syzkaller.appspot.com/bug?extid=d9ae84069cff753e94bf
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10642545900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141f2bed900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fbmem: add margin check to fb_check_caps()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Based on the reproducer it looks reasonable:

#syz fix: fbmem: add margin check to fb_check_caps()
