Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774842D0D14
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgLGJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:34:45 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:45520 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLGJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:34:44 -0500
Received: by mail-io1-f72.google.com with SMTP id x7so11436003ion.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lM8WLkinSDHgX0CP1qhRRtUnNv9UgUMhc5+FYvvQq+4=;
        b=YZN3ynfWRzo1SLmGbd4NDuzK1Pca57v2Z23jk2XJIyWxX7x3pQAUd4RpumvmF+OTri
         3VPlCyH1PtTIlml6jrOvOtJ/XsJ0jbpyI9NnzUWHSiBmgMBg8drpA/C1zas+wtpn7tZC
         Xt3I7rdP3VI/zQ1SMeUhldKcaEXcx46G9yP9HUKPlyzWOtv19e+1AslPaw9iDk9u8TEj
         Hrz0OifrcLKtJQbCx8ER/Bdm3SbsJe0mcszbQjrC2Efv89Pb3bB/DLRPqNqJLT7PUdiH
         ZPDO+U7QYJOtixlk1TZJ9j0t6wtVWk6MskcUh0Svekorxf03P/nvckRqRjOfnI99Spd4
         Wpfg==
X-Gm-Message-State: AOAM5300ZqelBR+Wy9gpMehVSVkik4t9+mq3RJlOcvkVH8AOhvpIBegQ
        LGvVECKku8r+wlv9SC/F89m5G6XBOLkWs595Ztz/V5+Pk5w9
X-Google-Smtp-Source: ABdhPJxiaeneNlDt35Xc9SOPXO/UFyyutzJ3zRt1jb7qr+u3x1AAXCpLVEIA0wmIkUqXkcpOj6N1ezTtw1h2zLhDVr7ppP5/uyYT
MIME-Version: 1.0
X-Received: by 2002:a92:c112:: with SMTP id p18mr14337470ile.89.1607333643854;
 Mon, 07 Dec 2020 01:34:03 -0800 (PST)
Date:   Mon, 07 Dec 2020 01:34:03 -0800
In-Reply-To: <0000000000002ae6eb05b3bd420c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0aa9a05b5dc86cb@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in btrfs_scan_one_device
From:   syzbot <syzbot+c4b1e5278d93269fd69c@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        jthumshirn@suse.de, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, nborisov@suse.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0697d9a610998b8bdee6b2390836cb2391d8fd1a
Author: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed Nov 18 09:03:26 2020 +0000

    btrfs: don't access possibly stale fs_info data for printing duplicate device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fb0d9b500000
start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e791ddf0875adf65
dashboard link: https://syzkaller.appspot.com/bug?extid=c4b1e5278d93269fd69c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16296f5c500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1614e746500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: don't access possibly stale fs_info data for printing duplicate device

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
