Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766512B2DB0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 15:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKNOmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 09:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKNOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 09:42:09 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BA5C0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 06:42:08 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id d38so5118898qvc.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 06:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bFkAwvvqi3q0otrB3Dod9Fx9vaczXbmmZ2zfJ4oQKA=;
        b=vt7NKvHYNiIrG9yiILF1mUGM++rmh/wIyOpU4q1QBv0sSJdsGSnVbrex17MBNlMLIu
         1qlvO4PWaapapJ8q3rLypOIECQBLQ0/lHAR1e0U3bkqWgt+nmpZ8f3dtFfm1SWr85/B7
         NEX0idcSJmPuuSt+W89FFf/DWd41HfdbxAJCyMWLoCW1G+nETt+mOaBZE8vdY9zvuewk
         fpAU8hgBYSUpZEk0OuBfJaO4zOJ4qZLsgbqMiPy+fArG3gqH48S8F7gOF4anLIn6Op9w
         wUqu3lpnmwT+dzGkJCT3KCHbNmjtPVSlUoTImgUIldlow0g7ScE+dHkDm9z9rHdT/nsB
         TBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bFkAwvvqi3q0otrB3Dod9Fx9vaczXbmmZ2zfJ4oQKA=;
        b=UuzVhjHtNu9B1dsG9/+5w+LctunNTrkVqSMmbtHNWx0y98sU6mMS8MH7cO4lQ95hwF
         rs6PgzgC0faBrozQDwk0Ftd96Cbf/Cero915ce8OCWSRGDCl5m/5B1RPBkqfAQT/G4Wz
         7YBtm6tKbKvkb3WDBubaj/432oCuyf00Tc/1WBg6xMxGJv78Ol//nGnNXt2zj4Rg5EFV
         R7qoqr4LBl7ROXTE+iu60sHRyzcTPSFOIwhceKcwndzsCUUZ63utFcOlidWUgrNH2AOB
         fvDFLHkHtatpMS4BXQtoJ5TECp4IyKkpF07nllXYm/J/O34z/la5/1Ra3aWFRjf1Irn7
         RG8w==
X-Gm-Message-State: AOAM533braR78Pa2/nR2wADxVMXNMqvu3FmLZJ9UYUkWUkjTdphgyjq8
        4dmpe7JjurvwxBomcJhe0vTJuLLXx14tEJ8dTJ+CSA==
X-Google-Smtp-Source: ABdhPJxk5r43DAmJDSrFhSpq4tpiJg2MdbsMie16Z4zaHsDKab8OWtliq094SlHS0Ys6gte+N9HLIjsIHgJCdThAoO8=
X-Received: by 2002:a0c:e911:: with SMTP id a17mr7558779qvo.18.1605364927202;
 Sat, 14 Nov 2020 06:42:07 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004740cd05ac444126@google.com> <00000000000005d94d05b4118980@google.com>
In-Reply-To: <00000000000005d94d05b4118980@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 14 Nov 2020 15:41:55 +0100
Message-ID: <CACT4Y+Ya+VbfXC6vn0cFJ0R6geg124vjxNzVo-g83iUV=gapdA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in afs_manage_cell
To:     syzbot <syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Hillf Danton <hdanton@sina.com>, linux-afs@lists.infradead.org,
        linux-cachefs-bounces@redhat.com, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 2:58 PM syzbot
<syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Oct 16 12:21:14 2020 +0000
>
>     afs: Fix cell removal
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b78dba500000
> start commit:   da690031 Merge branch 'i2c/for-current' of git://git.kerne..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
> dashboard link: https://syzkaller.appspot.com/bug?extid=f59c67285cb61166a0cf
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10960a8b900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e938cf900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: afs: Fix cell removal
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: afs: Fix cell removal
