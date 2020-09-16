Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141EA26BF01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIPITQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:19:16 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:52465 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:19:11 -0400
Received: by mail-il1-f207.google.com with SMTP id m1so4951018iln.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MpjW6yPzOhFB98vREk8U50PzmQ08W7Z9iyhJvVdEnJg=;
        b=UJxA29eyzFaTjPtnqxZlg55I5DudNVorfx+YCwXduG4brmAXtU24lc2Ip4gLaet0oh
         To8MgwIUGEBYiP64UQnOGFoWQr0GaAUyzhnIR7oYvPS+noqjLuUQvR9VdvbAA/Rmt84F
         720wlhhtxdepjhTdTOPDqZSTdJKTzx4GwBzckCyoIk2w2QywP36GpStBoVXWyacm4cup
         Yre3Yg0ovZnvcechsjq/EnI0YV8E2IMD0XLEW5gdOiLX7Ifu9TghZkJV5GcG1XhY9e19
         ZG8IVK4SL7lbDoiL5WoM557fmkqp5/I0PYdiRzmqZ4L1wLl4J0XgcJr7jp+xu/NBgfdU
         umOQ==
X-Gm-Message-State: AOAM533D0S3z9oHSgMzlh3JopsDQ/4oJD4XYdizy3JD6Fz/5qWRzWnpp
        oUv8khKhwglErH6hN+WJMSVF4Z43DPPFjIq+fRp4ShflCMUi
X-Google-Smtp-Source: ABdhPJwFOyM2R4eo8fW8aOAA9iJyx59dTuWjTzJjlk/np2AmX2NM0Lqembb1/k6o9Y7CdAHXiPP78YaM9lMqspuh/QwIai9kafLT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d45:: with SMTP id h5mr20731707ilj.168.1600244350175;
 Wed, 16 Sep 2020 01:19:10 -0700 (PDT)
Date:   Wed, 16 Sep 2020 01:19:10 -0700
In-Reply-To: <000000000000a61d6b05af580e62@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bcff305af69ecae@google.com>
Subject: Re: kernel BUG at lib/string.c:LINE! (5)
From:   syzbot <syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        jthumshirn@suse.de, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 3951e7f050ac6a38bbc859fc3cd6093890c31d1c
Author: Johannes Thumshirn <jthumshirn@suse.de>
Date:   Mon Oct 7 09:11:01 2019 +0000

    btrfs: add xxhash64 to checksumming algorithms

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10aadcc5900000
start commit:   e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12aadcc5900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14aadcc5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=e864a35d361e1d4e29a5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177582be900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13deb2b5900000

Reported-by: syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
