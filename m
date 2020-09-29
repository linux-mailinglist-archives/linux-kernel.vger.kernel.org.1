Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB027BC78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 07:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgI2FeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 01:34:08 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:40948 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgI2FeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:34:08 -0400
Received: by mail-il1-f207.google.com with SMTP id e9so2592051ils.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 22:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KfWV0gnoumlsZJk50gbr1pEK2WkQDVbgVi8fBs3qwgg=;
        b=qKsn7iNiWcNM/E/SNajREAynT0BHx7FSL7mXtbsNt7RAm08ndjoapjfKP7cM6q4aa9
         BjrWxVnoZ9fkmhr6FerCX8jO0/cfkJ+dJQtS2zNGS9wOUW+3fC/dGv7oSYXA5GXGE58J
         Q3D05AVpkO2dRWdXCxQ2HexKro6a8t2Z3Q9UoEx+Sq3vaS1JpGKiVeq0N9fYqadOVdod
         4DXdd8K6eFV1ezqpruzN0rQUC87VDdaKcARbTr9CnxJL9djZagLFvlPqUVD9rUO5KMvM
         h+pjF5KiKgI3Vq45gq7uHFSlP5rnrwiqjDcgRzuQeKxhXloOzJWcJ3mTEBcEOc2A/yeO
         hmcA==
X-Gm-Message-State: AOAM533zTV0fMD0pkY/Qtmlk/v/3ClWFnOfPCucyRl6kOavqY1J3M96s
        Nhwj6BS8w+QrEHudC4moFiITOSlMLVJp87vKls4ec4CSViis
X-Google-Smtp-Source: ABdhPJwbUrHiwJnq2FAlkdIXW3NQ3i/5IXxdyF7HO+N7tTecczltm5HcCn0fFrzgglyR/4GrYjNiHL/H+BnicYsWOYzmtkWC2k5H
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ed3:: with SMTP id i19mr1536216ilk.188.1601357646098;
 Mon, 28 Sep 2020 22:34:06 -0700 (PDT)
Date:   Mon, 28 Sep 2020 22:34:06 -0700
In-Reply-To: <000000000000b6d7fd05b02037ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7770405b06d21ac@google.com>
Subject: Re: general protection fault in gfs2_withdraw
From:   syzbot <syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, anprice@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 601ef0d52e9617588fcff3df26953592f2eb44ac
Author: Bob Peterson <rpeterso@redhat.com>
Date:   Tue Jan 28 19:23:45 2020 +0000

    gfs2: Force withdraw to replay journals and wait for it to finish

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151d25e3900000
start commit:   7c7ec322 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=171d25e3900000
console output: https://syzkaller.appspot.com/x/log.txt?x=131d25e3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6184b75aa6d48d66
dashboard link: https://syzkaller.appspot.com/bug?extid=50a8a9cf8127f2c6f5df
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c6a109900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d45ed3900000

Reported-by: syzbot+50a8a9cf8127f2c6f5df@syzkaller.appspotmail.com
Fixes: 601ef0d52e96 ("gfs2: Force withdraw to replay journals and wait for it to finish")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
