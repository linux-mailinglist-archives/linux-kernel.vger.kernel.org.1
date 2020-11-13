Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249092B186D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgKMJim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgKMJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:38:37 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F102BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 01:38:36 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so6271878qtx.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 01:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+nPinMUroPmGA/FkIjqQBwtdL5YldQSIOTcEcMGd2/4=;
        b=sP2UXoyAtZ8SikAA1SjVp8Qbu9mStc+okk5CaBBKtm6aEuLYvcn/xZmC6YYtsx6tDv
         JovxPRgLgng8mBgt11H0QsOGNILZX7PG+qp/gor5f+9poI80ZNmKKad28FWeogZxM4+2
         JPJ9sAit/KD9in3TN4IrR6oC1r/AykE1DQsghE5pk9lNEecxVoalulS6XsLYioWn2D3e
         kAO9QXXyQ2PULPhUMD8wKxfmujBAMWh8do3KxILxHqvRRJRyq3ezTtSMwKuCUh/g2GN4
         Msr+Ch/GaoB63BFLcwbJmwBAltaitf0oJYtoyu+beHvbGuEGhtjsVzC5lX8zokUtJJxw
         4Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+nPinMUroPmGA/FkIjqQBwtdL5YldQSIOTcEcMGd2/4=;
        b=LsoHL/Fsx0rez59u3EWtNXEyOwtl8zyBKJhmWwovtWJLilZniZFLeTQQ5LAy3DqZG6
         AMbz9tDa4R5jnwQYi3yZN1SSo3m9ZX++02+dz5pQS0m2J9Ms3RYpa+VXcjzv/oD4LnP1
         jwcSvxadZuVkJJfyjt8ZC8rz9M59WO2OLwpbN5omynDnqZiFOphRknsPCcFyOAXf4Ehd
         PcF1UBfUxGcV+za3pNI3QDYH6eelRccd7lPz86C4LYezi3Lfsg8ShS8thL7c8N182GUj
         2v7FxzNEwDxh8SsgNwz5ah36F/fx5f/DWMGoRMUvC1fRLr6TvCCDjAx+U+8+SKOm+2EN
         hmXQ==
X-Gm-Message-State: AOAM530EHWhpaVIUKL/C9ydyV/SCZ9/TI85GIHK7PfRwwulyyKXlqmc2
        OHRalAG4s6BjBjHD7I1Bxjl+sXZDtQLkkA2XPfilrw==
X-Google-Smtp-Source: ABdhPJyo/Cl+Ne93ZkCd4fZlwp/wG54EGnO3l6zPkSR9N43rFoK2rdDDxK08DHhrUJKQSjmiJSohka5GpTEd5MZS0y4=
X-Received: by 2002:aed:2b47:: with SMTP id p65mr1051756qtd.337.1605260315929;
 Fri, 13 Nov 2020 01:38:35 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bb202905af132b8f@google.com> <0000000000004c208d05b3f8cbb6@google.com>
In-Reply-To: <0000000000004c208d05b3f8cbb6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 13 Nov 2020 10:38:24 +0100
Message-ID: <CACT4Y+ZKyCCreqOTx9POAGbabf0=WMenQk3YJc4d4E8Tb4=_Gg@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in get_kernel_gp_address
To:     syzbot <syzbot+d6459d8f8984c0929e54@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 9:27 AM syzbot
<syzbot+d6459d8f8984c0929e54@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a49145acfb975d921464b84fe00279f99827d816
> Author: George Kennedy <george.kennedy@oracle.com>
> Date:   Tue Jul 7 19:26:03 2020 +0000
>
>     fbmem: add margin check to fb_check_caps()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ff7572500000
> start commit:   f4d51dff Linux 5.9-rc4
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6459d8f8984c0929e54
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164270dd900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fbmem: add margin check to fb_check_caps()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: fbmem: add margin check to fb_check_caps()
