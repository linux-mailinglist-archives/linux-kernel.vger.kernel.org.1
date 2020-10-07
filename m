Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE428655C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgJGRBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:01:09 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:54823 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJGRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:01:09 -0400
Received: by mail-io1-f77.google.com with SMTP id f6so1880628ion.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+o4BZuu/0OdIHH6om63thYUeqrY8yyf+OMPBpQX6xY4=;
        b=LkRbQN/bmnCXuHVgyT11f0aMDD/HhKeGHxoWVTeN/SkqXAsFsNby552JFpe7dsqKkl
         WVv/+JhzrWk2PHzdlFj3FMJHjKHfrfTv35R5kai0et6bfyKNMSLQdseHc5vHq+gFD/JY
         tw+p8CcQ2tyUy1xzt4xVHVB4epX/kk71m9Rr3Z5CvcyKLs24F4zvdZjXNvFo6LixwVM0
         scP0pznfsroNkTTjgAbzI7tNo2ebGE8TRHdMGQNJDK/RbyllzCBvbT0hdS/HJMgq4lib
         UMJMhaxAECGdf/B087rT7U3E0vuQNy0hA2G7DSU4IT7zzEtvKayKPuXYSOyup9pyHLiz
         +1dQ==
X-Gm-Message-State: AOAM5325V6ssvuogoSGPs461v7IlyEXh/TdX5gxYFTQ4KjGVAa72kkhW
        LsgNNAJjNmlGg+h3OqSxUH09Op/iDEptam4i6F9ZrMpz6OiE
X-Google-Smtp-Source: ABdhPJyoIOJDTcvlbIzi1zdUoLG+t6AoTPXU1AL58wlSRpAKdpWohslxu5jIIwXR2ywYUB1QrvwAApjesJPBI94hpaq3jvanJVxB
MIME-Version: 1.0
X-Received: by 2002:a92:c0cf:: with SMTP id t15mr3403899ilf.216.1602090068238;
 Wed, 07 Oct 2020 10:01:08 -0700 (PDT)
Date:   Wed, 07 Oct 2020 10:01:08 -0700
In-Reply-To: <000000000000ce8d2305a03b0988@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a67f005b117a94a@google.com>
Subject: Re: INFO: trying to register non-static key in uhid_char_release
From:   syzbot <syzbot+8357fbef0d7bb602de45@syzkaller.appspotmail.com>
To:     benjamin.tissoires@gmail.com, benjamin.tissoires@redhat.com,
        brookebasile@gmail.com, david.rheinsberg@gmail.com,
        dh.herrmann@googlemail.com, ebiggers@kernel.org, hdanton@sina.com,
        jikos@kernel.org, jkorsnes@cisco.com, jkosina@suse.cz,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit bce1305c0ece3dc549663605e567655dd701752c
Author: Marc Zyngier <maz@kernel.org>
Date:   Sat Aug 29 11:26:01 2020 +0000

    HID: core: Correctly handle ReportSize being zero

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d19370500000
start commit:   1127b219 Merge tag 'fallthrough-fixes-5.9-rc3' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=8357fbef0d7bb602de45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102c472e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13081056900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: HID: core: Correctly handle ReportSize being zero

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
