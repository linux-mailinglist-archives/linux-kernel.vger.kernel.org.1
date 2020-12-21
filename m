Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABDC2DFB15
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 11:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgLUKbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 05:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgLUKby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:31:54 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E68C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:31:14 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id w79so8315139qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3vPUkaHqxxnpGause6hsihZy19vITzBYUQC4M2DuK0=;
        b=GkpADlDK6kXFRky6ufX56elk9icvfmz+M/J6l59CmtSlPLH4ncsqlMJrTCazhfJ5X3
         s9uf+YK+LyK5apriQZBpnEe1NOezzU8cY+o290rhjsdfxEecdiilZc14u0sDnzJy5+wK
         OtdoxUWZxuNBbRed6LfnlO+DpyZeSGcQeOffSLDYxyFYwgQ9CEcOKy3n6eJPErWfK7Jk
         nSuSI9xfPG0v4U8ei7XwFxiujcljbZe5+5BLMpycVMd2+eNjFbc7ZT9GhSvrycBtyEFO
         dKDkTVLlpCjAzIWfJSqZvbeQd5BMRNMsjHRU23Y285BmuAQism5IhrPL23rJoADHHKFo
         HvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3vPUkaHqxxnpGause6hsihZy19vITzBYUQC4M2DuK0=;
        b=PNQHR2y3St/sO2vyZ7fgvkxeUWGVU4mNrqJ/ZBH4wDQxEeH4DySOsDXkcxGsYgYv1O
         YYQDBla2fTBKCk3MWXwssW6QWaj2i/7ioxEb3uaD7zB8DD/XF23wpSyZFv1FjQt2iGzC
         mPwM3XEQmWkA++jzfVcggda6IzhCGiuAepjN01BCzDN2LBqorzpvxiPJiMLITbV8XAFu
         i4JFOfb0W5cE4HH02LS+mMVBpuVx0Hnmfx84aWeHsW5qdSLfdaYqDX5NoqE5e/aic7Q1
         FBdMmZHPTXDwhQiyXjXswhxFXGy0G2a6ppls+iW5YgG0Hexxbyj6poFZQ2+K2syBW1p1
         pVOw==
X-Gm-Message-State: AOAM530KnerNb+zHXPUnnnw3VLEZQjPklXcSfzvTrFa6/sBFGqAGaqd/
        4RxcOwjCGbsTHNIyRALDmtM9pnfHxnQUetuKyuxzJLfh5ISSFA==
X-Google-Smtp-Source: ABdhPJwtyyMOp1Nmg+ViXvFUW653vwTmL49q8hTvJK0JtvTBFPAhiP+BL5Kb8rFGMs48uUDJmg8O9hGVZy8dmJkgz6o=
X-Received: by 2002:a05:620a:713:: with SMTP id 19mr16429791qkc.424.1608542538865;
 Mon, 21 Dec 2020 01:22:18 -0800 (PST)
MIME-Version: 1.0
References: <00000000000089904d057f1e0ae0@google.com> <00000000000014086305b6e54cfc@google.com>
In-Reply-To: <00000000000014086305b6e54cfc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Dec 2020 10:22:07 +0100
Message-ID: <CACT4Y+a+KHz924KNzNkxs=kWwM9Udf8t7=uCfg+uH_WPyJN=qg@mail.gmail.com>
Subject: Re: general protection fault in rose_send_frame
To:     syzbot <syzbot+7078ae989d857fe17988@syzkaller.appspotmail.com>
Cc:     anmol.karan123@gmail.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-hams <linux-hams@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 2:27 PM syzbot
<syzbot+7078ae989d857fe17988@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 3b3fd068c56e3fbea30090859216a368398e39bf
> Author: Anmol Karn <anmol.karan123@gmail.com>
> Date:   Thu Nov 19 19:10:43 2020 +0000
>
>     rose: Fix Null pointer dereference in rose_send_frame()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=139e2b9b500000
> start commit:   23ee3e4e Merge tag 'pci-v5.8-fixes-2' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
> dashboard link: https://syzkaller.appspot.com/bug?extid=7078ae989d857fe17988
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157e8964900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10046c54900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: rose: Fix Null pointer dereference in rose_send_frame()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: rose: Fix Null pointer dereference in rose_send_frame()
