Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0FB303403
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbhAZFMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbhAYJiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:38:23 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8BC061355
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:36:49 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c12so9217372qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRQosLm6C15KsdbC23z53ajS0ecGg4Tv0WOPnf4DcbI=;
        b=EHl79LcNBPa09vYmh5NvxQvwwidvVxnIqn3I/Hy/z9XHQ/fHzVwKPcucw1DHXOV3ug
         vYD3EbzHtHyuqjEgXkK0bduWkFxxoKGyzKX6qpt159lfypUoBN4LItQQc/6tyeHTDAHM
         7uOabEhAEHERLBY1WRTHE9SA17jPhFPTUJUalI0ZXPTDLuhkpDX1XkU61wMqvv9eNKec
         XZJO51qerZojWiNgdVnXAmlPwSY5ueaeAo+CcTYVWKVrEQlGbL0d0B9xBc1v3nvQ9M0f
         BcSaFnw4p/WvBfghFxU/VegTdjo93M6UIv5jZhhuhJLfg6foUVIr8U06lYJMe/QG8IIB
         Gn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRQosLm6C15KsdbC23z53ajS0ecGg4Tv0WOPnf4DcbI=;
        b=VZTzDFf2Wjz8YdODDOnLAF74UXNgGaf4FR17ZvH+F3LpmWwItKz1yqX3yaPNNcTbC0
         YWJpGIKwkESsiF5ZP/NRt11oif8jkAjFkVgSOok7Ne4C0pDsxPnw3BVo1Zp60XoJBzHq
         iHYKFvEczlLpT+V6W7ad1QBn6LJxx3+YSqjnkjBT1nwGzOwteem++/J0vsU6eQrBEorU
         2NL/CP43zLhY+BRpRmWp6MEU+d+1XvTZnO2Khdt678PTN/n0rz3acX0YUgTI3yjoXMeo
         3rEJ8xfNFEOHwfZXNw/V6KieP9mqoWNzrXctSxYkyaUdUIZN92A791T4v3zw45pmUqzE
         ScNg==
X-Gm-Message-State: AOAM533JrPbJBXaW3FgGeoEavNMqb02QuNXsxzhL8WVRRKCVP1RXc7M6
        vrizMiQExH78Ahk+osqa40cMwDAwlWveBKhB1Vx1Xw==
X-Google-Smtp-Source: ABdhPJx/RY2g66p/t1/L0q/cqPmlQAgvBZkCf/KHiV6YEfYM36LT31LfSHFCetjbvDZYwqBG8g5Q4idYKqRctw+2qic=
X-Received: by 2002:ac8:e0e:: with SMTP id a14mr587226qti.66.1611567408146;
 Mon, 25 Jan 2021 01:36:48 -0800 (PST)
MIME-Version: 1.0
References: <000000000000418c7705afcff2e1@google.com> <0000000000001b4eeb05b91ae518@google.com>
In-Reply-To: <0000000000001b4eeb05b91ae518@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Jan 2021 10:36:36 +0100
Message-ID: <CACT4Y+Y=rsqHVRGWtfcJmdd_8CAYw3W_tO72_YkpLiu6d9Qo6w@mail.gmail.com>
Subject: Re: general protection fault in jffs2_parse_param
To:     syzbot <syzbot+9765367bb86a19d38732@syzkaller.appspotmail.com>
Cc:     anmol.karan123@gmail.com, David Howells <dhowells@redhat.com>,
        dwmw2@infradead.org, jamie@nuviainc.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, lizhe67@huawei.com,
        Richard Weinberger <richard@nod.at>,
        Eric Sandeen <sandeen@sandeen.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 5:14 PM syzbot
<syzbot+9765367bb86a19d38732@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit a61df3c413e49b0042f9caf774c58512d1cc71b7
> Author: Jamie Iles <jamie@nuviainc.com>
> Date:   Mon Oct 12 13:12:04 2020 +0000
>
>     jffs2: Fix NULL pointer dereference in rp_size fs option parsing
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cb91e7500000
> start commit:   bf3e7628 Merge branch 'mtd/fixes' of git://git.kernel.org/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=9765367bb86a19d38732
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d81f32500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13516852500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: jffs2: Fix NULL pointer dereference in rp_size fs option parsing
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: jffs2: Fix NULL pointer dereference in rp_size fs option parsing
