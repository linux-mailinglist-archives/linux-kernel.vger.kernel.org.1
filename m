Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F408528208B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 04:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgJCCdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 22:33:07 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:52709 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJCCdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:33:06 -0400
Received: by mail-io1-f80.google.com with SMTP id m4so2249359iov.19
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 19:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=huAQ2XNxNk0+JP0caungu+yrhrmWz2OAWIUz9RtSlI4=;
        b=NTJm2WAil3llRVOzR1vKbP51d2luHk8wMin2zHkLnA2FDPp/361auV1BwBhDuVBh4x
         cLUoDbTgKFNyXv6Ex+Qov6MuNo645Dqm7yIDEAGPuWsKMOn/G6aLo67xOLGAi0aVzc+R
         jJ1ECj4OtSF0tlAMP45w32nMy4IOSk9E3/RpU80RY71DvgQ7Eb75I9mRP020kli8K6N6
         T6VeD3fus79JHK465erM5Z5n6wsEyT6skFphhW7ohl09Uw5UxnkCgx1bC/GzwuHTJGJI
         k/+XiGlnJlT1S/94r9ptY6AFSjKZSevGKNsPZUfboApwFqf0lR8BYiwsntSGDWgGhZT0
         fycw==
X-Gm-Message-State: AOAM532f85st87i04RJ8Y9Tt8lGZvc+wnOoJm8jglGt9dm4ZyOUGa5Lk
        XOr9OZ2D6WG2Pr6SjvvZuBZdVY7U8CgQw/5/gYrRX2rvwI00
X-Google-Smtp-Source: ABdhPJzrlAP5imDWEPKyVGiLnhg0plpe3Pjdz0K8YSADKul87MvIbS1OPbnv7c/HZQJfp1argFlx9wEiLJU/BiWVN/BRncyNJ03n
MIME-Version: 1.0
X-Received: by 2002:a02:5d85:: with SMTP id w127mr4693509jaa.76.1601692385603;
 Fri, 02 Oct 2020 19:33:05 -0700 (PDT)
Date:   Fri, 02 Oct 2020 19:33:05 -0700
In-Reply-To: <000000000000ed022605b0b1efaa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aef3fc05b0bb11ce@google.com>
Subject: Re: WARNING in ieee80211_bss_info_change_notify
From:   syzbot <syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com>
To:     airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        davem@davemloft.net, dieter@nuetzel-hh.de,
        dri-devel@lists.freedesktop.org, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 135f971181d779c96ff3725c1a350a721785cc66
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Mon Nov 20 22:49:53 2017 +0000

    drm/amdgpu: don't skip attributes when powerplay is enabled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120f55bd900000
start commit:   fcadab74 Merge tag 'drm-fixes-2020-10-01-1' of git://anong..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=110f55bd900000
console output: https://syzkaller.appspot.com/x/log.txt?x=160f55bd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e672827d2ffab1f
dashboard link: https://syzkaller.appspot.com/bug?extid=09d1cd2f71e6dd3bfd2c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161112eb900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124fc533900000

Reported-by: syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com
Fixes: 135f971181d7 ("drm/amdgpu: don't skip attributes when powerplay is enabled")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
