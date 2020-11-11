Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA852AF234
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgKKNdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgKKNdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:33:05 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25356C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:33:05 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so1601833qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=P3Q4xL73uRuMqOxoZjkn+rZ4PdGUjKI3a9aP6ZdWb6w=;
        b=Om3Nu5Nm0kZHhs9M150sJEuxg8vF0U3QyD4TIuXRZI0INPCAyS5ye5h5P8mCmVgEDa
         WefbJoRo6RmvBO/zC+9uOcz2uClHgirDEs5lQKPztqN2WOLpLFW+OO72txMv1X+Ad1Jd
         cgHZypmDQeQ+FInoHR4SxrzgGCbDDKkQMd+2O/5UPfSOVlJqvOMEhpIUG1YU/Cc2kiO8
         0mffUajEvEkPTnnU16kvyuLSqd0xC5KZP9HteXOuGfBtCdc8hZNYd4BDVlktNG+qoUpc
         N0yJjxEfjLsq6pse6pHM9GBnP9a99h+FwPIAzkyUE2mpoSsNmqYgxVgKIb0hYjf+E7ZA
         fwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=P3Q4xL73uRuMqOxoZjkn+rZ4PdGUjKI3a9aP6ZdWb6w=;
        b=k3g5WFIq4gxNrAcK9YNpW0yGR/XVK5MWnET/6oo0trg2PUVjvwPtkKKAtw+yYVnDMF
         t1wcFGoNw5+Qu9NCijGEimLVyKbY2mwJ+ft0t8+t0OgucM2aPLZeY1dEs00RD1iqjYT8
         cfsaBcgp3pcmAGbjwRSbsoqVhx5y76/0Pv9ou+B7gg3TViB4lGSYS0TxdENpDDZ5/hZM
         zUbbsVwLkc1PN6as88mWB1daFexvyJ/a54AwFNSCO25/W4xY40Vdd4YPd6tk6lyOB0+/
         bVp4DRzEw6WAFM/B3ZUZyHY+39vAkjLQBoWHD5xyfvGpLYNOb62GPwpwcB/L11+PjlZH
         YnIg==
X-Gm-Message-State: AOAM530+axtFFt1WFWfBd28kKq+R3mrmYaGNoxN5GN9z2ihxCdlB9O4c
        0JlNI9FbJ+EpA4sB3nGnf9Xu5t0vliN/Yoi8vBhpEmyxSJz/hjQ7
X-Google-Smtp-Source: ABdhPJxg3cck2yQP0+4JPC7EIlpfAw7D43z9b3Lfv/XwKG0qOeH4VIOEkHLBHuKEjzujKGF1+OOI12r4vf4iwQS4isk=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr25849058qkm.231.1605101583992;
 Wed, 11 Nov 2020 05:33:03 -0800 (PST)
MIME-Version: 1.0
References: <000000000000fe6c39059905c289@google.com> <0000000000001529fb05a109c3dd@google.com>
In-Reply-To: <0000000000001529fb05a109c3dd@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:32:52 +0100
Message-ID: <CACT4Y+ZGna8rTLWTV2Fttyua9kteJA=SuTHHKK9k1KvV32_P3Q@mail.gmail.com>
Subject: Re: INFO: task hung in flush_to_ldisc
To:     syzbot <syzbot+e199b43b49192126ff69@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 10:43 AM syzbot
<syzbot+e199b43b49192126ff69@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit e8c75a30a23c6ba63f4ef6895cbf41fd42f21aa2
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Fri Feb 28 11:54:06 2020 +0000
>
>     vt: selection, push sel_lock up
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bd23e3e00000
> start commit:   07c4b9e9 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
> dashboard link: https://syzkaller.appspot.com/bug?extid=e199b43b49192126ff69
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4efdae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ccf946e00000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: vt: selection, push sel_lock up
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: vt: selection, push sel_lock up
