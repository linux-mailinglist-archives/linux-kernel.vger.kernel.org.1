Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CC258298
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgHaU3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 16:29:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:43551 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgHaU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:29:08 -0400
Received: by mail-io1-f72.google.com with SMTP id f19so4934964iol.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gnKsjgJ5rv+iBjKke+34Do0zneKwGI7SNQuffWwXV30=;
        b=TSb/FBaOaqiAtTJSO3Aw1gp8kj1cUkla+tjG4x9u7G+Vi+vJ3JX+uOXRzncD6aVeXA
         gXuaF9vlbIxB5qSkWDGUyGLKPs92al0HejsQkqWdojkj3kZz49jJT7ddgTkD/ZcZbAR3
         VjfHibIidPABS0bYuV2JML8N6wAg8kjbnrcsjewClyLMu/zetLb5asGkDi6BWWHeG4Vg
         nKy6dyH/cVBsXIbOYNBEJ/uvJiMT3ZTZ961urHdYCQlUlAzuY/sslEU8W8KlN1Hxzrle
         ExyU4KGxwCj5D4L7KyiLxPXFvK68BpROQKhiBIfXHxDDq12AjtGuTapXPxohZ7jI7NSX
         ePjg==
X-Gm-Message-State: AOAM532joGzTC7rg+1KuntnqYWnr7UtS1RvmKHH9isuXQK08HuVRp+DN
        TPOt8JHf5v9XwWJBtaVYZighuVQdIGVhcCeRDukbPts6SPMb
X-Google-Smtp-Source: ABdhPJwCvxBZTJEsf7HAcCNqGtxUArlv0LeJO8NfG5NM0O/U5K34R5yLEbt3NyLxslkp5VsQxwdtrntanuYjj9jwxim2j2G3q909
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b13:: with SMTP id p19mr2800611iov.30.1598905747341;
 Mon, 31 Aug 2020 13:29:07 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:29:07 -0700
In-Reply-To: <000000000000520ffc05ae2f4fee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001985dc05ae32417b@google.com>
Subject: Re: KASAN: use-after-free Read in bdev_del_partition
From:   syzbot <syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, jack@suse.cz,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit cddae808aeb77e5c29d22a8e0dfbdaed413f9e04
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 14 07:28:54 2020 +0000

    block: pass a hd_struct to delete_partition

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fa7656900000
start commit:   dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14067656900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10067656900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=6448f3c229bc52b82f69
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e2285900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f6e915900000

Reported-by: syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com
Fixes: cddae808aeb7 ("block: pass a hd_struct to delete_partition")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
