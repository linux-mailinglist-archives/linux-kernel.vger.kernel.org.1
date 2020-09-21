Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2827335D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgIUT6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:58:10 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:45883 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUT6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:58:09 -0400
Received: by mail-il1-f208.google.com with SMTP id b19so216526ill.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=alVi99wcGR4KF0/EHp0MBZMK0CgriRXeZymu+1h/cXk=;
        b=C9dvUQtc8i05ZQOlvLtpKILdyO5LGYGSg5AiRKtRHHOh+Il6KmpE7hsN6YbIQq8V2C
         5o3u0wZIB4DP+9gjlXDeM/ZfoOOXifyucX5uBJRpEpzYxcwLXKWXE9/5Mj86iFt4hAuE
         2OWhengBfAL0iQHqd/5PeBWky44NEfyX2X92TDTLE5gafJeUUT6mmGxPRh0rPqMAB8xK
         HvAhS/hZGIsMG8+VDJoYadW3WIn8AGv+RIIf8CDIJt3E7lmmk2CKsVN7CsUe3ATtsJxX
         F/3rKKxb+nKA0eIfIdxMfLBAMxEemW/JwTkXo+/Xbnj5i+OAmhHttFjtMxxQQaTAc9aJ
         2KEQ==
X-Gm-Message-State: AOAM530Z/Ed69xrQv/AVvtzIl6d6AMpn+9UQf03TRepuk8e9rbZa5U9G
        zBckqx1CSPY2mKGotNurNngOc9NYoF0ekhiwngdty5cTvf/9
X-Google-Smtp-Source: ABdhPJxkQ1g5PNEJxbE0Iv6MFNLvGWp1qpEpJQ51q32GaKCxEvtNog5hSKTboOOsu9XPGk2SyuyJxSiH6o2FIUcTRXF74Pkq9SFV
MIME-Version: 1.0
X-Received: by 2002:a92:7713:: with SMTP id s19mr1432669ilc.161.1600718288785;
 Mon, 21 Sep 2020 12:58:08 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:58:08 -0700
In-Reply-To: <000000000000f5be7f05afcf862a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd18b405afd84475@google.com>
Subject: Re: general protection fault in reiserfs_security_init
From:   syzbot <syzbot+690cb1e51970435f9775@syzkaller.appspotmail.com>
To:     baolin.wang7@gmail.com, gregkh@linuxfoundation.org,
        linhua.xu@unisoc.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 1592c4b9935fa8a3b7c297955bb872a357e5a3b6
Author: Linhua Xu <linhua.xu@unisoc.com>
Date:   Wed Mar 25 08:25:28 2020 +0000

    pinctrl: sprd: Add pin high impedance mode support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111050d3900000
start commit:   325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=131050d3900000
console output: https://syzkaller.appspot.com/x/log.txt?x=151050d3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b12e84189082991c
dashboard link: https://syzkaller.appspot.com/bug?extid=690cb1e51970435f9775
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15705a3d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117b3281900000

Reported-by: syzbot+690cb1e51970435f9775@syzkaller.appspotmail.com
Fixes: 1592c4b9935f ("pinctrl: sprd: Add pin high impedance mode support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
